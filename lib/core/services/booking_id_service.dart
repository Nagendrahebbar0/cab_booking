// *****************************************************************************
// File        : booking_id_service.dart
// Project     : Cab Booking Manager
// Description :
// Generates unique booking IDs.
//
// Responsibilities:
// • Read current booking counter.
// • Increment booking counter.
// • Generate formatted booking ID.
// • Persist updated counter.
//
// Example:
// SGC000001
// SGC000002
// SGC000003
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:sqflite/sqflite.dart';

import '../database/database_constants.dart';
import '../database/database_helper.dart';

/// Service responsible for generating booking IDs.
final class BookingIdService {
  BookingIdService._();

  static final BookingIdService instance = BookingIdService._();

  /// Generates the next booking ID.
  Future<String> generateBookingId() async {
    final Database db = await DatabaseHelper.instance.database;

    final result = await db.query(
      DatabaseTables.bookingCounter,
      where: '${BookingCounterColumns.id} = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isEmpty) {
      throw Exception('Booking counter record not found.');
    }

    final counter = result.first;

    final String prefix =
    counter[BookingCounterColumns.prefix] as String;

    final int currentNumber =
    counter[BookingCounterColumns.currentNumber] as int;

    final int nextNumber = currentNumber + 1;

    await db.update(
      DatabaseTables.bookingCounter,
      {
        BookingCounterColumns.currentNumber: nextNumber,
      },
      where: '${BookingCounterColumns.id} = ?',
      whereArgs: [1],
    );

    final formattedNumber =
    nextNumber.toString().padLeft(6, '0');

    return '$prefix$formattedNumber';
  }

  /// Resets the booking counter.
  ///
  /// Intended for development/testing only.
  Future<void> resetCounter({
    int value = 0,
  }) async {
    final Database db = await DatabaseHelper.instance.database;

    await db.update(
      DatabaseTables.bookingCounter,
      {
        BookingCounterColumns.currentNumber: value,
      },
      where: '${BookingCounterColumns.id} = ?',
      whereArgs: [1],
    );
  }

  /// Returns the current booking number.
  Future<int> currentNumber() async {
    final Database db = await DatabaseHelper.instance.database;

    final result = await db.query(
      DatabaseTables.bookingCounter,
      columns: [
        BookingCounterColumns.currentNumber,
      ],
      where: '${BookingCounterColumns.id} = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isEmpty) {
      return 0;
    }

    return result.first[
    BookingCounterColumns.currentNumber] as int;
  }
}