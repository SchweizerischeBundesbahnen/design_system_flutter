import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBToast].
///
/// Use this class in combination with [SBBToastThemeData] to customize
/// the appearance of toasts throughout your app or for specific widget subtrees.
class SBBToastStyle {
  const SBBToastStyle({
    this.titleTextStyle,
    this.titleMaxLines = 2,
    this.titleForegroundColor,
    this.actionTextStyle,
    this.actionForegroundColor,
    this.titleActionHorizontalGap = SBBSpacing.large,
    this.titleActionVerticalGap = SBBSpacing.xSmall,
    this.actionOverflowThreshold = 0.25,
    this.backgroundColor,
    this.padding,
    this.margin,
  });

  /// The text style for the title.
  ///
  /// Default: [SBBTextStyles.smallLight] with [TextDecoration.none] and [SBBColors.white].
  final TextStyle? titleTextStyle;

  /// The maximum number of lines for the title.
  ///
  /// Default: 2.
  final int? titleMaxLines;

  /// The color of the title text.
  ///
  /// Default: [SBBColors.white].
  final Color? titleForegroundColor;

  /// The text style for the action.
  ///
  /// Default: [SBBTextStyles.smallBold] with [TextDecoration.none] and [SBBColors.white].
  final TextStyle? actionTextStyle;

  /// The color of the action text.
  ///
  /// Default: [SBBColors.white].
  final Color? actionForegroundColor;

  /// The horizontal gap between title and action.
  ///
  /// Default: [SBBSpacing.large].
  final double? titleActionHorizontalGap;

  /// The vertical gap between title and action when wrapped.
  ///
  /// Default: [SBBSpacing.xSmall].
  final double? titleActionVerticalGap;

  /// The threshold (fraction of toast width) at which the action wraps.
  ///
  /// Default: 0.25 (25%).
  final double? actionOverflowThreshold;

  /// The background color of the toast.
  ///
  /// Default: themed value (dark: [SBBColors.metal], light: [SBBColors.smoke]).
  final Color? backgroundColor;

  /// The padding inside the toast.
  ///
  /// Default: `EdgeInsets.symmetric(vertical: 6.0, horizontal: SBBSpacing.medium)`.
  final EdgeInsetsGeometry? padding;

  /// The margin around the toast.
  ///
  /// Default: `EdgeInsets.symmetric(horizontal: SBBSpacing.medium)`.
  final EdgeInsetsGeometry? margin;

  /// The border radius of the toast container.
  ///
  /// Defaults to `SBBSpacing.medium`.
  static const Radius borderRadius = Radius.circular(SBBSpacing.medium);

  SBBToastStyle copyWith({
    TextStyle? titleTextStyle,
    int? titleMaxLines,
    Color? titleForegroundColor,
    TextStyle? actionTextStyle,
    Color? actionForegroundColor,
    double? titleActionHorizontalGap,
    double? titleActionVerticalGap,
    double? actionOverflowThreshold,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return SBBToastStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleMaxLines: titleMaxLines ?? this.titleMaxLines,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      actionForegroundColor: actionForegroundColor ?? this.actionForegroundColor,
      titleActionHorizontalGap: titleActionHorizontalGap ?? this.titleActionHorizontalGap,
      titleActionVerticalGap: titleActionVerticalGap ?? this.titleActionVerticalGap,
      actionOverflowThreshold: actionOverflowThreshold ?? this.actionOverflowThreshold,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
    );
  }

  SBBToastStyle merge(SBBToastStyle? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle: other.titleTextStyle,
      titleMaxLines: other.titleMaxLines,
      titleForegroundColor: other.titleForegroundColor,
      actionTextStyle: other.actionTextStyle,
      actionForegroundColor: other.actionForegroundColor,
      titleActionHorizontalGap: other.titleActionHorizontalGap,
      titleActionVerticalGap: other.titleActionVerticalGap,
      actionOverflowThreshold: other.actionOverflowThreshold,
      backgroundColor: other.backgroundColor,
      padding: other.padding,
      margin: other.margin,
    );
  }

  static SBBToastStyle? lerp(SBBToastStyle? a, SBBToastStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBToastStyle(
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleMaxLines: t < 0.5 ? a?.titleMaxLines : b?.titleMaxLines,
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      actionTextStyle: TextStyle.lerp(a?.actionTextStyle, b?.actionTextStyle, t),
      actionForegroundColor: Color.lerp(a?.actionForegroundColor, b?.actionForegroundColor, t),
      titleActionHorizontalGap: lerpDouble(a?.titleActionHorizontalGap, b?.titleActionHorizontalGap, t),
      titleActionVerticalGap: lerpDouble(a?.titleActionVerticalGap, b?.titleActionVerticalGap, t),
      actionOverflowThreshold: lerpDouble(a?.actionOverflowThreshold, b?.actionOverflowThreshold, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBToastStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.titleMaxLines == titleMaxLines &&
        other.titleForegroundColor == titleForegroundColor &&
        other.actionTextStyle == actionTextStyle &&
        other.actionForegroundColor == actionForegroundColor &&
        other.titleActionHorizontalGap == titleActionHorizontalGap &&
        other.titleActionVerticalGap == titleActionVerticalGap &&
        other.actionOverflowThreshold == actionOverflowThreshold &&
        other.backgroundColor == backgroundColor &&
        other.padding == padding &&
        other.margin == margin;
  }

  @override
  int get hashCode => Object.hash(
    titleTextStyle,
    titleMaxLines,
    titleForegroundColor,
    actionTextStyle,
    actionForegroundColor,
    titleActionHorizontalGap,
    titleActionVerticalGap,
    actionOverflowThreshold,
    backgroundColor,
    padding,
    margin,
  );
}
