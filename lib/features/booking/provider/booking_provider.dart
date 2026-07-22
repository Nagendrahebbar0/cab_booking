// *****************************************************************************
// File        : booking_provider.dart
// Project     : Cab Booking Manager
// Description :
// State management for bookings.
//
// Responsibilities:
// • Load bookings
// • Create booking
// • Update booking
// • Delete booking
// • Restore booking
// • Search bookings
// • Notify UI about changes
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/foundation.dart';

import '../models/booking_model.dart';
import '../repository/booking_repository.dart';

/// Provider responsible for managing booking state.
class BookingProvider extends ChangeNotifier {
  BookingProvider();

  final BookingRepository _repository = BookingRepository.instance;

  List<BookingModel> _bookings = [];

  bool _isLoading = false;

  String _searchKeyword = '';

  /// Current bookings.
  List<BookingModel> get bookings => _bookings;

  /// Loading indicator.
  bool get isLoading => _isLoading;

  /// Current search text.
  String get searchKeyword => _searchKeyword;

  /// Loads all bookings.
  Future<void> loadBookings() async {
    _setLoading(true);

    _bookings = await _repository.getAllBookings();

    _setLoading(false);
  }

  /// Creates a booking and returns the saved booking.
  Future<BookingModel> createBooking(
      BookingModel booking,
      ) async {
    _setLoading(true);

    final createdBooking =
    await _repository.createBooking(booking);

    await loadBookings();

    _setLoading(false);

    return createdBooking;
  }

  /// Updates a booking.
  Future<void> updateBooking(
      BookingModel booking,
      ) async {
    _setLoading(true);

    await _repository.updateBooking(booking);

    await loadBookings();

    _setLoading(false);
  }

  /// Soft deletes a booking.
  Future<void> deleteBooking(
      int id,
      ) async {
    _setLoading(true);

    await _repository.deleteBooking(id);

    await loadBookings();

    _setLoading(false);
  }

  /// Restores a booking.
  Future<void> restoreBooking(
      int id,
      ) async {
    _setLoading(true);

    await _repository.restoreBooking(id);

    await loadBookings();

    _setLoading(false);
  }

  /// Searches bookings.
  Future<void> searchBookings(
      String keyword,
      ) async {
    _searchKeyword = keyword;

    if (keyword.trim().isEmpty) {
      await loadBookings();
      return;
    }

    _setLoading(true);

    _bookings =
    await _repository.searchBookings(keyword);

    _setLoading(false);
  }

  /// Refreshes booking list.
  Future<void> refresh() async {
    await loadBookings();
  }

  /// Returns total booking count.
  int get totalBookings => _bookings.length;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}