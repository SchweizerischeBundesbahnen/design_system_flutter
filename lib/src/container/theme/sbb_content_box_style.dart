import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBContentBox].
///
/// Use this class in combination with [SBBContentBoxThemeData] to customize
/// the appearance of content boxes throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBContentBox], the widget that uses this style.
/// * [SBBContentBoxThemeData], which applies this style theme-wide.
class SBBContentBoxStyle extends ThemeExtension<SBBContentBoxStyle> {
  SBBContentBoxStyle({
    this.margin,
    this.padding,
    this.color,
    this.clipBehavior,
    this.isSemanticContainer,
  });

  /// The empty space that surrounds the [SBBContentBox].
  ///
  /// This is the outer margin outside the box.
  final EdgeInsetsGeometry? margin;

  /// The empty space that separates the child and the edge of [SBBContentBox].
  ///
  /// This is the inner padding inside the box.
  final EdgeInsetsGeometry? padding;

  /// The background color of the content box.
  ///
  /// This fills the entire box container.
  final Color? color;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  final bool? isSemanticContainer;

  /// The border of the content box.
  static ShapeBorder get shape => RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing)),
  );

  @override
  SBBContentBoxStyle copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    Clip? clipBehavior,
    bool? isSemanticContainer,
  }) => SBBContentBoxStyle(
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
    color: color ?? this.color,
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
      clipBehavior: this!.clipBehavior ?? other?.clipBehavior,
      isSemanticContainer: this!.isSemanticContainer ?? other?.isSemanticContainer,
    );
  }
}
