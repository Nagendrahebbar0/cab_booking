// *****************************************************************************
// File        : booking_section_card.dart
// Project     : Cab Booking Manager
// Description :
// Reusable section card used in booking forms.
//
// Responsibilities:
// • Display a section title.
// • Display section content.
// • Maintain consistent spacing and styling.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

/// A reusable card widget used to group related form fields.
class BookingSectionCard extends StatelessWidget {
  /// Creates a booking section card.
  const BookingSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
  });

  /// Section title.
  final String title;

  /// Optional leading icon.
  final IconData? icon;

  /// Section content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            child,
          ],
        ),
      ),
    );
  }
}