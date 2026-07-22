// *****************************************************************************
// File        : booking_repository.dart
// Project     : Cab Booking Manager
// Description :
// Repository responsible for all booking database operations.
//
// Responsibilities:
// • Create bookings
// • Read bookings
// • Update bookings
// • Cancel bookings
// • Soft delete bookings
// • Restore bookings
// • Search bookings
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:sqflite/sqflite.dart';

import '../../../core/database/database_constants.dart';
import '../../../core/database/database_helper.dart';
import '../../../core/services/booking_id_service.dart';
import '../models/booking_model.dart';

/// Repository responsible for booking CRUD operations.
final class BookingRepository {
  BookingRepository._();

  static final BookingRepository instance = BookingRepository._();

  Future<Database> get _db async => DatabaseHelper.instance.database;

  /// Inserts a new booking.
  Future<BookingModel> createBooking(
      BookingModel booking,
      ) async {
    final db = await _db;

    final bookingId =
    await BookingIdService.instance.generateBookingId();

    final newBooking = booking.copyWith(
      bookingId: bookingId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await db.insert(
      DatabaseTables.bookings,
      newBooking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return newBooking;
  }

  /// Returns all active bookings.
  Future<List<BookingModel>> getAllBookings() async {
    final db = await _db;

    final result = await db.query(
      DatabaseTables.bookings,
      where: '${BookingColumns.isDeleted}=0',
      orderBy:
      '${BookingColumns.reportingDateTime} ASC',
    );

    return result
        .map(BookingModel.fromMap)
        .toList();
  }

  /// Returns booking by SQLite ID.
  Future<BookingModel?> getBooking(
      int id,
      ) async {
    final db = await _db;

    final result = await db.query(
      DatabaseTables.bookings,
      where: '${BookingColumns.id}=?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return BookingModel.fromMap(result.first);
  }

  /// Updates an existing booking.
  Future<void> updateBooking(
      BookingModel booking,
      ) async {
    final db = await _db;

    final updated = booking.copyWith(
      updatedAt: DateTime.now(),
    );

    await db.update(
      DatabaseTables.bookings,
      updated.toMap(),
      where: '${BookingColumns.id}=?',
      whereArgs: [booking.id],
    );
  }

  /// Soft deletes a booking.
  Future<void> deleteBooking(
      int id,
      ) async {
    final db = await _db;

    await db.update(
      DatabaseTables.bookings,
      {
        BookingColumns.isDeleted: 1,
        BookingColumns.updatedAt:
        DateTime.now().toIso8601String(),
      },
      where: '${BookingColumns.id}=?',
      whereArgs: [id],
    );
  }

  /// Restores a deleted booking.
  Future<void> restoreBooking(
      int id,
      ) async {
    final db = await _db;

    await db.update(
      DatabaseTables.bookings,
      {
        BookingColumns.isDeleted: 0,
        BookingColumns.updatedAt:
        DateTime.now().toIso8601String(),
      },
      where: '${BookingColumns.id}=?',
      whereArgs: [id],
    );
  }

  /// Permanently deletes a booking.
  Future<void> deleteBookingPermanently(
      int id,
      ) async {
    final db = await _db;

    await db.delete(
      DatabaseTables.bookings,
      where: '${BookingColumns.id}=?',
      whereArgs: [id],
    );
  }

  /// Searches bookings by passenger name,
  /// booking ID or phone number.
  Future<List<BookingModel>> searchBookings(
      String keyword,
      ) async {
    final db = await _db;

    final result = await db.query(
      DatabaseTables.bookings,
      where: '''
${BookingColumns.isDeleted}=0
AND
(
${BookingColumns.passengerName} LIKE ?
OR
${BookingColumns.passengerPhone} LIKE ?
OR
${BookingColumns.bookingId} LIKE ?
)
''',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
        '%$keyword%',
      ],
      orderBy:
      '${BookingColumns.reportingDateTime} ASC',
    );

    return result
        .map(BookingModel.fromMap)
        .toList();
  }

  /// Returns total active bookings.
  Future<int> bookingCount() async {
    final db = await _db;

    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        '''
SELECT COUNT(*)
FROM ${DatabaseTables.bookings}
WHERE ${BookingColumns.isDeleted}=0
''',
      ),
    );

    return result ?? 0;
  }
}