// *****************************************************************************
// File        : dashboard_stat_card.dart
// Project     : Cab Booking Manager
// Description :
// Reusable dashboard statistics card.
//
// Responsibilities:
// • Display statistic title
// • Display statistic value
// • Display statistic icon
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  /// Card title.
  final String title;

  /// Statistic value.
  final int value;

  /// Leading icon.
  final IconData icon;

  /// Card color.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              value.toString(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}