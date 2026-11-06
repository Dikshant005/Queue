import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../auth_screens/auth_screen.dart';
import 'providers/onboarding_provider.dart';
import 'widgets/notification_step_view.dart';
import 'widgets/queue_step_view.dart';
import 'widgets/welcome_step_view.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  void _onComplete(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: Stack(
        children: [
          // Decorative top-left curved lines for Screen 1
          if (state.currentPage == 0)
            Positioned(
              top: 0,
              left: 0,
              child: CustomPaint(
                size: const Size(200, 200),
                painter: _OnboardingTopWavesPainter(),
              ),
            ),

          SafeArea(
            child: Column(
              children: [
                // Top Navigation Bar
                _buildTopBar(context, state.currentPage),

                // PageView with all 3 Onboarding Steps
                Expanded(
                  child: PageView(
                    controller: notifier.pageController,
                    onPageChanged: notifier.onPageChanged,
                    children: const [
                      WelcomeStepView(),
                      QueueStepView(),
                      NotificationStepView(),
                    ],
                  ),
                ),

                // Dynamic Bottom Bar matching each screen's design
                _buildBottomBar(context, ref, state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, int currentPage) {
    // Screen 1 does not display Skip button; Screens 2 & 3 show "Skip" on the top right
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstants.screenHorizontalPadding,
        vertical: DimenConstants.spacingSmall,
      ),
      child: SizedBox(
        height: 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (currentPage > 0)
              TextButton(
                onPressed: () => _onComplete(context),
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.primaryBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstants.spacingSmall,
                    vertical: DimenConstants.spacingExtraSmall,
                  ),
                ),
                child: const Text(
                  TextConstants.skip,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeSubtitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    WidgetRef ref,
    OnboardingState state,
  ) {
    final notifier = ref.read(onboardingProvider.notifier);

    if (state.currentPage == 0) {
      // Screen 1: 3-dot indicator on left, "Get Started →" on right
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstants.screenHorizontalPadding,
          vertical: DimenConstants.spacingLarge,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildDot(isActive: true),
                const SizedBox(width: DimenConstants.spacingSmall),
                _buildDot(isActive: false),
                const SizedBox(width: DimenConstants.spacingSmall),
                _buildDot(isActive: false),
              ],
            ),
            InkWell(
              onTap: notifier.nextPage,
              borderRadius: BorderRadius.circular(DimenConstants.radiusPill),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstants.spacingSmall,
                  vertical: DimenConstants.spacingSmall,
                ),
                child: Text(
                  TextConstants.getStartedWithArrow,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeSubtitle,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.primaryBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Screens 2 & 3: Centered dots + full-width dark pill button
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstants.screenHorizontalPadding,
        vertical: DimenConstants.spacingLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Centered 3 dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(state.totalPages, (index) {
              final isActive = index == state.currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: DimenConstants.dotSize,
                height: DimenConstants.dotSize,
                decoration: BoxDecoration(
                  color: isActive
                      ? ColorConstants.dotActive
                      : ColorConstants.dotInactive,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),

          const SizedBox(height: DimenConstants.spacingLarge),

          // Dark pill action button ("Next →" on screen 2, "Get Started" on screen 3)
          SizedBox(
            width: double.infinity,
            height: DimenConstants.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (state.currentPage < state.totalPages - 1) {
                  notifier.nextPage();
                } else {
                  _onComplete(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.darkButtonBackground,
                foregroundColor: ColorConstants.textWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DimenConstants.radiusPill,
                  ),
                ),
              ),
              child: Text(
                state.currentPage == 1
                    ? TextConstants.nextWithArrow
                    : TextConstants.getStarted,
                style: const TextStyle(
                  fontSize: DimenConstants.fontSizeSubtitle,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? DimenConstants.activeDotWidth : DimenConstants.dotSize,
      height: DimenConstants.dotSize,
      decoration: BoxDecoration(
        color: isActive ? ColorConstants.dotActive : ColorConstants.dotInactive,
        borderRadius: BorderRadius.circular(DimenConstants.radiusPill),
      ),
    );
  }
}

/// Custom painter for the delicate curved lines in the top left corner of the first onboarding screen
class _OnboardingTopWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorConstants.curvedWaveLine.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    path1.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.6,
      size.width * 0.8,
      0,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.9);
    path2.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.7,
      size.width,
      0,
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
