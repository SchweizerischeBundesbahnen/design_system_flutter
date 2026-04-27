import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for [SBBPopup].
///
/// Use this to set the [SBBPopupStyle] for all [SBBPopup] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPopupTheme`.
@immutable
class SBBPopupThemeData extends ThemeExtension<SBBPopupThemeData> with Diagnosticable {
  const SBBPopupThemeData({
    this.style,
  });

  /// Overrides for the popup's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBPopupStyle? style;

  @override
  SBBPopupThemeData copyWith({
    SBBPopupStyle? style,
  }) {
    return SBBPopupThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBPopupThemeData lerp(SBBPopupThemeData? other, double t) {
    if (other == null) return this;
    return SBBPopupThemeData(
      style: SBBPopupStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPopupThemeData && other.style == style;
  }
}

extension SBBPopupThemeDataX on SBBPopupThemeData {
  SBBPopupThemeData merge(SBBPopupThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBPopupThemeDataThemeDataX on ThemeData {
  /// Access the [SBBPopupThemeData] from the current theme.
  SBBPopupThemeData? get sbbPopupTheme => extension<SBBPopupThemeData>();
}
