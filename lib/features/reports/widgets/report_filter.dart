// *****************************************************************************
// File        : report_filter.dart
// Project     : Cab Booking Manager
// Description :
// Report filter widget.
//
// Responsibilities:
// • Select date range
// • Filter report
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

class ReportFilter extends StatelessWidget {
  const ReportFilter({
    super.key,
    this.onDateRangeTap,
    this.onStatusTap,
  });

  /// Called when date range filter is pressed.
  final VoidCallback? onDateRangeTap;

  /// Called when status filter is pressed.
  final VoidCallback? onStatusTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onDateRangeTap,
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    label: const Text(
                      'Date Range',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onStatusTap,
                    icon: const Icon(
                      Icons.filter_alt,
                    ),
                    label: const Text(
                      'Status',
                    ),
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