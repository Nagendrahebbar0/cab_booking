// *****************************************************************************
// File        : app_drawer.dart
// Project     : Cab Booking Manager
// Description :
// Application navigation drawer.
// *****************************************************************************

import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../features/booking/screens/booking_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/reports/screens/reports_screen.dart';

/// Common navigation drawer.
class AppDrawer extends StatelessWidget {
  /// Creates the application drawer.
  const AppDrawer({
    super.key,
  });

  void _navigate(
      BuildContext context,
      Widget screen,
      ) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                AppStrings.appName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //--------------------------------------------------------------------
          // Dashboard
          //--------------------------------------------------------------------

          ListTile(
            leading: const Icon(
              Icons.dashboard_outlined,
            ),
            title: const Text(
              AppStrings.dashboard,
            ),
            onTap: () {
              _navigate(
                context,
                const DashboardScreen(),
              );
            },
          ),

          //--------------------------------------------------------------------
          // Bookings
          //--------------------------------------------------------------------

          ListTile(
            leading: const Icon(
              Icons.book_online_outlined,
            ),
            title: const Text(
              AppStrings.bookings,
            ),
            onTap: () {
              _navigate(
                context,
                const BookingScreen(),
              );
            },
          ),

          //--------------------------------------------------------------------
          // Reports
          //--------------------------------------------------------------------

          ListTile(
            leading: const Icon(
              Icons.assessment_outlined,
            ),
            title: const Text(
              'Reports',
            ),
            onTap: () {
              _navigate(
                context,
                const ReportsScreen(),
              );
            },
          ),

          const Divider(),

          //--------------------------------------------------------------------
          // Settings
          //--------------------------------------------------------------------

          const ListTile(
            leading: Icon(
              Icons.settings_outlined,
            ),
            title: Text(
              AppStrings.settings,
            ),
          ),

          //--------------------------------------------------------------------
          // About
          //--------------------------------------------------------------------

          const ListTile(
            leading: Icon(
              Icons.info_outline,
            ),
            title: Text(
              AppStrings.about,
            ),
          ),

          const Divider(),

          //--------------------------------------------------------------------
          // Logout
          //--------------------------------------------------------------------

          const ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: Text(
              AppStrings.logout,
            ),
          ),
        ],
      ),
    );
  }
}