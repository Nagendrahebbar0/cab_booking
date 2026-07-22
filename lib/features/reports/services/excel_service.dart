// *****************************************************************************
// File        : excel_service.dart
// Project     : Cab Booking Manager
// Description :
// Professional Excel Report Generator.
//
// Responsibilities:
// • Generate booking reports
// • Create workbook
// • Create worksheets
// • Export Excel file
// • Share Excel report
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';

import '../../../core/enums/booking_status.dart';
import '../../../core/enums/trip_type.dart';
import '../../booking/models/booking_model.dart';
import '../models/report_model.dart';

/// Professional Excel report generator.
class ExcelService {
ExcelService._();

/// Singleton instance.
static final ExcelService instance =
ExcelService._();

//--------------------------------------------------------------------------
// Generate Workbook
//--------------------------------------------------------------------------

Future<Uint8List> generateReport({
required ReportModel report,
required String reportTitle,
}) async {
final excel = Excel.createExcel();

final Sheet sheet =
excel['Booking Report'];

//----------------------------------------------------------------------
// Company Header
//----------------------------------------------------------------------

_buildHeader(
sheet,
reportTitle,
);

//----------------------------------------------------------------------
// Summary
//----------------------------------------------------------------------

_buildSummary(
sheet,
report,
);

//----------------------------------------------------------------------
// Booking Table
//----------------------------------------------------------------------

_buildBookingTable(
sheet,
report.bookings,
);

final bytes = excel.save();

if (bytes == null) {
throw Exception(
'Unable to generate Excel report.',
);
}

return Uint8List.fromList(
bytes,
);
}
//--------------------------------------------------------------------------
// Company Header
//--------------------------------------------------------------------------

void _buildHeader(
Sheet sheet,
String reportTitle,
) {
sheet.appendRow([
TextCellValue('SRI GURU CABS®'),
]);

sheet.appendRow([
TextCellValue(reportTitle.toUpperCase()),
]);

sheet.appendRow([
TextCellValue(
'Generated On',
),
TextCellValue(
DateFormat(
'dd MMM yyyy  hh:mm a',
).format(
DateTime.now(),
),
),
]);

sheet.appendRow([
TextCellValue(''),
]);
}

//--------------------------------------------------------------------------
// Report Summary
//--------------------------------------------------------------------------

void _buildSummary(
Sheet sheet,
ReportModel report,
) {
sheet.appendRow([
TextCellValue('REPORT SUMMARY'),
]);

sheet.appendRow([
TextCellValue('Total Bookings'),
IntCellValue(report.totalBookings),
]);

sheet.appendRow([
TextCellValue('Confirmed'),
IntCellValue(report.confirmedBookings),
]);

sheet.appendRow([
TextCellValue('Completed'),
IntCellValue(report.completedBookings),
]);

sheet.appendRow([
TextCellValue('Cancelled'),
IntCellValue(report.cancelledBookings),
]);

sheet.appendRow([
TextCellValue(''),
]);
}
//--------------------------------------------------------------------------
// Booking Table
//--------------------------------------------------------------------------

void _buildBookingTable(
Sheet sheet,
List<BookingModel> bookings,
) {
//----------------------------------------------------------------------
// Table Header
//----------------------------------------------------------------------

sheet.appendRow([
TextCellValue('Booking ID'),
TextCellValue('Passenger'),
TextCellValue('Phone'),
TextCellValue('Reporting'),
TextCellValue('Pickup'),
TextCellValue('Drop'),
TextCellValue('Trip Type'),
TextCellValue('Status'),
]);

//----------------------------------------------------------------------
// Table Rows
//----------------------------------------------------------------------

for (final booking in bookings) {
sheet.appendRow([
TextCellValue(
booking.bookingId,
),

TextCellValue(
booking.passengerName,
),

TextCellValue(
booking.passengerPhone,
),

TextCellValue(
DateFormat(
'dd MMM yyyy  hh:mm a',
).format(
booking.reportingDateTime,
),
),

TextCellValue(
booking.reportingAddress,
),

TextCellValue(
booking.dropAddress,
),

TextCellValue(
booking.tripType.displayName,
),

TextCellValue(
booking.status.displayName,
),
]);
}

//----------------------------------------------------------------------
// Total
//----------------------------------------------------------------------

sheet.appendRow([
TextCellValue(''),
]);

sheet.appendRow([
TextCellValue('Total Bookings'),
IntCellValue(bookings.length),
]);
}
  //--------------------------------------------------------------------------
  // Save Workbook
  //--------------------------------------------------------------------------

  Future<Uint8List> saveReport({
    required ReportModel report,
    required String reportTitle,
  }) async {
    return generateReport(
      report: report,
      reportTitle: reportTitle,
    );
  }

  //--------------------------------------------------------------------------
  // Share Workbook (Returns generated bytes)
  //--------------------------------------------------------------------------

  Future<Uint8List> shareReport({
    required ReportModel report,
    required String reportTitle,
  }) async {
    return generateReport(
      report: report,
      reportTitle: reportTitle,
    );
  }

  //--------------------------------------------------------------------------
  // Workbook Information
  //--------------------------------------------------------------------------

  String defaultFileName({
    required String reportTitle,
  }) {
    final timestamp = DateFormat(
      'yyyyMMdd_HHmmss',
    ).format(
      DateTime.now(),
    );

    return '${reportTitle.replaceAll(' ', '_')}_$timestamp.xlsx';
  }
}