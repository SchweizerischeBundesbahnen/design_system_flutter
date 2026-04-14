import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../notification_box.dart';

/// The ThemeData for [SBBNotificationBox].
///
/// Use this to set the [SBBNotificationBoxStyle] for all [SBBNotificationBox] widgets
/// within the current [SBBTheme]. You can define different styles for each notification
/// box type (alert, warning, success, information).
///
/// To access this in your application, use `Theme.of(context).sbbNotificationBoxTheme`.
///
/// See also:
///
/// * [SBBNotificationBox], the notification box widget that uses this theme.
/// * [SBBNotificationBoxStyle], which defines the visual properties.
@immutable
class SBBNotificationBoxThemeData extends ThemeExtension<SBBNotificationBoxThemeData>
    with Diagnosticable {
  /// Creates an [SBBNotificationBoxThemeData].
  ///
  /// Each parameter corresponds to a specific notification box type and may be null.
  /// When null, the default style for that type is used.
  const SBBNotificationBoxThemeData({
    this.alert,
    this.warning,
    this.success,
    this.information,
  });

  /// Style overrides for [SBBNotificationBox.alert].
  ///
  /// If null, the default alert style is used.
  final SBBNotificationBoxStyle? alert;

  /// Style overrides for [SBBNotificationBox.warning].
  ///
  /// If null, the default warning style is used.
  final SBBNotificationBoxStyle? warning;

  /// Style overrides for [SBBNotificationBox.success].
  ///
  /// If null, the default success style is used.
  final SBBNotificationBoxStyle? success;

  /// Style overrides for [SBBNotificationBox.information].
  ///
  /// If null, the default information style is used.
  final SBBNotificationBoxStyle? information;

  @override
  SBBNotificationBoxThemeData copyWith({
    SBBNotificationBoxStyle? alert,
    SBBNotificationBoxStyle? warning,
    SBBNotificationBoxStyle? success,
    SBBNotificationBoxStyle? information,
  }) {
    return SBBNotificationBoxThemeData(
      alert: alert ?? this.alert,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      information: information ?? this.information,
    );
  }

  @override
  SBBNotificationBoxThemeData lerp(SBBNotificationBoxThemeData? other, double t) {
    if (other == null) return this;
    return SBBNotificationBoxThemeData(
      alert: SBBNotificationBoxStyle.lerp(alert, other.alert, t),
      warning: SBBNotificationBoxStyle.lerp(warning, other.warning, t),
      success: SBBNotificationBoxStyle.lerp(success, other.success, t),
      information: SBBNotificationBoxStyle.lerp(information, other.information, t),
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
    return other is SBBNotificationBoxThemeData &&
        other.alert == alert &&
        other.warning == warning &&
        other.success == success &&
        other.information == information;
  }
}

extension SBBNotificationBoxThemeDataX on SBBNotificationBoxThemeData {
  /// Merges this theme with another [SBBNotificationBoxThemeData].
  ///
  /// Properties from [other] override properties from this theme.
  /// If [other] is null, returns this theme unchanged.
  SBBNotificationBoxThemeData merge(SBBNotificationBoxThemeData? other) {
    if (other == null) return this;
    return copyWith(
      alert: alert?.merge(other.alert) ?? other.alert,
      warning: warning?.merge(other.warning) ?? other.warning,
      success: success?.merge(other.success) ?? other.success,
      information: information?.merge(other.information) ?? other.information,
    );
  }
}

extension SBBNotificationBoxThemeDataThemeDataX on ThemeData {
  /// Access the [SBBNotificationBoxThemeData] from the current theme.
  SBBNotificationBoxThemeData? get sbbNotificationBoxTheme {
    return extension<SBBNotificationBoxThemeData>();
  }
}