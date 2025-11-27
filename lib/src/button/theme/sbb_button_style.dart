import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// Style for SBB Buttons. Use this in combination with [SBBButtonThemeData]
/// to override all button variants within the current [SBBTheme].
///
/// See also:
/// * [SBBPrimaryButtonThemeData], the ThemeData given to SBBTheme to override the [SBBPrimaryButton]
/// * [SBBSecondaryButtonThemeData], the ThemeData given to SBBTheme to override the [SBBSecondaryButton]
/// * [SBBTertiaryButtonThemeData], the ThemeData given to SBBTheme to override the [SBBTertiaryButton]
class SBBButtonStyle {
  const SBBButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.iconColor,
    this.borderColor,
  });

  /// The style for a button's [Text] widget descendants.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The button's background fill color.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle].
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The color used to indicate that the button is focused or pressed.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The icon's color inside of the button.
  final WidgetStateProperty<Color?>? iconColor;

  /// The color of the button's outline.
  final WidgetStateProperty<Color?>? borderColor;

  SBBButtonStyle copyWith({
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  SBBButtonStyle merge(SBBButtonStyle? other) {
    if (other == null) return this;

    return copyWith(
      textStyle: other.textStyle,
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      overlayColor: other.overlayColor,
      iconColor: other.iconColor,
      borderColor: other.borderColor,
    );
  }

  static SBBButtonStyle? lerp(SBBButtonStyle? a, SBBButtonStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBButtonStyle(
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      iconColor: WidgetStateProperty.lerp<Color?>(a?.iconColor, b?.iconColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBButtonStyle &&
        other.textStyle == textStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.overlayColor == overlayColor &&
        other.iconColor == iconColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(
    textStyle,
    backgroundColor,
    foregroundColor,
    overlayColor,
    iconColor,
    borderColor,
  );
}
