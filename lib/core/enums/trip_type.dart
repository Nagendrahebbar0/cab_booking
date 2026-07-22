// *****************************************************************************
// File        : trip_type.dart
// Project     : Cab Booking Manager
// Description :
// Defines supported trip types.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

/// Supported trip types.
enum TripType {
  oneWay,
  roundTrip,
}

/// Helper methods for [TripType].
extension TripTypeExtension on TripType {
  /// Display text shown in the UI.
  String get displayName {
    switch (this) {
      case TripType.oneWay:
        return 'One Way';

      case TripType.roundTrip:
        return 'Round Trip';
    }
  }

  /// SQLite value.
  String get databaseValue => displayName;

  /// Returns TripType from SQLite string.
  static TripType fromDatabase(String value) {
    switch (value) {
      case 'One Way':
        return TripType.oneWay;

      case 'Round Trip':
        return TripType.roundTrip;

      default:
        return TripType.oneWay;
    }
  }
}