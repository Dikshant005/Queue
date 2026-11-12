import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../providers/queue_tracker_provider.dart';

class QueueTrackerHeader extends ConsumerWidget {
  const QueueTrackerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: ColorConstants.textHeadline,
          ),
          splashRadius: 24,
        ),

        // Refresh Action Button
        IconButton(
          onPressed: () async {
            await ref.read(queueTrackerProvider.notifier).refresh();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Queue status updated!'),
                  backgroundColor: ColorConstants.primaryDark,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            }
            // TODO: Re-fetch latest queue state from backend / sync via WebSocket
          },
          icon: const Icon(
            Icons.refresh_rounded,
            size: 26,
            color: ColorConstants.textHeadline,
          ),
          splashRadius: 24,
        ),
      ],
    );
  }
}

