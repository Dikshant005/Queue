import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../../home_screen/providers/home_nav_provider.dart';

class NoAppointmentsEmptyView extends ConsumerWidget {
  const NoAppointmentsEmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Clock & Calendar Illustration Composition
            _buildIllustration(),
            const SizedBox(height: 28),

            // Title
            const Text(
              TextConstants.noAppointmentsTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: ColorConstants.textHeadline,
                letterSpacing: -0.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Subtitle
            const Text(
              TextConstants.noAppointmentsSubtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstants.textBody,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // "Explore Clinics" Pill Button
            SizedBox(
              width: 220,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Switch to Explore Tab in Bottom Nav
                  ref.read(homeNavProvider.notifier).selectTab(HomeNavTab.explore);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  TextConstants.exploreClinicsButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 160,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft blue glow bubble
          Container(
            width: 140,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(60),
            ),
          ),

          // Magnifying Glass Illustration (Matching Mockup Row 4, Col 2)
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstants.primaryBlue,
                width: 3.5,
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: 3,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryBlue,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ),
          Positioned(
            right: 36,
            bottom: 24,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                width: 32,
                height: 4.5,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryBlue,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

