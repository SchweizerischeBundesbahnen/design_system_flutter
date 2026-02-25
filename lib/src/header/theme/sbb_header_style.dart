import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBHeader].
///
/// Use this class in combination with [SBBHeaderThemeData] to customize
/// the appearance of the header throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBHeader], the header widget that uses this style.
/// * [SBBHeaderThemeData], which applies this style theme-wide.
class SBBHeaderStyle {
  const SBBHeaderStyle({
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.systemOverlayStyle,
    this.elevation,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.titleSpacing,
    this.actionsPadding,
    this.clipBehavior,
  });

  /// {@macro flutter.material.appbar.backgroundColor}
  final Color? backgroundColor;

  /// {@macro flutter.material.appbar.foregroundColor}
  final Color? foregroundColor;

  /// {@macro flutter.material.appbar.elevation}
  final double? elevation;

  /// {@macro flutter.material.appbar.titleSpacing}
  final double? titleSpacing;

  /// {@macro flutter.material.appbar.actionsPadding}
  final EdgeInsetsGeometry? actionsPadding;

  /// {@macro flutter.material.appbar.titleSpacing}
  final Clip? clipBehavior;

  /// {@macro flutter.material.appbar.centerTitle}
  final bool? centerTitle;

  /// {@macro flutter.material.appbar.systemOverlayStyle}
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// {@macro flutter.material.appbar.toolbarTextStyle}
  final TextStyle? toolbarTextStyle;

  /// {@macro flutter.material.appbar.titleTextStyle}
  final TextStyle? titleTextStyle;

  /// default height of the toolbar component of the [SBBHeader].
  static double get toolbarHeight => 80.0;

  /// default height of the toolbar component of the [SBBHeader].
  static double get smallToolbarHeight => 56.0;

  SBBHeaderStyle copyWith({
    bool? centerTitle,
    Color? backgroundColor,
    Color? foregroundColor,
    SystemUiOverlayStyle? systemOverlayStyle,
    double? elevation,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    double? titleSpacing,
    EdgeInsetsGeometry? actionsPadding,
    Clip? clipBehavior,
  }) {
    return SBBHeaderStyle(
      centerTitle: centerTitle ?? this.centerTitle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
      elevation: elevation ?? this.elevation,
      toolbarTextStyle: toolbarTextStyle ?? this.toolbarTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  SBBHeaderStyle merge(SBBHeaderStyle? other) {
    if (other == null) return this;

    return SBBHeaderStyle(
      centerTitle: other.centerTitle ?? centerTitle,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      systemOverlayStyle: other.systemOverlayStyle ?? systemOverlayStyle,
      elevation: other.elevation ?? elevation,
      toolbarTextStyle: toolbarTextStyle?.merge(other.toolbarTextStyle) ?? other.toolbarTextStyle ?? toolbarTextStyle,
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle ?? titleTextStyle,
      titleSpacing: other.titleSpacing ?? titleSpacing,
      actionsPadding: other.actionsPadding ?? actionsPadding,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }

  static SBBHeaderStyle? lerp(SBBHeaderStyle? a, SBBHeaderStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return SBBHeaderStyle(
      centerTitle: t < 0.5 ? a?.centerTitle : b?.centerTitle,
      clipBehavior: t < 0.5 ? a?.clipBehavior : b?.clipBehavior,
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      titleSpacing: lerpDouble(a?.titleSpacing, b?.titleSpacing, t),
      actionsPadding: EdgeInsetsGeometry.lerp(a?.actionsPadding, b?.actionsPadding, t),
      toolbarTextStyle: TextStyle.lerp(a?.toolbarTextStyle, b?.toolbarTextStyle, t),
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      systemOverlayStyle: t < 0.5 ? a?.systemOverlayStyle : b?.systemOverlayStyle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBHeaderStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          elevation == other.elevation &&
          titleSpacing == other.titleSpacing &&
          actionsPadding == other.actionsPadding &&
          clipBehavior == other.clipBehavior &&
          centerTitle == other.centerTitle &&
          systemOverlayStyle == other.systemOverlayStyle &&
          toolbarTextStyle == other.toolbarTextStyle &&
          titleTextStyle == other.titleTextStyle;

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    foregroundColor,
    elevation,
    titleSpacing,
    actionsPadding,
    clipBehavior,
    centerTitle,
    systemOverlayStyle,
    toolbarTextStyle,
    titleTextStyle,
  );
}
