import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.textField,
    this.selectLabel,
    this.promotionBox,
    this.picker,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) => SBBControlStyles(
    textField: SBBTextFieldStyle.$default(baseStyle: baseStyle),
    selectLabel: SBBTextStyle(
      textStyle: baseStyle.themedTextStyle(
        textStyle: SBBTextStyles.helpersLabel,
        color: baseStyle.themeValue(SBBColors.metal, SBBColors.cement),
      ),
      textStyleDisabled: baseStyle.themedTextStyle(textStyle: SBBTextStyles.helpersLabel, color: SBBColors.metal),
    ),
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
    picker: SBBPickerStyle.$default(baseStyle: baseStyle),
  );

  final SBBTextFieldStyle? textField;
  final SBBTextStyle? selectLabel;

  final PromotionBoxStyle? promotionBox;
  final SBBPickerStyle? picker;

  static SBBControlStyles of(BuildContext context) => Theme.of(context).extension<SBBControlStyles>()!;

  TextSelectionThemeData get textSelectionTheme => TextSelectionThemeData(
    selectionColor: textField!.selectionColor,
    cursorColor: textField!.cursorColor,
    selectionHandleColor: textField!.selectionHandleColor,
  );

  @override
  ThemeExtension<SBBControlStyles> copyWith({
    SBBTextFieldStyle? textField,
    SBBTextStyle? selectLabel,
    PromotionBoxStyle? promotionBox,
    SBBPickerStyle? picker,
  }) => SBBControlStyles(
    textField: textField ?? this.textField,
    selectLabel: selectLabel ?? this.selectLabel,
    promotionBox: promotionBox ?? this.promotionBox,
    picker: picker ?? this.picker,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      textField: textField?.lerp(other.textField, t),
      selectLabel: selectLabel?.lerp(other.selectLabel, t),
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
      picker: picker?.lerp(other.picker, t),
    );
  }
}

extension SBBControlStylesExtension on SBBControlStyles? {
  SBBControlStyles merge(SBBControlStyles? other) {
    if (this == null) return other ?? SBBControlStyles();
    return this!.copyWith(
          textField: this!.textField.merge(other?.textField),
          selectLabel: this!.selectLabel.merge(other?.selectLabel),
          picker: this!.picker.merge(other?.picker),
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
