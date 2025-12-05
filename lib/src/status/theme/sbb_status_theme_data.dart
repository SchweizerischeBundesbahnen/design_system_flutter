import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBStatus].
///
/// Use this to set the [SBBStatusStyle] for all [SBBStatus] widgets within the current [SBBTheme].
/// You can define different styles for each status type (alert, warning, success, information).
///
/// To access this in your application, use `Theme.of(context).sbbStatusTheme`.
///
/// See also:
/// * [SBBStatus], the status widget that uses this theme.
/// * [SBBStatusStyle], which defines the visual properties.
@immutable
class SBBStatusThemeData extends ThemeExtension<SBBStatusThemeData> with Diagnosticable {
  /// Creates an [SBBStatusThemeData].
  ///
  /// Each parameter corresponds to a specific [SBBStatusType] and may be null.
  /// When null, the default style for that type is used.
  const SBBStatusThemeData({
    this.alert,
    this.warning,
    this.success,
    this.information,
  });

  /// Style overrides for [SBBStatus.alert].
  ///
  /// If null, the default alert style is used.
  final SBBStatusStyle? alert;

  /// Style overrides for [SBBStatus.warning].
  ///
  /// If null, the default warning style is used.
  final SBBStatusStyle? warning;

  /// Style overrides for [SBBStatus.success].
  ///
  /// If null, the default success style is used.
  final SBBStatusStyle? success;

  /// Style overrides for [SBBStatus.information].
  ///
  /// If null, the default information style is used.
  final SBBStatusStyle? information;

  @override
  SBBStatusThemeData copyWith({
    SBBStatusStyle? alert,
    SBBStatusStyle? warning,
    SBBStatusStyle? success,
    SBBStatusStyle? information,
  }) {
    return SBBStatusThemeData(
      alert: alert ?? this.alert,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      information: information ?? this.information,
    );
  }

  @override
  SBBStatusThemeData lerp(SBBStatusThemeData? other, double t) {
    if (other == null) return this;
    return SBBStatusThemeData(
      alert: SBBStatusStyle.lerp(alert, other.alert, t),
      warning: SBBStatusStyle.lerp(warning, other.warning, t),
      success: SBBStatusStyle.lerp(success, other.success, t),
      information: SBBStatusStyle.lerp(information, other.information, t),
    );
  }

  @override
  int get hashCode => Object.hash(
    alert,
    warning,
    success,
    information,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBStatusThemeData &&
        other.alert == alert &&
        other.warning == warning &&
        other.success == success &&
        other.information == information;
  }
}

extension SBBStatusThemeDataX on SBBStatusThemeData {
  /// Merges this theme with another [SBBStatusThemeData].
  ///
  /// Properties from [other] override properties from this theme.
  /// If [other] is null, returns this theme unchanged.
  SBBStatusThemeData merge(SBBStatusThemeData? other) {
    if (other == null) return this;
    return copyWith(
      alert: alert?.merge(other.alert) ?? other.alert,
      warning: warning?.merge(other.warning) ?? other.warning,
      success: success?.merge(other.success) ?? other.success,
      information: information?.merge(other.information) ?? other.information,
    );
  }
}

extension SBBStatusThemeDataThemeDataX on ThemeData {
  /// Access the [SBBStatusThemeData] from the current theme.
  SBBStatusThemeData? get sbbStatusTheme {
    return extension<SBBStatusThemeData>();
  }
}
