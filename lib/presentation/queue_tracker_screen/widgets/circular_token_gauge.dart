import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/queue_tracker_provider.dart';

class CircularTokenGauge extends ConsumerWidget {
  const CircularTokenGauge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueState = ref.watch(queueTrackerProvider);

    return SizedBox(
      height: 260,
      width: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gauge Arc Painter
          CustomPaint(
            size: const Size(240, 240),
            painter: _TokenGaugePainter(),
          ),

          // Central Token Info
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                TextConstants.yourToken,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textBody,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                queueState.tokenNumber,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),

          // "Waiting in Line" Pill Badge at Bottom Center
          Positioned(
            bottom: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                TextConstants.waitingInLine,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.primaryBlue,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TokenGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;

    const strokeWidth = 10.0;
    // An open gauge from roughly 135 deg to 405 deg (270 degrees sweep)
    const startAngle = 135 * (math.pi / 180);
    const sweepAngle = 270 * (math.pi / 180);

    // Track arc (faint light blue/grey)
    final trackPaint = Paint()
      ..color = const Color(0xFFDBEAFE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    // Active progress arc (~65% of the sweep)
    const activeSweep = sweepAngle * 0.65;
    final activePaint = Paint()
      ..color = ColorConstants.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      activeSweep,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

