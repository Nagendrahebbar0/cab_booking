// *****************************************************************************
// File        : report_provider.dart
// Project     : Cab Booking Manager
// Description :
// Provider responsible for report generation.
//
// Responsibilities:
// • Load reports
// • Load date range reports
// • Load booking status reports
// • Refresh reports
// • Notify listeners
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

import '../../../core/enums/booking_status.dart';
import '../models/report_model.dart';
import '../repository/report_repository.dart';

/// Provider responsible for report state management.
class ReportProvider extends ChangeNotifier {
  /// Creates a report provider.
  ReportProvider({
    required this.reportRepository,
  });

  /// Report repository.
  final ReportRepository reportRepository;

  ReportModel? _report;

  /// Current report.
  ReportModel? get report => _report;

  bool _isLoading = false;

  /// Loading state.
  bool get isLoading => _isLoading;

  /// Loads complete report.
  Future<void> loadReport() async {
    _isLoading = true;
    notifyListeners();

    _report = await reportRepository.getReport();

    _isLoading = false;
    notifyListeners();
  }

  /// Loads report for selected date range.
  Future<void> loadDateRangeReport({
    required DateTime from,
    required DateTime to,
  }) async {
    _isLoading = true;
    notifyListeners();

    _report = await reportRepository.getDateRangeReport(
      from: from,
      to: to,
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Loads report by booking status.
  Future<void> loadStatusReport(
      BookingStatus status,
      ) async {
    _isLoading = true;
    notifyListeners();

    _report = await reportRepository.getStatusReport(
      status,
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Refreshes the current report.
  Future<void> refresh() async {
    await loadReport();
  }
}