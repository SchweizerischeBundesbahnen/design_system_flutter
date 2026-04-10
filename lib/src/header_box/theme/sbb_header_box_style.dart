import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of the "header box" (e.g. the card-like
/// element below the SBBHeader).
///
/// Use this class in combination with [SBBHeaderBoxThemeData] to customize
/// the appearance of the header box throughout your app or for specific
/// widget subtrees.
///
/// See also:
/// * [SBBHeaderBoxThemeData], which applies this style theme-wide.
@immutable
class SBBHeaderBoxStyle {
  const SBBHeaderBoxStyle({
    this.titleTextStyle,
    this.secondaryLabelColor,
    this.largeSecondaryLabelColor,
    this.backgroundColor,
    this.flapBackgroundColor,
  });

  final TextStyle? titleTextStyle;
  final Color? secondaryLabelColor;
  final Color? largeSecondaryLabelColor;
  final Color? backgroundColor;
  final Color? flapBackgroundColor;

  SBBHeaderBoxStyle copyWith({
    TextStyle? titleTextStyle,
    Color? secondaryLabelColor,
    Color? largeSecondaryLabelColor,
    Color? backgroundColor,
    Color? flapBackgroundColor,
  }) {
    return SBBHeaderBoxStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      secondaryLabelColor: secondaryLabelColor ?? this.secondaryLabelColor,
      largeSecondaryLabelColor: largeSecondaryLabelColor ?? this.largeSecondaryLabelColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      flapBackgroundColor: flapBackgroundColor ?? this.flapBackgroundColor,
    );
  }

  SBBHeaderBoxStyle merge(SBBHeaderBoxStyle? other) {
    if (other == null) return this;

    return SBBHeaderBoxStyle(
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle ?? titleTextStyle,
      secondaryLabelColor: other.secondaryLabelColor ?? secondaryLabelColor,
      largeSecondaryLabelColor: other.largeSecondaryLabelColor ?? largeSecondaryLabelColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      flapBackgroundColor: other.flapBackgroundColor ?? flapBackgroundColor,
    );
  }

  static SBBHeaderBoxStyle? lerp(
    SBBHeaderBoxStyle? a,
    SBBHeaderBoxStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return SBBHeaderBoxStyle(
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      secondaryLabelColor: Color.lerp(a?.secondaryLabelColor, b?.secondaryLabelColor, t),
      largeSecondaryLabelColor: Color.lerp(a?.largeSecondaryLabelColor, b?.largeSecondaryLabelColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      flapBackgroundColor: Color.lerp(a?.flapBackgroundColor, b?.flapBackgroundColor, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBHeaderBoxStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          secondaryLabelColor == other.secondaryLabelColor &&
          largeSecondaryLabelColor == other.largeSecondaryLabelColor &&
          backgroundColor == other.backgroundColor &&
          flapBackgroundColor == other.flapBackgroundColor;

  @override
  int get hashCode => Object.hash(
    titleTextStyle,
    secondaryLabelColor,
    largeSecondaryLabelColor,
    backgroundColor,
    flapBackgroundColor,
  );
}
