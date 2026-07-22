// *****************************************************************************
// File        : app_strings.dart
// Project     : Cab Booking Manager
// Description :
// Centralized application strings.
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

/// Centralized application strings.
///
/// Do not hardcode user-visible text in widgets.
final class AppStrings {
  AppStrings._();

  // Application
  static const String appName = 'Cab Booking Manager';
  static const String appVersion = '1.0.0';

  // Drawer
  static const String dashboard = 'Dashboard';
  static const String bookings = 'Bookings';
  static const String settings = 'Settings';
  static const String about = 'About';
  static const String logout = 'Logout';

  // Dashboard
  static const String totalBookings = 'Total Bookings';
  static const String confirmed = 'Confirmed';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
  static const String todaysBookings = "Today's Bookings";

  // Common
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String yes = 'Yes';
  static const String no = 'No';
}