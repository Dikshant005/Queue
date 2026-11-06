import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/queue_tracker_provider.dart';

class QueueBottomActions extends ConsumerWidget {
  const QueueBottomActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Directions Button
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening maps for directions...'),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // TODO: Launch Google Maps / Apple Maps using lat/long coordinates
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  TextConstants.directionsButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Leave Queue Button
          Expanded(
            child: SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => _showLeaveQueueDialog(context, ref),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: ColorConstants.primaryBlue,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  TextConstants.leaveQueueButton,
                  style: TextStyle(
                    color: ColorConstants.primaryBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLeaveQueueDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Leave Queue?'),
        content: const Text(
          'Are you sure you want to give up your spot? You will lose token A-024.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Stay in Line'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              ref.read(queueTrackerProvider.notifier).cancelToken();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have left the queue.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // TODO: Send leave queue API cancellation request
            },
            child: const Text(
              'Leave',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

