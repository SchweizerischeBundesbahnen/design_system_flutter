import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/theme/theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.promotionBox,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) => SBBControlStyles(
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
  );

  final PromotionBoxStyle? promotionBox;

  static SBBControlStyles of(BuildContext context) => Theme.of(context).extension<SBBControlStyles>()!;

  @override
  ThemeExtension<SBBControlStyles> copyWith({
    PromotionBoxStyle? promotionBox,
  }) => SBBControlStyles(
    promotionBox: promotionBox ?? this.promotionBox,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
    );
  }
}

extension SBBControlStylesExtension on SBBControlStyles? {
  SBBControlStyles merge(SBBControlStyles? other) {
    if (this == null) return other ?? SBBControlStyles();
    return this!.copyWith(
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
