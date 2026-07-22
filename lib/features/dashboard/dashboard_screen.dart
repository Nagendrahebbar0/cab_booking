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

import 'package:cab_booking_manager/features/dashboard/provider/dashboard_provider.dart';
import 'package:cab_booking_manager/features/dashboard/widgets/dashboard_stat_card.dart';
import 'package:cab_booking_manager/features/dashboard/widgets/quick_action_card.dart';
import 'package:cab_booking_manager/features/dashboard/widgets/recent_booking_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/drawer/app_drawer.dart';
import '../booking/screens/booking_details_screen.dart';
import '../booking/screens/booking_screen.dart';


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
if (!mounted) return;

context
.read<DashboardProvider>()
.loadDashboard();
});
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
provider.refresh,

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
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const BookingScreen(),
),
).then((_) {
if (mounted) {
context.read<DashboardProvider>().loadDashboard();
}
});
},
),

QuickActionCard(
title: 'View Bookings',
icon: Icons.book_online,
color: Colors.green,
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const BookingScreen(),
),
).then((_) {
if (mounted) {
context.read<DashboardProvider>().loadDashboard();
}
});
},
),

QuickActionCard(
title: 'Reports',
icon: Icons.bar_chart,
color: Colors.orange,
onTap: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Reports module will be available soon.',
),
),
);
},
),

QuickActionCard(
title: 'Backup',
icon: Icons.backup,
color: Colors.deepPurple,
onTap: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Backup & Restore module will be available soon.',
),
),
);
},
),
],
),

const SizedBox(height: 24),

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
separatorBuilder: (_, __) => const SizedBox(height: 8),
itemBuilder: (context, index) {
final booking = stats.recentBookings[index];

return RecentBookingTile(
booking: booking,
onTap: () async {
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
await context
.read<DashboardProvider>()
.loadDashboard();
}
},
);
},
),

const SizedBox(height: 24),
],
),
),

  floatingActionButton: FloatingActionButton.extended(
    onPressed: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BookingScreen(),
        ),
      );

      if (!mounted) return;

      await context
          .read<DashboardProvider>()
          .loadDashboard();
    },
    icon: const Icon(Icons.add),
    label: const Text('New Booking'),
  ),
);
},
);
}
}