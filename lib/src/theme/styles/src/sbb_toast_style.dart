import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBToastStyle extends ThemeExtension<SBBToastStyle> {
  SBBToastStyle({
    this.titleTextStyle,
    this.actionTextStyle,
    this.actionOverflowThreshold,
    this.decoration,
    this.titleMaxLines,
    this.margin,
    this.padding,
  });

  factory SBBToastStyle.$default({required SBBBaseStyle baseStyle}) => SBBToastStyle(
        titleTextStyle: SBBTextStyles.smallLight.copyWith(decoration: TextDecoration.none, color: SBBColors.white),
        actionTextStyle: SBBTextStyles.smallBold.copyWith(decoration: TextDecoration.none, color: SBBColors.white),
        actionOverflowThreshold: 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sbbDefaultSpacing),
            color: baseStyle.themeValue(SBBColors.metal, SBBColors.smoke)),
        titleMaxLines: 2,
        margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: sbbDefaultSpacing),
      );

  static SBBToastStyle of(BuildContext context) => Theme.of(context).extension<SBBToastStyle>()!;

  final TextStyle? titleTextStyle;
  final TextStyle? actionTextStyle;
  final double? actionOverflowThreshold;
  final BoxDecoration? decoration;
  final int? titleMaxLines;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  SBBToastStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? actionTextStyle,
    double? actionOverflowThreshold,
    BoxDecoration? decoration,
    int? titleMaxLines,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) =>
      SBBToastStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        actionTextStyle: actionTextStyle ?? this.actionTextStyle,
        actionOverflowThreshold: actionOverflowThreshold ?? this.actionOverflowThreshold,
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
      decoration: this!.decoration ?? other?.decoration,
      titleMaxLines: this!.titleMaxLines ?? other?.titleMaxLines,
      padding: this!.padding ?? other?.padding,
      margin: this!.margin ?? other?.margin,
    );
  }
}
