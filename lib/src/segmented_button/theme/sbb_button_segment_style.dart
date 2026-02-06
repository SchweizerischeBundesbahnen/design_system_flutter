import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual properties for an [SBBButtonSegment].
///
/// Use this class in combination with [SBBSegmentedButtonThemeData] to customize
/// the appearance of button segments throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBButtonSegment], the class that uses this style.
class SBBButtonSegmentStyle with Diagnosticable {
  const SBBButtonSegmentStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
  });

  /// The background color of the segment.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The foreground color (for text and icons).
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The text style for the label.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final TextStyle? textStyle;

  SBBButtonSegmentStyle copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    TextStyle? textStyle,
  }) {
    return SBBButtonSegmentStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  SBBButtonSegmentStyle merge(SBBButtonSegmentStyle? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      textStyle: other.textStyle,
    );
  }

  static SBBButtonSegmentStyle? lerp(SBBButtonSegmentStyle? a, SBBButtonSegmentStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBButtonSegmentStyle(
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBButtonSegmentStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(backgroundColor, foregroundColor, textStyle);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>>('backgroundColor', backgroundColor, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>>('foregroundColor', foregroundColor, defaultValue: null),
    );
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle, defaultValue: null));
  }
}
