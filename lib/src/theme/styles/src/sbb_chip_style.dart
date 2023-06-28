import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBChipStyle {
  SBBChipStyle({
    this.borderColor,
    this.disabledBorderColor,
    this.badgeColor,
    this.disabledBadgeColor,
    this.badgeTextColor,
    this.unselectButtonColor,
  });

  factory SBBChipStyle.$default({required SBBBaseStyle baseStyle}) {
    final isDarkTheme = baseStyle.brightness == Brightness.dark;
    return SBBChipStyle(
      borderColor: isDarkTheme ? SBBColors.smoke : SBBColors.metal,
      disabledBorderColor: isDarkTheme ? SBBColors.iron : SBBColors.cloud,
      badgeColor: SBBColors.red,
      disabledBadgeColor: isDarkTheme ? SBBColors.iron : SBBColors.graphite,
      badgeTextColor: SBBColors.white,
      unselectButtonColor: isDarkTheme ? SBBColors.iron : SBBColors.milk,
    );
  }

  final Color? borderColor;
  final Color? disabledBorderColor;
  final Color? badgeColor;
  final Color? disabledBadgeColor;
  final Color? badgeTextColor;
  final Color? unselectButtonColor;

  SBBChipStyle copyWith({
    Color? borderColor,
    Color? disabledBorderColor,
    Color? badgeColor,
    Color? disabledBadgeColor,
    Color? badgeTextColor,
    Color? unselectButtonColor,
  }) =>
      SBBChipStyle(
        borderColor: borderColor ?? this.borderColor,
        disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
        badgeColor: badgeColor ?? this.badgeColor,
        disabledBadgeColor: disabledBadgeColor ?? this.disabledBadgeColor,
        badgeTextColor: badgeTextColor ?? this.badgeTextColor,
        unselectButtonColor: unselectButtonColor ?? this.unselectButtonColor,
      );

  SBBChipStyle lerp(SBBChipStyle? other, double t) => SBBChipStyle(
        borderColor: Color.lerp(borderColor, other?.borderColor, t),
        disabledBorderColor: Color.lerp(disabledBorderColor, other?.disabledBorderColor, t),
        badgeColor: Color.lerp(badgeColor, other?.badgeColor, t),
        disabledBadgeColor: Color.lerp(disabledBadgeColor, other?.disabledBadgeColor, t),
        badgeTextColor: Color.lerp(badgeTextColor, other?.badgeTextColor, t),
        unselectButtonColor: Color.lerp(unselectButtonColor, other?.unselectButtonColor, t),
      );
}

extension SBBSliderStyleExtension on SBBChipStyle? {
  SBBChipStyle merge(SBBChipStyle? other) {
    if (this == null) return other ?? SBBChipStyle();
    return this!.copyWith(
      borderColor: this!.borderColor ?? other?.borderColor,
      disabledBorderColor: this!.disabledBorderColor ?? other?.disabledBorderColor,
      badgeColor: this!.badgeColor ?? other?.badgeColor,
      disabledBadgeColor: this!.disabledBadgeColor ?? other?.disabledBadgeColor,
      badgeTextColor: this!.badgeTextColor ?? other?.badgeTextColor,
      unselectButtonColor: this!.unselectButtonColor ?? other?.unselectButtonColor,
    );
  }
}
