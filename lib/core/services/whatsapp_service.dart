// *****************************************************************************
// File        : whatsapp_service.dart
// Project     : Cab Booking Manager
// Description :
// Provides WhatsApp sharing functionality.
//
// Responsibilities:
// • Generate booking message
// • Launch WhatsApp
// • Fallback to wa.me if needed
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/booking/models/booking_model.dart';

class WhatsAppService {
  WhatsAppService._();

  static Future<void> shareBooking(
      BuildContext context,
      BookingModel booking, {
        required String supportNumber,
      }) async {
    final message = '''
Hello!

Please find the updated vehicle & driver details for your booking.

Booking ID: ${booking.bookingId}

Passenger:
${booking.passengerName} (${booking.passengerPhone})

Reporting On:
${DateFormat('dd MMM yyyy hh:mm a').format(booking.reportingDateTime)}

Reporting Address:
${booking.reportingAddress}

Drop Address:
${booking.dropAddress}

Remarks:
${booking.remarks.isEmpty ? "-" : booking.remarks}

Captain's Name:
${booking.captainName}

Captain's Phone:
${booking.captainPhone}

Vehicle:
${booking.vehicleModel}

Vehicle Number:
${booking.vehicleNumber}

For any assistance, please feel free to contact us.

Regards,

SRI GURU CABS®

Customer Support
📞 +91 $supportNumber
''';

    final encodedMessage = Uri.encodeComponent(message);

    final whatsappUri = Uri.parse(
      'whatsapp://send?text=$encodedMessage',
    );

    final waMeUri = Uri.parse(
      'https://wa.me/?text=$encodedMessage',
    );

    try {
      final launched = await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        return;
      }
    } catch (_) {
      // Try fallback below.
    }

    try {
      final launched = await launchUrl(
        waMeUri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        return;
      }
    } catch (_) {
      // Fall through to error.
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to open WhatsApp. Please make sure it is installed.',
        ),
      ),
    );
  }
}