import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/src/slide_to_toggle/slide_to_toggle.dart';

/// Defines the visual properties of [SBBSlideToToggle].
///
/// Use this class in combination with [SBBSlideToToggleThemeData] to customize
/// the appearance of Slide-To-Toggles throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBSlideToToggle], the widget that uses this style.
/// * [SBBSlideToToggleThemeData], which applies this style theme-wide.
class SBBSlideToToggleStyle {
  const SBBSlideToToggleStyle({
    this.borderColor,
    this.backgroundColor,
    this.toggleForegroundColor,
    this.toggleBackgroundColor,
    this.toggleOverlayColor,
    this.loadingIndicatorColor,
    this.helpForegroundColor,
    this.toggleTextStyle,
    this.helpTextStyle,
  });

  /// The color of the Slide-To-Toggle border.
  ///
  /// The border width is defined by [SBBSlideToToggleStyle.borderWidth].
  final WidgetStateProperty<Color?>? borderColor;

  /// The background color of the Slide-To-Toggle.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The foreground color of the toggle.
  final WidgetStateProperty<Color?>? toggleForegroundColor;

  /// The background color of the toggle.
  final WidgetStateProperty<Color?>? toggleBackgroundColor;

  /// The color used to indicate that the button is focused or pressed.
  final WidgetStateProperty<Color?>? toggleOverlayColor;

  /// The color of the loading indicator inside of the toggle.
  final WidgetStateProperty<Color?>? loadingIndicatorColor;

  /// The foreground color of the help area in the track.
  final WidgetStateProperty<Color?>? helpForegroundColor;

  /// The text style for the text label used inside the toggle.
  ///
  /// Applies to all text descendants of the toggle of SBBSlideToToggle.
  ///
  /// The color of the [toggleTextStyle] is typically not used directly, the
  /// [toggleForegroundColor] is used instead.
  final TextStyle? toggleTextStyle;

  /// The text style for the help label used inside the slide track.
  ///
  /// Applies to all text descendants of the track of SBBSlideToToggle.
  ///
  /// The color of the [helpTextStyle] is typically not used directly, the
  /// [helpForegroundColor] is used instead.
  final TextStyle? helpTextStyle;

  /// The thickness of the Slide-To-Toggle border.
  static const double borderWidth = 1.0;

  /// The shape of the Slide-To-Toggle's border.
  ///
  /// This creates the pill-shaped appearance of the Slide-To-Toggle.
  static const ShapeBorder borderShape = StadiumBorder();

  /// Toggle size of the default variant.
  static const double toggleSize = 82.0;

  /// Toggle size of the small variant.
  static const double toggleSizeSmall = 40.0;

  SBBSlideToToggleStyle copyWith({
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? toggleBackgroundColor,
    WidgetStateProperty<Color?>? toggleOverlayColor,
    TextStyle? toggleTextStyle,
    TextStyle? helpTextStyle,
  }) {
    return SBBSlideToToggleStyle(
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      toggleBackgroundColor: toggleBackgroundColor ?? this.toggleBackgroundColor,
      toggleOverlayColor: toggleOverlayColor ?? this.toggleOverlayColor,
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
      toggleOverlayColor: other.toggleOverlayColor,
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
      toggleOverlayColor: WidgetStateProperty.lerp<Color?>(a?.toggleOverlayColor, b?.toggleOverlayColor, t, Color.lerp),
      toggleTextStyle: TextStyle.lerp(a?.toggleTextStyle, b?.toggleTextStyle, t),
      helpTextStyle: TextStyle.lerp(a?.helpTextStyle, b?.helpTextStyle, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBSlideToToggleStyle &&
          runtimeType == other.runtimeType &&
          borderColor == other.borderColor &&
          backgroundColor == other.backgroundColor &&
          toggleForegroundColor == other.toggleForegroundColor &&
          toggleBackgroundColor == other.toggleBackgroundColor &&
          toggleOverlayColor == other.toggleOverlayColor &&
          loadingIndicatorColor == other.loadingIndicatorColor &&
          helpForegroundColor == other.helpForegroundColor &&
          toggleTextStyle == other.toggleTextStyle &&
          helpTextStyle == other.helpTextStyle;

  @override
  int get hashCode => Object.hash(
    borderColor,
    backgroundColor,
    toggleForegroundColor,
    toggleBackgroundColor,
    toggleOverlayColor,
    loadingIndicatorColor,
    helpForegroundColor,
    toggleTextStyle,
    helpTextStyle,
  );
}
