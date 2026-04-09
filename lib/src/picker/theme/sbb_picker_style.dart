import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBPicker] and related widgets.
///
/// Use this class in combination with [SBBPickerThemeData] to customize
/// the appearance of pickers throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBPicker], the widget that uses this style.
/// * [SBBPickerScrollView], the scroll view that uses this style.
/// * [SBBPickerThemeData], which applies this style theme-wide.
class SBBPickerStyle {
  SBBPickerStyle({this.highlightBackgroundColor, this.textStyle, this.foregroundColor, this.disabledForegroundColor});

  /// The background color of the highlighted area in the center of the [SBBPickerScrollView].
  final Color? highlightBackgroundColor;

  /// The foreground color applied to the [Text] descendants of the [SBBPickerItem].
  ///
  /// This color is shaded by a [ShaderMask] to achieve the fade out effect of the picker.
  final Color? foregroundColor;

  /// The disabled color applied to the [Text] descendants of the [SBBPickerItem].
  ///
  /// This color is shaded by a [ShaderMask] to achieve the fade out effect of the picker.
  final Color? disabledForegroundColor;

  /// The text style applied to [Text] descendants of the [SBBPickerItem].
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
