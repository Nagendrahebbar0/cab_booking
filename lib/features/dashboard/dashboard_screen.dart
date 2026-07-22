// *****************************************************************************
// File        : dashboard_screen.dart
// Project     : Cab Booking Manager
// Description :
// Dashboard screen.
//
// Responsibilities:
// • Display dashboard statistics
// • Display quick actions
// • Display recent bookings
// • Refresh dashboard
//
// Author      : H S Nagendra Hebbar & OpenAI ChatGPT
// *****************************************************************************

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/drawer/app_drawer.dart';

import '../booking/screens/booking_details_screen.dart';
import '../booking/screens/booking_screen.dart';
import '../booking/models/booking_model.dart';
import 'provider/dashboard_provider.dart';
import 'widgets/dashboard_stat_card.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/recent_booking_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

@override
void initState() {
super.initState();

WidgetsBinding.instance.addPostFrameCallback((_) {
_refreshDashboard();
});
}

Future<void> _refreshDashboard() async {
if (!mounted) return;

await context
.read<DashboardProvider>()
.loadDashboard();
}

Future<void> _openBookingScreen() async {
await Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const BookingScreen(),
),
);

if (!mounted) return;

await _refreshDashboard();
}

Future<void> _openBookingDetails(
    BookingModel booking,
    ) async {
final result = await Navigator.push<bool>(
context,
MaterialPageRoute(
builder: (_) => BookingDetailsScreen(
booking: booking,
),
),
);

if (!mounted) return;

if (result == true) {
await _refreshDashboard();
}
}

void _showComingSoon(
String message,
) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(message),
),
);
}

@override
Widget build(BuildContext context) {
return Consumer<DashboardProvider>(
builder: (
context,
provider,
child,
) {
final stats = provider.stats;

return Scaffold(
drawer: const AppDrawer(),

appBar: AppBar(
title: const Text(
AppStrings.dashboard,
),
),

body: provider.isLoading
? const Center(
child:
CircularProgressIndicator(),
)
: stats == null
? const Center(
child: Text(
'No dashboard data available.',
),
)
: RefreshIndicator(
onRefresh:
_refreshDashboard,

child: ListView(
padding:
const EdgeInsets.all(
AppSizes.md,
),

children: [

Text(
'Dashboard Overview',
style: Theme.of(
context,
)
.textTheme
.headlineSmall
?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(
height:
AppSizes.md,
),
// -------------------------------------------------------------------------
// Statistics
// -------------------------------------------------------------------------

GridView.count(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
crossAxisCount: 2,
mainAxisSpacing: 12,
crossAxisSpacing: 12,
childAspectRatio: 1.15,
children: [
DashboardStatCard(
title: "Today's Bookings",
value: stats.todayBookings,
icon: Icons.today,
color: Colors.blue,
),

DashboardStatCard(
title: "Total Bookings",
value: stats.totalBookings,
icon: Icons.book_online,
color: Colors.indigo,
),

DashboardStatCard(
title: "Confirmed",
value: stats.confirmedBookings,
icon: Icons.check_circle,
color: Colors.green,
),

DashboardStatCard(
title: "Completed",
value: stats.completedBookings,
icon: Icons.task_alt,
color: Colors.orange,
),

DashboardStatCard(
title: "Cancelled",
value: stats.cancelledBookings,
icon: Icons.cancel,
color: Colors.red,
),
],
),

const SizedBox(height: 24),

// -------------------------------------------------------------------------
// Quick Actions
// -------------------------------------------------------------------------

Text(
'Quick Actions',
style: Theme.of(context)
.textTheme
.titleLarge
?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),
// -------------------------------------------------------------------------
// Quick Actions
// -------------------------------------------------------------------------

GridView.count(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
crossAxisCount: 2,
mainAxisSpacing: 12,
crossAxisSpacing: 12,
childAspectRatio: 1.25,
children: [
QuickActionCard(
title: 'New Booking',
icon: Icons.add_circle,
color: Colors.blue,
onTap: _openBookingScreen,
),

QuickActionCard(
title: 'View Bookings',
icon: Icons.book_online,
color: Colors.green,
onTap: _openBookingScreen,
),

QuickActionCard(
title: 'Reports',
icon: Icons.bar_chart,
color: Colors.orange,
onTap: () => _showComingSoon(
'Reports module will be available soon.',
),
),

QuickActionCard(
title: 'Backup',
icon: Icons.backup,
color: Colors.deepPurple,
onTap: () => _showComingSoon(
'Backup & Restore module will be available soon.',
),
),
],
),

const SizedBox(height: 24),

// -------------------------------------------------------------------------
// Recent Bookings
// -------------------------------------------------------------------------

Text(
'Recent Bookings',
style: Theme.of(context)
.textTheme
.titleLarge
?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),
// -------------------------------------------------------------------------
// Recent Bookings
// -------------------------------------------------------------------------

if (stats.recentBookings.isEmpty)
const Card(
child: Padding(
padding: EdgeInsets.all(24),
child: Center(
child: Text(
'No recent bookings available.',
style: TextStyle(
fontSize: 16,
),
),
),
),
)
else
ListView.separated(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
itemCount: stats.recentBookings.length,
separatorBuilder: (_, _) =>
const SizedBox(height: 8),
itemBuilder: (context, index) {
final booking = stats.recentBookings[index];

return RecentBookingTile(
booking: booking,
onTap: () => _openBookingDetails(
booking,
),
);
},
),

const SizedBox(height: 24),
],
),
),

  floatingActionButton: FloatingActionButton.extended(
    onPressed: _openBookingScreen,
    icon: const Icon(Icons.add),
    label: const Text(
      'New Booking',
    ),
  ),
);
},
);
}
}