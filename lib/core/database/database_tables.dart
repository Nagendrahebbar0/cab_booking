// *****************************************************************************
// File        : database_tables.dart
// Project     : Cab Booking Manager
// Description :
// Contains all SQLite CREATE TABLE statements used by the application.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'database_constants.dart';

/// SQL statements used to create the application's database tables.
final class DatabaseTablesSql {
  DatabaseTablesSql._();

  /// Creates the bookings table.
  static String get createBookingsTable => '''
CREATE TABLE ${DatabaseTables.bookings} (

  ${BookingColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,

  ${BookingColumns.bookingId} TEXT UNIQUE NOT NULL,

  ${BookingColumns.tripType} TEXT NOT NULL,

  ${BookingColumns.passengerName} TEXT NOT NULL,

  ${BookingColumns.passengerPhone} TEXT NOT NULL,

  ${BookingColumns.reportingDateTime} TEXT NOT NULL,

  ${BookingColumns.reportingAddress} TEXT NOT NULL,

  ${BookingColumns.dropAddress} TEXT NOT NULL,

  ${BookingColumns.remarks} TEXT,

  ${BookingColumns.notes} TEXT,

  ${BookingColumns.captainName} TEXT NOT NULL,

  ${BookingColumns.captainPhone} TEXT NOT NULL,

  ${BookingColumns.vehicleModel} TEXT NOT NULL,

  ${BookingColumns.vehicleNumber} TEXT NOT NULL,

  ${BookingColumns.status} TEXT NOT NULL,

  ${BookingColumns.cancelReason} TEXT,

  ${BookingColumns.isDeleted} INTEGER NOT NULL DEFAULT 0,

  ${BookingColumns.createdAt} TEXT NOT NULL,

  ${BookingColumns.updatedAt} TEXT NOT NULL

);
''';

  /// Creates the booking counter table.
  static String get createBookingCounterTable => '''
CREATE TABLE ${DatabaseTables.bookingCounter} (

  ${BookingCounterColumns.id} INTEGER PRIMARY KEY,

  ${BookingCounterColumns.prefix} TEXT NOT NULL,

  ${BookingCounterColumns.currentNumber} INTEGER NOT NULL

);
''';

  /// Creates the company settings table.
  static String get createCompanySettingsTable => '''
CREATE TABLE ${DatabaseTables.companySettings} (

  ${CompanySettingsColumns.id} INTEGER PRIMARY KEY,

  ${CompanySettingsColumns.companyName} TEXT,

  ${CompanySettingsColumns.companyPhone} TEXT,

  ${CompanySettingsColumns.companyEmail} TEXT,

  ${CompanySettingsColumns.companyAddress} TEXT,

  ${CompanySettingsColumns.companyLogo} TEXT,

  ${CompanySettingsColumns.lastBackup} TEXT,

  ${CompanySettingsColumns.lastRestore} TEXT

);
''';
}