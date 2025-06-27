import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBContentboxStyle extends ThemeExtension<SBBContentboxStyle> {
  SBBContentboxStyle({
    this.margin,
    this.padding,
    this.color,
    this.shadowColor,
    this.shape,
    this.clipBehavior,
  });

  factory SBBContentboxStyle.$default({required SBBBaseStyle baseStyle}) => SBBContentboxStyle(
        margin: EdgeInsets.all(sbbDefaultSpacing),
        padding: EdgeInsets.zero,
        color: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
        shadowColor: SBBColors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
        clipBehavior: Clip.hardEdge,
      );

  static SBBContentboxStyle of(BuildContext context) => Theme.of(context).extension<SBBContentboxStyle>()!;

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Clip? clipBehavior;

  @override
  SBBContentboxStyle copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? color,
    Color? shadowColor,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) =>
      SBBContentboxStyle(
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        color: color ?? this.color,
        shadowColor: shadowColor ?? this.shadowColor,
        shape: shape ?? this.shape,
        clipBehavior: clipBehavior ?? this.clipBehavior,
      );

  @override
  SBBContentboxStyle lerp(ThemeExtension<SBBContentboxStyle>? other, double t) {
    if (other is! SBBContentboxStyle) return this;
    return SBBContentboxStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) as EdgeInsets?,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) as EdgeInsets?,
      color: Color.lerp(color, other.color, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
    );
  }
}

extension SBBContentboxStyleExtension on SBBContentboxStyle? {
  SBBContentboxStyle merge(SBBContentboxStyle? other) {
    if (this == null) return other ?? SBBContentboxStyle();
    return this!.copyWith(
      margin: this!.margin ?? other?.margin,
      padding: this!.padding ?? other?.padding,
      color: this!.color ?? other?.color,
      shadowColor: this!.shadowColor ?? other?.shadowColor,
      shape: this!.shape ?? other?.shape,
      clipBehavior: this!.clipBehavior ?? other?.clipBehavior,
    );
  }
}
