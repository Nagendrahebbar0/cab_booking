// *****************************************************************************
// File        : booking_search_bar.dart
// Project     : Cab Booking Manager
// Description :
// Reusable search bar for bookings.
// *****************************************************************************

import 'package:flutter/material.dart';

class BookingSearchBar extends StatefulWidget {
  const BookingSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<BookingSearchBar> createState() =>
      _BookingSearchBarState();
}

class _BookingSearchBarState
    extends State<BookingSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Search Booking...',
          prefixIcon: const Icon(Icons.search),

          suffixIcon: widget.controller.text.isEmpty
              ? null
              : IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear();
              widget.onChanged('');
            },
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}