import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBSegmentedButton].
///
/// Use this class in combination with [SBBSegmentedButtonThemeData] to customize
/// the appearance of segmented buttons throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBSegmentedButton(
///   style: SBBSegmentedButtonStyle(
///     backgroundColor: SBBColors.milk,
///     borderColor: SBBColors.green,
///   ),
///   segments: [...],
///   selected: selectedValue,
///   onSelectionChanged: (value) {
///     setState(() => selectedValue = value);
///   },
/// ),
/// ```
///
/// See also:
/// * [SBBSegmentedButton], the widget that uses this style.
/// * [SBBSegmentedButtonThemeData], which applies this style theme-wide.
class SBBSegmentedButtonStyle {
  const SBBSegmentedButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.segmentStyle,
  });

  /// Background color of the segmented button container.
  ///
  /// The selected state is used for the sliding indicator.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// Color of the border around the segmented button.
  ///
  /// The selected state is used for the sliding indicator.
  final WidgetStateProperty<Color?>? borderColor;

  /// Defines the visual properties of individual segments.
  final SBBButtonSegmentStyle? segmentStyle;

  /// The shape of the segmented button.
  ///
  /// The height will be the default sbb button height of 44 logical pixels.
  static StadiumBorder get shape => StadiumBorder();

  SBBSegmentedButtonStyle copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? borderColor,
    SBBButtonSegmentStyle? segmentStyle,
  }) {
    return SBBSegmentedButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      segmentStyle: segmentStyle ?? this.segmentStyle,
    );
  }

  SBBSegmentedButtonStyle merge(SBBSegmentedButtonStyle? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      segmentStyle: segmentStyle?.merge(other.segmentStyle) ?? other.segmentStyle,
    );
  }

  static SBBSegmentedButtonStyle? lerp(SBBSegmentedButtonStyle? a, SBBSegmentedButtonStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBSegmentedButtonStyle(
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      segmentStyle: SBBButtonSegmentStyle.lerp(a?.segmentStyle, b?.segmentStyle, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBSegmentedButtonStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          segmentStyle == other.segmentStyle;

  @override
  int get hashCode => Object.hash(backgroundColor, borderColor, segmentStyle);
}
