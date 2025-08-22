import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBGroupStyle extends ThemeExtension<SBBGroupStyle> {
  SBBGroupStyle({
    this.margin,
    this.padding,
    this.color,
    this.shape,
    this.clipBehavior,
    this.isSemanticContainer,
  });

  factory SBBGroupStyle.$default({required SBBBaseStyle baseStyle}) => SBBGroupStyle(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    color: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
    clipBehavior: Clip.hardEdge,
    isSemanticContainer: true,
  );

  static SBBGroupStyle of(BuildContext context) => Theme.of(context).extension<SBBGroupStyle>()!;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final bool? isSemanticContainer;

  @override
  SBBGroupStyle copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    Color? shadowColor,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool? isSemanticContainer,
  }) => SBBGroupStyle(
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
    color: color ?? this.color,
    shape: shape ?? this.shape,
    clipBehavior: clipBehavior ?? this.clipBehavior,
    isSemanticContainer: isSemanticContainer ?? this.isSemanticContainer,
  );

  @override
  SBBGroupStyle lerp(ThemeExtension<SBBGroupStyle>? other, double t) {
    if (other is! SBBGroupStyle) return this;
    return SBBGroupStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) as EdgeInsets?,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) as EdgeInsets?,
      color: Color.lerp(color, other.color, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
      isSemanticContainer: t < 0.5 ? isSemanticContainer : other.isSemanticContainer,
    );
  }
}

extension SBBGroupStyleExtension on SBBGroupStyle? {
  SBBGroupStyle merge(SBBGroupStyle? other) {
    if (this == null) return other ?? SBBGroupStyle();
    return this!.copyWith(
      margin: this!.margin ?? other?.margin,
      padding: this!.padding ?? other?.padding,
      color: this!.color ?? other?.color,
      shape: this!.shape ?? other?.shape,
      clipBehavior: this!.clipBehavior ?? other?.clipBehavior,
      isSemanticContainer: this!.isSemanticContainer ?? other?.isSemanticContainer,
    );
  }
}
