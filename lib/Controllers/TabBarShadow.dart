import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GlowingBottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final baseRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(baseRect, Paint()..color = const Color(0xAA000000));

    final shadowRect = Rect.fromLTWH(0, 0, size.width, 10);
    final shadowPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 10), Offset(0, 0), // Bottom to top
        [
          const Color(0x88000000), // Darker at bottom
          const Color(0x00000000), // Transparent at top
        ],
        [0.0, 1.0],
      );
    canvas.drawRect(shadowRect, shadowPaint);

    // 3. Faint Glow Gradient (Subtle)
    final glowRect = Rect.fromLTWH(0, 0, size.width, 14);
    final glowPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 14), Offset(0, 0),
        [
          const Color(0x05FFFFFF), // Very faint
          const Color(0x00FFFFFF), // Even more faint
        ],
        [0.0, 1.0],
      )
      ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, 2); // Small blur;
    canvas.drawRect(glowRect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}