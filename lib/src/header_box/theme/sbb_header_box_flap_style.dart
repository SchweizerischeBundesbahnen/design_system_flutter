import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBHeaderBoxFlap].
///
/// Use this class in combination with [SBBHeaderBoxThemeData] to customize
/// the appearance of header box flaps throughout your app or for specific
/// widget subtrees.
///
/// See also:
/// * [SBBHeaderBoxFlap], the widget that uses this style.
/// * [SBBHeaderBoxThemeData], which applies this style theme-wide.
@immutable
class SBBHeaderBoxFlapStyle {
  const SBBHeaderBoxFlapStyle({
    this.leadingForegroundColor,
    this.trailingForegroundColor,
    this.labelForegroundColor,
    this.labelTextStyle,
    this.leadingTextStyle,
    this.trailingTextStyle,
    this.iconSize,
    this.padding,
  });

  /// The color of the leading flap content.
  ///
  /// This affects the icon or text color of [SBBHeaderBoxFlap.leading].
  final Color? leadingForegroundColor;

  /// The color of the trailing flap content.
  ///
  /// This affects the icon or text color of [SBBHeaderBoxFlap.trailing].
  final Color? trailingForegroundColor;

  /// The color of the flap label.
  ///
  /// This color is typically used instead of the color of the [labelTextStyle].
  final Color? labelForegroundColor;

  /// The text style for the flap label.
  ///
  /// Applies to text descendants of [SBBHeaderBoxFlap.label].
  ///
  /// The color of the [labelTextStyle] is typically not used directly, the
  /// [labelForegroundColor] is used instead.
  final TextStyle? labelTextStyle;

  /// The text style for the leading flap content.
  ///
  /// Applies to text descendants of [SBBHeaderBoxFlap.leading].
  final TextStyle? leadingTextStyle;

  /// The text style for the trailing flap content.
  ///
  /// Applies to text descendants of [SBBHeaderBoxFlap.trailing].
  final TextStyle? trailingTextStyle;

  /// The icon size used for leading and trailing flap icons.
  final double? iconSize;

  /// The padding around the flap content.
  final EdgeInsetsGeometry? padding;

  SBBHeaderBoxFlapStyle copyWith({
    Color? leadingForegroundColor,
    Color? trailingForegroundColor,
    Color? labelForegroundColor,
    TextStyle? labelTextStyle,
    TextStyle? leadingTextStyle,
    TextStyle? trailingTextStyle,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBHeaderBoxFlapStyle(
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      iconSize: iconSize ?? this.iconSize,
      padding: padding ?? this.padding,
    );
  }

  SBBHeaderBoxFlapStyle merge(SBBHeaderBoxFlapStyle? other) {
    if (other == null) return this;

    return SBBHeaderBoxFlapStyle(
      leadingForegroundColor: other.leadingForegroundColor ?? leadingForegroundColor,
      trailingForegroundColor: other.trailingForegroundColor ?? trailingForegroundColor,
      labelForegroundColor: other.labelForegroundColor ?? labelForegroundColor,
      labelTextStyle: labelTextStyle?.merge(other.labelTextStyle) ?? other.labelTextStyle ?? labelTextStyle,
      leadingTextStyle: leadingTextStyle?.merge(other.leadingTextStyle) ?? other.leadingTextStyle ?? leadingTextStyle,
      trailingTextStyle:
          trailingTextStyle?.merge(other.trailingTextStyle) ?? other.trailingTextStyle ?? trailingTextStyle,
      iconSize: other.iconSize ?? iconSize,
      padding: other.padding ?? padding,
    );
  }

  static SBBHeaderBoxFlapStyle? lerp(
    SBBHeaderBoxFlapStyle? a,
    SBBHeaderBoxFlapStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return SBBHeaderBoxFlapStyle(
      leadingForegroundColor: Color.lerp(a?.leadingForegroundColor, b?.leadingForegroundColor, t),
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),
      labelForegroundColor: Color.lerp(a?.labelForegroundColor, b?.labelForegroundColor, t),
      labelTextStyle: TextStyle.lerp(a?.labelTextStyle, b?.labelTextStyle, t),
      leadingTextStyle: TextStyle.lerp(a?.leadingTextStyle, b?.leadingTextStyle, t),
      trailingTextStyle: TextStyle.lerp(a?.trailingTextStyle, b?.trailingTextStyle, t),
      iconSize: ui.lerpDouble(a?.iconSize, b?.iconSize, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBHeaderBoxFlapStyle &&
          runtimeType == other.runtimeType &&
          leadingForegroundColor == other.leadingForegroundColor &&
          trailingForegroundColor == other.trailingForegroundColor &&
          labelForegroundColor == other.labelForegroundColor &&
          labelTextStyle == other.labelTextStyle &&
          leadingTextStyle == other.leadingTextStyle &&
          trailingTextStyle == other.trailingTextStyle &&
          iconSize == other.iconSize &&
          padding == other.padding;

  @override
  int get hashCode => Object.hash(
    leadingForegroundColor,
    trailingForegroundColor,
    labelForegroundColor,
    labelTextStyle,
    leadingTextStyle,
    trailingTextStyle,
    iconSize,
    padding,
  );
}
