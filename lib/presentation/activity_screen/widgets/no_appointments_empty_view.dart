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
      width: 170,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft blue glow bubble
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(60),
            ),
          ),

          // Clock (left background)
          Positioned(
            left: 14,
            top: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConstants.primaryBlue,
                  width: 3.5,
                ),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Clock hour hand
                  Container(
                    width: 3,
                    height: 22,
                    margin: const EdgeInsets.only(bottom: 18),
                    color: ColorConstants.primaryBlue,
                  ),
                  // Clock minute hand
                  Container(
                    width: 18,
                    height: 3,
                    margin: const EdgeInsets.only(left: 16),
                    color: ColorConstants.primaryBlue,
                  ),
                  // Center pivot dot
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: ColorConstants.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Calendar Card (right foreground overlap)
          Positioned(
            right: 18,
            bottom: 22,
            child: Container(
              width: 68,
              height: 64,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorConstants.primaryBlue,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x221D61F2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Top mini binder pins
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  // Calendar date grid dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildWhiteDot(),
                      _buildWhiteDot(),
                      _buildWhiteDot(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildWhiteDot(),
                      _buildWhiteDot(),
                      _buildWhiteDot(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteDot() {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}

