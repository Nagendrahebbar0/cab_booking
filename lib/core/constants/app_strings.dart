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

  //==========================================================================
  // Application
  //==========================================================================

  static const String appName = 'Cab Booking Manager';
  static const String appVersion = '1.0.0';

  //==========================================================================
  // Drawer
  //==========================================================================

  static const String dashboard = 'Dashboard';
  static const String bookings = 'Bookings';
  static const String settings = 'Settings';
  static const String about = 'About';
  static const String logout = 'Logout';

  //==========================================================================
  // Dashboard
  //==========================================================================

  static const String totalBookings = 'Total Bookings';
  static const String confirmed = 'Confirmed';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
  static const String todaysBookings = "Today's Bookings";

  //==========================================================================
  // Booking Form
  //==========================================================================

  static const String newBooking = 'New Booking';
  static const String editBooking = 'Edit Booking';

  static const String passengerDetails = 'Passenger Details';
  static const String tripDetails = 'Trip Details';
  static const String driverVehicleDetails = 'Driver & Vehicle';
  static const String additionalInformation = 'Additional Information';

  static const String passengerName = 'Passenger Name';
  static const String passengerPhone = 'Passenger Phone';

  static const String tripType = 'Trip Type';

  static const String oneWay = 'One Way';
  static const String roundTrip = 'Round Trip';

  static const String reportingDateTime =
      'Reporting Date & Time';

  static const String reportingAddress =
      'Reporting Address';

  static const String dropAddress = 'Drop Address';

  static const String captainName = 'Captain Name';
  static const String captainPhone = 'Captain Phone';

  static const String vehicleModel = 'Vehicle Model';
  static const String vehicleNumber =
      'Vehicle Registration Number';

  static const String remarks = 'Remarks';
  static const String officeNotes = 'Office Notes';

  static const String saveBooking = 'Save Booking';

  //==========================================================================
  // Validation Messages
  //==========================================================================

  static const String fieldRequired =
      'This field is required';

  static const String invalidPhone =
      'Please enter a valid phone number';

  //==========================================================================
  // Success Messages
  //==========================================================================

  static const String bookingSaved =
      'Booking saved successfully';

  static const String bookingUpdated =
      'Booking updated successfully';

  static const String bookingDeleted =
      'Booking deleted successfully';

  //==========================================================================
  // Empty States
  //==========================================================================

  static const String noBookings =
      'No bookings found';

  //==========================================================================
  // Common
  //==========================================================================

  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String yes = 'Yes';
  static const String no = 'No';

  static const String loading = 'Loading...';

  static const String retry = 'Retry';

  static const String close = 'Close';
}