// *****************************************************************************
// File        : app_drawer.dart
// Project     : Cab Booking Manager
// Description :
// Application navigation drawer.
// *****************************************************************************

import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

/// Common navigation drawer.
class AppDrawer extends StatelessWidget {
  /// Creates the application drawer.
  const AppDrawer({super.key});

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
          const ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text(AppStrings.dashboard),
          ),
          const ListTile(
            leading: Icon(Icons.book_online_outlined),
            title: Text(AppStrings.bookings),
          ),
          const ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text(AppStrings.settings),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(AppStrings.about),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text(AppStrings.logout),
          ),
        ],
      ),
    );
  }
}