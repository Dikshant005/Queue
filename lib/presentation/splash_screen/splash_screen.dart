import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../onboarding_screens/onboarding_screen.dart';
import 'providers/splash_provider.dart';
import 'widgets/splash_loading_dots.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    // Listen to Riverpod splash loading provider to auto-navigate
    ref.listen<AsyncValue<bool>>(splashLoadingProvider, (previous, next) {
      if (next.hasValue && next.value == true && context.mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: Stack(
        children: [
          // Top-left decorative concentric circular waves
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.7, screenSize.height * 0.3),
              painter: _SplashTopConcentricWavesPainter(),
            ),
          ),

          // Bottom-right fluid layered curved waves
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.9, screenSize.height * 0.35),
              painter: _SplashBottomFluidWavesPainter(),
            ),
          ),

          // Center Brand, Tagline & Animated Loading Dots
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // 3D Ribbon Logo
                  Image.asset(
                    AssetConstants.logo,
                    height: DimenConstants.splashLogoSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.waves_rounded,
                        size: DimenConstants.splashLogoSize,
                        color: ColorConstants.primaryBlue,
                      );
                    },
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Brand Name
                  const Text(
                    TextConstants.appName,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeHeadline + 2,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.2,
                      color: ColorConstants.textHeadline,
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingSmall),

                  // Tagline
                  const Text(
                    TextConstants.appTagline,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeSubtitle,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.textBody,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingHuge),

                  // 3 Animated Loading Dots
                  const SplashLoadingDots(),

                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for top-left concentric circular wave lines
class _SplashTopConcentricWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = ColorConstants.curvedWaveLine.withValues(alpha: 0.65);

    final center = Offset(-size.width * 0.15, -size.height * 0.2);

    canvas.drawCircle(center, size.width * 0.45, strokePaint);
    canvas.drawCircle(center, size.width * 0.70, strokePaint);
    canvas.drawCircle(center, size.width * 0.95, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for bottom-right smooth layered fluid blue waves
class _SplashBottomFluidWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Light blue background wave
    final lightWavePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          ColorConstants.splashWaveLight.withValues(alpha: 0.45),
          ColorConstants.splashWaveMedium.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path1 = Path();
    path1.moveTo(0, h);
    path1.quadraticBezierTo(w * 0.2, h * 0.5, w, h * 0.15);
    path1.lineTo(w, h);
    path1.close();
    canvas.drawPath(path1, lightWavePaint);

    // 2. Vibrant royal blue middle wave
    final midWavePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          ColorConstants.splashWaveMedium,
          ColorConstants.primaryBlue,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(w * 0.15, h * 0.25, w * 0.85, h * 0.75));

    final path2 = Path();
    path2.moveTo(w * 0.15, h);
    path2.quadraticBezierTo(w * 0.35, h * 0.65, w, h * 0.3);
    path2.lineTo(w, h);
    path2.close();
    canvas.drawPath(path2, midWavePaint);

    // 3. Deep dark navy foreground wave
    final darkWavePaint = Paint()
      ..color = ColorConstants.splashWaveDark;

    final path3 = Path();
    path3.moveTo(w * 0.35, h);
    path3.quadraticBezierTo(w * 0.55, h * 0.8, w, h * 0.45);
    path3.lineTo(w, h);
    path3.close();
    canvas.drawPath(path3, darkWavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
