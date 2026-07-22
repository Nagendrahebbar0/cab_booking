// *****************************************************************************
// File        : app_colors.dart
// Project     : Cab Booking Manager
// Description :
// Centralized application color definitions.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

/// Centralized application color definitions.
///
/// Do not use hardcoded colors anywhere in the project.
final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand Colors
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF1565C0);
  static const Color secondary = Color(0xFF42A5F5);

  // ---------------------------------------------------------------------------
  // Background Colors
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFFF5F5F5);

  /// Default surface/card color.
  static const Color surface = Colors.white;

  // ---------------------------------------------------------------------------
  // Status Colors
  // ---------------------------------------------------------------------------

  static const Color confirmed = Color(0xFF2E7D32);
  static const Color completed = Color(0xFF1565C0);
  static const Color cancelled = Color(0xFFC62828);

  // ---------------------------------------------------------------------------
  // Text Colors
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // ---------------------------------------------------------------------------
  // Utility Colors
  // ---------------------------------------------------------------------------

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color divider = Color(0xFFE0E0E0);
}