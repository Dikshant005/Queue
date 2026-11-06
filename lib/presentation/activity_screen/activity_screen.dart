import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import 'providers/activity_provider.dart';
import 'widgets/activity_header.dart';
import 'widgets/activity_tabs_bar.dart';
import 'widgets/appointment_card.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(activityTabProvider);
    final upcomingList = ref.watch(upcomingAppointmentsProvider);
    final pastList = ref.watch(pastAppointmentsProvider);

    final appointments = currentTab.isUpcoming ? upcomingList : pastList;

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Screen Header ("My Appointments")
            const ActivityHeader(),

            // Segmented Tabs ("Upcoming" | "Past")
            const ActivityTabsBar(),
            const SizedBox(height: 16),

            // Appointments List View
            Expanded(
              child: appointments.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          appointment: appointments[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.event_busy_rounded,
            size: 54,
            color: ColorConstants.textLight,
          ),
          SizedBox(height: 12),
          Text(
            TextConstants.noPastAppointments,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textBody,
            ),
          ),
        ],
      ),
    );
  }
}

