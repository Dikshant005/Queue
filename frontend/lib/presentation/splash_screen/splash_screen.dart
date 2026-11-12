import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../onboarding_screens/onboarding_screen.dart';
import 'providers/splash_provider.dart';

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
          // Top-right layered gradient blue curved waves
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.75, screenSize.height * 0.32),
              painter: _SplashTopRightWavesPainter(),
            ),
          ),

          // Bottom-left layered deep navy & blue curved waves
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.85, screenSize.height * 0.35),
              painter: _SplashBottomLeftWavesPainter(),
            ),
          ),

          // Center Brand, Tagline
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // 3D Ribbon Logo
                  Image.asset(
                    AssetConstants.logo,
                    height: DimenConstants.splashLogoSize + 12,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.waves_rounded,
                        size: DimenConstants.splashLogoSize,
                        color: ColorConstants.primaryBlue,
                      );
                    },
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge + 4),

                  // Brand Name
                  const Text(
                    TextConstants.appName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.2,
                      color: ColorConstants.textHeadline,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Tagline
                  const Text(
                    TextConstants.appTagline,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.textBody,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for top-right fluid layered curved waves
class _SplashTopRightWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Soft light-blue outer wave
    final lightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF93C5FD).withValues(alpha: 0.35),
          const Color(0xFF60A5FA).withValues(alpha: 0.5),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path1 = Path();
    path1.moveTo(w, 0);
    path1.lineTo(0, 0);
    path1.quadraticBezierTo(w * 0.15, h * 0.65, w, h * 0.95);
    path1.close();
    canvas.drawPath(path1, lightPaint);

    // 2. Vivid royal blue inner wave
    final bluePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF3B82F6),
          Color(0xFF1D61F2),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(w * 0.2, 0, w * 0.8, h * 0.8));

    final path2 = Path();
    path2.moveTo(w, 0);
    path2.lineTo(w * 0.25, 0);
    path2.quadraticBezierTo(w * 0.45, h * 0.55, w, h * 0.72);
    path2.close();
    canvas.drawPath(path2, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for bottom-left smooth layered fluid navy & blue waves
class _SplashBottomLeftWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Soft light blue outer wave
    final lightWavePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF93C5FD).withValues(alpha: 0.4),
          const Color(0xFF60A5FA).withValues(alpha: 0.3),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path1 = Path();
    path1.moveTo(0, h * 0.3);
    path1.quadraticBezierTo(w * 0.65, h * 0.45, w * 0.85, h);
    path1.lineTo(0, h);
    path1.close();
    canvas.drawPath(path1, lightWavePaint);

    // 2. Royal blue middle wave
    final midWavePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF2563EB),
          Color(0xFF1D61F2),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, h * 0.45, w * 0.7, h * 0.55));

    final path2 = Path();
    path2.moveTo(0, h * 0.52);
    path2.quadraticBezierTo(w * 0.45, h * 0.65, w * 0.6, h);
    path2.lineTo(0, h);
    path2.close();
    canvas.drawPath(path2, midWavePaint);

    // 3. Deep dark navy foreground wave
    final darkWavePaint = Paint()
      ..color = const Color(0xFF0B132B);

    final path3 = Path();
    path3.moveTo(0, h * 0.72);
    path3.quadraticBezierTo(w * 0.3, h * 0.82, w * 0.42, h);
    path3.lineTo(0, h);
    path3.close();
    canvas.drawPath(path3, darkWavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
