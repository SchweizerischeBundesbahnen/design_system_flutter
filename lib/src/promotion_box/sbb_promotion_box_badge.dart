import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _shadowSpreadRadius = 8.0;
const _borderRadius = 20.0;
const _padding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0);

/// Only used within the [SBBPromotionBox].
class SBBPromotionBoxBadge extends StatelessWidget {
  const SBBPromotionBoxBadge({
    required this.text,
    this.badgeColor,
    super.key,
  });

  final String text;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).promotionBox!;
    final resolvedBadgeColor = badgeColor ?? style.badgeColor;
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        border: Border.all(color: style.borderColor!),
        borderRadius: BorderRadius.circular(_borderRadius),
        color: resolvedBadgeColor,
      ),
      child: Text(text, style: style.badgeTextStyle, maxLines: 1),
    );
  }
}

class SBBPromotionBoxBadgeShadow extends StatelessWidget {
  const SBBPromotionBoxBadgeShadow({required this.badgeSize, this.shadowColor});

  final Size badgeSize;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).promotionBox!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: SBBColors.transparent,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? style.badgeShadowColor!,
            spreadRadius: _shadowSpreadRadius,
          ),
        ],
      ),
      child: SizedBox.fromSize(size: badgeSize),
    );
  }
}
