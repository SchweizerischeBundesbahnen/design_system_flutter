import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Only used within the [SBBPromotionBox].
class SBBPromotionBoxBadge extends StatelessWidget {
  const SBBPromotionBoxBadge({
    this.labelText,
    this.label,
    this.style,
    super.key,
  }) : assert(labelText != null || label != null, 'One of labelText or label must be non null!'),
       assert(labelText == null || label == null, 'Cannot set both labelText and label!');

  final String? labelText;
  final Widget? label;
  final SBBPromotionBoxBadgeStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbPromotionBoxTheme.badgeStyle!;
    final effectiveStyle = themeStyle.merge(style);

    return CustomPaint(
      painter: _BadgeHaloPainter(
        color: effectiveStyle.haloColor ?? SBBColors.transparent,
        spread: SBBPromotionBoxBadgeStyle.haloSpreadRadius,
      ),
      child: Container(
        padding: effectiveStyle.padding!,
        decoration: ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(color: effectiveStyle.borderColor!)),
          color: effectiveStyle.backgroundColor,
        ),
        child: _content(context, effectiveStyle),
      ),
    );
  }

  Widget? _content(BuildContext context, SBBPromotionBoxBadgeStyle effectiveStyle) {
    final child = label ?? Text(labelText!, maxLines: 1);
    final resolvedTextStyle = effectiveStyle.textStyle!.copyWith(color: effectiveStyle.foregroundColor);

    return DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: effectiveStyle.foregroundColor),
        child: child,
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
