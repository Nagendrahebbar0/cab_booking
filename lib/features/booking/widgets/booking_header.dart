// *****************************************************************************
// File        : booking_header.dart
// Project     : Cab Booking Manager
// Description :
// Header widget displayed on the Booking Details screen.
//
// Responsibilities:
// • Display Booking ID
// • Display Booking Status
// • Display Created Date
// • Display Reporting Date
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/booking_model.dart';
import 'booking_status_chip.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({
    super.key,
    required this.booking,
  });

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.bookingId,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            BookingStatusChip(
              status: booking.status,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Created: ${DateFormat('dd MMM yyyy').format(booking.createdAt)}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.schedule, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Reporting: ${DateFormat('dd MMM yyyy hh:mm a').format(booking.reportingDateTime)}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}