import 'package:flutter/material.dart';

/// Defines the visual properties of the badge shown on top of [SBBPromotionBox].
class SBBPromotionBoxBadgeStyle {
  const SBBPromotionBoxBadgeStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.textStyle,
    this.haloColor,
    this.padding,
  });

  /// The fill color of the badge pill.
  final Color? backgroundColor;

  /// The color of the badge text (and any foreground content).
  final Color? foregroundColor;

  /// The color of the badge border.
  final Color? borderColor;

  /// The text style used for the badge label.
  ///
  /// The color of [textStyle] is typically not used directly; [foregroundColor]
  /// is applied on top.
  final TextStyle? textStyle;

  /// The color of the solid halo painted above the badge.
  final Color? haloColor;

  /// The inner padding of the badge pill.
  final EdgeInsetsGeometry? padding;

  /// The radius by which the halo expands beyond the badge bounds on all sides.
  static const double haloSpreadRadius = 8.0;

  SBBPromotionBoxBadgeStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    TextStyle? textStyle,
    Color? haloColor,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBPromotionBoxBadgeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      textStyle: textStyle ?? this.textStyle,
      haloColor: haloColor ?? this.haloColor,
      padding: padding ?? this.padding,
    );
  }

  /// Returns a new style with the non-null properties of [other] replacing
  /// those of this style ("fill in the blanks" semantics).
  SBBPromotionBoxBadgeStyle merge(SBBPromotionBoxBadgeStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      borderColor: other.borderColor,
      textStyle: other.textStyle,
      haloColor: other.haloColor,
      padding: other.padding,
    );
  }

  static SBBPromotionBoxBadgeStyle? lerp(
    SBBPromotionBoxBadgeStyle? a,
    SBBPromotionBoxBadgeStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return SBBPromotionBoxBadgeStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      haloColor: Color.lerp(a?.haloColor, b?.haloColor, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPromotionBoxBadgeStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.borderColor == borderColor &&
        other.textStyle == textStyle &&
        other.haloColor == haloColor &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    foregroundColor,
    borderColor,
    textStyle,
    haloColor,
    padding,
  );
}
