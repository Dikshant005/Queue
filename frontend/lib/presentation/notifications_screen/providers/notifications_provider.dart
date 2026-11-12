import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/text_constants.dart';

enum NotifFilter {
  all,
  updates,
  bookings,
  offers;

  String get label {
    switch (this) {
      case NotifFilter.all:
        return TextConstants.notifFilterAll;
      case NotifFilter.updates:
        return TextConstants.notifFilterUpdates;
      case NotifFilter.bookings:
        return TextConstants.notifFilterBookings;
      case NotifFilter.offers:
        return TextConstants.notifFilterOffers;
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final NotifFilter category;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.category,
  });
}

class NotificationFilterNotifier extends Notifier<NotifFilter> {
  @override
  NotifFilter build() => NotifFilter.all;

  void selectFilter(NotifFilter filter) {
    state = filter;
  }
}

final notificationFilterProvider =
    NotifierProvider<NotificationFilterNotifier, NotifFilter>(
  NotificationFilterNotifier.new,
);

final allNotificationsProvider = Provider<List<NotificationItem>>((ref) {
  // TODO: Fetch user notifications stream from backend / push notification service
  return const [
    NotificationItem(
      id: 'n-1',
      title: TextConstants.notifTurnApproaching,
      subtitle: TextConstants.notifTurnApproachingSub,
      icon: Icons.notifications_rounded,
      iconBgColor: Color(0xFFEFF6FF),
      iconColor: Color(0xFF1D61F2),
      category: NotifFilter.updates,
    ),
    NotificationItem(
      id: 'n-2',
      title: TextConstants.notifAppointmentConfirmed,
      subtitle: TextConstants.notifAppointmentConfirmedSub,
      icon: Icons.check_circle_outline_rounded,
      iconBgColor: Color(0xFFDCFCE7),
      iconColor: Color(0xFF16A34A),
      category: NotifFilter.bookings,
    ),
    NotificationItem(
      id: 'n-3',
      title: TextConstants.notifReferral,
      subtitle: TextConstants.notifReferralSub,
      icon: Icons.card_giftcard_rounded,
      iconBgColor: Color(0xFFFFF7ED),
      iconColor: Color(0xFFEA580C),
      category: NotifFilter.offers,
    ),
    NotificationItem(
      id: 'n-4',
      title: TextConstants.notifClinicUpdate,
      subtitle: TextConstants.notifClinicUpdateSub,
      icon: Icons.notifications_none_rounded,
      iconBgColor: Color(0xFFEFF6FF),
      iconColor: Color(0xFF1D61F2),
      category: NotifFilter.updates,
    ),
    NotificationItem(
      id: 'n-5',
      title: TextConstants.notifSpecialOffer,
      subtitle: TextConstants.notifSpecialOfferSub,
      icon: Icons.local_offer_outlined,
      iconBgColor: Color(0xFFF5F3FF),
      iconColor: Color(0xFF7C3AED),
      category: NotifFilter.offers,
    ),
  ];
});

final filteredNotificationsProvider = Provider<List<NotificationItem>>((ref) {
  final filter = ref.watch(notificationFilterProvider);
  final all = ref.watch(allNotificationsProvider);

  if (filter == NotifFilter.all) return all;
  return all.where((n) => n.category == filter).toList();
});

