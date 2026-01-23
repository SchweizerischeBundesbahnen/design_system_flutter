import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBStepper].
///
/// Use this to set the [SBBStepperStyle] for all [SBBStepper] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbStepperTheme`.
@immutable
class SBBStepperThemeData extends ThemeExtension<SBBStepperThemeData> with Diagnosticable {
  /// Creates an [SBBStepperThemeData].
  ///
  /// The [style] may be null.
  const SBBStepperThemeData({this.style, this.coloredStyle});

  /// Style overrides for [SBBStepper].
  ///
  /// If null, the default style is used.
  final SBBStepperStyle? style;

  /// Style overrides for [SBBStepper.colored].
  ///
  /// If null, the default colored style is used.
  final SBBStepperStyle? coloredStyle;

  @override
  SBBStepperThemeData copyWith({SBBStepperStyle? style, SBBStepperStyle? coloredStyle}) {
    return SBBStepperThemeData(style: style ?? this.style, coloredStyle: coloredStyle ?? this.coloredStyle);
  }

  @override
  SBBStepperThemeData lerp(SBBStepperThemeData? other, double t) {
    if (other == null) return this;
    return SBBStepperThemeData(
      style: SBBStepperStyle.lerp(style, other.style, t),
      coloredStyle: SBBStepperStyle.lerp(coloredStyle, other.coloredStyle, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBStepperThemeData &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          coloredStyle == other.coloredStyle;

  @override
  int get hashCode => Object.hash(style, coloredStyle);
}

extension SBBStepperThemeDataX on SBBStepperThemeData {
  SBBStepperThemeData merge(SBBStepperThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style), coloredStyle: coloredStyle?.merge(other.coloredStyle));
  }
}

extension SBBStepperThemeDataThemeDataX on ThemeData {
  SBBStepperThemeData? get sbbStepperTheme => extension<SBBStepperThemeData>();
}
