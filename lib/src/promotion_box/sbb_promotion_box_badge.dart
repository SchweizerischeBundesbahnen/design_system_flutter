import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 1.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: style.borderColor!),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: resolvedBadgeColor,
      ),
      child: Text(text, style: style.badgeTextStyle, maxLines: 1),
    );
  }
}
