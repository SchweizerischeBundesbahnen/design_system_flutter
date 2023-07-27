import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBSwitchStyle {
  SBBSwitchStyle({
    this.trackColor,
    this.trackColorDisabled,
    this.activeColor,
    this.activeColorDisabled,
  });

  factory SBBSwitchStyle.$default({required SBBBaseStyle baseStyle}) =>
      SBBSwitchStyle(
        trackColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.metal),
        trackColorDisabled: baseStyle.themeValue(
            SBBColors.smoke.withOpacity(0.5), SBBColors.metal),
        activeColor: baseStyle.themeValue(SBBColors.red, SBBColors.redDarkMode),
        activeColorDisabled: baseStyle.themeValue(
            SBBColors.red.withOpacity(0.5), SBBColors.redDarkMode),
      );

  final Color? trackColor;
  final Color? trackColorDisabled;
  final Color? activeColor;
  final Color? activeColorDisabled;

  SBBSwitchStyle copyWith({
    Color? trackColor,
    Color? trackColorDisabled,
    Color? activeColor,
    Color? activeColorDisabled,
  }) =>
      SBBSwitchStyle(
        trackColor: trackColor ?? this.trackColor,
        trackColorDisabled: trackColorDisabled ?? this.trackColorDisabled,
        activeColor: activeColor ?? this.activeColor,
        activeColorDisabled: activeColorDisabled ?? this.activeColorDisabled,
      );

  SBBSwitchStyle lerp(SBBSwitchStyle? other, double t) => SBBSwitchStyle(
        trackColor: Color.lerp(trackColor, other?.trackColor, t),
        trackColorDisabled:
            Color.lerp(trackColorDisabled, other?.trackColorDisabled, t),
        activeColor: Color.lerp(activeColor, other?.activeColor, t),
        activeColorDisabled:
            Color.lerp(activeColorDisabled, other?.activeColorDisabled, t),
      );
}

extension SBBSwitchControlStyleExtension on SBBSwitchStyle? {
  SBBSwitchStyle merge(SBBSwitchStyle? other) {
    if (this == null) return other ?? SBBSwitchStyle();
    return this!.copyWith(
      trackColor: this!.trackColor ?? other?.trackColor,
      trackColorDisabled: this!.trackColorDisabled ?? other?.trackColorDisabled,
      activeColor: this!.activeColor ?? other?.activeColor,
      activeColorDisabled:
          this!.activeColorDisabled ?? other?.activeColorDisabled,
    );
  }
}
