import 'package:flutter/material.dart';

import '../../../sbb_internal.dart';
import '../sbb_styles.dart';

class SBBSegmentedButtonStyle {
  SBBSegmentedButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.selectedColor,
    this.selectedBorderColor,
    this.textStyle,
    this.selectedTextStyle,
    this.redTextStyle,
    this.redSelectedTextStyle,
    this.boxShadow,
  });

  factory SBBSegmentedButtonStyle.$default({required SBBBaseStyle baseStyle}) =>
      SBBSegmentedButtonStyle(
        backgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.charcoal),
        borderColor: baseStyle.themeValue(SBBColors.transparent, SBBColors.iron),
        selectedColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
        selectedBorderColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
        textStyle: baseStyle.themedTextStyle(),
        selectedTextStyle: baseStyle.themedTextStyle(),
        redTextStyle: baseStyle.themedTextStyle(color: SBBColors.white),
        redSelectedTextStyle: baseStyle.themedTextStyle(color: SBBColors.white, boldFont: true),
        boxShadow: baseStyle.themeValue(SBBInternal.defaultBoxShadow, SBBInternal.defaultDarkBoxShadow),
      );

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final TextStyle? redTextStyle;
  final TextStyle? redSelectedTextStyle;
  final List<BoxShadow>? boxShadow;

  SBBSegmentedButtonStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? selectedColor,
    Color? selectedBorderColor,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    TextStyle? redTextStyle,
    TextStyle? redSelectedTextStyle,
    List<BoxShadow>? boxShadow,
  }) =>
      SBBSegmentedButtonStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderColor: borderColor ?? this.borderColor,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
        textStyle: textStyle ?? this.textStyle,
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        redTextStyle: redTextStyle ?? this.redTextStyle,
        redSelectedTextStyle: redSelectedTextStyle ?? this.redSelectedTextStyle,
        boxShadow: boxShadow ?? this.boxShadow,
      );

  SBBSegmentedButtonStyle lerp(SBBSegmentedButtonStyle? other, double t) =>
      SBBSegmentedButtonStyle(
        backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
        borderColor: Color.lerp(borderColor, other?.borderColor, t),
        selectedColor: Color.lerp(selectedColor, other?.selectedColor, t),
        selectedBorderColor: Color.lerp(selectedBorderColor, other?.selectedBorderColor, t),
        textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
        selectedTextStyle: TextStyle.lerp(selectedTextStyle, other?.selectedTextStyle, t),
        redTextStyle: TextStyle.lerp(redTextStyle, other?.redTextStyle, t),
        redSelectedTextStyle: TextStyle.lerp(redSelectedTextStyle, other?.redSelectedTextStyle, t),
        boxShadow: BoxShadow.lerpList(boxShadow, other?.boxShadow, t),
      );
}

extension SBBSegmentedButtonStyleExtension on SBBSegmentedButtonStyle? {
  SBBSegmentedButtonStyle merge(SBBSegmentedButtonStyle? other) {
    if (this == null) return other ?? SBBSegmentedButtonStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      borderColor: this!.borderColor ?? other?.borderColor,
      selectedColor: this!.selectedColor ?? other?.selectedColor,
      selectedBorderColor: this!.selectedBorderColor ?? other?.selectedBorderColor,
      textStyle: this!.textStyle ?? other?.textStyle,
      selectedTextStyle: this!.selectedTextStyle ?? other?.selectedTextStyle,
      redTextStyle: this!.redTextStyle ?? other?.redTextStyle,
      redSelectedTextStyle: this!.redSelectedTextStyle ?? other?.redSelectedTextStyle,
      boxShadow: this!.boxShadow ?? other?.boxShadow,
    );
  }

  TextStyle? getTextStyle(bool selected, bool isRed) => selected
      ? isRed
          ? this?.redSelectedTextStyle
          : this?.selectedTextStyle
      : isRed
          ? this?.redTextStyle
          : this?.textStyle;
}
