// *****************************************************************************
// File        : report_repository.dart
// Project     : Cab Booking Manager
// Description :
// Repository responsible for generating reports.
//
// Responsibilities:
// • Fetch bookings
// • Filter bookings
// • Generate report statistics
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import '../../../core/enums/booking_status.dart';
import '../../booking/models/booking_model.dart';
import '../../booking/repository/booking_repository.dart';
import '../models/report_model.dart';

class ReportRepository {
  ReportRepository({
    required this.bookingRepository,
  });

  final BookingRepository bookingRepository;

  /// Returns overall booking report.
  Future<ReportModel> getReport() async {
    final bookings = await bookingRepository.getAllBookings();

    return _generateReport(bookings);
  }

  /// Returns report between two dates.
  Future<ReportModel> getDateRangeReport({
    required DateTime from,
    required DateTime to,
  }) async {
    final bookings = await bookingRepository.getAllBookings();

    final filtered = bookings.where((booking) {
      final reporting = booking.reportingDateTime;

      return !reporting.isBefore(from) &&
          !reporting.isAfter(to);
    }).toList();

    return _generateReport(filtered);
  }

  /// Returns report for a specific booking status.
  Future<ReportModel> getStatusReport(
      BookingStatus status,
      ) async {
    final bookings = await bookingRepository.getAllBookings();

    final filtered = bookings.where(
          (booking) => booking.status == status,
    ).toList();

    return _generateReport(filtered);
  }

  /// Generates report statistics.
  ReportModel _generateReport(
      List<BookingModel> bookings,
      ) {
    int confirmed = 0;
    int completed = 0;
    int cancelled = 0;

    for (final booking in bookings) {
      switch (booking.status) {
        case BookingStatus.confirmed:
          confirmed++;
          break;

        case BookingStatus.completed:
          completed++;
          break;

        case BookingStatus.cancelled:
          cancelled++;
          break;
      }
    }

    return ReportModel(
      totalBookings: bookings.length,
      confirmedBookings: confirmed,
      completedBookings: completed,
      cancelledBookings: cancelled,
      bookings: bookings,
    );
  }
}