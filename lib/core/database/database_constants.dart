// *****************************************************************************
// File        : database_constants.dart
// Project     : Cab Booking Manager
// Description :
// Centralized SQLite database constants.
//
// This file contains:
// • Database configuration
// • Table names
// • Column names
//
// NOTE:
// BookingStatus and TripType are defined as enums under:
//
// lib/core/enums/booking_status.dart
// lib/core/enums/trip_type.dart
//
// Do not duplicate those values here.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

/// SQLite database configuration.
final class DatabaseConstants {
  DatabaseConstants._();

  /// SQLite database file name.
  static const String databaseName = 'cab_booking.db';

  /// Database schema version.
  ///
  /// Increment only when the database schema changes.
  static const int databaseVersion = 1;
}

/// SQLite table names.
final class DatabaseTables {
  DatabaseTables._();

  static const String bookings = 'bookings';

  static const String bookingCounter = 'booking_counter';

  static const String companySettings = 'company_settings';
}

/// Column names for the bookings table.
final class BookingColumns {
  BookingColumns._();

  static const String id = 'id';

  static const String bookingId = 'bookingId';

  static const String tripType = 'tripType';

  static const String passengerName = 'passengerName';

  static const String passengerPhone = 'passengerPhone';

  static const String reportingDateTime = 'reportingDateTime';

  static const String reportingAddress = 'reportingAddress';

  static const String dropAddress = 'dropAddress';

  static const String remarks = 'remarks';

  static const String notes = 'notes';

  static const String captainName = 'captainName';

  static const String captainPhone = 'captainPhone';

  static const String vehicleModel = 'vehicleModel';

  static const String vehicleNumber = 'vehicleNumber';

  static const String status = 'status';

  static const String cancelReason = 'cancelReason';

  static const String isDeleted = 'isDeleted';

  static const String createdAt = 'createdAt';

  static const String updatedAt = 'updatedAt';
}

/// Column names for the booking counter table.
final class BookingCounterColumns {
  BookingCounterColumns._();

  static const String id = 'id';

  static const String prefix = 'prefix';

  static const String currentNumber = 'currentNumber';
}

/// Column names for the company settings table.
final class CompanySettingsColumns {
  CompanySettingsColumns._();

  static const String id = 'id';

  static const String companyName = 'companyName';

  static const String companyPhone = 'companyPhone';

  static const String companyEmail = 'companyEmail';

  static const String companyAddress = 'companyAddress';

  static const String companyLogo = 'companyLogo';

  static const String lastBackup = 'lastBackup';

  static const String lastRestore = 'lastRestore';
}