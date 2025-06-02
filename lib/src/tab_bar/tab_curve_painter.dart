import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';

class TabCurvePainter extends CustomPainter {
  TabCurvePainter(this.curves, this.color, this.shadowColor);

  final List<TabCurves> curves;
  final Color color;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final wavePath = Path();

    // Start drawing the wave from a known point, often off-screen to the left
    wavePath.moveTo(0, 0);
    wavePath.lineTo(curves.first.p0.dx, 0);

    // Call the draw method from your BezierCurves class
    for (var c in curves) {
      c.draw(wavePath);
    }

    // Close the path to form a shape (e.g., for a filled tab)
    wavePath.lineTo(size.width, 0);
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    final waveShadow = Paint()
      ..color = shadowColor.withAlpha(64)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawPath(wavePath, waveShadow);

    final wavePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool shouldRepaint(TabCurvePainter oldDelegate) {
    return true;
  }
}
