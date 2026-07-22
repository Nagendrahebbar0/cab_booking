// *****************************************************************************
// File        : booking_form_screen.dart
// Project     : Cab Booking Manager
// Description :
// Screen used to create a new booking.
//
// Responsibilities:
// • Collect booking information
// • Validate user input
// • Save booking using BookingProvider
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/enums/booking_status.dart';
import '../../../core/enums/trip_type.dart';
import '../../../shared/widgets/app_date_time_field.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/booking_section_card.dart';
import '../models/booking_model.dart';
import '../provider/booking_provider.dart';

/// Booking creation screen.
class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({
    super.key,
    this.booking,
  });

  /// Booking to edit.
  ///
  /// If null, the screen works in Create mode.
  final BookingModel? booking;

  @override
  State<BookingFormScreen> createState() =>
      _BookingFormScreenState();
}

class _BookingFormScreenState
    extends State<BookingFormScreen> {
final _formKey = GlobalKey<FormState>();

// Passenger

final _passengerNameController =
TextEditingController();

final _passengerPhoneController =
TextEditingController();

// Trip

final _reportingDateTimeController =
TextEditingController();

final _reportingAddressController =
TextEditingController();

final _dropAddressController =
TextEditingController();

// Driver

final _captainNameController =
TextEditingController();

final _captainPhoneController =
TextEditingController();

// Vehicle

final _vehicleModelController =
TextEditingController();

final _vehicleNumberController =
TextEditingController();

// Additional

final _remarksController =
TextEditingController();

final _notesController =
TextEditingController();

TripType _tripType = TripType.oneWay;

DateTime? _reportingDateTime;

bool _isSaving = false;
bool get _isEditMode => widget.booking != null;
  @override
  void initState() {
    super.initState();

    _initializeForm();
  }
  void _initializeForm() {
    if (!_isEditMode) {
      return;
    }

    final booking = widget.booking!;

    _passengerNameController.text = booking.passengerName;
    _passengerPhoneController.text = booking.passengerPhone;

    _tripType = booking.tripType;

    _reportingDateTime = booking.reportingDateTime;

    _reportingDateTimeController.text =
        DateFormat('dd/MM/yyyy hh:mm a')
            .format(booking.reportingDateTime);

    _reportingAddressController.text =
        booking.reportingAddress;

    _dropAddressController.text =
        booking.dropAddress;

    _captainNameController.text =
        booking.captainName;

    _captainPhoneController.text =
        booking.captainPhone;

    _vehicleModelController.text =
        booking.vehicleModel;

    _vehicleNumberController.text =
        booking.vehicleNumber;

    _remarksController.text =
        booking.remarks;

    _notesController.text =
        booking.notes;
  }
@override
void dispose() {
_passengerNameController.dispose();
_passengerPhoneController.dispose();
_reportingDateTimeController.dispose();
_reportingAddressController.dispose();
_dropAddressController.dispose();
_captainNameController.dispose();
_captainPhoneController.dispose();
_vehicleModelController.dispose();
_vehicleNumberController.dispose();
_remarksController.dispose();
_notesController.dispose();

super.dispose();
}

String? _requiredValidator(String? value) {
if (value == null || value.trim().isEmpty) {
return 'This field is required';
}

return null;
}
Widget _buildPassengerSection() {
return BookingSectionCard(
title: AppStrings.passengerDetails,
icon: Icons.person,
child: Column(
children: [
AppTextField(
controller: _passengerNameController,
label: AppStrings.passengerName,
prefixIcon: Icons.person_outline,
textInputAction: TextInputAction.next,
validator: _requiredValidator,
),

AppTextField(
controller: _passengerPhoneController,
label: AppStrings.passengerPhone,
prefixIcon: Icons.phone,
keyboardType: TextInputType.phone,
textInputAction: TextInputAction.next,
validator: _requiredValidator,
),

DropdownButtonFormField<TripType>(
initialValue: _tripType,
decoration: const InputDecoration(
labelText: AppStrings.tripType,
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.route),
),
items: TripType.values.map((tripType) {
return DropdownMenuItem<TripType>(
value: tripType,
child: Text(tripType.displayName),
);
}).toList(),
onChanged: (value) {
if (value == null) return;

setState(() {
_tripType = value;
});
},
),
],
),
);
}

