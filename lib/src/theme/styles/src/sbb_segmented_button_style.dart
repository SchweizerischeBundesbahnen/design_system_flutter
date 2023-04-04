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
    this.boxShadow,
  });

  factory SBBSegmentedButtonStyle.$default({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonStyle(
        backgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.charcoal),
        borderColor: baseStyle.themeValue(SBBColors.transparent, SBBColors.iron),
        selectedColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
        selectedBorderColor: baseStyle.themeValue(SBBColors.black, SBBColors.graphite),
        textStyle: baseStyle.themedTextStyle(),
        boxShadow: baseStyle.themeValue(SBBInternal.defaultBoxShadow, SBBInternal.defaultDarkBoxShadow),
      );

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;

  SBBSegmentedButtonStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? selectedColor,
    Color? selectedBorderColor,
    TextStyle? textStyle,
    List<BoxShadow>? boxShadow,
  }) =>
      SBBSegmentedButtonStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderColor: borderColor ?? this.borderColor,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
        textStyle: textStyle ?? this.textStyle,
        boxShadow: boxShadow ?? this.boxShadow,
      );

  SBBSegmentedButtonStyle lerp(SBBSegmentedButtonStyle? other, double t) => SBBSegmentedButtonStyle(
        backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
        borderColor: Color.lerp(borderColor, other?.borderColor, t),
        selectedColor: Color.lerp(selectedColor, other?.selectedColor, t),
        selectedBorderColor: Color.lerp(selectedBorderColor, other?.selectedBorderColor, t),
        textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
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
      boxShadow: this!.boxShadow ?? other?.boxShadow,
    );
  }
}
