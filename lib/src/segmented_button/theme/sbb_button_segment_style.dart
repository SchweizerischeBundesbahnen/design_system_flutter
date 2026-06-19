import 'package:flutter/material.dart';

/// Defines the visual properties for an [SBBButtonSegment].
///
/// Use this class in combination with [SBBSegmentedButtonThemeData] to customize
/// the appearance of button segments throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBButtonSegment], the class that uses this style.
class SBBButtonSegmentStyle {
  const SBBButtonSegmentStyle({
    this.foregroundColor,
    this.textStyle,
  });

  /// The foreground color (for text and icons).
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The text style for the label.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  SBBButtonSegmentStyle copyWith({
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<TextStyle?>? textStyle,
  }) {
    return SBBButtonSegmentStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  SBBButtonSegmentStyle merge(SBBButtonSegmentStyle? other) {
    if (other == null) return this;

    return copyWith(
      foregroundColor: other.foregroundColor,
      textStyle: other.textStyle,
    );
  }

  static SBBButtonSegmentStyle? lerp(SBBButtonSegmentStyle? a, SBBButtonSegmentStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBButtonSegmentStyle(
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBButtonSegmentStyle && other.foregroundColor == foregroundColor && other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(foregroundColor, textStyle);
}
