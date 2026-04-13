import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header_box/theme/sbb_header_box_flap_style.dart';

/// Theme data for the [SBBHeaderBox].
///
/// Use this to set the [SBBHeaderBoxStyle] for all header boxes within
/// the current [ThemeData].
@immutable
class SBBHeaderBoxThemeData extends ThemeExtension<SBBHeaderBoxThemeData> with Diagnosticable {
  const SBBHeaderBoxThemeData({
    this.style,
    this.largeStyle,
    this.flapStyle,
  });

  /// Overrides for the header box's default style.
  ///
  /// Non-null values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override the style.
  final SBBHeaderBoxStyle? style;

  /// Overrides for the header box's large style.
  ///
  /// Non-null values override the default values.
  ///
  /// If [largeStyle] is null, then this theme doesn't override the style.
  final SBBHeaderBoxStyle? largeStyle;

  final SBBHeaderBoxFlapStyle? flapStyle;

  @override
  SBBHeaderBoxThemeData copyWith({
    SBBHeaderBoxStyle? style,
    SBBHeaderBoxStyle? largeStyle,
    SBBHeaderBoxFlapStyle? flapStyle,
  }) {
    return SBBHeaderBoxThemeData(
      style: style ?? this.style,
      largeStyle: largeStyle ?? this.largeStyle,
      flapStyle: flapStyle ?? this.flapStyle,
    );
  }

  @override
  SBBHeaderBoxThemeData lerp(
    ThemeExtension<SBBHeaderBoxThemeData>? other,
    double t,
  ) {
    if (other == null) return this;
    final o = other as SBBHeaderBoxThemeData;

    return SBBHeaderBoxThemeData(
      style: SBBHeaderBoxStyle.lerp(style, o.style, t),
      largeStyle: SBBHeaderBoxStyle.lerp(largeStyle, o.largeStyle, t),
      flapStyle: SBBHeaderBoxFlapStyle.lerp(flapStyle, o.flapStyle, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBHeaderBoxThemeData &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          largeStyle == other.largeStyle &&
          flapStyle == other.flapStyle;

  @override
  int get hashCode => Object.hash(style, largeStyle, flapStyle);
}

extension SBBHeaderBoxThemeDataX on SBBHeaderBoxThemeData {
  /// Merges this theme with another [SBBHeaderBoxThemeData].
  ///
  /// Properties from [other] override properties from this theme.
  /// If [other] is null, returns this theme unchanged.
  SBBHeaderBoxThemeData merge(SBBHeaderBoxThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
      largeStyle: largeStyle?.merge(other.largeStyle) ?? other.largeStyle,
      flapStyle: flapStyle?.merge(other.flapStyle) ?? other.flapStyle,
    );
  }
}

extension SBBHeaderBoxThemeOnThemeData on ThemeData {
  /// Access the [SBBHeaderBoxThemeData] from the current theme.
  SBBHeaderBoxThemeData? get sbbHeaderBoxTheme {
    return extension<SBBHeaderBoxThemeData>();
  }
}
