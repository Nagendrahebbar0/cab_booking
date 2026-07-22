// *****************************************************************************
// File        : booking_card.dart
// Project     : Cab Booking Manager
// Description :
// Reusable booking card displayed in the booking list.
//
// Responsibilities:
// • Display booking summary
// • Open Booking Details on tap
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/enums/trip_type.dart';
import '../models/booking_model.dart';
import '../screens/booking_details_screen.dart';
import 'booking_status_chip.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
  });

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingDetailsScreen(
                booking: booking,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----------------------------------------------------------------
              // Header
              //----------------------------------------------------------------

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

                  BookingStatusChip(
                    status: booking.status,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //----------------------------------------------------------------
              // Passenger
              //----------------------------------------------------------------

              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person),
                title: Text(booking.passengerName),
                subtitle: Text(booking.passengerPhone),
              ),

              //----------------------------------------------------------------
              // Reporting
              //----------------------------------------------------------------

              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(
                  DateFormat(
                    'dd/MM/yyyy hh:mm a',
                  ).format(
                    booking.reportingDateTime,
                  ),
                ),
                subtitle: Text(
                  booking.tripType.displayName,
                ),
              ),

              //----------------------------------------------------------------
              // Pickup
              //----------------------------------------------------------------

              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.my_location),
                title: const Text('Pickup'),
                subtitle: Text(
                  booking.reportingAddress,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //----------------------------------------------------------------
              // Drop
              //----------------------------------------------------------------

              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on),
                title: const Text('Drop'),
                subtitle: Text(
                  booking.dropAddress,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const Divider(),

              //----------------------------------------------------------------
              // Footer
              //----------------------------------------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tap to view details',
                    style: theme.textTheme.bodySmall,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}