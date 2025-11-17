import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

@immutable
class SBBButtonThemeData with Diagnosticable {
  /// Creates an [SBBButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBButtonThemeData({this.style});

  /// Overrides for the button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBButtonStyle2? style;

  /// Linearly interpolate between two SBBButtonTheme themes.
  static SBBButtonThemeData? lerp(SBBButtonThemeData? a, SBBButtonThemeData? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return SBBButtonThemeData(style: SBBButtonStyle2.lerp(a?.style, b?.style, t));
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SBBButtonThemeData && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SBBButtonStyle2>('style', style, defaultValue: null));
  }
}
