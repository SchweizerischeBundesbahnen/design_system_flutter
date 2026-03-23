import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.textField,
    this.linkTextStyle,
    this.linkTextStyleHighlighted,
    this.tabBarTextStyle,
    this.promotionBox,
    this.picker,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) => SBBControlStyles(
    textField: SBBTextFieldStyle.$default(baseStyle: baseStyle),
    linkTextStyle: baseStyle.defaultTextStyle?.copyWith(color: baseStyle.primaryColor),
    linkTextStyleHighlighted: baseStyle.defaultTextStyle?.copyWith(
      color: baseStyle.themeValue(baseStyle.primaryColorDark, SBBColors.white),
    ),
    tabBarTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
    picker: SBBPickerStyle.$default(baseStyle: baseStyle),
  );

  final SBBTextFieldStyle? textField;
  final TextStyle? linkTextStyle;
  final TextStyle? linkTextStyleHighlighted;
  final TextStyle? tabBarTextStyle;
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
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,
    TextStyle? tabBarTextStyle,
    PromotionBoxStyle? promotionBox,
    SBBPickerStyle? picker,
  }) => SBBControlStyles(
    textField: textField ?? this.textField,
    linkTextStyle: linkTextStyle ?? this.linkTextStyle,
    linkTextStyleHighlighted: linkTextStyleHighlighted ?? this.linkTextStyleHighlighted,
    tabBarTextStyle: tabBarTextStyle ?? this.tabBarTextStyle,
    promotionBox: promotionBox ?? this.promotionBox,
    picker: picker ?? this.picker,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      textField: textField?.lerp(other.textField, t),
      linkTextStyle: TextStyle.lerp(linkTextStyle, other.linkTextStyle, t),
      linkTextStyleHighlighted: TextStyle.lerp(linkTextStyleHighlighted, other.linkTextStyleHighlighted, t),
      tabBarTextStyle: TextStyle.lerp(tabBarTextStyle, other.tabBarTextStyle, t),
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
          picker: this!.picker.merge(other?.picker),
          linkTextStyle: this!.linkTextStyle ?? other?.linkTextStyle,
          linkTextStyleHighlighted: this!.linkTextStyleHighlighted ?? other?.linkTextStyleHighlighted,
          tabBarTextStyle: this!.tabBarTextStyle ?? other?.tabBarTextStyle,
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
