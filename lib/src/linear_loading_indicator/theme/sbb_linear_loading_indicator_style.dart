import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBLinearLoadingIndicator].
///
/// Use this class in combination with [SBBLinearLoadingIndicatorThemeData] to
/// customize the appearance of linear loading indicators throughout your app
/// or for specific widget subtrees.
class SBBLinearLoadingIndicatorStyle {
  const SBBLinearLoadingIndicatorStyle({this.color});

  /// The color the indicator bar fades into from transparent.
  final Color? color;

  /// The height of the indicator bar, in logical pixels.
  static const double height = 3.0;

  /// The width of the indicator bar relative to the width of its parent.
  static const double widthRatio = 0.3;

  /// The duration of one animation cycle.
  static const Duration duration = Duration(seconds: 3);

  SBBLinearLoadingIndicatorStyle copyWith({Color? color}) {
    return SBBLinearLoadingIndicatorStyle(color: color ?? this.color);
  }

  SBBLinearLoadingIndicatorStyle merge(SBBLinearLoadingIndicatorStyle? other) {
    if (other == null) return this;
    return copyWith(color: other.color);
  }

  static SBBLinearLoadingIndicatorStyle? lerp(
    SBBLinearLoadingIndicatorStyle? a,
    SBBLinearLoadingIndicatorStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return SBBLinearLoadingIndicatorStyle(color: Color.lerp(a?.color, b?.color, t));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBLinearLoadingIndicatorStyle && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;
}
