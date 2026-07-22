// *****************************************************************************
// File        : dashboard_repository.dart
// Project     : Cab Booking Manager
// Description :
// Repository responsible for dashboard statistics.
//
// Responsibilities:
// • Fetch dashboard statistics
// • Count bookings by status
// • Count today's bookings
// • Fetch recent bookings
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import '../../../core/enums/booking_status.dart';
import '../../booking/models/booking_model.dart';
import '../../booking/repository/booking_repository.dart';
import '../models/dashboard_stats.dart';

/// Repository responsible for loading dashboard statistics.
class DashboardRepository {
  /// Creates a dashboard repository.
  DashboardRepository({
    required this.bookingRepository,
  });

  /// Booking repository.
  final BookingRepository bookingRepository;

  /// Returns dashboard statistics.
  Future<DashboardStats> getDashboardStats() async {
    final List<BookingModel> bookings =
    await bookingRepository.getAllBookings();

    final now = DateTime.now();

    int todayBookings = 0;
    int confirmedBookings = 0;
    int completedBookings = 0;
    int cancelledBookings = 0;

    for (final booking in bookings) {
      final reporting = booking.reportingDateTime;

      // Count today's bookings.
      if (reporting.year == now.year &&
          reporting.month == now.month &&
          reporting.day == now.day) {
        todayBookings++;
      }

      // Count bookings by status.
      switch (booking.status) {
        case BookingStatus.confirmed:
          confirmedBookings++;
          break;

        case BookingStatus.completed:
          completedBookings++;
          break;

        case BookingStatus.cancelled:
          cancelledBookings++;
          break;
      }
    }

    // -------------------------------------------------------------------------
    // Recent Bookings
    // -------------------------------------------------------------------------

    final recentBookings = List<BookingModel>.from(bookings)
      ..sort(
            (a, b) => b.reportingDateTime.compareTo(
          a.reportingDateTime,
        ),
      );

    if (recentBookings.length > 5) {
      recentBookings.removeRange(
        5,
        recentBookings.length,
      );
    }

    return DashboardStats(
      totalBookings: bookings.length,
      todayBookings: todayBookings,
      confirmedBookings: confirmedBookings,
      completedBookings: completedBookings,
      cancelledBookings: cancelledBookings,
      recentBookings: recentBookings,
    );
  }
}