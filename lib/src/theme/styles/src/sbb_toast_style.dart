import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBToastStyle extends ThemeExtension<SBBToastStyle> {
  /// Creates a style for [SBBToast].
  ///
  /// The [titleTextStyle] defines the text style for the toast title.
  /// By default, uses [SBBTextStyles.smallLight] with [TextDecoration.none] and [SBBColors.white].
  ///
  /// The [actionTextStyle] defines the text style for the toast action button.
  /// By default, uses [SBBTextStyles.smallBold] with [TextDecoration.none] and [SBBColors.white].
  ///
  /// The [actionOverflowThreshold] is the threshold (as a fraction of toast width) at which
  /// the action wraps to a new line. Default value is 0.25 (25% of the toast width).
  ///
  /// The [actionPadding] is the padding applied to the action widget.
  /// By default, applies [EdgeInsets.only(left: sbbDefaultSpacing)].
  ///
  /// The [decoration] is the decoration for the toast container.
  /// By default, uses [BoxDecoration] with rounded corners and a background color
  /// based on the theme (dark: [SBBColors.metal], light: [SBBColors.smoke]).
  ///
  /// The [titleMaxLines] is the maximum number of lines for the toast title.
  /// Default value is 2.
  ///
  /// The [margin] is the margin around the toast.
  /// By default, applies [EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)].
  ///
  /// The [padding] is the padding inside the toast.
  /// By default, applies [EdgeInsets.symmetric(vertical: 6.0, horizontal: sbbDefaultSpacing)].
  const SBBToastStyle({
    this.titleTextStyle,
    this.actionTextStyle,
    this.actionOverflowThreshold,
    this.actionPadding,
    this.decoration,
    this.titleMaxLines,
    this.margin,
    this.padding,
  });

  factory SBBToastStyle.$default({required SBBBaseStyle baseStyle}) => SBBToastStyle(
    titleTextStyle: SBBTextStyles.smallLight.copyWith(
      decoration: TextDecoration.none,
      color: SBBColors.white,
    ),
    actionTextStyle: SBBTextStyles.smallBold.copyWith(
      decoration: TextDecoration.none,
      color: SBBColors.white,
    ),
    actionOverflowThreshold: 0.25,
    actionPadding: const EdgeInsets.only(left: sbbDefaultSpacing),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sbbDefaultSpacing),
      color: baseStyle.themeValue(SBBColors.metal, SBBColors.smoke),
    ),
    titleMaxLines: 2,
    margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: sbbDefaultSpacing),
  );

  static SBBToastStyle of(BuildContext context) => Theme.of(context).extension<SBBToastStyle>()!;

  final TextStyle? titleTextStyle;
  final TextStyle? actionTextStyle;
  final double? actionOverflowThreshold;
  final EdgeInsetsGeometry? actionPadding;
  final BoxDecoration? decoration;
  final int? titleMaxLines;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  SBBToastStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? actionTextStyle,
    double? actionOverflowThreshold,
    EdgeInsetsGeometry? actionPadding,
    BoxDecoration? decoration,
    int? titleMaxLines,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) => SBBToastStyle(
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    actionTextStyle: actionTextStyle ?? this.actionTextStyle,
    actionOverflowThreshold: actionOverflowThreshold ?? this.actionOverflowThreshold,
    actionPadding: actionPadding ?? this.actionPadding,
    decoration: decoration ?? this.decoration,
    titleMaxLines: titleMaxLines ?? this.titleMaxLines,
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
  );

  @override
  SBBToastStyle lerp(SBBToastStyle? other, double t) => SBBToastStyle(
    titleTextStyle: TextStyle.lerp(titleTextStyle, other?.titleTextStyle, t),
    actionTextStyle: TextStyle.lerp(actionTextStyle, other?.actionTextStyle, t),
    actionOverflowThreshold: lerpDouble(actionOverflowThreshold, other?.actionOverflowThreshold, t),
    actionPadding: EdgeInsetsGeometry.lerp(actionPadding, other?.actionPadding, t),
    decoration: BoxDecoration.lerp(decoration, other?.decoration, t),
    titleMaxLines: t < 0.5 ? titleMaxLines : other?.titleMaxLines,
    padding: EdgeInsetsGeometry.lerp(padding, other?.padding, t),
    margin: EdgeInsetsGeometry.lerp(margin, other?.margin, t),
  );
}

extension SBBToastStyleExtension on SBBToastStyle? {
  SBBToastStyle merge(SBBToastStyle? other) {
    if (this == null) return other ?? SBBToastStyle();
    return this!.copyWith(
      titleTextStyle: this!.titleTextStyle ?? other?.titleTextStyle,
      actionTextStyle: this!.actionTextStyle ?? other?.actionTextStyle,
      actionOverflowThreshold: this!.actionOverflowThreshold ?? other?.actionOverflowThreshold,
      actionPadding: this!.actionPadding ?? other?.actionPadding,
      decoration: this!.decoration ?? other?.decoration,
      titleMaxLines: this!.titleMaxLines ?? other?.titleMaxLines,
      padding: this!.padding ?? other?.padding,
      margin: this!.margin ?? other?.margin,
    );
  }
}
