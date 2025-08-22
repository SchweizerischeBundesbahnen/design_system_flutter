import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

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
    super.key,
  });

  final String text;
  final Color badgeColor;
  final Color badgeBorderColor;
  final TextStyle badgeTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        border: Border.all(color: badgeBorderColor),
        borderRadius: BorderRadius.circular(_borderRadius),
        color: badgeColor,
      ),
      child: Text(text, style: badgeTextStyle, maxLines: 1),
    );
  }
}

class SBBPromotionBoxBadgeShadow extends StatelessWidget {
  const SBBPromotionBoxBadgeShadow({
    super.key,
    required this.badgeSize,
    required this.shadowColor,
  });

  final Size badgeSize;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.0, color: SBBColors.transparent),
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(color: shadowColor, spreadRadius: _shadowSpreadRadius),
        ],
      ),
      child: SizedBox.fromSize(size: badgeSize),
    );
  }
}
