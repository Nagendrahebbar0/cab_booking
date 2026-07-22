// *****************************************************************************
// File        : dashboard_screen.dart
// Project     : Cab Booking Manager
// Description :
// Dashboard screen displayed when the application starts.
// *****************************************************************************

import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/drawer/app_drawer.dart';
import '../booking/screens/booking_screen.dart';

/// Dashboard screen.
class DashboardScreen extends StatelessWidget {
  /// Creates the dashboard screen.
  const DashboardScreen({super.key});

  Widget _buildStatCard(
      BuildContext context,
      String title,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          _buildStatCard(
            context,
            AppStrings.totalBookings,
          ),
          _buildStatCard(
            context,
            AppStrings.confirmed,
          ),
          _buildStatCard(
            context,
            AppStrings.completed,
          ),
          _buildStatCard(
            context,
            AppStrings.cancelled,
          ),
          _buildStatCard(
            context,
            AppStrings.todaysBookings,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const BookingScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}