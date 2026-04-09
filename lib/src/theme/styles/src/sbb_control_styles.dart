import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.textField,
    this.promotionBox,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) => SBBControlStyles(
    textField: SBBTextFieldStyle.$default(baseStyle: baseStyle),
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
  );

  final SBBTextFieldStyle? textField;

  final PromotionBoxStyle? promotionBox;

  static SBBControlStyles of(BuildContext context) => Theme.of(context).extension<SBBControlStyles>()!;

  TextSelectionThemeData get textSelectionTheme => TextSelectionThemeData(
    selectionColor: textField!.selectionColor,
    cursorColor: textField!.cursorColor,
    selectionHandleColor: textField!.selectionHandleColor,
  );

  @override
  ThemeExtension<SBBControlStyles> copyWith({
    SBBTextFieldStyle? textField,
    PromotionBoxStyle? promotionBox,
  }) => SBBControlStyles(
    textField: textField ?? this.textField,
    promotionBox: promotionBox ?? this.promotionBox,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      textField: textField?.lerp(other.textField, t),
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
    );
  }
}

extension SBBControlStylesExtension on SBBControlStyles? {
  SBBControlStyles merge(SBBControlStyles? other) {
    if (this == null) return other ?? SBBControlStyles();
    return this!.copyWith(
          textField: this!.textField.merge(other?.textField),
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
