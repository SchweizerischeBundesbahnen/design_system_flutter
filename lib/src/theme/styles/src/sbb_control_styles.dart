import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.textField,
    this.selectLabel,
    this.linkTextStyle,
    this.linkTextStyleHighlighted,
    this.listHeaderTextStyle,
    this.modalBackgroundColor,
    this.modalTitleTextStyle,
    this.tabBarTextStyle,
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
    linkTextStyle: baseStyle.defaultTextStyle?.copyWith(color: baseStyle.primaryColor),
    linkTextStyleHighlighted: baseStyle.defaultTextStyle?.copyWith(
      color: baseStyle.themeValue(baseStyle.primaryColorDark, SBBColors.white),
    ),
    listHeaderTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
    modalBackgroundColor: baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
    modalTitleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight),
    tabBarTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
    promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
    picker: SBBPickerStyle.$default(baseStyle: baseStyle),
  );

  final SBBTextFieldStyle? textField;
  final SBBTextStyle? selectLabel;

  final TextStyle? linkTextStyle;
  final TextStyle? linkTextStyleHighlighted;
  final TextStyle? listHeaderTextStyle;
  final Color? modalBackgroundColor;
  final TextStyle? modalTitleTextStyle;
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
    SBBTextStyle? selectLabel,
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,
    TextStyle? listHeaderTextStyle,
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,
    TextStyle? tabBarTextStyle,
    PromotionBoxStyle? promotionBox,
    SBBPickerStyle? picker,
  }) => SBBControlStyles(
    textField: textField ?? this.textField,
    selectLabel: selectLabel ?? this.selectLabel,
    linkTextStyle: linkTextStyle ?? this.linkTextStyle,
    linkTextStyleHighlighted: linkTextStyleHighlighted ?? this.linkTextStyleHighlighted,
    listHeaderTextStyle: listHeaderTextStyle ?? this.listHeaderTextStyle,
    modalBackgroundColor: modalBackgroundColor ?? this.modalBackgroundColor,
    modalTitleTextStyle: modalTitleTextStyle ?? this.modalTitleTextStyle,
    tabBarTextStyle: tabBarTextStyle ?? this.tabBarTextStyle,
    promotionBox: promotionBox ?? this.promotionBox,
    picker: picker ?? this.picker,
  );

  @override
  ThemeExtension<SBBControlStyles> lerp(ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      textField: textField?.lerp(other.textField, t),
      selectLabel: selectLabel?.lerp(other.selectLabel, t),
      linkTextStyle: TextStyle.lerp(linkTextStyle, other.linkTextStyle, t),
      linkTextStyleHighlighted: TextStyle.lerp(linkTextStyleHighlighted, other.linkTextStyleHighlighted, t),
      listHeaderTextStyle: TextStyle.lerp(listHeaderTextStyle, other.listHeaderTextStyle, t),
      modalBackgroundColor: Color.lerp(modalBackgroundColor, other.modalBackgroundColor, t),
      modalTitleTextStyle: TextStyle.lerp(modalTitleTextStyle, other.modalTitleTextStyle, t),
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
          selectLabel: this!.selectLabel.merge(other?.selectLabel),
          picker: this!.picker.merge(other?.picker),
          linkTextStyle: this!.linkTextStyle ?? other?.linkTextStyle,
          linkTextStyleHighlighted: this!.linkTextStyleHighlighted ?? other?.linkTextStyleHighlighted,
          listHeaderTextStyle: this!.listHeaderTextStyle ?? other?.listHeaderTextStyle,
          modalBackgroundColor: this!.modalBackgroundColor ?? other?.modalBackgroundColor,
          modalTitleTextStyle: this!.modalTitleTextStyle ?? other?.modalTitleTextStyle,
          tabBarTextStyle: this!.tabBarTextStyle ?? other?.tabBarTextStyle,
          promotionBox: this!.promotionBox ?? other?.promotionBox,
        )
        as SBBControlStyles;
  }
}
