import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBTabBar].
///
/// Use this to set the [SBBTabBarStyle] for all [SBBTabBar] instances within
/// the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbTabBarTheme`.
@immutable
class SBBTabBarThemeData extends ThemeExtension<SBBTabBarThemeData> with Diagnosticable {
  /// Creates an [SBBTabBarThemeData].
  ///
  /// The [style] may be null.
  const SBBTabBarThemeData({this.style});

  /// Overrides for the tab bar's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBTabBarStyle? style;

  @override
  SBBTabBarThemeData copyWith({SBBTabBarStyle? style}) {
    return SBBTabBarThemeData(style: style ?? this.style);
  }

  @override
  SBBTabBarThemeData lerp(SBBTabBarThemeData? other, double t) {
    if (other == null) return this;
    return SBBTabBarThemeData(
      style: SBBTabBarStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBTabBarThemeData && other.style == style;
  }
}

extension SBBTabBarThemeDataX on SBBTabBarThemeData {
  SBBTabBarThemeData merge(SBBTabBarThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBTabBarThemeDataThemeDataX on ThemeData {
  SBBTabBarThemeData? get sbbTabBarTheme {
    return extension<SBBTabBarThemeData>();
  }
}
