import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';

class LocationMapIllustration extends StatelessWidget {
  const LocationMapIllustration({super.key});

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
            left: 18,
            top: 15,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 22,
            top: 20,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Perspective Grid Map Tile
          Positioned(
            bottom: 14,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(0.65),
              alignment: Alignment.center,
              child: Container(
                width: 110,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF93C5FD),
                    width: 1.5,
                  ),
                ),
                child: CustomPaint(
                  size: const Size(110, 75),
                  painter: _GridMapPainter(),
                ),
              ),
            ),
          ),

          // Blue Location Pin Drop
          Positioned(
            top: 20,
            child: Container(
              width: 44,
              height: 48,
              decoration: const BoxDecoration(
                color: ColorConstants.primaryBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x401D61F2),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBFDBFE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Horizontal grid lines
    canvas.drawLine(
      Offset(0, size.height * 0.33),
      Offset(size.width, size.height * 0.33),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.66),
      Offset(size.width, size.height * 0.66),
      paint,
    );

    // Vertical grid lines
    canvas.drawLine(
      Offset(size.width * 0.33, 0),
      Offset(size.width * 0.33, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.66, 0),
      Offset(size.width * 0.66, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

