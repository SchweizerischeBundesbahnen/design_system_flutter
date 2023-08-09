import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBListItemStyle {
  SBBListItemStyle({
    this.backgroundColor,
    this.backgroundColorHighlighted,
    this.backgroundColorDisabled,
    this.iconColor,
    this.iconColorDisabled,
    this.textStyle,
    this.textStyleDisabled,
    this.secondaryTextStyle,
    this.secondaryTextStyleDisabled,
  });

  factory SBBListItemStyle.$default({required SBBBaseStyle baseStyle}) =>
      SBBListItemStyle(
        backgroundColor: SBBColors.transparent,
        backgroundColorHighlighted: baseStyle.themeValue(
          SBBColors.platinum,
          SBBColors.midnight,
        ),
        backgroundColorDisabled: SBBColors.transparent,
        iconColor: baseStyle.iconColor,
        iconColorDisabled: baseStyle.themeValue(
          SBBColors.granite,
          SBBColors.graphite,
        ),
        textStyle: baseStyle.themedTextStyle(),
        textStyleDisabled: baseStyle.themedTextStyle(
          color: baseStyle.themeValue(
            SBBColors.granite,
            SBBColors.graphite,
          ),
        ),
        secondaryTextStyle: baseStyle.themedTextStyle(
          textStyle: SBBTextStyles.smallLight,
          color: baseStyle.labelColor,
        ),
        secondaryTextStyleDisabled: baseStyle.themedTextStyle(
          textStyle: SBBTextStyles.smallLight,
          color: baseStyle.labelColor,
        ),
      );

  final Color? backgroundColor;
  final Color? backgroundColorHighlighted;
  final Color? backgroundColorDisabled;
  final Color? iconColor;
  final Color? iconColorDisabled;
  final TextStyle? textStyle;
  final TextStyle? textStyleDisabled;
  final TextStyle? secondaryTextStyle;
  final TextStyle? secondaryTextStyleDisabled;

  SBBListItemStyle copyWith({
    Color? backgroundColor,
    Color? backgroundColorHighlighted,
    Color? backgroundColorDisabled,
    Color? iconColor,
    Color? iconColorDisabled,
    TextStyle? textStyle,
    TextStyle? textStyleDisabled,
    TextStyle? secondaryTextStyle,
    TextStyle? secondaryTextStyleDisabled,
  }) =>
      SBBListItemStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundColorHighlighted: backgroundColorHighlighted ?? this.backgroundColorHighlighted,
        backgroundColorDisabled: backgroundColorDisabled ?? this.backgroundColorDisabled,
        iconColor: iconColor ?? this.iconColor,
        iconColorDisabled: iconColorDisabled ?? this.iconColorDisabled,
        textStyle: textStyle ?? this.textStyle,
        textStyleDisabled: textStyleDisabled ?? this.textStyleDisabled,
        secondaryTextStyle: secondaryTextStyle ?? this.secondaryTextStyle,
        secondaryTextStyleDisabled: secondaryTextStyleDisabled ?? this.secondaryTextStyleDisabled,
      );

  SBBListItemStyle lerp(SBBListItemStyle? other, double t) => SBBListItemStyle(
        backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
        backgroundColorHighlighted: Color.lerp(backgroundColorHighlighted, other?.backgroundColorHighlighted, t),
        backgroundColorDisabled: Color.lerp(backgroundColorDisabled, other?.backgroundColorDisabled, t),
        iconColor: Color.lerp(iconColor, other?.iconColor, t),
        iconColorDisabled: Color.lerp(iconColorDisabled, other?.iconColorDisabled, t),
        textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
        textStyleDisabled: TextStyle.lerp(textStyleDisabled, other?.textStyleDisabled, t),
        secondaryTextStyle: TextStyle.lerp(secondaryTextStyle, other?.secondaryTextStyle, t),
        secondaryTextStyleDisabled: TextStyle.lerp(secondaryTextStyleDisabled, other?.secondaryTextStyleDisabled, t),
      );
}

extension SBBListItemControlStyleExtension on SBBListItemStyle? {
  SBBListItemStyle merge(SBBListItemStyle? other) {
    if (this == null) return other ?? SBBListItemStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      backgroundColorHighlighted: this!.backgroundColorHighlighted ?? other?.backgroundColorHighlighted,
      backgroundColorDisabled: this!.backgroundColorDisabled ?? other?.backgroundColorDisabled,
      iconColor: this!.iconColor ?? other?.iconColor,
      iconColorDisabled: this!.iconColorDisabled ?? other?.iconColorDisabled,
      textStyle: this!.textStyle ?? other?.textStyle,
      textStyleDisabled: this!.textStyleDisabled ?? other?.textStyleDisabled,
      secondaryTextStyle: this!.secondaryTextStyle ?? other?.secondaryTextStyle,
      secondaryTextStyleDisabled: this!.secondaryTextStyleDisabled ?? other?.secondaryTextStyleDisabled,
    );
  }
}
