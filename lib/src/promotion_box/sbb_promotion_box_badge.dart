import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _shadowSpreadRadius = 8.0;
const _borderRadius = 20.0;
const _padding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0);

/// Only used within the [SBBPromotionBox].
class SBBPromotionBoxBadge extends StatelessWidget {
  const SBBPromotionBoxBadge({
    required this.text,
    required this.badgeColor,
    required this.badgeBorderColor,
    required this.badgeTextStyle,
    required this.shadowColor,
    super.key,
  });

  final String text;
  final Color badgeColor;
  final Color badgeBorderColor;
  final TextStyle badgeTextStyle;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BadgeHaloPainter(
        color: shadowColor,
        spread: _shadowSpreadRadius,
      ),
      child: Container(
        padding: _padding,
        decoration: BoxDecoration(
          border: Border.all(color: badgeBorderColor),
          borderRadius: BorderRadius.circular(_borderRadius),
          color: badgeColor,
        ),
        child: Text(text, style: badgeTextStyle, maxLines: 1),
      ),
    );
  }
}

/// Paints a solid rounded rectangle expanded by [spread] around the badge, only on the
/// upper half, acting as a thick halo colored with [color].
class _BadgeHaloPainter extends CustomPainter {
  _BadgeHaloPainter({
    required this.color,
    required this.spread,
  });

  final Color color;
  final double spread;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset.zero;

    // The halo is a larger rounded rect expanded by [spread] on all sides, rounded like a stadium border.
    final shadowRect = Rect.fromPoints(Offset.zero, size.bottomRight(origin)).inflate(spread);
    final shadowRRect = RRect.fromRectAndRadius(shadowRect, Radius.circular(shadowRect.shortestSide / 2.0));

    // Clip it to the upper half so it only appears above the badge centre line.
    canvas.clipRect(Rect.fromPoints(shadowRect.topLeft, shadowRect.centerRight));

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(shadowRRect, paint);
  }

  @override
  bool shouldRepaint(_BadgeHaloPainter oldDelegate) => oldDelegate.color != color || oldDelegate.spread != spread;
}
