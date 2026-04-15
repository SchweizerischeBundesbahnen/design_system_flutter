import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBHeaderBox].
///
/// Use this class in combination with [SBBHeaderBoxThemeData] to customize
/// the appearance of header boxes throughout your app or for specific widget
/// subtrees.
///
/// See also:
/// * [SBBHeaderBox], the widget that uses this style.
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

  /// The text style for the header box title.
  ///
  /// Applies to text descendants of the title in [SBBHeaderBox].
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color of the title text.
  ///
  /// This color is typically used instead of the color of the [titleTextStyle].
  final Color? titleForegroundColor;

  /// The text style for the header box subtitle.
  ///
  /// Applies to text descendants of the subtitle in [SBBHeaderBox].
  ///
  /// The color of the [subtitleTextStyle] is typically not used directly, the
  /// [subtitleForegroundColor] is used instead.
  final TextStyle? subtitleTextStyle;

  /// The color of the subtitle text.
  ///
  /// This color is typically used instead of the color of the [subtitleTextStyle].
  final Color? subtitleForegroundColor;

  /// The text style for the leading content.
  ///
  /// Applies to text descendants of [SBBHeaderBox.leading].
  final TextStyle? leadingTextStyle;

  /// The color of the leading widget content.
  ///
  /// This affects the icon or text color of [SBBHeaderBox.leading].
  final Color? leadingForegroundColor;

  /// The text style for the trailing content.
  ///
  /// Applies to text descendants of [SBBHeaderBox.trailing].
  final TextStyle? trailingTextStyle;

  /// The color of the trailing widget content.
  ///
  /// This affects the icon or text color of [SBBHeaderBox.trailing].
  final Color? trailingForegroundColor;

  /// The background color of the header box.
  ///
  /// This fills the main card-like container of [SBBHeaderBox].
  final Color? backgroundColor;

  /// The background color of the attached flap area.
  ///
  /// This is used for the area below the main header box when a flap is shown.
  final Color? flapBackgroundColor;

  /// The shadows painted around the main header box container.
  final List<BoxShadow>? headerBoxShadow;

  /// The shadows painted above the flap area.
  ///
  /// This helps visually separate the header box from an attached flap.
  final List<BoxShadow>? shadowOverFlap;

  /// The padding inside the header box.
  ///
  /// This defines the space between the outer container and its content.
  final EdgeInsetsGeometry? padding;

  /// The vertical gap between the title and subtitle.
  final double? titleSubtitleGap;

  /// The amount the header box overlaps the app bar.
  ///
  /// This is primarily used by sliver and top-of-page header box layouts.
  final double? appBarOverlap;

  /// The empty space that surrounds the header box.
  final EdgeInsetsGeometry? margin;

  /// The shape of the header box.
  static ShapeBorder get border => RoundedRectangleBorder(borderRadius: radius);

  /// The radius of the header box.
  static BorderRadius get radius => const BorderRadius.all(Radius.circular(SBBSpacing.medium));

  /// The minimum height of the header box without external margin applied.
  static double get minHeight => 56.0;

  SBBHeaderBoxStyle copyWith({
    TextStyle? titleTextStyle,
    Color? titleForegroundColor,
    TextStyle? subtitleTextStyle,
    Color? subtitleForegroundColor,
    TextStyle? leadingTextStyle,
    Color? leadingForegroundColor,
    TextStyle? trailingTextStyle,
    Color? trailingForegroundColor,
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
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      subtitleForegroundColor: subtitleForegroundColor ?? this.subtitleForegroundColor,
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
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
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle ?? titleTextStyle,
      titleForegroundColor: other.titleForegroundColor ?? titleForegroundColor,
      subtitleTextStyle:
          subtitleTextStyle?.merge(other.subtitleTextStyle) ?? other.subtitleTextStyle ?? subtitleTextStyle,
      subtitleForegroundColor: other.subtitleForegroundColor ?? subtitleForegroundColor,
      leadingTextStyle: leadingTextStyle?.merge(other.leadingTextStyle) ?? other.leadingTextStyle ?? leadingTextStyle,
      leadingForegroundColor: other.leadingForegroundColor ?? leadingForegroundColor,
      trailingTextStyle:
          trailingTextStyle?.merge(other.trailingTextStyle) ?? other.trailingTextStyle ?? trailingTextStyle,
      trailingForegroundColor: other.trailingForegroundColor ?? trailingForegroundColor,
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
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      subtitleTextStyle: TextStyle.lerp(a?.subtitleTextStyle, b?.subtitleTextStyle, t),
      subtitleForegroundColor: Color.lerp(a?.subtitleForegroundColor, b?.subtitleForegroundColor, t),
      leadingTextStyle: TextStyle.lerp(a?.leadingTextStyle, b?.leadingTextStyle, t),
      leadingForegroundColor: Color.lerp(a?.leadingForegroundColor, b?.leadingForegroundColor, t),
      trailingTextStyle: TextStyle.lerp(a?.trailingTextStyle, b?.trailingTextStyle, t),
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),
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
          titleTextStyle == other.titleTextStyle &&
          titleForegroundColor == other.titleForegroundColor &&
          subtitleTextStyle == other.subtitleTextStyle &&
          subtitleForegroundColor == other.subtitleForegroundColor &&
          leadingTextStyle == other.leadingTextStyle &&
          leadingForegroundColor == other.leadingForegroundColor &&
          trailingTextStyle == other.trailingTextStyle &&
          trailingForegroundColor == other.trailingForegroundColor &&
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
    titleTextStyle,
    titleForegroundColor,
    subtitleTextStyle,
    subtitleForegroundColor,
    leadingTextStyle,
    leadingForegroundColor,
    trailingTextStyle,
    trailingForegroundColor,
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
