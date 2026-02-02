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
/// * [SBBStepperItemStyle], the style for a step of the stepper.
/// * [SBBStepperThemeData], which applies this style theme-wide.
class SBBStepperItemStyle {
  const SBBStepperItemStyle({
    this.backgroundColor,
    this.borderColor,
    this.badgeBackgroundColor,
    this.badgeBorderColor,
    this.badgeIconColor,
    this.iconColor,
    this.textStyle,
    this.labelTextStyle,
  });

  /// Color of the icon shown inside of a step.
  final WidgetStateProperty<Color?>? iconColor;

  /// Background color of the step.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// Color of the step border.
  final WidgetStateProperty<Color?>? borderColor;

  /// Icon displayed in the badge shown for passed steps.
  final Color? badgeIconColor;

  /// Background color of the badge shown for passed steps.
  final Color? badgeBackgroundColor;

  /// Color of the badge border shown for passed steps.
  final Color? badgeBorderColor;

  /// TextStyle of text shown inside of a step.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// TextStyle of the label shown below the active step.
  final TextStyle? labelTextStyle;

  /// The height of the divider between steps.
  static const double stepCircleSize = 32.0;

  /// The size of the icon of a step.
  static const double stepIconSize = 24.0;

  /// The size of the badge on a step.
  static const double badgeSize = 12.0;

  /// The size of the icon inside the badge on a step.
  static const double badgeIconSize = 10.0;

  SBBStepperItemStyle copyWith({
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? borderColor,
    Color? badgeIconColor,
    Color? badgeBackgroundColor,
    Color? badgeBorderColor,
    IconData? badgeIconData,
    WidgetStateProperty<TextStyle?>? textStyle,
    TextStyle? labelTextStyle,
  }) {
    return SBBStepperItemStyle(
      iconColor: iconColor ?? this.iconColor,
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
      iconColor: other.iconColor,
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
      iconColor: WidgetStateProperty.lerp<Color?>(a?.iconColor, b?.iconColor, t, Color.lerp),
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
