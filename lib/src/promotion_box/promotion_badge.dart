import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class PromotionBadge extends StatelessWidget {
  const PromotionBadge({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).promotionBox!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 1.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: style.borderColor!),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: style.badgeColor,
      ),
      child: Text(
        text,
        style: style.badgeTextStyle,
        maxLines: 1,
      ),
    );
  }
}
