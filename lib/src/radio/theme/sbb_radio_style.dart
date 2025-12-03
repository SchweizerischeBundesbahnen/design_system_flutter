import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBRadio].
///
/// Use this class in combination with [SBBRadioThemeData] to customize
/// the appearance of radio buttons throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBRadio<int>(
///   value: 1,
///   style: SBBRadioStyle(
///     fillColor: WidgetStateProperty.all(Colors.blue),
///     checkColor: WidgetStateProperty.all(Colors.white),
///   ),
/// )
/// ```
///
/// See also:
/// * [SBBRadio], the radio widget that uses this style.
/// * [SBBRadioThemeData], which applies this style theme-wide.
class SBBRadioStyle {
  const SBBRadioStyle({
    this.fillColor,
    this.innerCircleColor,
    this.borderColor,
    this.padding,
  });

  /// The background color of the radio.
  ///
  /// This color fills the radio circle.
  /// It does not affect the tap target area, which is controlled by [padding].
  final WidgetStateProperty<Color?>? fillColor;

  /// The color of the inner circle when the radio is selected.
  final WidgetStateProperty<Color?>? innerCircleColor;

  /// The color of the radio border.
  final WidgetStateProperty<Color?>? borderColor;

  /// The space between the radio's tap target and its visual appearance.
  ///
  /// This padding increases the interactive area of the radio beyond the
  /// visible [SBBRadioStyle.radioSize] × [SBBRadioStyle.radioSize] square. A larger padding makes the radio
  /// easier to tap while keeping the visual size constant.
  ///
  /// Defaults to `EdgeInsets.all(8.0)`.
  final EdgeInsetsGeometry? padding;

  /// The size of the radios's visible circle.
  ///
  /// This is the width and height of the rounded square containing the inner circle,
  /// not including the [padding].
  static const double radioSize = 20.0;

  /// The size of the inner circle when the radio is selected.
  ///
  /// This is the diameter of the filled circle that appears when the radio is selected.
  static const double innerCircleSize = 8.0;

  /// The thickness of the radio border.
  ///
  /// This value determines how wide the border line around the radio appears.
  static const double borderWidth = 1.0;

  SBBRadioStyle copyWith({
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? innerCircleColor,
    WidgetStateProperty<Color?>? borderColor,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBRadioStyle(
      fillColor: fillColor ?? this.fillColor,
      innerCircleColor: innerCircleColor ?? this.innerCircleColor,
      borderColor: borderColor ?? this.borderColor,
      padding: padding ?? this.padding,
    );
  }

  SBBRadioStyle merge(SBBRadioStyle? other) {
    if (other == null) return this;

    return copyWith(
      fillColor: other.fillColor,
      innerCircleColor: other.innerCircleColor,
      borderColor: other.borderColor,
      padding: other.padding,
    );
  }

  static SBBRadioStyle? lerp(SBBRadioStyle? a, SBBRadioStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBRadioStyle(
      fillColor: WidgetStateProperty.lerp<Color?>(a?.fillColor, b?.fillColor, t, Color.lerp),
      innerCircleColor: WidgetStateProperty.lerp<Color?>(a?.innerCircleColor, b?.innerCircleColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBRadioStyle &&
        other.fillColor == fillColor &&
        other.innerCircleColor == innerCircleColor &&
        other.borderColor == borderColor &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
    fillColor,
    innerCircleColor,
    borderColor,
    padding,
  );
}
