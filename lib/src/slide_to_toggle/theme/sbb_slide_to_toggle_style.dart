import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/src/slide_to_toggle/slide_to_toggle.dart';

/// Defines the visual properties of [SBBSlideToToggle].
///
/// Use this class in combination with [SBBSlideToToggleThemeData] to customize
/// the appearance of Slide-To-Toggles throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// TODO:
/// ```
///
/// See also:
/// * [SBBSlideToToggle], the widget that uses this style.
/// * [SBBSlideToToggleThemeData], which applies this style theme-wide.
class SBBSlideToToggleStyle {
  const SBBSlideToToggleStyle({
    this.borderColor,
    this.backgroundColor,
    this.toggleBackgroundColor,
    this.toggleTextStyle,
    this.helpTextStyle,
  });

  /// The color of the Slide-To-Toggle border.
  ///
  /// The border width is defined by [SBBSlideToToggleStyle.borderWidth].
  final WidgetStateProperty<Color?>? borderColor;

  /// The background color of the Slide-To-Toggle.
  /// TODO: background color for container and part between border?
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The background color of toggle.
  final WidgetStateProperty<Color?>? toggleBackgroundColor;

  /// TODO: Maybe one for start and stop?
  final WidgetStateProperty<TextStyle?>? toggleTextStyle;

  /// TODO: Maybe one for start and stop?
  final WidgetStateProperty<TextStyle?>? helpTextStyle;

  /// TODO:
  static const double border = 82.0;

  /// The thickness of the Slide-To-Toggle border.
  static const double borderWidth = 1.0;

  /// The shape of the Slide-To-Toggle's border.
  ///
  /// This creates the pill-shaped appearance of the Slide-To-Toggle.
  static const ShapeBorder borderShape = StadiumBorder();

  /// TODO:
  static const double toggleSize = 82.0;

  SBBSlideToToggleStyle copyWith({
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? toggleBackgroundColor,
    WidgetStateProperty<TextStyle?>? toggleTextStyle,
    WidgetStateProperty<TextStyle?>? helpTextStyle,
  }) {
    return SBBSlideToToggleStyle(
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      toggleBackgroundColor: toggleBackgroundColor ?? this.toggleBackgroundColor,
      toggleTextStyle: toggleTextStyle ?? this.toggleTextStyle,
      helpTextStyle: helpTextStyle ?? this.helpTextStyle,
    );
  }

  SBBSlideToToggleStyle merge(SBBSlideToToggleStyle? other) {
    if (other == null) return this;

    return copyWith(
      borderColor: other.borderColor,
      backgroundColor: other.backgroundColor,
      toggleBackgroundColor: other.toggleBackgroundColor,
      toggleTextStyle: other.toggleTextStyle,
      helpTextStyle: other.helpTextStyle,
    );
  }

  static SBBSlideToToggleStyle? lerp(SBBSlideToToggleStyle? a, SBBSlideToToggleStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBSlideToToggleStyle(
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      toggleBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.toggleBackgroundColor,
        b?.toggleBackgroundColor,
        t,
        Color.lerp,
      ),
      toggleTextStyle: WidgetStateProperty.lerp<TextStyle?>(a?.toggleTextStyle, b?.toggleTextStyle, t, TextStyle.lerp),
      helpTextStyle: WidgetStateProperty.lerp<TextStyle?>(a?.helpTextStyle, b?.helpTextStyle, t, TextStyle.lerp),
    );
  }

  // TODO: Equal & hashcode
}
