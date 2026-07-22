// *****************************************************************************
// File        : report_model.dart
// Project     : Cab Booking Manager
// Description :
// Model representing dashboard report statistics.
//
// Responsibilities:
// • Store report summary
// • Store filtered bookings
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import '../../booking/models/booking_model.dart';

class ReportModel {
  const ReportModel({
    required this.totalBookings,
    required this.confirmedBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.bookings,
  });

  final int totalBookings;
  final int confirmedBookings;
  final int completedBookings;
  final int cancelledBookings;

  final List<BookingModel> bookings;
}