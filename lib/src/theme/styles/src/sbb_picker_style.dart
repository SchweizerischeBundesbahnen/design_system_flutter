import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/theme/theme.dart';

class SBBPickerStyle {
  SBBPickerStyle({this.highlightColor, this.textStyle});

  factory SBBPickerStyle.$default({required SBBBaseStyle baseStyle}) => SBBPickerStyle(
        highlightColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
        textStyle: baseStyle.defaultTextStyle?.copyWith(
          fontFamily: SBBFontFamily.sbbFontRoman,
          fontSize: 24.0,
          height: 26.0 / 24.0,
        ),
      );

  final Color? highlightColor;
  final TextStyle? textStyle;

  SBBPickerStyle copyWith({
    Color? highlightColor,
    TextStyle? textStyle,
  }) =>
      SBBPickerStyle(
        highlightColor: highlightColor ?? this.highlightColor,
        textStyle: textStyle ?? this.textStyle,
      );

  SBBPickerStyle lerp(SBBPickerStyle? other, double t) => SBBPickerStyle(
        highlightColor: Color.lerp(highlightColor, other?.highlightColor, t),
        textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
      );
}

extension SBBPickerStyleExtension on SBBPickerStyle? {
  SBBPickerStyle merge(SBBPickerStyle? other) {
    if (this == null) return other ?? SBBPickerStyle();
    return this!.copyWith(
      highlightColor: this!.highlightColor ?? other?.highlightColor,
      textStyle: this!.textStyle ?? other?.textStyle,
    );
  }
}
