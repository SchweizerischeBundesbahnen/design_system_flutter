import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Defines the visual properties of the "flap" area of the header box.
///
/// This can be used to theme the leading / trailing icons and text that
/// appear on the flap.
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

  /// Color used for the leading element on the flap (e.g. icon).
  final Color? leadingForegroundColor;

  /// Color used for the trailing element on the flap (e.g. icon / text).
  final Color? trailingForegroundColor;

  /// General foreground color for the flap (e.g. default icon / text color).
  final Color? labelForegroundColor;

  /// Text style used for the common flap label.
  final TextStyle? labelTextStyle;

  /// Text style used for the leading text on the flap.
  final TextStyle? leadingTextStyle;

  /// Text style used for the trailing text on the flap.
  final TextStyle? trailingTextStyle;

  /// Icon size for leading / trailing icons on the flap.
  final double? iconSize;

  /// Padding around the flap content.
  final EdgeInsetsGeometry? padding;

  SBBHeaderBoxFlapStyle copyWith({
    Color? leadingForegroundColor,
    Color? trailingForegroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    TextStyle? leadingTextStyle,
    TextStyle? trailingTextStyle,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBHeaderBoxFlapStyle(
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      labelForegroundColor: foregroundColor ?? this.labelForegroundColor,
      labelTextStyle: textStyle ?? this.labelTextStyle,
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
