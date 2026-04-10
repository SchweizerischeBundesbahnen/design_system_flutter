import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBStepperItem] of [SBBStepper].
///
/// Use this class as part of [SBBStepperStyle] in combination with [SBBStepperThemeData] to customize
/// the appearance of steps throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBStepperItem.numbered(
///   style: SBBStepperItemStyle(
///     backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
///       WidgetState.selected: SBBColors.iron,
///       WidgetState.any: SBBColors.aluminum,
///     }),
///   ),
/// ),
/// ```
///
/// See also:
/// * [SBBStepper], the widget that uses this style.
/// * [SBBStepperStyle], the overall style for the stepper.
/// * [SBBStepperThemeData], which applies this style theme-wide.
class SBBStepperItemStyle {
  const SBBStepperItemStyle({
    this.backgroundColor,
    this.borderColor,
    this.badgeBackgroundColor,
    this.badgeBorderColor,
    this.badgeIconColor,
    this.foregroundColor,
    this.textStyle,
    this.labelTextStyle,
  });

  /// Color of the icon or text of the step.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// Background color of the step.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// Color of the step border.
  final WidgetStateProperty<Color?>? borderColor;

  /// Color of the icon shown in the badge
  final Color? badgeIconColor;

  /// Background color of the badge shown for passed steps.
  final Color? badgeBackgroundColor;

  /// Color of the badge border shown for passed steps.
  final Color? badgeBorderColor;

  /// TextStyle of text shown inside of a step.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// TextStyle of the label shown below the active step.
  final TextStyle? labelTextStyle;

  /// The size of the step's circle shape.
  static const double stepCircleSize = 32.0;

  /// The size of the icon of a step.
  static const double stepIconSize = 24.0;

  /// The size of the badge on a step.
  static const double badgeSize = 12.0;

  /// The size of the icon inside the badge on a step.
  static const double badgeIconSize = 10.0;

  SBBStepperItemStyle copyWith({
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? borderColor,
    Color? badgeIconColor,
    Color? badgeBackgroundColor,
    Color? badgeBorderColor,
    WidgetStateProperty<TextStyle?>? textStyle,
    TextStyle? labelTextStyle,
  }) {
    return SBBStepperItemStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      badgeIconColor: badgeIconColor ?? this.badgeIconColor,
      badgeBackgroundColor: badgeBackgroundColor ?? this.badgeBackgroundColor,
      badgeBorderColor: badgeBorderColor ?? this.badgeBorderColor,
      textStyle: textStyle ?? this.textStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    );
  }

  SBBStepperItemStyle merge(SBBStepperItemStyle? other) {
    if (other == null) return this;

    return copyWith(
      foregroundColor: other.foregroundColor,
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      badgeIconColor: other.badgeIconColor,
      badgeBackgroundColor: other.badgeBackgroundColor,
      badgeBorderColor: other.badgeBorderColor,
      textStyle: other.textStyle,
      labelTextStyle: other.labelTextStyle,
    );
  }

  static SBBStepperItemStyle? lerp(SBBStepperItemStyle? a, SBBStepperItemStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBStepperItemStyle(
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      badgeBorderColor: Color.lerp(a?.badgeBorderColor, b?.badgeBorderColor, t),
      badgeBackgroundColor: Color.lerp(a?.badgeBackgroundColor, b?.badgeBackgroundColor, t),
      badgeIconColor: Color.lerp(a?.badgeIconColor, b?.badgeIconColor, t),
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
      labelTextStyle: TextStyle.lerp(a?.labelTextStyle, b?.labelTextStyle, t),
    );
  }
}
