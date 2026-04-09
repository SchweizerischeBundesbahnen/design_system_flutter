import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SBBPickerStyle {
  SBBPickerStyle({this.highlightBackgroundColor, this.textStyle, this.foregroundColor, this.disabledForegroundColor});

  /// The background color of the highlighted area in the center of the [SBBPickerScrollView].
  final Color? highlightBackgroundColor;
  final Color? foregroundColor;
  final Color? disabledForegroundColor;
  final TextStyle? textStyle;

  SBBPickerStyle copyWith({
    Color? highlightBackgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    TextStyle? textStyle,
  }) => SBBPickerStyle(
    highlightBackgroundColor: highlightBackgroundColor ?? this.highlightBackgroundColor,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    disabledForegroundColor: disabledForegroundColor ?? this.disabledForegroundColor,
    textStyle: textStyle ?? this.textStyle,
  );

  SBBPickerStyle lerp(SBBPickerStyle? other, double t) => SBBPickerStyle(
    highlightBackgroundColor: Color.lerp(highlightBackgroundColor, other?.highlightBackgroundColor, t),
    foregroundColor: Color.lerp(foregroundColor, other?.foregroundColor, t),
    disabledForegroundColor: Color.lerp(disabledForegroundColor, other?.disabledForegroundColor, t),
    textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
  );

  SBBPickerStyle merge(SBBPickerStyle? other) {
    if (other == null) return this;

    return copyWith(
      textStyle: other.textStyle,
      foregroundColor: other.foregroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      highlightBackgroundColor: other.highlightBackgroundColor,
    );
  }
}
