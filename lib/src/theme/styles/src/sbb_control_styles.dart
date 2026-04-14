import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.promotionBox,
    this.picker,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) => SBBControlStyles(
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
    picker: SBBPickerStyle.$default(baseStyle: baseStyle),
  );

  final PromotionBoxStyle? promotionBox;
  final SBBPickerStyle? picker;

  static SBBControlStyles of(BuildContext context) => Theme.of(context).extension<SBBControlStyles>()!;

  @override
  ThemeExtension<SBBControlStyles> copyWith({
    PromotionBoxStyle? promotionBox,
    SBBPickerStyle? picker,
  }) => SBBControlStyles(
    promotionBox: promotionBox ?? this.promotionBox,
    picker: picker ?? this.picker,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
      picker: picker?.lerp(other.picker, t),
    );
  }
}

extension SBBControlStylesExtension on SBBControlStyles? {
  SBBControlStyles merge(SBBControlStyles? other) {
    if (this == null) return other ?? SBBControlStyles();
    return this!.copyWith(
          picker: this!.picker.merge(other?.picker),
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
