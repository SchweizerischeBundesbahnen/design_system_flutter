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
  });

  /// The color of the Slide-To-Toggle border.
  ///
  /// The border width is defined by [SBBSlideToToggleStyle.borderWidth].
  final WidgetStateProperty<Color?>? borderColor;

  /// The background color of the Slide-To-Toggle.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The background color of toggle.
  final WidgetStateProperty<Color?>? toggleBackgroundColor;

  /// The thickness of the Slide-To-Toggle border.
  static const double borderWidth = 1.0;

  /// The shape of the Slide-To-Toggle's border.
  ///
  /// This creates the pill-shaped appearance of the Slide-To-Toggle.
  static const ShapeBorder borderShape = StadiumBorder();

  SBBSlideToToggleStyle copyWith({
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? toggleBackgroundColor,
  }) {
    return SBBSlideToToggleStyle(
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      toggleBackgroundColor: toggleBackgroundColor ?? this.toggleBackgroundColor,
    );
  }

  SBBSlideToToggleStyle merge(SBBSlideToToggleStyle? other) {
    if (other == null) return this;

    return copyWith(
      borderColor: other.borderColor,
      backgroundColor: other.backgroundColor,
      toggleBackgroundColor: other.toggleBackgroundColor,
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
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBSlideToToggleStyle &&
        other.borderColor == borderColor &&
        other.backgroundColor == backgroundColor &&
        other.toggleBackgroundColor == toggleBackgroundColor;
  }

  @override
  int get hashCode => Object.hash(
    borderColor,
    backgroundColor,
    toggleBackgroundColor,
  );
}
