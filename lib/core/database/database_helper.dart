// *****************************************************************************
// File        : database_helper.dart
// Project     : Cab Booking Manager
// Description :
// Handles SQLite database initialization and access.
//
// Responsibilities:
// • Open the database.
// • Create database tables.
// • Insert default records.
// • Provide a singleton database instance.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'database_tables.dart';

/// Singleton helper responsible for managing the SQLite database.
final class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  /// Returns the application database instance.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initializeDatabase();

    return _database!;
  }

  /// Opens or creates the SQLite database.
  Future<Database> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();

    final path = join(
      databasesPath,
      DatabaseConstants.databaseName,
    );

    return openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
  }

  /// Enables SQLite foreign key support.
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Creates all application tables and inserts default records.
  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute(DatabaseTablesSql.createBookingsTable);

    await db.execute(DatabaseTablesSql.createBookingCounterTable);

    await db.execute(DatabaseTablesSql.createCompanySettingsTable);

    await _insertDefaultBookingCounter(db);

    await _insertDefaultCompanySettings(db);
  }

  /// Inserts the initial booking counter record.
  Future<void> _insertDefaultBookingCounter(
      Database db,
      ) async {
    await db.insert(
      DatabaseTables.bookingCounter,
      {
        BookingCounterColumns.id: 1,
        BookingCounterColumns.prefix: 'SGC',
        BookingCounterColumns.currentNumber: 0,
      },
    );
  }

  /// Inserts the initial company settings record.
  Future<void> _insertDefaultCompanySettings(
      Database db,
      ) async {
    await db.insert(
      DatabaseTables.companySettings,
      {
        CompanySettingsColumns.id: 1,
        CompanySettingsColumns.companyName: '',
        CompanySettingsColumns.companyPhone: '',
        CompanySettingsColumns.companyEmail: '',
        CompanySettingsColumns.companyAddress: '',
        CompanySettingsColumns.companyLogo: '',
        CompanySettingsColumns.lastBackup: '',
        CompanySettingsColumns.lastRestore: '',
      },
    );
  }

  /// Closes the database connection.
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}