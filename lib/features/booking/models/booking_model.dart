// *****************************************************************************
// File        : booking_model.dart
// Project     : Cab Booking Manager
// Description :
// Immutable booking model used throughout the application.
//
// Responsibilities:
// • Represents a cab booking.
// • Supports SQLite serialization.
// • Supports JSON serialization.
// • Supports immutable updates using copyWith().
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import '../../../core/database/database_constants.dart';
import '../../../core/enums/booking_status.dart';
import '../../../core/enums/trip_type.dart';

/// Immutable booking model.
class BookingModel {
/// Internal SQLite row ID.
final int? id;

/// Booking number.
///
/// Example:
/// SGC000001
final String bookingId;

/// Trip type.
final TripType tripType;

/// Passenger name.
final String passengerName;

/// Passenger phone number.
final String passengerPhone;

/// Reporting date and time.
final DateTime reportingDateTime;

/// Pickup address.
final String reportingAddress;

/// Drop address.
final String dropAddress;

/// Customer remarks.
final String remarks;

/// Internal office notes.
final String notes;

/// Driver/Captain name.
final String captainName;

/// Driver/Captain phone.
final String captainPhone;

/// Vehicle model.
final String vehicleModel;

/// Vehicle registration number.
final String vehicleNumber;

/// Booking status.
final BookingStatus status;

/// Cancellation reason.
final String cancelReason;

/// Soft delete flag.
final bool isDeleted;

/// Record creation timestamp.
final DateTime createdAt;

/// Record last update timestamp.
final DateTime updatedAt;

/// Creates a booking.
const BookingModel({
this.id,
required this.bookingId,
required this.tripType,
required this.passengerName,
required this.passengerPhone,
required this.reportingDateTime,
required this.reportingAddress,
required this.dropAddress,
this.remarks = '',
this.notes = '',
required this.captainName,
required this.captainPhone,
required this.vehicleModel,
required this.vehicleNumber,
this.status = BookingStatus.confirmed,
this.cancelReason = '',
this.isDeleted = false,
required this.createdAt,
required this.updatedAt,
});

/// Creates a modified copy of this booking.
BookingModel copyWith({
int? id,
String? bookingId,
TripType? tripType,
String? passengerName,
String? passengerPhone,
DateTime? reportingDateTime,
String? reportingAddress,
String? dropAddress,
String? remarks,
String? notes,
String? captainName,
String? captainPhone,
String? vehicleModel,
String? vehicleNumber,
BookingStatus? status,
String? cancelReason,
bool? isDeleted,
DateTime? createdAt,
DateTime? updatedAt,
}) {
return BookingModel(
id: id ?? this.id,
bookingId: bookingId ?? this.bookingId,
tripType: tripType ?? this.tripType,
passengerName: passengerName ?? this.passengerName,
passengerPhone: passengerPhone ?? this.passengerPhone,
reportingDateTime:
reportingDateTime ?? this.reportingDateTime,
reportingAddress:
reportingAddress ?? this.reportingAddress,
dropAddress: dropAddress ?? this.dropAddress,
remarks: remarks ?? this.remarks,
notes: notes ?? this.notes,
captainName: captainName ?? this.captainName,
captainPhone: captainPhone ?? this.captainPhone,
vehicleModel: vehicleModel ?? this.vehicleModel,
vehicleNumber: vehicleNumber ?? this.vehicleNumber,
status: status ?? this.status,
cancelReason: cancelReason ?? this.cancelReason,
isDeleted: isDeleted ?? this.isDeleted,
createdAt: createdAt ?? this.createdAt,
updatedAt: updatedAt ?? this.updatedAt,
);
}
/// Converts this booking into a SQLite compatible map.
Map<String, dynamic> toMap() {
return {
BookingColumns.id: id,
BookingColumns.bookingId: bookingId,
BookingColumns.tripType: tripType.databaseValue,
BookingColumns.passengerName: passengerName,
BookingColumns.passengerPhone: passengerPhone,
BookingColumns.reportingDateTime:
reportingDateTime.toIso8601String(),
BookingColumns.reportingAddress: reportingAddress,
BookingColumns.dropAddress: dropAddress,
BookingColumns.remarks: remarks,
BookingColumns.notes: notes,
BookingColumns.captainName: captainName,
BookingColumns.captainPhone: captainPhone,
BookingColumns.vehicleModel: vehicleModel,
BookingColumns.vehicleNumber: vehicleNumber,
BookingColumns.status: status.databaseValue,
BookingColumns.cancelReason: cancelReason,
BookingColumns.isDeleted: isDeleted ? 1 : 0,
BookingColumns.createdAt: createdAt.toIso8601String(),
BookingColumns.updatedAt: updatedAt.toIso8601String(),
};
}

/// Alias for JSON serialization.
///
/// Firebase and other APIs can directly use this map.
Map<String, dynamic> toJson() => toMap();

/// Creates a booking model from a SQLite map.
factory BookingModel.fromMap(
Map<String, dynamic> map,
) {
return BookingModel(
id: map[BookingColumns.id] as int?,
bookingId:
map[BookingColumns.bookingId] as String,
tripType: TripTypeExtension.fromDatabase(
map[BookingColumns.tripType] as String,
),
passengerName:
map[BookingColumns.passengerName] as String,
passengerPhone:
map[BookingColumns.passengerPhone] as String,
reportingDateTime: DateTime.parse(
map[BookingColumns.reportingDateTime] as String,
),
reportingAddress:
map[BookingColumns.reportingAddress] as String,
dropAddress:
map[BookingColumns.dropAddress] as String,
remarks:
map[BookingColumns.remarks] as String? ?? '',
notes:
map[BookingColumns.notes] as String? ?? '',
captainName:
map[BookingColumns.captainName] as String,
captainPhone:
map[BookingColumns.captainPhone] as String,
vehicleModel:
map[BookingColumns.vehicleModel] as String,
vehicleNumber:
map[BookingColumns.vehicleNumber] as String,
status: BookingStatusExtension.fromDatabase(
map[BookingColumns.status] as String,
),
cancelReason:
map[BookingColumns.cancelReason] as String? ??
'',
isDeleted:
(map[BookingColumns.isDeleted] as int? ?? 0) ==
1,
createdAt: DateTime.parse(
map[BookingColumns.createdAt] as String,
),
updatedAt: DateTime.parse(
map[BookingColumns.updatedAt] as String,
),
);
}

/// Creates a booking model from JSON.
factory BookingModel.fromJson(
Map<String, dynamic> json,
) {
return BookingModel.fromMap(json);
}
@override
bool operator ==(Object other) {
if (identical(this, other)) {
return true;
}

return other is BookingModel &&
other.id == id &&
other.bookingId == bookingId &&
other.tripType == tripType &&
other.passengerName == passengerName &&
other.passengerPhone == passengerPhone &&
other.reportingDateTime == reportingDateTime &&
other.reportingAddress == reportingAddress &&
other.dropAddress == dropAddress &&
other.remarks == remarks &&
other.notes == notes &&
other.captainName == captainName &&
other.captainPhone == captainPhone &&
other.vehicleModel == vehicleModel &&
other.vehicleNumber == vehicleNumber &&
other.status == status &&
other.cancelReason == cancelReason &&
other.isDeleted == isDeleted &&
other.createdAt == createdAt &&
other.updatedAt == updatedAt;
}

@override
int get hashCode {
return Object.hash(
id,
bookingId,
tripType,
passengerName,
passengerPhone,
reportingDateTime,
reportingAddress,
dropAddress,
remarks,
notes,
captainName,
captainPhone,
vehicleModel,
vehicleNumber,
status,
cancelReason,
isDeleted,
createdAt,
updatedAt,
);
}
@override
String toString() {
  return '''
BookingModel(
  id: $id,
  bookingId: $bookingId,
  tripType: ${tripType.displayName},
  passengerName: $passengerName,
  passengerPhone: $passengerPhone,
  reportingDateTime: $reportingDateTime,
  reportingAddress: $reportingAddress,
  dropAddress: $dropAddress,
  remarks: $remarks,
  notes: $notes,
  captainName: $captainName,
  captainPhone: $captainPhone,
  vehicleModel: $vehicleModel,
  vehicleNumber: $vehicleNumber,
  status: ${status.displayName},
  cancelReason: $cancelReason,
  isDeleted: $isDeleted,
  createdAt: $createdAt,
  updatedAt: $updatedAt
)
''';
}
}