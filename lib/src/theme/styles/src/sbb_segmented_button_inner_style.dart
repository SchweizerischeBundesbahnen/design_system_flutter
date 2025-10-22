import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBSegmentedButtonInnerStyle {
  SBBSegmentedButtonInnerStyle({this.backgroundColor, this.borderColor, this.textStyle});

  factory SBBSegmentedButtonInnerStyle.$default({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonInnerStyle(
    backgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.charcoal),
    borderColor: baseStyle.themeValue(SBBColors.transparent, SBBColors.iron),
    textStyle: baseStyle.themedTextStyle(),
  );

  factory SBBSegmentedButtonInnerStyle.red({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonInnerStyle(
    backgroundColor: SBBColors.red125,
    borderColor: SBBColors.transparent,
    textStyle: baseStyle.themedTextStyle(color: SBBColors.white),
  );

  factory SBBSegmentedButtonInnerStyle.selected({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonInnerStyle(
    backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
    borderColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
    textStyle: baseStyle.themedTextStyle(),
  );

  factory SBBSegmentedButtonInnerStyle.redSelected({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonInnerStyle(
    backgroundColor: SBBColors.red,
    borderColor: SBBColors.red150,
    textStyle: baseStyle.themedTextStyle(color: SBBColors.white, fontFamily: SBBFontFamily.sbbFontBold),
  );

  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  SBBSegmentedButtonInnerStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    TextStyle? textStyle,
  }) => SBBSegmentedButtonInnerStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    borderColor: borderColor ?? this.borderColor,
    textStyle: textStyle ?? this.textStyle,
  );

  SBBSegmentedButtonInnerStyle lerp(SBBSegmentedButtonInnerStyle? other, double t) => SBBSegmentedButtonInnerStyle(
    backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
    borderColor: Color.lerp(borderColor, other?.borderColor, t),
    textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
  );
}

extension SBBSegmentedButtonInnerStyleExtension on SBBSegmentedButtonInnerStyle? {
  SBBSegmentedButtonInnerStyle merge(SBBSegmentedButtonInnerStyle? other) {
    if (this == null) return other ?? SBBSegmentedButtonInnerStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      borderColor: this!.borderColor ?? other?.borderColor,
      textStyle: this!.textStyle ?? other?.textStyle,
    );
  }
}
