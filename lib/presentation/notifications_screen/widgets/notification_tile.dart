import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../providers/notifications_provider.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening ${notification.title}...'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
        // TODO: Handle notification tap / deep link to token or appointment
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Colored Circular Icon Container
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: notification.iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  notification.icon,
                  color: notification.iconColor,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Notification Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textHeadline,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notification.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.textBody,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: ColorConstants.textLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

