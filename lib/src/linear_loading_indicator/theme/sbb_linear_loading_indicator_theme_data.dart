import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for [SBBLinearLoadingIndicator].
///
/// Use this to set the [SBBLinearLoadingIndicatorStyle] for all
/// [SBBLinearLoadingIndicator] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbLinearLoadingIndicatorTheme`.
@immutable
class SBBLinearLoadingIndicatorThemeData extends ThemeExtension<SBBLinearLoadingIndicatorThemeData>
    with Diagnosticable {
  const SBBLinearLoadingIndicatorThemeData({
    this.style,
  });

  /// Overrides for the linear loading indicator's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBLinearLoadingIndicatorStyle? style;

  @override
  SBBLinearLoadingIndicatorThemeData copyWith({
    SBBLinearLoadingIndicatorStyle? style,
  }) {
    return SBBLinearLoadingIndicatorThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBLinearLoadingIndicatorThemeData lerp(SBBLinearLoadingIndicatorThemeData? other, double t) {
    if (other == null) return this;
    return SBBLinearLoadingIndicatorThemeData(
      style: SBBLinearLoadingIndicatorStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBLinearLoadingIndicatorThemeData && other.style == style;
  }
}

extension SBBLinearLoadingIndicatorThemeDataX on SBBLinearLoadingIndicatorThemeData {
  SBBLinearLoadingIndicatorThemeData merge(SBBLinearLoadingIndicatorThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBLinearLoadingIndicatorThemeDataThemeDataX on ThemeData {
  /// Access the [SBBLinearLoadingIndicatorThemeData] from the current theme.
  SBBLinearLoadingIndicatorThemeData get sbbLinearLoadingIndicatorTheme =>
      extension<SBBLinearLoadingIndicatorThemeData>()!;
}
