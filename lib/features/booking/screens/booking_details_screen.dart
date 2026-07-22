// *****************************************************************************
// File        : booking_details_screen.dart
// Project     : Cab Booking Manager
// Description :
// Displays complete booking details.
//
// Responsibilities:
// • View booking details
// • Edit booking
// • Delete booking
// • Share booking
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/trip_type.dart';
import '../models/booking_model.dart';
import '../provider/booking_provider.dart';
import '../widgets/booking_action_bar.dart';
import '../widgets/booking_header.dart';
import '../widgets/booking_info_tile.dart';
import '../widgets/booking_section.dart';
import 'booking_form_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
const BookingDetailsScreen({
super.key,
required this.booking,
});

final BookingModel booking;

Future<void> _editBooking(
BuildContext context,
) async {
final provider = context.read<BookingProvider>();

final result = await Navigator.push<bool>(
context,
MaterialPageRoute(
builder: (_) => BookingFormScreen(
booking: booking,
),
),
);

if (result == true) {
await provider.loadBookings();
}

if (context.mounted) {
Navigator.pop(context, true);
}
}

Future<void> _deleteBooking(
BuildContext context,
) async {
final provider = context.read<BookingProvider>();

final confirm = await showDialog<bool>(
context: context,
builder: (dialogContext) {
return AlertDialog(
title: const Text('Delete Booking'),
content: Text(
'Delete booking ${booking.bookingId}?',
),
actions: [
TextButton(
onPressed: () =>
Navigator.pop(dialogContext, false),
child: const Text('Cancel'),
),
FilledButton(
onPressed: () =>
Navigator.pop(dialogContext, true),
child: const Text('Delete'),
),
],
);
},
);

if (confirm != true) return;

await provider.deleteBooking(
booking.id!,
);

if (!context.mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
'${booking.bookingId} deleted successfully.',
),
),
);

Navigator.pop(context, true);
}

void _shareBooking(
BuildContext context,
) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'WhatsApp sharing coming next.',
),
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Booking Details',
),
),

body: Column(
children: [
Expanded(
child: SingleChildScrollView(
child: Column(
children: [

BookingHeader(
booking: booking,
),

BookingSection(
title: 'Passenger Details',
icon: Icons.person,
children: [
BookingInfoTile(
title: 'Passenger Name',
value: booking.passengerName,
icon: Icons.person_outline,
),
BookingInfoTile(
title: 'Phone Number',
value: booking.passengerPhone,
icon: Icons.phone,
),
],
),

BookingSection(
title: 'Trip Details',
icon: Icons.route,
children: [
BookingInfoTile(
title: 'Trip Type',
value: booking.tripType.displayName,
icon: Icons.alt_route,
),
BookingInfoTile(
title: 'Reporting Time',
value: DateFormat(
'dd MMM yyyy hh:mm a',
).format(
booking.reportingDateTime,
),
icon: Icons.schedule,
),
],
),

BookingSection(
title: 'Route',
icon: Icons.location_on,
children: [
BookingInfoTile(
title: 'Pickup Address',
value: booking.reportingAddress,
icon: Icons.my_location,
),
BookingInfoTile(
title: 'Drop Address',
value: booking.dropAddress,
icon: Icons.location_on,
),
],
),
  BookingSection(
    title: 'Captain Details',
    icon: Icons.person_pin_circle,
    children: [
      BookingInfoTile(
        title: 'Captain Name',
        value: booking.captainName,
        icon: Icons.person_outline,
      ),
      BookingInfoTile(
        title: 'Captain Phone',
        value: booking.captainPhone,
        icon: Icons.phone,
      ),
    ],
  ),

  BookingSection(
    title: 'Vehicle Details',
    icon: Icons.directions_car,
    children: [
      BookingInfoTile(
        title: 'Vehicle Model',
        value: booking.vehicleModel,
        icon: Icons.local_taxi,
      ),
      BookingInfoTile(
        title: 'Vehicle Number',
        value: booking.vehicleNumber,
        icon: Icons.confirmation_number,
      ),
    ],
  ),

  BookingSection(
    title: 'Remarks',
    icon: Icons.sticky_note_2,
    children: [
      BookingInfoTile(
        title: 'Customer Remarks',
        value: booking.remarks.isEmpty
            ? 'No remarks'
            : booking.remarks,
        icon: Icons.note_alt_outlined,
      ),
    ],
  ),

  BookingSection(
    title: 'Office Notes',
    icon: Icons.description,
    children: [
      BookingInfoTile(
        title: 'Internal Notes',
        value: booking.notes.isEmpty
            ? 'No notes'
            : booking.notes,
        icon: Icons.description_outlined,
      ),
    ],
  ),

  const SizedBox(height: 16),
],
),
),
),

  BookingActionBar(
    onEdit: () => _editBooking(context),
    onShare: () => _shareBooking(context),
    onDelete: () => _deleteBooking(context),
  ),
],
),
);
}
}