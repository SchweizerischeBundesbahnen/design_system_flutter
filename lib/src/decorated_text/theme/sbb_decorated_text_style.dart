import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBDecoratedText].
///
/// Use this class in combination with [SBBDecoratedTextThemeData] to customize
/// the appearance of decorated text fields throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBDecoratedText], the widget that uses this style.
/// * [SBBDecoratedTextThemeData], which applies this style theme-wide.
class SBBDecoratedTextStyle {
  const SBBDecoratedTextStyle({
    this.valueTextStyle,
    this.valueForegroundColor,
    this.overlayColor,
  });

  /// The text style for the value text.
  ///
  /// The color of the [valueTextStyle] is typically not used directly, the
  /// [valueForegroundColor] is used instead.
  final TextStyle? valueTextStyle;

  /// The color of the value text.
  final WidgetStateProperty<Color?>? valueForegroundColor;

  /// The overlay color shown on interaction.
  ///
  /// This creates the visual feedback when the field is interacted with.
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
