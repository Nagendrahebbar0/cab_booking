// *****************************************************************************
// File        : reports_screen.dart
// Project     : Cab Booking Manager
// Description :
// Reports screen.
//
// Responsibilities:
// • Display report summary
// • Display filters
// • Export reports
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../shared/drawer/app_drawer.dart';
import '../provider/report_provider.dart';
import '../widgets/report_card.dart';
import '../widgets/report_filter.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({
    super.key,
  });

  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ReportProvider>().loadReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(
      builder: (
          context,
          provider,
          child,
          ) {
        final report = provider.report;

        return Scaffold(
          drawer: const AppDrawer(),

          appBar: AppBar(
            title: const Text(
              'Reports',
            ),
          ),

          body: provider.isLoading
              ? const Center(
            child:
            CircularProgressIndicator(),
          )
              : report == null
              ? const Center(
            child: Text(
              'No report available.',
            ),
          )
              : RefreshIndicator(
            onRefresh: provider.refresh,
            child: ListView(
              padding: const EdgeInsets.all(
                AppSizes.md,
              ),
              children: [
                const ReportFilter(),

                const SizedBox(
                  height: 20,
                ),

                ReportCard(
                  title: 'Total Bookings',
                  value: report.totalBookings,
                  icon: Icons.book_online,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                ReportCard(
                  title: 'Confirmed',
                  value: report.confirmedBookings,
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),

                const SizedBox(height: 12),

                ReportCard(
                  title: 'Completed',
                  value: report.completedBookings,
                  icon: Icons.task_alt,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),

                ReportCard(
                  title: 'Cancelled',
                  value: report.cancelledBookings,
                  icon: Icons.cancel,
                  color: Colors.red,
                ),

                const SizedBox(
                  height: 24,
                ),

                Row(
                  children: [
                    Expanded(
                      child:
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'PDF Export coming soon.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.picture_as_pdf,
                        ),
                        label: const Text(
                          'PDF',
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child:
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Excel Export coming soon.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.table_chart,
                        ),
                        label: const Text(
                          'Excel',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}