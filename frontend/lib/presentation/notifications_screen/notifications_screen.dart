import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import 'providers/notifications_provider.dart';
import 'widgets/notification_filter_chips.dart';
import 'widgets/notification_tile.dart';
import 'widgets/notifications_top_bar.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(filteredNotificationsProvider);

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            const NotificationsTopBar(),
            const SizedBox(height: 6),

            // Horizontal Filter Chips
            const NotificationFilterChips(),
            const SizedBox(height: 12),

            // Notifications List
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Text(
                        'No notifications in this category',
                        style: TextStyle(
                          color: ColorConstants.textBody,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationTile(
                          notification: notifications[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

