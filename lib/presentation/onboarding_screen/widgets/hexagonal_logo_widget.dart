import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class HexagonalLogoWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Color textColor;
  final String text;

  const HexagonalLogoWidget({
    super.key,
    this.size = 100,
    this.color = const Color(0xFF2D5A3D),
    this.textColor = Colors.white,
    this.text = '7',
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: HexagonPainter(color: color),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: size * 0.4,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Create hexagon path
    for (int i = 0; i < 6; i++) {
      final double angle = (i * 60) * (3.14159 / 180);
      final double x = centerX + radius * 0.8 * math.cos(angle);
      final double y = centerY + radius * 0.8 * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Helper function for cos
double cos(double angle) => math.cos(angle);

// Helper function for sin
double sin(double angle) => math.sin(angle);
