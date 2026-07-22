// *****************************************************************************
// File        : booking_info_tile.dart
// Project     : Cab Booking Manager
// Description :
// Reusable information tile used throughout the application.
//
// Responsibilities:
// • Display a title and value
// • Show optional leading icon
// • Maintain consistent spacing
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

/// Displays a label and value in a clean card layout.
class BookingInfoTile extends StatelessWidget {
  const BookingInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  /// Field title.
  final String title;

  /// Field value.
  final String value;

  /// Optional leading icon.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 22,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value.isEmpty ? '-' : value,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}