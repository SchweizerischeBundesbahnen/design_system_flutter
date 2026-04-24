import 'package:flutter/material.dart';

import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _thumbBoxShadows = <BoxShadow>[
  BoxShadow(color: Color(0x338D8D8D), offset: Offset(0, 1), blurRadius: 8.0),
  BoxShadow(color: Color(0x1A8D8D8D), offset: Offset(0, 4), blurRadius: 32.0),
];

/// Custom circle thumb shape with border for the [SBBSlider].
class CircleBorderThumbShape extends SliderComponentShape {
  const CircleBorderThumbShape({
    required this.radius,
    required this.borderWidth,
    required this.disabledBorderColor,
    required this.enabledBorderColor,
  });

  final double radius;
  final double borderWidth;
  final Color enabledBorderColor;
  final Color disabledBorderColor;

  @override
  Size getPreferredSize(_, _) => Size.fromRadius(radius);

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
    final canvas = context.canvas;

    // drop shadows
    if (enableAnimation.value > 0.5) _paintShadow(center, canvas);

    final disabledBackgroundColor = sliderTheme.disabledThumbColor;
    final enabledBackgroundColor = sliderTheme.thumbColor;

    final backgroundColor =
        Color.lerp(disabledBackgroundColor, enabledBackgroundColor, enableAnimation.value) ?? SBBColors.white;
    final borderColor = Color.lerp(disabledBorderColor, enabledBorderColor, enableAnimation.value)!;

    // thumb background
    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = .fill;
    canvas.drawCircle(center, radius, fillPaint);

    // thumb border
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = .stroke;
    canvas.drawCircle(center, radius, borderPaint);
  }

  void _paintShadow(Offset center, Canvas canvas) {
    final thumbRect = Rect.fromCircle(center: center, radius: radius);
    for (final BoxShadow shadow in _thumbBoxShadows) {
      final shadowRect = thumbRect.shift(shadow.offset);
      final shadowPaint = shadow.toPaint();
      canvas.drawOval(shadowRect, shadowPaint);
    }
  }
}
