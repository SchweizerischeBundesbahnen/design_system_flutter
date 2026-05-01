import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBMessage].
///
/// Use this class in combination with [SBBMessageThemeData] to customize
/// the appearance of messages throughout your app or for specific widget subtrees.
class SBBMessageStyle {
  const SBBMessageStyle({
    this.titleTextStyle,
    this.titleForegroundColor,
    this.subtitleTextStyle,
    this.subtitleForegroundColor,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.padding,
    this.illustrationTitleGap = SBBSpacing.large,
    this.textGap = SBBSpacing.medium,
    this.textActionGap = SBBSpacing.large,
  });

  /// The text style for the title.
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color of the title text.
  ///
  /// This color is typically used instead of the color of the [titleTextStyle].
  final Color? titleForegroundColor;

  /// The text style for the subtitle.
  ///
  /// The color of the [subtitleTextStyle] is typically not used directly, the
  /// [subtitleForegroundColor] is used instead.
  final TextStyle? subtitleTextStyle;

  /// The color of the subtitle text.
  ///
  /// This color is typically used instead of the color of the [subtitleTextStyle].
  final Color? subtitleForegroundColor;

  /// The text style for the error text.
  ///
  /// The color of the [errorTextStyle] is typically not used directly, the
  /// [errorForegroundColor] is used instead.
  final TextStyle? errorTextStyle;

  /// The color of the error text.
  ///
  /// This color is typically used instead of the color of the [errorTextStyle].
  final Color? errorForegroundColor;

  /// The padding around the message content.
  final EdgeInsets? padding;

  /// The gap between the illustration and title.
  final double illustrationTitleGap;

  /// The gap between text elements (title, subtitle, error).
  final double textGap;

  /// The gap between text and action button.
  final double textActionGap;

  /// The default padding for the message.
  static const EdgeInsets defaultPadding = .all(SBBSpacing.medium);

  SBBMessageStyle copyWith({
    TextStyle? titleTextStyle,
    Color? titleForegroundColor,
    TextStyle? subtitleTextStyle,
    Color? subtitleForegroundColor,
    TextStyle? errorTextStyle,
    Color? errorForegroundColor,
    EdgeInsets? padding,
    double? illustrationTitleGap,
    double? textGap,
    double? textActionGap,
  }) {
    return SBBMessageStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      subtitleForegroundColor: subtitleForegroundColor ?? this.subtitleForegroundColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      padding: padding ?? this.padding,
      illustrationTitleGap: illustrationTitleGap ?? this.illustrationTitleGap,
      textGap: textGap ?? this.textGap,
      textActionGap: textActionGap ?? this.textActionGap,
    );
  }

  SBBMessageStyle merge(SBBMessageStyle? other) {
    if (other == null) return this;

    return copyWith(
      titleTextStyle: other.titleTextStyle,
      titleForegroundColor: other.titleForegroundColor,
      subtitleTextStyle: other.subtitleTextStyle,
      subtitleForegroundColor: other.subtitleForegroundColor,
      errorTextStyle: other.errorTextStyle,
      errorForegroundColor: other.errorForegroundColor,
      padding: other.padding,
      illustrationTitleGap: other.illustrationTitleGap,
      textGap: other.textGap,
      textActionGap: other.textActionGap,
    );
  }

  static SBBMessageStyle? lerp(SBBMessageStyle? a, SBBMessageStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBMessageStyle(
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      subtitleTextStyle: TextStyle.lerp(a?.subtitleTextStyle, b?.subtitleTextStyle, t),
      subtitleForegroundColor: Color.lerp(a?.subtitleForegroundColor, b?.subtitleForegroundColor, t),
      errorTextStyle: TextStyle.lerp(a?.errorTextStyle, b?.errorTextStyle, t),
      errorForegroundColor: Color.lerp(a?.errorForegroundColor, b?.errorForegroundColor, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      illustrationTitleGap: lerpDouble(a?.illustrationTitleGap, b?.illustrationTitleGap, t) ?? SBBSpacing.large,
      textGap: lerpDouble(a?.textGap, b?.textGap, t) ?? SBBSpacing.medium,
      textActionGap: lerpDouble(a?.textActionGap, b?.textActionGap, t) ?? SBBSpacing.large,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBMessageStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.titleForegroundColor == titleForegroundColor &&
        other.subtitleTextStyle == subtitleTextStyle &&
        other.subtitleForegroundColor == subtitleForegroundColor &&
        other.errorTextStyle == errorTextStyle &&
        other.errorForegroundColor == errorForegroundColor &&
        other.padding == padding &&
        other.illustrationTitleGap == illustrationTitleGap &&
        other.textGap == textGap &&
        other.textActionGap == textActionGap;
  }

  @override
  int get hashCode => Object.hash(
    titleTextStyle,
    titleForegroundColor,
    subtitleTextStyle,
    subtitleForegroundColor,
    errorTextStyle,
    errorForegroundColor,
    padding,
    illustrationTitleGap,
    textGap,
    textActionGap,
  );
}
