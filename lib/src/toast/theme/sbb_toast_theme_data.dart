import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBToast].
///
/// Use this to set the [SBBToastStyle] for all [SBBToast] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbToastTheme`.
@immutable
class SBBToastThemeData extends ThemeExtension<SBBToastThemeData> with Diagnosticable {
  /// Creates an [SBBToastThemeData].
  const SBBToastThemeData({
    this.style,
  });

  /// Overrides for the toast's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBToastStyle? style;

  @override
  SBBToastThemeData copyWith({
    SBBToastStyle? style,
  }) {
    return SBBToastThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBToastThemeData lerp(SBBToastThemeData? other, double t) {
    if (other == null) return this;
    return SBBToastThemeData(
      style: SBBToastStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBToastThemeData && other.style == style;
  }
}

extension SBBToastThemeDataX on SBBToastThemeData {
  SBBToastThemeData merge(SBBToastThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBToastThemeDataThemeDataX on ThemeData {
  SBBToastThemeData? get sbbToastTheme {
    return extension<SBBToastThemeData>();
  }
}
