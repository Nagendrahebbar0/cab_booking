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
import '../features/booking/repository/booking_repository.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/provider/dashboard_provider.dart';
import '../features/dashboard/repository/dashboard_repository.dart';

import '../features/reports/provider/report_provider.dart';
import '../features/reports/repository/report_repository.dart';

import 'app_theme.dart';

/// Root widget of the Cab Booking Manager application.
class CabBookingManagerApp extends StatelessWidget {
  /// Creates the root application widget.
  const CabBookingManagerApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //----------------------------------------------------------------------
        // Booking Provider
        //----------------------------------------------------------------------

        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),

        //----------------------------------------------------------------------
        // Dashboard Provider
        //----------------------------------------------------------------------

        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => DashboardProvider(
            dashboardRepository: DashboardRepository(
              bookingRepository: BookingRepository.instance,
            ),
          ),
        ),

        //----------------------------------------------------------------------
        // Report Provider
        //----------------------------------------------------------------------

        ChangeNotifierProvider<ReportProvider>(
          create: (_) => ReportProvider(
            reportRepository: ReportRepository(
              bookingRepository: BookingRepository.instance,
            ),
          ),
        ),
      ],

      child: MaterialApp(
        title: 'Cab Booking Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const DashboardScreen(),
      ),
    );
  }
}