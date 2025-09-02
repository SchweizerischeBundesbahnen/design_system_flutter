import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';

class TabCurvePainter extends CustomPainter {
  TabCurvePainter(this.curves, this.color, this.shadowColor);

  final List<TabCurves> curves;
  final Color color;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final wavePath = TabCurves.toPath(curves, size);

    // Additional shadow
    final waveShadow =
        Paint()
          ..color = shadowColor.withAlpha(64)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawPath(wavePath, waveShadow);

    final wavePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;
    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool? hitTest(Offset position) {
    // Prevent the paint from stopping pointer events from reaching the icons underneath.
    // Hit tests still reach the children of the paint.
    return false;
  }

  @override
  bool shouldRepaint(TabCurvePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.shadowColor != shadowColor ||
      oldDelegate.curves.length != curves.length ||
      oldDelegate.curves.mapIndexed((i, c) => c != curves[i]).any((c) => c);
}
