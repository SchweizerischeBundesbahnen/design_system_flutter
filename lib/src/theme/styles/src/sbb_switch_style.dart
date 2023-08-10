import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBSwitchStyle {
  SBBSwitchStyle({
    this.thumbColor,
    this.thumbColorDisabled,
    this.trackColor,
    this.trackColorDisabled,
    this.activeColor,
    this.activeColorDisabled,
  });

  factory SBBSwitchStyle.$default({required SBBBaseStyle baseStyle}) =>
      SBBSwitchStyle(
        thumbColor: SBBColors.white,
        thumbColorDisabled: SBBColors.white,
        trackColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.metal),
        trackColorDisabled:
            baseStyle.themeValue(SBBColors.smoke, SBBColors.metal),
        activeColor: baseStyle.primaryColor,
        activeColorDisabled: baseStyle.primaryColor,
      );

  final Color? thumbColor;
  final Color? thumbColorDisabled;
  final Color? trackColor;
  final Color? trackColorDisabled;
  final Color? activeColor;
  final Color? activeColorDisabled;

  SBBSwitchStyle copyWith({
    Color? thumbColor,
    Color? thumbColorDisabled,
    Color? trackColor,
    Color? trackColorDisabled,
    Color? activeColor,
    Color? activeColorDisabled,
  }) =>
      SBBSwitchStyle(
        thumbColor: thumbColor ?? this.thumbColor,
        thumbColorDisabled: thumbColorDisabled ?? this.thumbColorDisabled,
        trackColor: trackColor ?? this.trackColor,
        trackColorDisabled: trackColorDisabled ?? this.trackColorDisabled,
        activeColor: activeColor ?? this.activeColor,
        activeColorDisabled: activeColorDisabled ?? this.activeColorDisabled,
      );

  SBBSwitchStyle lerp(SBBSwitchStyle? other, double t) => SBBSwitchStyle(
        thumbColor: Color.lerp(thumbColor, other?.thumbColor, t),
        thumbColorDisabled:
            Color.lerp(thumbColorDisabled, other?.thumbColorDisabled, t),
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
      thumbColor: this!.thumbColor ?? other?.thumbColor,
      thumbColorDisabled: this!.thumbColorDisabled ?? other?.thumbColorDisabled,
      trackColor: this!.trackColor ?? other?.trackColor,
      trackColorDisabled: this!.trackColorDisabled ?? other?.trackColorDisabled,
      activeColor: this!.activeColor ?? other?.activeColor,
      activeColorDisabled:
          this!.activeColorDisabled ?? other?.activeColorDisabled,
    );
  }
}
