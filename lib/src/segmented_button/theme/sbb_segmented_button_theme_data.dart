import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBSegmentedButton].
///
/// Use this to set the [SBBSegmentedButtonStyle] for all [SBBSegmentedButton] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbSegmentedButtonTheme`.
@immutable
class SBBSegmentedButtonThemeData extends ThemeExtension<SBBSegmentedButtonThemeData> with Diagnosticable {
  /// Creates an [SBBSegmentedButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBSegmentedButtonThemeData({this.style, this.filledStyle, this.leadingHorizontalGapWidth});

  /// Overrides for the segmented button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBSegmentedButtonStyle? style;

  /// Style overrides for [SBBSegmentedButton.filled] variant.
  ///
  /// If null, the default filled style is used.
  final SBBSegmentedButtonStyle? filledStyle;

  /// Horizontal gap width between the leading widget and the label.
  ///
  /// Defaults to 4.0.
  final double? leadingHorizontalGapWidth;

  @override
  SBBSegmentedButtonThemeData copyWith({SBBSegmentedButtonStyle? style, SBBSegmentedButtonStyle? filledStyle}) {
    return SBBSegmentedButtonThemeData(style: style ?? this.style, filledStyle: filledStyle ?? this.filledStyle);
  }

  @override
  SBBSegmentedButtonThemeData lerp(SBBSegmentedButtonThemeData? other, double t) {
    if (other == null) return this;
    return SBBSegmentedButtonThemeData(
      style: SBBSegmentedButtonStyle.lerp(style, other.style, t),
      filledStyle: SBBSegmentedButtonStyle.lerp(filledStyle, other.filledStyle, t),
    );
  }

  @override
  int get hashCode => style.hashCode ^ filledStyle.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBSegmentedButtonThemeData && other.style == style && other.filledStyle == filledStyle;
  }
}

extension SBBSegmentedButtonThemeDataX on SBBSegmentedButtonThemeData {
  SBBSegmentedButtonThemeData merge(SBBSegmentedButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
      filledStyle: filledStyle?.merge(other.filledStyle) ?? other.filledStyle,
    );
  }
}

extension SBBSegmentedButtonThemeDataThemeDataX on ThemeData {
  SBBSegmentedButtonThemeData? get sbbSegmentedButtonTheme {
    return extension<SBBSegmentedButtonThemeData>();
  }
}
