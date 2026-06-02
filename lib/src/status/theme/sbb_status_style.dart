import 'dart:ui';

import 'package:flutter/material.dart';

/// Defines the visual properties of [SBBStatus].
///
/// Use this class in combination with [SBBStatusThemeData] to customize
/// the appearance of status indicators throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBStatus], the status widget that uses this style.
/// * [SBBStatusThemeData], which applies this style theme-wide.
class SBBStatusStyle {
  const SBBStatusStyle({
    this.textStyle,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.iconData,
    this.borderColor,
    this.alphaValue,
  });

  /// The text style for the status text descendants.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final TextStyle? textStyle;

  /// The color for status [Text] and [Icon] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle].
  final Color? foregroundColor;

  /// The background color of the status indicator.
  ///
  /// This color is used for:
  /// * The solid background behind the icon
  /// * The tinted background behind the text (with [alphaValue] applied)
  final Color? backgroundColor;

  /// The color of the status icon.
  ///
  /// This color is applied to the icon that indicates the status type
  /// (alert, warning, success, or information).
  ///
  /// If null, defaults to [foregroundColor].
  final Color? iconColor;

  /// The default icon for this status state.
  ///
  /// Used when neither [SBBStatus.icon] nor [SBBStatus.iconData]
  /// are provided.
  final IconData? iconData;

  /// The color of the border around the status text container.
  ///
  /// This border separates the icon container from the text container.
  /// If null, no border is displayed.
  final Color? borderColor;

  /// The opacity value applied to the text container background.
  ///
  /// This value (between 0.0 and 1.0) controls how transparent the
  /// background behind the text appears.
  ///
  /// Defaults to `0.05` for all types if not specified.
  final double? alphaValue;

  /// The shape of the border of [SBBStatus].
  static const RoundedRectangleBorder border = RoundedRectangleBorder(borderRadius: BorderRadius.all(borderRadius));

  /// The border radius of the [SBBStatus].
  ///
  /// All content is clipped to a RoundedRectangle with this border.
  static const Radius borderRadius = .circular(8.0);

  SBBStatusStyle copyWith({
    TextStyle? textStyle,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? iconColor,
    IconData? iconData,
    Color? borderColor,
    double? alphaValue,
  }) {
    return SBBStatusStyle(
      textStyle: textStyle ?? this.textStyle,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      iconData: iconData ?? this.iconData,
      borderColor: borderColor ?? this.borderColor,
      alphaValue: alphaValue ?? this.alphaValue,
    );
  }

  SBBStatusStyle merge(SBBStatusStyle? other) {
    if (other == null) return this;

    return copyWith(
      textStyle: other.textStyle,
      foregroundColor: other.foregroundColor,
      backgroundColor: other.backgroundColor,
      iconColor: other.iconColor,
      iconData: other.iconData,
      borderColor: other.borderColor,
      alphaValue: other.alphaValue,
    );
  }

  static SBBStatusStyle? lerp(SBBStatusStyle? a, SBBStatusStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBStatusStyle(
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      iconData: t < 0.5 ? a?.iconData : b?.iconData,
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      alphaValue: lerpDouble(a?.alphaValue, b?.alphaValue, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBStatusStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          foregroundColor == other.foregroundColor &&
          backgroundColor == other.backgroundColor &&
          iconColor == other.iconColor &&
          iconData == other.iconData &&
          borderColor == other.borderColor &&
          alphaValue == other.alphaValue;

  @override
  int get hashCode => Object.hash(
    textStyle,
    foregroundColor,
    backgroundColor,
    iconColor,
    iconData,
    borderColor,
    alphaValue,
  );
}
