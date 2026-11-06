import 'package:flutter/material.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';

class StepTwoView extends StatelessWidget {
  const StepTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = (size.height * 0.48).clamp(240.0, 440.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Clipped Notification Illustration with Concave Scoop Curve
        ClipPath(
          clipper: _OnboardingCurveClipper(),
          child: Container(
            width: double.infinity,
            height: imageHeight,
            color: const Color(0xFFEFF6FF),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 24),
                child: Image.asset(
                  AssetConstants.notificationIllustration,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.notifications_active_rounded,
                    size: 80,
                    color: ColorConstants.primaryBlue,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Vertically centered text block
        const Spacer(),

        // Text Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  TextConstants.onboardingStep2Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.textHeadline,
                    height: 1.25,
                    letterSpacing: -0.6,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  TextConstants.onboardingStep2Subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),
      ],
    );
  }
}

class _OnboardingCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Starts 52px above bottom on left
    path.lineTo(0, size.height - 52);
    // Smooth symmetrical concave bowl reaching lowest in the center
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height + 18,
      size.width,
      size.height - 52,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
