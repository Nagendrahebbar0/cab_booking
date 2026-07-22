// *****************************************************************************
// File        : booking_status.dart
// Project     : Cab Booking Manager
// Description :
// Defines the booking status values used throughout the application.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

/// Represents the current status of a booking.
enum BookingStatus {
  confirmed,
  completed,
  cancelled,
}

/// Helper methods for [BookingStatus].
extension BookingStatusExtension on BookingStatus {
  /// Display text shown in the UI.
  String get displayName {
    switch (this) {
      case BookingStatus.confirmed:
        return 'Confirmed';

      case BookingStatus.completed:
        return 'Completed';

      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// SQLite value.
  String get databaseValue => displayName;

  /// Returns BookingStatus from SQLite string.
  static BookingStatus fromDatabase(String value) {
    switch (value) {
      case 'Confirmed':
        return BookingStatus.confirmed;

      case 'Completed':
        return BookingStatus.completed;

      case 'Cancelled':
        return BookingStatus.cancelled;

      default:
        return BookingStatus.confirmed;
    }
  }
}