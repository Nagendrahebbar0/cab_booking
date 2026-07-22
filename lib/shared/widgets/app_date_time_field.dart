// *****************************************************************************
// File        : app_date_time_field.dart
// Project     : Cab Booking Manager
// Description :
// Reusable Date & Time picker.
//
// Features:
// • Read-only field
// • Tap anywhere to open picker
// • Material Date Picker
// • Material Time Picker
// • Defaults to current date/time
// • Rounds time to next 5-minute interval
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateTimeField extends StatelessWidget {
  const AppDateTimeField({
    super.key,
    required this.controller,
    required this.onDateTimeSelected,
    this.label = 'Reporting Date & Time',
  });

  final TextEditingController controller;
  final String label;
  final ValueChanged<DateTime> onDateTimeSelected;

  Future<void> _pickDateTime(BuildContext context) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (!context.mounted || date == null) {
      return;
    }

    final roundedMinute = ((now.minute + 4) ~/ 5) * 5;

    final roundedHour = roundedMinute == 60
        ? (now.hour + 1) % 24
        : now.hour;

    final roundedTime = TimeOfDay(
      hour: roundedHour,
      minute: roundedMinute == 60 ? 0 : roundedMinute,
    );

    final time = await showTimePicker(
      context: context,
      initialTime: roundedTime,
    );

    if (!context.mounted || time == null) {
      return;
    }

    final selected = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    controller.text =
        DateFormat('dd/MM/yyyy hh:mm a').format(selected);

    onDateTimeSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      showCursor: false,
      onTap: () => _pickDateTime(context),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: const Icon(Icons.schedule),
          onPressed: () => _pickDateTime(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}