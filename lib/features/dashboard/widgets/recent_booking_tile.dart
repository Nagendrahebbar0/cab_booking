// *****************************************************************************
// File        : recent_booking_tile.dart
// Project     : Cab Booking Manager
// Description :
// Reusable tile for displaying a recent booking.
//
// Responsibilities:
// • Display booking summary
// • Navigate when tapped
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../booking/models/booking_model.dart';

class RecentBookingTile extends StatelessWidget {
  const RecentBookingTile({
    super.key,
    required this.booking,
    required this.onTap,
  });

  /// Booking to display.
  final BookingModel booking;

  /// Called when the tile is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.book_online),
        ),
        title: Text(
          booking.bookingId,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.passengerName),
            const SizedBox(height: 2),
            Text(
              DateFormat(
                'dd MMM yyyy • hh:mm a',
              ).format(
                booking.reportingDateTime,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }
}