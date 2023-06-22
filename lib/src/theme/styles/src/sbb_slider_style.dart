import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBSliderStyle {
  SBBSliderStyle({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.disabledActiveTrackColor,
    this.disabledInactiveTrackColor,
    this.disabledThumbColor,
    this.disabledThumbBorderColor,
  });

  factory SBBSliderStyle.$default({required SBBBaseStyle baseStyle}) {
    final thumbColor = baseStyle.brightness == Brightness.light ? SBBColors.white : SBBColors.iron;
    return SBBSliderStyle(
      activeTrackColor: baseStyle.primaryColor,
      inactiveTrackColor: SBBColors.smoke,
      thumbColor: thumbColor,
      thumbBorderColor: baseStyle.primaryColor,
      disabledActiveTrackColor: baseStyle.primaryColor!.withOpacity(0.5),
      disabledInactiveTrackColor: SBBColors.smoke.withOpacity(0.5),
      disabledThumbColor: Color.alphaBlend(thumbColor.withOpacity(0.5), baseStyle.backgroundColor!),
      disabledThumbBorderColor: Color.alphaBlend(baseStyle.primaryColor!.withOpacity(0.5), baseStyle.backgroundColor!),
    );
  }

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Color? thumbBorderColor;

  final Color? disabledActiveTrackColor;
  final Color? disabledInactiveTrackColor;
  final Color? disabledThumbColor;
  final Color? disabledThumbBorderColor;

  SBBSliderStyle copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
    Color? thumbBorderColor,
    Color? thumbBackgroundColor,
    Color? disabledActiveTrackColor,
    Color? disabledInactiveTrackColor,
    Color? disabledThumbColor,
    Color? disabledThumbBorderColor,
  }) =>
      SBBSliderStyle(
        activeTrackColor: activeTrackColor ?? this.activeTrackColor,
        inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
        thumbColor: thumbColor ?? this.thumbColor,
        thumbBorderColor: thumbBorderColor ?? this.thumbBorderColor,
        disabledActiveTrackColor: disabledActiveTrackColor ?? this.disabledActiveTrackColor,
        disabledInactiveTrackColor: disabledInactiveTrackColor ?? this.disabledInactiveTrackColor,
        disabledThumbColor: disabledThumbColor ?? this.disabledThumbColor,
        disabledThumbBorderColor: disabledThumbBorderColor ?? this.disabledThumbBorderColor,
      );

  SBBSliderStyle lerp(SBBSliderStyle? other, double t) => SBBSliderStyle(
        activeTrackColor: Color.lerp(activeTrackColor, other?.activeTrackColor, t),
        inactiveTrackColor: Color.lerp(inactiveTrackColor, other?.inactiveTrackColor, t),
        thumbColor: Color.lerp(thumbColor, other?.thumbColor, t),
        thumbBorderColor: Color.lerp(thumbBorderColor, other?.thumbBorderColor, t),
        disabledActiveTrackColor: Color.lerp(disabledActiveTrackColor, other?.disabledActiveTrackColor, t),
        disabledInactiveTrackColor: Color.lerp(disabledInactiveTrackColor, other?.disabledInactiveTrackColor, t),
        disabledThumbColor: Color.lerp(disabledThumbColor, other?.disabledThumbColor, t),
        disabledThumbBorderColor: Color.lerp(disabledThumbBorderColor, other?.disabledThumbBorderColor, t),
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
      disabledActiveTrackColor: this!.disabledActiveTrackColor ?? other?.disabledActiveTrackColor,
      disabledInactiveTrackColor: this!.disabledInactiveTrackColor ?? other?.disabledInactiveTrackColor,
      disabledThumbColor: this!.disabledThumbColor ?? other?.disabledThumbColor,
      disabledThumbBorderColor: this!.disabledThumbBorderColor ?? other?.disabledThumbBorderColor,
    );
  }
}
