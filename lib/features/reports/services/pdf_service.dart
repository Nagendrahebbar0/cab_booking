// *****************************************************************************
// File        : pdf_service.dart
// Project     : Cab Booking Manager
// Description :
// Professional PDF Report Generator.
//
// Responsibilities:
// • Generate booking reports
// • Preview PDF
// • Print PDF
// • Share PDF
// • Professional SRI GURU CABS® layout
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/enums/booking_status.dart';
import '../../../core/enums/trip_type.dart';
import '../../booking/models/booking_model.dart';
import '../models/report_model.dart';

/// Service responsible for generating PDF reports.
class PdfService {
PdfService._();

/// Singleton instance.
static final PdfService instance =
PdfService._();

//--------------------------------------------------------------------------
// Generate PDF
//--------------------------------------------------------------------------

Future<Uint8List> generateReport({
required ReportModel report,
required String reportTitle,
}) async {
final pdf = pw.Document(
title: reportTitle,
author: 'SRI GURU CABS®',
creator: 'Cab Booking Manager',
);

pdf.addPage(
pw.MultiPage(
pageFormat: PdfPageFormat.a4,

margin: const pw.EdgeInsets.all(
24,
),

build: (context) => [

//------------------------------------------------------------------
// Header
//------------------------------------------------------------------

_buildHeader(
reportTitle,
),

pw.SizedBox(height: 20),

//------------------------------------------------------------------
// Summary
//------------------------------------------------------------------

_buildSummary(
report,
),

pw.SizedBox(height: 20),

//------------------------------------------------------------------
// Booking Table
//------------------------------------------------------------------

_buildBookingTable(
report.bookings,
),

pw.SizedBox(height: 20),

//------------------------------------------------------------------
// Footer
//------------------------------------------------------------------

_buildFooter(),
],

footer: (context) {
return pw.Align(
alignment:
pw.Alignment.centerRight,

child: pw.Text(
'Page ${context.pageNumber} of ${context.pagesCount}',
style: const pw.TextStyle(
fontSize: 9,
),
),
);
},
),
);

return pdf.save();
}

//--------------------------------------------------------------------------
// Preview PDF
//--------------------------------------------------------------------------

Future<void> previewReport({
required ReportModel report,
required String reportTitle,
}) async {
await Printing.layoutPdf(
onLayout: (_) async {
return generateReport(
report: report,
reportTitle: reportTitle,
);
},
);
}

//--------------------------------------------------------------------------
// Print PDF
//--------------------------------------------------------------------------

Future<void> printReport({
required ReportModel report,
required String reportTitle,
}) async {
await Printing.layoutPdf(
name: reportTitle,

onLayout: (_) async {
return generateReport(
report: report,
reportTitle: reportTitle,
);
},
);
}

//--------------------------------------------------------------------------
// Share PDF
//--------------------------------------------------------------------------

Future<void> shareReport({
required ReportModel report,
required String reportTitle,
}) async {
final bytes = await generateReport(
report: report,
reportTitle: reportTitle,
);

await Printing.sharePdf(
bytes: bytes,
filename:
'${reportTitle.replaceAll(' ', '_')}.pdf',
);
}
//--------------------------------------------------------------------------
// Header
//--------------------------------------------------------------------------

pw.Widget _buildHeader(
String reportTitle,
) {
return pw.Column(
crossAxisAlignment: pw.CrossAxisAlignment.start,
children: [
pw.Center(
child: pw.Text(
'SRI GURU CABS®',
style: pw.TextStyle(
fontSize: 24,
fontWeight: pw.FontWeight.bold,
),
),
),

pw.SizedBox(height: 4),

pw.Center(
child: pw.Text(
reportTitle.toUpperCase(),
style: pw.TextStyle(
fontSize: 18,
fontWeight: pw.FontWeight.bold,
),
),
),

pw.SizedBox(height: 16),

pw.Container(
padding: const pw.EdgeInsets.all(12),
decoration: pw.BoxDecoration(
border: pw.Border.all(
color: PdfColors.grey700,
),
borderRadius: pw.BorderRadius.circular(6),
),
child: pw.Row(
mainAxisAlignment:
pw.MainAxisAlignment.spaceBetween,
children: [
pw.Text(
'Generated On',
style: pw.TextStyle(
fontWeight: pw.FontWeight.bold,
),
),

pw.Text(
DateFormat(
'dd MMM yyyy  hh:mm a',
).format(
DateTime.now(),
),
),
],
),
),
],
);
}

//--------------------------------------------------------------------------
// Report Summary
//--------------------------------------------------------------------------

pw.Widget _buildSummary(
ReportModel report,
) {
return pw.Container(
width: double.infinity,
padding: const pw.EdgeInsets.all(12),

decoration: pw.BoxDecoration(
border: pw.Border.all(
color: PdfColors.blueGrey,
),
borderRadius:
pw.BorderRadius.circular(6),
),

child: pw.Column(
crossAxisAlignment:
pw.CrossAxisAlignment.start,
children: [

pw.Text(
'REPORT SUMMARY',
style: pw.TextStyle(
fontSize: 16,
fontWeight: pw.FontWeight.bold,
),
),

pw.SizedBox(height: 12),

_summaryRow(
'Total Bookings',
report.totalBookings.toString(),
),

_summaryRow(
'Confirmed',
report.confirmedBookings.toString(),
),

_summaryRow(
'Completed',
report.completedBookings.toString(),
),

_summaryRow(
'Cancelled',
report.cancelledBookings.toString(),
),
],
),
);
}

//--------------------------------------------------------------------------
// Summary Row
//--------------------------------------------------------------------------

pw.Widget _summaryRow(
String title,
String value,
) {
return pw.Padding(
padding: const pw.EdgeInsets.symmetric(
vertical: 4,
),

child: pw.Row(
mainAxisAlignment:
pw.MainAxisAlignment.spaceBetween,
children: [
pw.Text(
title,
),

pw.Text(
value,
style: pw.TextStyle(
fontWeight:
pw.FontWeight.bold,
),
),
],
),
);
}
//--------------------------------------------------------------------------
// Booking Table
//--------------------------------------------------------------------------

pw.Widget _buildBookingTable(
List<BookingModel> bookings,
) {
return pw.Column(
crossAxisAlignment:
pw.CrossAxisAlignment.start,
children: [
pw.Text(
'BOOKING DETAILS',
style: pw.TextStyle(
fontSize: 16,
fontWeight: pw.FontWeight.bold,
),
),

pw.SizedBox(height: 10),

pw.TableHelper.fromTextArray(
border: pw.TableBorder.all(
color: PdfColors.grey700,
width: 0.5,
),

headerDecoration:
const pw.BoxDecoration(
color: PdfColors.blue700,
),

headerStyle: pw.TextStyle(
color: PdfColors.white,
fontWeight:
pw.FontWeight.bold,
fontSize: 9,
),

cellStyle: const pw.TextStyle(
fontSize: 8,
),

cellAlignment:
pw.Alignment.centerLeft,

columnWidths: {
0: const pw.FixedColumnWidth(55),
1: const pw.FixedColumnWidth(85),
2: const pw.FixedColumnWidth(70),
3: const pw.FixedColumnWidth(75),
4: const pw.FixedColumnWidth(55),
5: const pw.FixedColumnWidth(55),
},

headers: const [
'Booking ID',
'Passenger',
'Phone',
'Reporting',
'Trip',
'Status',
],

data: bookings.map(
(booking) {
return [
booking.bookingId,

booking.passengerName,

booking.passengerPhone,

DateFormat(
'dd/MM/yyyy\nhh:mm a',
).format(
booking.reportingDateTime,
),

booking.tripType.displayName,

booking.status.displayName,
];
},
).toList(),
),

pw.SizedBox(height: 12),

pw.Align(
alignment:
pw.Alignment.centerRight,
child: pw.Text(
'Total Bookings : ${bookings.length}',
style: pw.TextStyle(
fontWeight:
pw.FontWeight.bold,
fontSize: 11,
),
),
),
],
);
}
  //--------------------------------------------------------------------------
  // Footer
  //--------------------------------------------------------------------------

  pw.Widget _buildFooter() {
    return pw.Container(
      margin: const pw.EdgeInsets.only(
        top: 12,
      ),
      padding: const pw.EdgeInsets.only(
        top: 8,
      ),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(
            color: PdfColors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: pw.Column(
        children: [
          pw.Center(
            child: pw.Text(
              'Generated by Cab Booking Manager',
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ),

          pw.SizedBox(height: 4),

          pw.Center(
            child: pw.Text(
              'SRI GURU CABS®',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),

          pw.SizedBox(height: 2),

          pw.Center(
            child: pw.Text(
              'Professional Cab Booking Solution',
              style: const pw.TextStyle(
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}