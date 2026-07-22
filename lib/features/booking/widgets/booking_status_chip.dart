// *****************************************************************************
// File        : booking_status_chip.dart
// Project     : Cab Booking Manager
// Description :
// Displays booking status as a colored chip.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

import '../../../core/enums/booking_status.dart';

class BookingStatusChip extends StatelessWidget {
  const BookingStatusChip({
    super.key,
    required this.status,
  });

  final BookingStatus status;

  Color get _backgroundColor {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green.shade100;

      case BookingStatus.completed:
        return Colors.blue.shade100;

      case BookingStatus.cancelled:
        return Colors.red.shade100;
    }
  }

  Color get _textColor {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green.shade800;

      case BookingStatus.completed:
        return Colors.blue.shade800;

      case BookingStatus.cancelled:
        return Colors.red.shade800;
    }
  }

  IconData get _icon {
    switch (status) {
      case BookingStatus.confirmed:
        return Icons.check_circle;

      case BookingStatus.completed:
        return Icons.task_alt;

      case BookingStatus.cancelled:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        _icon,
        size: 18,
        color: _textColor,
      ),
      label: Text(
        status.displayName,
        style: TextStyle(
          color: _textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}