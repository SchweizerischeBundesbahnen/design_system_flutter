import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBSlider].
///
/// Use this to set the [SBBSliderStyle] for all [SBBSlider] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbSliderTheme`.
@immutable
class SBBSliderThemeData extends ThemeExtension<SBBSliderThemeData> with Diagnosticable {
  /// Creates an [SBBSliderThemeData].
  ///
  /// The [style] may be null.
  const SBBSliderThemeData({this.style});

  /// Overrides for the slider's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBSliderStyle? style;

  @override
  SBBSliderThemeData copyWith({SBBSliderStyle? style}) {
    return SBBSliderThemeData(style: style ?? this.style);
  }

  @override
  SBBSliderThemeData lerp(SBBSliderThemeData? other, double t) {
    if (other == null) return this;
    return SBBSliderThemeData(
      style: SBBSliderStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBSliderThemeData && other.style == style;
  }
}

extension SBBSliderThemeDataX on SBBSliderThemeData {
  SBBSliderThemeData merge(SBBSliderThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBSliderThemeDataThemeDataX on ThemeData {
  SBBSliderThemeData? get sbbSliderTheme {
    return extension<SBBSliderThemeData>();
  }
}
