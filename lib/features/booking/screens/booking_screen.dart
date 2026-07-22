// *****************************************************************************
// File        : booking_screen.dart
// Project     : Cab Booking Manager
// Description :
// Displays all bookings.
//
// Responsibilities:
// • Display booking list
// • Search bookings
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
import '../provider/booking_provider.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_search_bar.dart';
import 'booking_form_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<BookingProvider>().loadBookings();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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


  Future<void> _searchBooking(
      String value,
      ) async {
    final provider = context.read<BookingProvider>();

    if (value.trim().isEmpty) {
      await provider.loadBookings();
    } else {
      await provider.searchBookings(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.bookings),
          ),
          body: Column(
            children: [
              BookingSearchBar(
                controller: _searchController,
                onChanged: _searchBooking,
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.refresh,
                  child: provider.isLoading
                      ? const Center(
                    child:
                    CircularProgressIndicator(),
                  )
                      : provider.bookings.isEmpty
                      ? ListView(
                    children: [
                      const SizedBox(height: 120),
                      const Icon(
                        Icons.search_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          _searchController
                              .text
                              .isEmpty
                              ? 'No bookings found'
                              : 'No matching bookings found',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                      : ListView.builder(
                    padding:
                    const EdgeInsets.all(12),
                    itemCount:
                    provider.bookings.length,
                    itemBuilder:
                        (context, index) {
                      final booking =
                      provider.bookings[
                      index];

                      return BookingCard(
                        booking: booking,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton:
          FloatingActionButton(
            onPressed: _openBookingForm,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}