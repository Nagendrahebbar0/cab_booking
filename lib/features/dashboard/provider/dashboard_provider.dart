// *****************************************************************************
// File        : dashboard_provider.dart
// Project     : Cab Booking Manager
// Description :
// Provider responsible for dashboard statistics.
//
// Responsibilities:
// • Load dashboard statistics
// • Refresh dashboard
// • Notify listeners
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';

import '../models/dashboard_stats.dart';
import '../repository/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required this.dashboardRepository,
  });

  final DashboardRepository dashboardRepository;

  DashboardStats? _stats;

  DashboardStats? get stats => _stats;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();

    _stats = await dashboardRepository.getDashboardStats();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadDashboard();
  }
}