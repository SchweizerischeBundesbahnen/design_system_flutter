import 'package:flutter/material.dart';

import '../theme/sbb_colors.dart';

/// Custom circle thumb shape with border for the [SBBSlider].
class CircleBorderThumbShape extends SliderComponentShape {
  const CircleBorderThumbShape({
    this.radius = 14.0,
    this.borderWidth = 2.0,
    this.color,
    this.borderColor,
  });

  final double radius;
  final double borderWidth;
  final Color? color;
  final Color? borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = color ?? sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor ?? sliderTheme.activeTrackColor ?? SBBColors.red
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }
}
