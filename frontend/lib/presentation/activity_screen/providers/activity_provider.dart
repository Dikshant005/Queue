import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/text_constants.dart';

enum ActivityTab {
  upcoming,
  past;

  bool get isUpcoming => this == ActivityTab.upcoming;
  bool get isPast => this == ActivityTab.past;
}

class AppointmentItem {
  final String id;
  final String title;
  final String dateTime;
  final String clinicName;
  final IconData icon;
  final bool hasNotificationDot;

  const AppointmentItem({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.clinicName,
    required this.icon,
    this.hasNotificationDot = true,
  });
}

class ActivityTabNotifier extends Notifier<ActivityTab> {
  @override
  ActivityTab build() => ActivityTab.upcoming;

  void selectTab(ActivityTab tab) {
    state = tab;
  }
}

final activityTabProvider =
    NotifierProvider<ActivityTabNotifier, ActivityTab>(
  ActivityTabNotifier.new,
);

final upcomingAppointmentsProvider = Provider<List<AppointmentItem>>((ref) {
  // TODO: Replace with live API query from Appointments service
  return const [
    AppointmentItem(
      id: 'apt-001',
      title: TextConstants.dentalCareTitle,
      dateTime: TextConstants.sampleAppointmentDentalTime,
      clinicName: TextConstants.sampleBusinessName,
      icon: Icons.medical_services_rounded,
      hasNotificationDot: true,
    ),
    AppointmentItem(
      id: 'apt-002',
      title: TextConstants.generalCheckupTitle,
      dateTime: TextConstants.sampleAppointmentGeneralTime,
      clinicName: TextConstants.sampleClinicLifeCare,
      icon: Icons.health_and_safety_rounded,
      hasNotificationDot: true,
    ),
  ];
});

final pastAppointmentsProvider = Provider<List<AppointmentItem>>((ref) {
  // TODO: Replace with historical appointment logs from backend
  return const [];
});

