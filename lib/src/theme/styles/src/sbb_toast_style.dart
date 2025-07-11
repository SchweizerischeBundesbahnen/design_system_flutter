import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBToastStyle extends ThemeExtension<SBBToastStyle> {
  SBBToastStyle({
    this.titleTextStyle,
    this.decoration,
    this.titleMaxLines,
    this.margin,
    this.padding,
  });

  factory SBBToastStyle.$default({required SBBBaseStyle baseStyle}) => SBBToastStyle(
        titleTextStyle: SBBTextStyles.smallLight.copyWith(decoration: TextDecoration.none, color: SBBColors.white),
        decoration:
            ShapeDecoration(shape: StadiumBorder(), color: baseStyle.themeValue(SBBColors.metal, SBBColors.smoke)),
        titleMaxLines: 2,
        margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      );

  static SBBToastStyle of(BuildContext context) => Theme.of(context).extension<SBBToastStyle>()!;

  final TextStyle? titleTextStyle;
  final ShapeDecoration? decoration;
  final int? titleMaxLines;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  SBBToastStyle copyWith({
    TextStyle? titleTextStyle,
    ShapeDecoration? decoration,
    int? titleMaxLines,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) =>
      SBBToastStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        decoration: decoration ?? this.decoration,
        titleMaxLines: titleMaxLines ?? this.titleMaxLines,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
      );

  @override
  SBBToastStyle lerp(SBBToastStyle? other, double t) => SBBToastStyle(
        titleTextStyle: TextStyle.lerp(titleTextStyle, other?.titleTextStyle, t),
        decoration: ShapeDecoration.lerp(decoration, other?.decoration, t),
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
      decoration: this!.decoration ?? other?.decoration,
      titleMaxLines: this!.titleMaxLines ?? other?.titleMaxLines,
      padding: this!.padding ?? other?.padding,
      margin: this!.margin ?? other?.margin,
    );
  }
}
