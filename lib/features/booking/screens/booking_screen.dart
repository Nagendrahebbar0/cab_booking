// *****************************************************************************
// File        : booking_screen.dart
// Project     : Cab Booking Manager
// Description :
// Displays all bookings.
//
// Responsibilities:
// • Display booking list
// • Navigate to Add Booking screen
// • Refresh bookings
// • Edit bookings
// • Delete bookings
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../models/booking_model.dart';
import '../provider/booking_provider.dart';
import '../widgets/booking_card.dart';
import 'booking_form_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<BookingProvider>().loadBookings();
    });
  }

  Future<void> _openBookingForm() async {
    final provider = context.read<BookingProvider>();

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const BookingFormScreen(),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      await provider.loadBookings();
    }
  }

  Future<void> _editBooking(
      BookingModel booking,
      ) async {
    final provider = context.read<BookingProvider>();

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => BookingFormScreen(
          booking: booking,
        ),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      await provider.loadBookings();
    }
  }

  Future<void> _deleteBooking(
      BookingModel booking,
      ) async {
    final provider = context.read<BookingProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Booking'),
          content: Text(
            'Are you sure you want to delete booking ${booking.bookingId}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await provider.deleteBooking(booking.id!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking ${booking.bookingId} deleted successfully.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.bookings),
          ),
          body: RefreshIndicator(
            onRefresh: provider.refresh,
            child: provider.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.bookings.isEmpty
                ? ListView(
              children: const [
                SizedBox(height: 120),
                Icon(
                  Icons.book_online_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'No bookings found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.bookings.length,
              itemBuilder: (context, index) {
                final booking = provider.bookings[index];

                return BookingCard(
                  booking: booking,
                  onEdit: () => _editBooking(booking),
                  onDelete: () => _deleteBooking(booking),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _openBookingForm,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}