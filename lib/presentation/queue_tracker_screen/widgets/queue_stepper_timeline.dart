import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/queue_tracker_provider.dart';

class QueueStepperTimeline extends ConsumerWidget {
  const QueueStepperTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(queueTrackerProvider).currentStep;

    const steps = [
      TextConstants.stepJoined,
      TextConstants.stepInQueue,
      TextConstants.stepNext,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Nodes and connecting lines
          Row(
            children: [
              // Step 0 Node
              _buildStepNode(index: 0, currentStep: currentStep),

              // Line 0 -> 1
              _buildConnectingLine(isDone: currentStep >= 1),

              // Step 1 Node
              _buildStepNode(index: 1, currentStep: currentStep),

              // Line 1 -> 2
              _buildConnectingLine(isDone: currentStep >= 2),

              // Step 2 Node
              _buildStepNode(index: 2, currentStep: currentStep),
            ],
          ),
          const SizedBox(height: 8),

          // Step Labels Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              return SizedBox(
                width: 72,
                child: Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: index <= currentStep
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: index <= currentStep
                        ? ColorConstants.textHeadline
                        : ColorConstants.textBody,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepNode({required int index, required int currentStep}) {
    final isCompleted = index < currentStep;
    final isActive = index == currentStep;

    if (isCompleted || isActive) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: ColorConstants.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 16,
        ),
      );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorConstants.primaryBlue,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildConnectingLine({required bool isDone}) {
    return Expanded(
      child: Container(
        height: 2.5,
        color: isDone ? ColorConstants.primaryBlue : const Color(0xFFDBEAFE),
      ),
    );
  }
}

