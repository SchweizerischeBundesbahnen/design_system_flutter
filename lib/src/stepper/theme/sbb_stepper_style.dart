import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBStepper].
///
/// Use this class in combination with [SBBStepperThemeData] to customize
/// the appearance of stepper throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// Sample Code TODO: add
/// ```
///
/// See also:
/// * [SBBStepper], the widget that uses this style.
/// * [SBBStepperThemeData], which applies this style theme-wide.
class SBBStepperStyle {
  const SBBStepperStyle({
    this.dividerColor,
    this.itemStyle,
  });

  /// TODO: Document
  final Color? dividerColor;

  /// TODO: Document
  final SBBStepperItemStyle? itemStyle;

  /// The height of the divider between steps.
  static const double dividerHeight = 2.0;

  /// TODO: Add more static values like paddings etc.

  SBBStepperStyle copyWith({
    Color? dividerColor,
    SBBStepperItemStyle? itemStyle,
  }) {
    return SBBStepperStyle(
      dividerColor: dividerColor ?? this.dividerColor,
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }

  SBBStepperStyle merge(SBBStepperStyle? other) {
    if (other == null) return this;

    return copyWith(
      dividerColor: other.dividerColor,
      itemStyle: other.itemStyle,
    );
  }

  static SBBStepperStyle? lerp(SBBStepperStyle? a, SBBStepperStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBStepperStyle(
      dividerColor: Color.lerp(a?.dividerColor, b?.dividerColor, t),
      itemStyle: SBBStepperItemStyle.lerp(a?.itemStyle, b?.itemStyle, t),
    );
  }
}
