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
/// SBBStepper(
///   style: SBBStepperStyle(
///     dividerColor: SBBColors.green,
///   ),
///   steps: [...],
///   activeStep: activeStep,
///   onStepPressed: (_, i) {
///     setState(() => activeStep = i);
///   },
/// ),
/// ```
///
/// See also:
/// * [SBBStepper], the widget that uses this style.
/// * [SBBStepperThemeData], which applies this style theme-wide.
class SBBStepperStyle {
  const SBBStepperStyle({
    this.dividerColor,
    this.itemStyle,
    this.padding,
  });

  /// Color of the divider between steps.
  final Color? dividerColor;

  /// Defines the visual properties of the steps.
  final SBBStepperItemStyle? itemStyle;

  /// Padding around the whole stepper with labels.
  final EdgeInsetsGeometry? padding;

  /// The height of the divider between steps.
  static const double dividerHeight = 2.0;

  SBBStepperStyle copyWith({
    Color? dividerColor,
    SBBStepperItemStyle? itemStyle,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBStepperStyle(
      dividerColor: dividerColor ?? this.dividerColor,
      itemStyle: itemStyle ?? this.itemStyle,
      padding: padding ?? this.padding,
    );
  }

  SBBStepperStyle merge(SBBStepperStyle? other) {
    if (other == null) return this;

    return copyWith(
      dividerColor: other.dividerColor,
      itemStyle: other.itemStyle,
      padding: other.padding,
    );
  }

  static SBBStepperStyle? lerp(SBBStepperStyle? a, SBBStepperStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBStepperStyle(
      dividerColor: Color.lerp(a?.dividerColor, b?.dividerColor, t),
      itemStyle: SBBStepperItemStyle.lerp(a?.itemStyle, b?.itemStyle, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t) as EdgeInsets?,
    );
  }
}
