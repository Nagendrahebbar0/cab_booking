// *****************************************************************************
// File        : dashboard_stats.dart
// Project     : Cab Booking Manager
// Description :
// Model representing dashboard statistics.
//
// Responsibilities:
// • Store dashboard statistics
// • Store recent bookings
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import '../../booking/models/booking_model.dart';

/// Dashboard statistics model.
class DashboardStats {
  /// Creates a dashboard statistics model.
  const DashboardStats({
    required this.totalBookings,
    required this.todayBookings,
    required this.confirmedBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.recentBookings,
  });

  /// Total number of bookings.
  final int totalBookings;

  /// Number of today's bookings.
  final int todayBookings;

  /// Number of confirmed bookings.
  final int confirmedBookings;

  /// Number of completed bookings.
  final int completedBookings;

  /// Number of cancelled bookings.
  final int cancelledBookings;

  /// Last 5 recent bookings.
  final List<BookingModel> recentBookings;
}