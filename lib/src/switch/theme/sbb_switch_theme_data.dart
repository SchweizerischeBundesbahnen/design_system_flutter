import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/switch/theme/sbb_switch_style.dart';

/// The ThemeData for the [SBBSwitch].
///
/// Use this to set the [SBBSwitchStyle] for all [SBBSwitch] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbSwitchTheme`.
@immutable
class SBBSwitchThemeData extends ThemeExtension<SBBSwitchThemeData> with Diagnosticable {
  /// Creates an [SBBSwitchThemeData].
  ///
  /// The [style] may be null.
  const SBBSwitchThemeData({this.style});

  /// Overrides for the switch's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBSwitchStyle? style;

  @override
  SBBSwitchThemeData copyWith({SBBSwitchStyle? style}) {
    return SBBSwitchThemeData(style: style ?? this.style);
  }

  @override
  SBBSwitchThemeData lerp(SBBSwitchThemeData? other, double t) {
    if (other == null) return this;
    return SBBSwitchThemeData(
      style: SBBSwitchStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBSwitchThemeData && other.style == style;
  }
}

extension SBBSwitchThemeDataX on SBBSwitchThemeData {
  SBBSwitchThemeData merge(SBBSwitchThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBSwitchThemeDataThemeDataX on ThemeData {
  SBBSwitchThemeData? get sbbSwitchTheme {
    return extension<SBBSwitchThemeData>();
  }
}
