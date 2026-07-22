// *****************************************************************************
// File        : booking_card.dart
// Project     : Cab Booking Manager
// Description :
// Reusable booking card displayed in the booking list.
//
// Responsibilities:
// • Display booking summary.
// • Provide Edit and Delete actions.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/enums/booking_status.dart';
import '../../../core/enums/trip_type.dart';
import '../models/booking_model.dart';

/// Displays a single booking.
class BookingCard extends StatelessWidget {
  /// Creates a booking card.
  const BookingCard({
    super.key,
    required this.booking,
    required this.onEdit,
    required this.onDelete,
  });

  /// Booking to display.
  final BookingModel booking;

  /// Called when Edit is pressed.
  final VoidCallback onEdit;

  /// Called when Delete is pressed.
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------------------------------------------------------
            // Header
            //------------------------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.bookingId,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Chip(
                  label: Text(
                    booking.status.displayName,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            //------------------------------------------------------------------
            // Passenger
            //------------------------------------------------------------------

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person),
              title: Text(booking.passengerName),
              subtitle: Text(booking.passengerPhone),
            ),

            //------------------------------------------------------------------
            // Trip
            //------------------------------------------------------------------

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: Text(
                DateFormat(
                  'dd/MM/yyyy hh:mm a',
                ).format(booking.reportingDateTime),
              ),
              subtitle: Text(
                booking.tripType.displayName,
              ),
            ),

            //------------------------------------------------------------------
            // Reporting Address
            //------------------------------------------------------------------

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.my_location),
              title: const Text('Reporting Address'),
              subtitle: Text(
                booking.reportingAddress,
              ),
            ),

            //------------------------------------------------------------------
            // Drop Address
            //------------------------------------------------------------------

            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on),
              title: const Text('Drop Address'),
              subtitle: Text(
                booking.dropAddress,
              ),
            ),

            const Divider(),

            //------------------------------------------------------------------
            // Actions
            //------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),

                const SizedBox(width: 8),

                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}