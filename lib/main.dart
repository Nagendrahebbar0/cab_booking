// *****************************************************************************
// File        : main.dart
// Project     : Cab Booking Manager
// Description :
// Entry point of the Cab Booking Manager application.
// Initializes Flutter bindings and launches the root application.
//
// Author      : H S Nagendra Hebbar
// Created     : 2026
// *****************************************************************************

import 'package:flutter/material.dart';

import 'app/app.dart';

/// Entry point of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CabBookingManagerApp());
}