Widget _buildTripSection() {
return BookingSectionCard(
title: AppStrings.tripDetails,
icon: Icons.location_on,
child: Column(
children: [
AppDateTimeField(
controller: _reportingDateTimeController,
onDateTimeSelected: (dateTime) {
_reportingDateTime = dateTime;
},
),

const SizedBox(height: 16),

AppTextField(
controller: _reportingAddressController,
label: AppStrings.reportingAddress,
prefixIcon: Icons.my_location,
maxLines: 2,
validator: _requiredValidator,
),

AppTextField(
controller: _dropAddressController,
label: AppStrings.dropAddress,
prefixIcon: Icons.location_pin,
maxLines: 2,
validator: _requiredValidator,
),
],
),
);
}

Widget _buildDriverVehicleSection() {
return BookingSectionCard(
title: AppStrings.driverVehicleDetails,
icon: Icons.directions_car,
child: Column(
children: [
AppTextField(
controller: _captainNameController,
label: AppStrings.captainName,
prefixIcon: Icons.person,
validator: _requiredValidator,
),

AppTextField(
controller: _captainPhoneController,
label: AppStrings.captainPhone,
prefixIcon: Icons.phone_android,
keyboardType: TextInputType.phone,
validator: _requiredValidator,
),

AppTextField(
controller: _vehicleModelController,
label: AppStrings.vehicleModel,
prefixIcon: Icons.directions_car_filled,
validator: _requiredValidator,
),

AppTextField(
controller: _vehicleNumberController,
label: AppStrings.vehicleNumber,
prefixIcon: Icons.confirmation_number,
validator: _requiredValidator,
),
],
),
);
}

Widget _buildAdditionalSection() {
return BookingSectionCard(
title: AppStrings.additionalInformation,
icon: Icons.notes,
child: Column(
children: [
AppTextField(
controller: _remarksController,
label: AppStrings.remarks,
prefixIcon: Icons.note_alt_outlined,
maxLines: 3,
),

AppTextField(
controller: _notesController,
label: AppStrings.officeNotes,
prefixIcon: Icons.sticky_note_2_outlined,
maxLines: 3,
),
],
),
);
}
Future<void> _saveBooking() async {
if (!_formKey.currentState!.validate()) {
return;
}

if (_reportingDateTime == null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Please select Reporting Date & Time',
),
),
);
return;
}

setState(() {
_isSaving = true;
});

try {
final provider = context.read<BookingProvider>();

final booking = BookingModel(
bookingId: '',
tripType: _tripType,
passengerName:
_passengerNameController.text.trim(),
passengerPhone:
_passengerPhoneController.text.trim(),
reportingDateTime: _reportingDateTime!,
reportingAddress:
_reportingAddressController.text.trim(),
dropAddress:
_dropAddressController.text.trim(),
remarks: _remarksController.text.trim(),
notes: _notesController.text.trim(),
captainName:
_captainNameController.text.trim(),
captainPhone:
_captainPhoneController.text.trim(),
vehicleModel:
_vehicleModelController.text.trim(),
vehicleNumber:
_vehicleNumberController.text.trim(),
status: BookingStatus.confirmed,
cancelReason: '',
isDeleted: false,
createdAt: DateTime.now(),
updatedAt: DateTime.now(),
);

if (_isEditMode) {
  final updatedBooking = booking.copyWith(
    id: widget.booking!.id,
    bookingId: widget.booking!.bookingId,
    createdAt: widget.booking!.createdAt,
    updatedAt: DateTime.now(),
  );

  await provider.updateBooking(updatedBooking);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Booking updated successfully.'),
      backgroundColor: Colors.green,
    ),
  );
} else {
  final savedBooking =
  await provider.createBooking(booking);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Booking ${savedBooking.bookingId} created successfully.',
      ),
      backgroundColor: Colors.green,
    ),
  );
}

Navigator.of(context).pop(true);} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
'Failed to save booking.\n$e',
),
backgroundColor: Colors.red,
),
);
} finally {
if (mounted) {
setState(() {
_isSaving = false;
});
}
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? 'Edit Booking'
              : AppStrings.newBooking,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPassengerSection(),

                _buildTripSection(),

                _buildDriverVehicleSection(),

                _buildAdditionalSection(),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed:
                    _isSaving ? null : _saveBooking,
                    icon: _isSaving
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Icon(Icons.save),
                    label: Text(
                      _isSaving
                          ? 'Saving...'
                          : _isEditMode
                          ? 'Update Booking'
                          : AppStrings.saveBooking,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}