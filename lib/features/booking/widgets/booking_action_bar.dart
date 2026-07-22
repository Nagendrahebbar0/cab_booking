// *****************************************************************************
// File        : booking_action_bar.dart
// Project     : Cab Booking Manager
// Description :
// Reusable action bar for booking operations.
//
// Responsibilities:
// • Edit booking
// • Share booking
// • Delete booking
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

class BookingActionBar extends StatelessWidget {
  const BookingActionBar({
    super.key,
    required this.onEdit,
    required this.onShare,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: const Border(
            top: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: onShare,
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: onDelete,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}