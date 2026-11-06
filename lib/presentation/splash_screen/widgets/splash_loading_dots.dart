import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';

/// Clean animated 3-dot loading wave component
class SplashLoadingDots extends StatefulWidget {
  const SplashLoadingDots({super.key});

  @override
  State<SplashLoadingDots> createState() => _SplashLoadingDotsState();
}

class _SplashLoadingDotsState extends State<SplashLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final start = index * 0.2;
            final end = (start + 0.6).clamp(0.0, 1.0);
            final curve = CurvedAnimation(
              parent: _controller,
              curve: Interval(start, end, curve: Curves.easeInOut),
            );

            final bounceOffset = -6.0 * (1.0 - (curve.value - 0.5).abs() * 2.0);
            final color = Color.lerp(
              ColorConstants.loadingDotInactive,
              ColorConstants.loadingDotActive,
              curve.value,
            );

            return Transform.translate(
              offset: Offset(0, bounceOffset),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                width: DimenConstants.splashLoadingDotSize,
                height: DimenConstants.splashLoadingDotSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

