import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBSliderStyle {
  SBBSliderStyle({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.iconColor,
    this.disabledIconColor,
  });

  factory SBBSliderStyle.$default({required SBBBaseStyle baseStyle}) {
    final isDarkTheme = baseStyle.brightness == Brightness.dark;
    return SBBSliderStyle(
      activeTrackColor: baseStyle.primaryColor,
      inactiveTrackColor: isDarkTheme ? SBBColors.metal : SBBColors.smoke,
      thumbColor: isDarkTheme ? SBBColors.iron : SBBColors.white,
      thumbBorderColor: baseStyle.primaryColor,
      iconColor: isDarkTheme ? SBBColors.white : SBBColors.black,
      disabledIconColor: isDarkTheme ? SBBColors.graphite : SBBColors.granite,
    );
  }

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Color? thumbBorderColor;
  final Color? iconColor;
  final Color? disabledIconColor;

  SBBSliderStyle copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
    Color? thumbBorderColor,
    Color? thumbBackgroundColor,
    Color? iconColor,
    Color? disabledIconColor,
  }) =>
      SBBSliderStyle(
        activeTrackColor: activeTrackColor ?? this.activeTrackColor,
        inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
        thumbColor: thumbColor ?? this.thumbColor,
        thumbBorderColor: thumbBorderColor ?? this.thumbBorderColor,
        iconColor: iconColor ?? this.iconColor,
        disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      );

  SBBSliderStyle lerp(SBBSliderStyle? other, double t) => SBBSliderStyle(
        activeTrackColor: Color.lerp(activeTrackColor, other?.activeTrackColor, t),
        inactiveTrackColor: Color.lerp(inactiveTrackColor, other?.inactiveTrackColor, t),
        thumbColor: Color.lerp(thumbColor, other?.thumbColor, t),
        thumbBorderColor: Color.lerp(thumbBorderColor, other?.thumbBorderColor, t),
        iconColor: Color.lerp(iconColor, other?.iconColor, t),
        disabledIconColor: Color.lerp(disabledIconColor, other?.disabledIconColor, t),
      );
}

extension SBBSliderStyleExtension on SBBSliderStyle? {
  SBBSliderStyle merge(SBBSliderStyle? other) {
    if (this == null) return other ?? SBBSliderStyle();
    return this!.copyWith(
      activeTrackColor: this!.activeTrackColor ?? other?.activeTrackColor,
      inactiveTrackColor: this!.inactiveTrackColor ?? other?.inactiveTrackColor,
      thumbColor: this!.thumbColor ?? other?.thumbColor,
      thumbBorderColor: this!.thumbBorderColor ?? other?.thumbBorderColor,
      iconColor: this!.iconColor ?? other?.iconColor,
      disabledIconColor: this!.disabledIconColor ?? other?.disabledIconColor,
    );
  }
}
