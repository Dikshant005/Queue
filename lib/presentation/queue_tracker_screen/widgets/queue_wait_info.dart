import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/queue_tracker_provider.dart';

class QueueWaitInfo extends ConsumerWidget {
  const QueueWaitInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueState = ref.watch(queueTrackerProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Wait Time
        Text(
          '${TextConstants.approxPrefix}${queueState.waitTime}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: ColorConstants.textHeadline,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),

        // "Estimated Wait" Label
        const Text(
          TextConstants.estimatedWaitLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.textBody,
          ),
        ),
        const SizedBox(height: 14),

        // "X People Ahead"
        Text(
          '${queueState.peopleAhead} People Ahead',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primaryBlue,
          ),
        ),
      ],
    );
  }
}

