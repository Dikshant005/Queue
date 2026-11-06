import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import 'widgets/circular_token_gauge.dart';
import 'widgets/queue_bottom_actions.dart';
import 'widgets/queue_business_card.dart';
import 'widgets/queue_tracker_header.dart';
import 'widgets/queue_stepper_timeline.dart';
import 'widgets/queue_wait_info.dart';

class QueueTrackerScreen extends StatelessWidget {
  const QueueTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: const [
                      // Header with back and refresh buttons
                      QueueTrackerHeader(),
                      SizedBox(height: 16),

                      // Circular radial progress gauge with token & status
                      CircularTokenGauge(),
                      SizedBox(height: 20),

                      // Wait time and people ahead count
                      QueueWaitInfo(),
                      SizedBox(height: 28),

                      // 3-step timeline (Joined -> In Queue -> Next)
                      QueueStepperTimeline(),
                      SizedBox(height: 32),

                      // Clinic business preview card
                      QueueBusinessCard(),

                      Spacer(),
                      SizedBox(height: 20),

                      // Bottom actions (Directions & Leave Queue)
                      QueueBottomActions(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
