import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBMessage].
///
/// Use this to set the [SBBMessageStyle] for all [SBBMessage] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbMessageTheme`.
@immutable
class SBBMessageThemeData extends ThemeExtension<SBBMessageThemeData> with Diagnosticable {
  /// Creates an [SBBMessageThemeData].
  const SBBMessageThemeData({
    this.style,
  });

  /// Overrides for the message's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBMessageStyle? style;

  @override
  SBBMessageThemeData copyWith({
    SBBMessageStyle? style,
  }) {
    return SBBMessageThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBMessageThemeData lerp(SBBMessageThemeData? other, double t) {
    if (other == null) return this;
    return SBBMessageThemeData(
      style: SBBMessageStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBMessageThemeData && other.style == style;
  }
}

extension SBBMessageThemeDataX on SBBMessageThemeData {
  SBBMessageThemeData merge(SBBMessageThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBMessageThemeDataThemeDataX on ThemeData {
  SBBMessageThemeData? get sbbMessageTheme {
    return extension<SBBMessageThemeData>();
  }
}
