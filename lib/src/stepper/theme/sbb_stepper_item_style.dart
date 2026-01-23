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
/// Sample Code TODO: add
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
    this.iconColor,
    this.textStyle,
    this.labelTextStyle,
  });

  /// TODO: Document
  final WidgetStateProperty<Color?>? iconColor;

  /// TODO: Document
  final WidgetStateProperty<Color?>? backgroundColor;

  /// TODO: Document
  final WidgetStateProperty<Color?>? borderColor;

  /// TODO: Document
  final WidgetStateProperty<Color?>? badgeBackgroundColor;

  /// TODO: Document
  final WidgetStateProperty<Color?>? badgeBorderColor;

  /// TODO: Document
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// TODO: Document
  final TextStyle? labelTextStyle;

  /// The height of the divider between steps.
  static const double stepCircleSize = 32.0;

  /// TODO: Add more static values like paddings etc.

  SBBStepperItemStyle copyWith({
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<Color?>? badgeBackgroundColor,
    WidgetStateProperty<Color?>? badgeBorderColor,
    WidgetStateProperty<TextStyle?>? textStyle,
    TextStyle? labelTextStyle,
  }) {
    return SBBStepperItemStyle(
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
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
      badgeBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.badgeBackgroundColor,
        b?.badgeBackgroundColor,
        t,
        Color.lerp,
      ),
      badgeBorderColor: WidgetStateProperty.lerp<Color?>(a?.badgeBorderColor, b?.badgeBorderColor, t, Color.lerp),
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
      labelTextStyle: TextStyle.lerp(a?.labelTextStyle, b?.labelTextStyle, t),
    );
  }
}
