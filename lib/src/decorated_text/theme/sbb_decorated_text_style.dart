import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBDecoratedText].
///
/// Use this class to customize how the decorated text appears, including text styling,
/// text color based on widget state, and interaction feedback colors.
///
/// Typically applied theme-wide via [SBBDecoratedTextThemeData], but can be overridden
/// per-widget using [SBBDecoratedText.triggerStyle].
///
/// See also:
/// * [SBBDecoratedText], the widget that uses this style
/// * [SBBDecoratedTextThemeData], for applying styles theme-wide
class SBBDecoratedTextStyle {
  const SBBDecoratedTextStyle({
    this.valueTextStyle,
    this.valueForegroundColor,
    this.overlayColor,
  });

  /// The base text style for the value text.
  ///
  /// Provides font family, size, weight, and line height. The text color is
  /// typically overridden by [valueForegroundColor] for state-aware styling.
  final TextStyle? valueTextStyle;

  /// The text color, resolved based on widget state.
  ///
  /// When set, this color overrides any color in [valueTextStyle].
  final WidgetStateProperty<Color?>? valueForegroundColor;

  /// The overlay color for tap interaction feedback.
  ///
  /// Shown when the user taps the widget, providing visual feedback via the
  /// [InkWell].
  final WidgetStateProperty<Color?>? overlayColor;

  SBBDecoratedTextStyle copyWith({
    TextStyle? valueTextStyle,
    WidgetStateProperty<Color?>? valueForegroundColor,
    WidgetStateProperty<Color?>? overlayColor,
  }) {
    return SBBDecoratedTextStyle(
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      valueForegroundColor: valueForegroundColor ?? this.valueForegroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }

  SBBDecoratedTextStyle merge(SBBDecoratedTextStyle? other) {
    if (other == null) return this;

    return copyWith(
      valueTextStyle: other.valueTextStyle,
      valueForegroundColor: other.valueForegroundColor,
      overlayColor: other.overlayColor,
    );
  }

  static SBBDecoratedTextStyle? lerp(SBBDecoratedTextStyle? a, SBBDecoratedTextStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBDecoratedTextStyle(
      valueTextStyle: TextStyle.lerp(a?.valueTextStyle, b?.valueTextStyle, t),
      valueForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.valueForegroundColor,
        b?.valueForegroundColor,
        t,
        Color.lerp,
      ),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBDecoratedTextStyle &&
        other.valueTextStyle == valueTextStyle &&
        other.valueForegroundColor == valueForegroundColor &&
        other.overlayColor == overlayColor;
  }

  @override
  int get hashCode => Object.hash(valueTextStyle, valueForegroundColor, overlayColor);
}
