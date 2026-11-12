import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../your_turn_screen/your_turn_screen.dart';
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
                    children: [
                      // Header with back and refresh buttons
                      const QueueTrackerHeader(),
                      const SizedBox(height: 16),

                      // Circular radial progress gauge with token & status
                      const CircularTokenGauge(),
                      const SizedBox(height: 20),

                      // Wait time and people ahead count
                      const QueueWaitInfo(),
                      const SizedBox(height: 28),

                      // 3-step timeline (Joined -> In Queue -> Next)
                      const QueueStepperTimeline(),
                      const SizedBox(height: 32),

                      // Clinic business preview card
                      const QueueBusinessCard(),
                      const SizedBox(height: 16),

                      // "View Details" Button (Row 2, Col 5 Mockup)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const YourTurnScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B132B),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 12),

                      // Bottom actions (Directions & Leave Queue)
                      const QueueBottomActions(),
                      const SizedBox(height: 16),
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
