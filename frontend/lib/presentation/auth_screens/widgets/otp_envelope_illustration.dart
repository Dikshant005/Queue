import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';

class OtpEnvelopeIllustration extends StatelessWidget {
  const OtpEnvelopeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft cloud bubble
          Container(
            width: 150,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(45),
            ),
          ),
          Positioned(
            left: 20,
            top: 15,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 25,
            top: 20,
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Envelope Body
          Positioned(
            bottom: 12,
            child: Container(
              width: 96,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFBFDBFE),
                  width: 1.2,
                ),
              ),
              child: Stack(
                children: [
                  // Envelope Fold V Lines
                  CustomPaint(
                    size: const Size(96, 64),
                    painter: _EnvelopeFoldPainter(),
                  ),
                ],
              ),
            ),
          ),

          // Paper Airplane Flying Out of Envelope
          Positioned(
            top: 18,
            left: 64,
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: ColorConstants.primaryBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x331D61F2),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          // Security Shield Badge on the right
          Positioned(
            bottom: 16,
            right: 22,
            child: Container(
              width: 32,
              height: 36,
              decoration: BoxDecoration(
                color: ColorConstants.primaryBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.primaryBlue.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvelopeFoldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF93C5FD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path();
    // Top fold flap
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height * 0.55);
    path.lineTo(size.width, 0);

    // Bottom fold lines
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.38, size.height * 0.45);

    path.moveTo(size.width, size.height);
    path.lineTo(size.width * 0.62, size.height * 0.45);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

