import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of the "header box" (e.g. the card-like
/// element below the SBBHeader).
///
/// Use this class in combination with [SBBHeaderBoxThemeData] to customize
/// the appearance of the header box throughout your app or for specific
/// widget subtrees.
///
/// See also:
/// * [SBBHeaderBoxThemeData], which applies this style theme-wide.
@immutable
class SBBHeaderBoxStyle {
  const SBBHeaderBoxStyle({
    // Title
    this.titleTextStyle,
    this.titleForegroundColor,

    // Subtitle
    this.subtitleTextStyle,
    this.subtitleForegroundColor,

    // Leading
    this.leadingTextStyle,
    this.leadingForegroundColor,

    // Trailing
    this.trailingTextStyle,
    this.trailingForegroundColor,

    // Container / box
    this.backgroundColor,
    this.flapBackgroundColor,
    this.headerBoxShadow,
    this.shadowOverFlap,
    this.padding,
    this.titleSubtitleGap,
    this.appBarOverlap,
    this.margin,
  });

  // Title
  final TextStyle? titleTextStyle;
  final Color? titleForegroundColor;

  // Subtitle
  final TextStyle? subtitleTextStyle;
  final Color? subtitleForegroundColor;

  // Leading (text, icon, etc.)
  final TextStyle? leadingTextStyle;
  final Color? leadingForegroundColor;

  // Trailing (text, icon, etc.)
  final TextStyle? trailingTextStyle;
  final Color? trailingForegroundColor;

  // Box-level properties
  final Color? backgroundColor;
  final Color? flapBackgroundColor;
  final List<BoxShadow>? headerBoxShadow;
  final List<BoxShadow>? shadowOverFlap;
  final EdgeInsetsGeometry? padding;
  final double? titleSubtitleGap;

  // Newly added properties
  final double? appBarOverlap;
  final EdgeInsetsGeometry? margin;

  /// The shape of the header box.
  static ShapeBorder get border => RoundedRectangleBorder(borderRadius: radius);

  /// The radius of the header box.
  static BorderRadius get radius => const BorderRadius.all(Radius.circular(SBBSpacing.medium));

  static double get minHeight => 56.0;

  SBBHeaderBoxStyle copyWith({
    // Title
    TextStyle? titleTextStyle,
    Color? titleForegroundColor,

    // Subtitle
    TextStyle? subtitleTextStyle,
    Color? subtitleForegroundColor,

    // Leading
    TextStyle? leadingTextStyle,
    Color? leadingForegroundColor,

    // Trailing
    TextStyle? trailingTextStyle,
    Color? trailingForegroundColor,

    // Box-level
    Color? backgroundColor,
    Color? flapBackgroundColor,
    List<BoxShadow>? contentShadow,
    List<BoxShadow>? shadowOverFlap,
    EdgeInsetsGeometry? padding,
    double? gap,
    double? appBarOverlap,
    EdgeInsetsGeometry? margin,
  }) {
    return SBBHeaderBoxStyle(
      // Title
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,

      // Subtitle
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      subtitleForegroundColor: subtitleForegroundColor ?? this.subtitleForegroundColor,

      // Leading
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,

      // Trailing
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,

      // Box-level
      backgroundColor: backgroundColor ?? this.backgroundColor,
      flapBackgroundColor: flapBackgroundColor ?? this.flapBackgroundColor,
      headerBoxShadow: contentShadow ?? headerBoxShadow,
      shadowOverFlap: shadowOverFlap ?? this.shadowOverFlap,
      padding: padding ?? this.padding,
      titleSubtitleGap: gap ?? titleSubtitleGap,
      appBarOverlap: appBarOverlap ?? this.appBarOverlap,
      margin: margin ?? this.margin,
    );
  }

  SBBHeaderBoxStyle merge(SBBHeaderBoxStyle? other) {
    if (other == null) return this;

    return SBBHeaderBoxStyle(
      // Title
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle ?? titleTextStyle,
      titleForegroundColor: other.titleForegroundColor ?? titleForegroundColor,

      // Subtitle
      subtitleTextStyle:
          subtitleTextStyle?.merge(other.subtitleTextStyle) ?? other.subtitleTextStyle ?? subtitleTextStyle,
      subtitleForegroundColor: other.subtitleForegroundColor ?? subtitleForegroundColor,

      // Leading
      leadingTextStyle: leadingTextStyle?.merge(other.leadingTextStyle) ?? other.leadingTextStyle ?? leadingTextStyle,
      leadingForegroundColor: other.leadingForegroundColor ?? leadingForegroundColor,

      // Trailing
      trailingTextStyle:
          trailingTextStyle?.merge(other.trailingTextStyle) ?? other.trailingTextStyle ?? trailingTextStyle,
      trailingForegroundColor: other.trailingForegroundColor ?? trailingForegroundColor,

      // Box-level
      backgroundColor: other.backgroundColor ?? backgroundColor,
      flapBackgroundColor: other.flapBackgroundColor ?? flapBackgroundColor,
      headerBoxShadow: other.headerBoxShadow ?? headerBoxShadow,
      shadowOverFlap: other.shadowOverFlap ?? shadowOverFlap,
      padding: other.padding ?? padding,
      titleSubtitleGap: other.titleSubtitleGap ?? titleSubtitleGap,
      appBarOverlap: other.appBarOverlap ?? appBarOverlap,
      margin: other.margin ?? margin,
    );
  }

  static SBBHeaderBoxStyle? lerp(
    SBBHeaderBoxStyle? a,
    SBBHeaderBoxStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return SBBHeaderBoxStyle(
      // Title
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),

      // Subtitle
      subtitleTextStyle: TextStyle.lerp(a?.subtitleTextStyle, b?.subtitleTextStyle, t),
      subtitleForegroundColor: Color.lerp(a?.subtitleForegroundColor, b?.subtitleForegroundColor, t),

      // Leading
      leadingTextStyle: TextStyle.lerp(a?.leadingTextStyle, b?.leadingTextStyle, t),
      leadingForegroundColor: Color.lerp(a?.leadingForegroundColor, b?.leadingForegroundColor, t),

      // Trailing
      trailingTextStyle: TextStyle.lerp(a?.trailingTextStyle, b?.trailingTextStyle, t),
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),

      // Box-level
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      flapBackgroundColor: Color.lerp(a?.flapBackgroundColor, b?.flapBackgroundColor, t),
      headerBoxShadow: BoxShadow.lerpList(a?.headerBoxShadow, b?.headerBoxShadow, t),
      shadowOverFlap: BoxShadow.lerpList(a?.shadowOverFlap, b?.shadowOverFlap, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
      titleSubtitleGap: ui.lerpDouble(a?.titleSubtitleGap, b?.titleSubtitleGap, t),
      appBarOverlap: ui.lerpDouble(a?.appBarOverlap, b?.appBarOverlap, t),
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBHeaderBoxStyle &&
          runtimeType == other.runtimeType &&
          // Title
          titleTextStyle == other.titleTextStyle &&
          titleForegroundColor == other.titleForegroundColor &&
          // Subtitle
          subtitleTextStyle == other.subtitleTextStyle &&
          subtitleForegroundColor == other.subtitleForegroundColor &&
          // Leading
          leadingTextStyle == other.leadingTextStyle &&
          leadingForegroundColor == other.leadingForegroundColor &&
          // Trailing
          trailingTextStyle == other.trailingTextStyle &&
          trailingForegroundColor == other.trailingForegroundColor &&
          // Box-level
          backgroundColor == other.backgroundColor &&
          flapBackgroundColor == other.flapBackgroundColor &&
          headerBoxShadow == other.headerBoxShadow &&
          shadowOverFlap == other.shadowOverFlap &&
          padding == other.padding &&
          titleSubtitleGap == other.titleSubtitleGap &&
          appBarOverlap == other.appBarOverlap &&
          margin == other.margin;

  @override
  int get hashCode => Object.hash(
    // Title
    titleTextStyle,
    titleForegroundColor,
    // Subtitle
    subtitleTextStyle,
    subtitleForegroundColor,
    // Leading
    leadingTextStyle,
    leadingForegroundColor,
    // Trailing
    trailingTextStyle,
    trailingForegroundColor,
    // Box-level
    backgroundColor,
    flapBackgroundColor,
    headerBoxShadow,
    shadowOverFlap,
    padding,
    titleSubtitleGap,
    appBarOverlap,
    margin,
  );
}
