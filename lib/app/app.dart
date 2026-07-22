// *****************************************************************************
// File        : app.dart
// Project     : Cab Booking Manager
// Description :
// Root application widget.
//
// Responsibilities:
// • Configure providers.
// • Configure the MaterialApp.
// • Apply the application theme.
// • Configure application title.
// • Set the initial screen.
//
// Author      : H S Nagendra Hebbar
// Created     : 2026
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/booking/provider/booking_provider.dart';
import '../features/dashboard/dashboard_screen.dart';
import 'app_theme.dart';

/// Root widget of the Cab Booking Manager application.
class CabBookingManagerApp extends StatelessWidget {
  /// Creates the root application widget.
  const CabBookingManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingProvider(),
      child: MaterialApp(
        title: 'Cab Booking Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const DashboardScreen(),
      ),
    );
  }
}