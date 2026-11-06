import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../queue_tracker_screen/queue_tracker_screen.dart';

class QueueSuccessScreen extends StatelessWidget {
  final String tokenNumber;

  const QueueSuccessScreen({
    super.key,
    this.tokenNumber = 'A-024',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B132B),
      body: SafeArea(
        child: Stack(
          children: [
            // Floating Confetti Particle Layer
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: _ConfettiPainter(),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Large Blue Checkmark Badge
                  Container(
                    width: 92,
                    height: 92,
                    decoration: const BoxDecoration(
                      color: ColorConstants.primaryBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x661D61F2),
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Headline
                  const Text(
                    TextConstants.queueJoinedTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Your token $tokenNumber has been\nconfirmed.',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(flex: 3),

                  // "Track Queue" Primary Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // Replace current route with Live Queue Tracker
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const QueueTrackerScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        TextConstants.trackQueueButton,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // "Done" Text Action
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      TextConstants.doneButton,
                      style: TextStyle(
                        color: Color(0xFF60A5FA),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2563EB);

    final particles = [
      // Left cluster
      _Particle(x: size.width * 0.18, y: size.height * 0.12, w: 8, h: 4, angle: 0.3),
      _Particle(x: size.width * 0.12, y: size.height * 0.19, w: 7, h: 5, angle: -0.4),
      _Particle(x: size.width * 0.28, y: size.height * 0.16, w: 6, h: 6, angle: 0.7),
      _Particle(x: size.width * 0.22, y: size.height * 0.24, w: 9, h: 4, angle: 0.2),

      // Center cluster
      _Particle(x: size.width * 0.42, y: size.height * 0.10, w: 6, h: 4, angle: -0.2),
      _Particle(x: size.width * 0.58, y: size.height * 0.09, w: 5, h: 5, angle: 0.5),

      // Right cluster
      _Particle(x: size.width * 0.78, y: size.height * 0.13, w: 8, h: 4, angle: -0.5),
      _Particle(x: size.width * 0.88, y: size.height * 0.18, w: 6, h: 5, angle: 0.6),
      _Particle(x: size.width * 0.72, y: size.height * 0.21, w: 7, h: 6, angle: -0.3),
      _Particle(x: size.width * 0.82, y: size.height * 0.26, w: 5, h: 5, angle: 0.4),
    ];

    for (final p in particles) {
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.angle);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.w, height: p.h),
          const Radius.circular(1.5),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Particle {
  final double x;
  final double y;
  final double w;
  final double h;
  final double angle;

  const _Particle({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.angle,
  });
}
