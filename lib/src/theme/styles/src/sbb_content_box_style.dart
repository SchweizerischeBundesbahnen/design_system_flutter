import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBContentBoxStyle extends ThemeExtension<SBBContentBoxStyle> {
  SBBContentBoxStyle({
    this.margin,
    this.padding,
    this.color,
    this.shape,
    this.clipBehavior,
    this.isSemanticContainer,
  });

  factory SBBContentBoxStyle.$default({required SBBBaseStyle baseStyle}) => SBBContentBoxStyle(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    color: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
    clipBehavior: Clip.hardEdge,
    isSemanticContainer: true,
  );

  static SBBContentBoxStyle of(BuildContext context) => Theme.of(context).extension<SBBContentBoxStyle>()!;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final bool? isSemanticContainer;

  @override
  SBBContentBoxStyle copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool? isSemanticContainer,
  }) => SBBContentBoxStyle(
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
    color: color ?? this.color,
    shape: shape ?? this.shape,
    clipBehavior: clipBehavior ?? this.clipBehavior,
    isSemanticContainer: isSemanticContainer ?? this.isSemanticContainer,
  );

  @override
  SBBContentBoxStyle lerp(ThemeExtension<SBBContentBoxStyle>? other, double t) {
    if (other is! SBBContentBoxStyle) return this;
    return SBBContentBoxStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) as EdgeInsets?,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) as EdgeInsets?,
      color: Color.lerp(color, other.color, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
      isSemanticContainer: t < 0.5 ? isSemanticContainer : other.isSemanticContainer,
    );
  }
}

extension SBBContentBoxStyleExtension on SBBContentBoxStyle? {
  SBBContentBoxStyle merge(SBBContentBoxStyle? other) {
    if (this == null) return other ?? SBBContentBoxStyle();
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
