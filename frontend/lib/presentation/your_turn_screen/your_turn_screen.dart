import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';

class YourTurnScreen extends StatelessWidget {
  final String tokenNumber;
  final String businessName;

  const YourTurnScreen({
    super.key,
    this.tokenNumber = TextConstants.tokenValueA024,
    this.businessName = TextConstants.sampleBusinessName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
            color: ColorConstants.textHeadline,
          ),
          splashRadius: 24,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Confetti Burst with Large Blue Checkmark Badge
              SizedBox(
                width: 220,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti Particles
                    CustomPaint(
                      size: const Size(220, 180),
                      painter: _ConfettiPainter(),
                    ),

                    // Large Blue Checkmark Circle
                    Container(
                      width: 84,
                      height: 84,
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryBlue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x401D61F2),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // "Your Turn!" Headline
              const Text(
                TextConstants.yourTurnTitle,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // Subtitle
              const Text(
                TextConstants.yourTurnSubtitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Prominent Token Badge Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFBFDBFE),
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: Text(
                    tokenNumber,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1D4ED8),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // "Okay" Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to Root / Home
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    TextConstants.okayButton,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final particles = [
      // Top left
      _Particle(offset: Offset(center.dx - 65, center.dy - 55), color: const Color(0xFF3B82F6), radius: 3),
      _Particle(offset: Offset(center.dx - 45, center.dy - 70), color: const Color(0xFFF59E0B), radius: 4, isRect: true),
      _Particle(offset: Offset(center.dx - 80, center.dy - 20), color: const Color(0xFF10B981), radius: 3),

      // Top right
      _Particle(offset: Offset(center.dx + 50, center.dy - 65), color: const Color(0xFFEC4899), radius: 3),
      _Particle(offset: Offset(center.dx + 75, center.dy - 40), color: const Color(0xFF3B82F6), radius: 4, isRect: true),
      _Particle(offset: Offset(center.dx + 65, center.dy - 10), color: const Color(0xFFF59E0B), radius: 3),

      // Bottom left & right
      _Particle(offset: Offset(center.dx - 70, center.dy + 35), color: const Color(0xFF8B5CF6), radius: 4, isRect: true),
      _Particle(offset: Offset(center.dx + 60, center.dy + 45), color: const Color(0xFF10B981), radius: 3),
      _Particle(offset: Offset(center.dx - 40, center.dy + 65), color: const Color(0xFF3B82F6), radius: 3),
      _Particle(offset: Offset(center.dx + 45, center.dy + 60), color: const Color(0xFFF59E0B), radius: 4, isRect: true),
    ];

    for (final p in particles) {
      final paint = Paint()
        ..color = p.color
        ..style = PaintingStyle.fill;

      if (p.isRect) {
        canvas.save();
        canvas.translate(p.offset.dx, p.offset.dy);
        canvas.rotate(math.pi / 4);
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.radius * 2, height: p.radius * 1.5),
          paint,
        );
        canvas.restore();
      } else {
        canvas.drawCircle(p.offset, p.radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Particle {
  final Offset offset;
  final Color color;
  final double radius;
  final bool isRect;

  const _Particle({
    required this.offset,
    required this.color,
    required this.radius,
    this.isRect = false,
  });
}

