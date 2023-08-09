import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBChipStyle {
  SBBChipStyle({
    this.borderColor,
    this.disabledBorderColor,
    this.badgeColor,
    this.disabledBadgeColor,
    this.badgeTextColor,
    this.disabledBadgeTextColor,
    this.unselectButtonColor,
    this.disabledUnselectButtonColor,
    this.unselectButtonIconColor,
    this.disabledUnselectButtonIconColor,
  });

  factory SBBChipStyle.$default({required SBBBaseStyle baseStyle}) {
    final isDarkTheme = baseStyle.brightness == Brightness.dark;
    return SBBChipStyle(
      borderColor: isDarkTheme ? SBBColors.smoke : SBBColors.metal,
      disabledBorderColor: isDarkTheme ? SBBColors.iron : SBBColors.cloud,
      badgeColor: baseStyle.primaryColor,
      disabledBadgeColor: isDarkTheme ? SBBColors.iron : SBBColors.graphite,
      badgeTextColor: SBBColors.white,
      disabledBadgeTextColor: SBBColors.white,
      unselectButtonColor: isDarkTheme ? SBBColors.iron : SBBColors.milk,
      disabledUnselectButtonColor: isDarkTheme ? SBBColors.iron : SBBColors.milk,
      unselectButtonIconColor: isDarkTheme ? SBBColors.white : SBBColors.black,
      disabledUnselectButtonIconColor: isDarkTheme ? SBBColors.graphite : SBBColors.granite,
    );
  }

  final Color? borderColor;
  final Color? disabledBorderColor;
  final Color? badgeColor;
  final Color? disabledBadgeColor;
  final Color? badgeTextColor;
  final Color? disabledBadgeTextColor;
  final Color? unselectButtonColor;
  final Color? disabledUnselectButtonColor;
  final Color? unselectButtonIconColor;
  final Color? disabledUnselectButtonIconColor;

  SBBChipStyle copyWith({
    Color? borderColor,
    Color? disabledBorderColor,
    Color? badgeColor,
    Color? disabledBadgeColor,
    Color? badgeTextColor,
    Color? disabledBadgeTextColor,
    Color? unselectButtonColor,
    Color? disabledUnselectButtonColor,
    Color? unselectButtonIconColor,
    Color? disabledUnselectButtonIconColor,
  }) =>
      SBBChipStyle(
        borderColor: borderColor ?? this.borderColor,
        disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
        badgeColor: badgeColor ?? this.badgeColor,
        disabledBadgeColor: disabledBadgeColor ?? this.disabledBadgeColor,
        badgeTextColor: badgeTextColor ?? this.badgeTextColor,
        disabledBadgeTextColor: disabledBadgeTextColor ?? this.disabledBadgeTextColor,
        unselectButtonColor: unselectButtonColor ?? this.unselectButtonColor,
        disabledUnselectButtonColor: disabledUnselectButtonColor ?? this.disabledUnselectButtonColor,
        unselectButtonIconColor: unselectButtonIconColor ?? this.unselectButtonIconColor,
        disabledUnselectButtonIconColor: disabledUnselectButtonIconColor ?? this.disabledUnselectButtonIconColor,
      );

  SBBChipStyle lerp(SBBChipStyle? other, double t) => SBBChipStyle(
        borderColor: Color.lerp(borderColor, other?.borderColor, t),
        disabledBorderColor: Color.lerp(disabledBorderColor, other?.disabledBorderColor, t),
        badgeColor: Color.lerp(badgeColor, other?.badgeColor, t),
        disabledBadgeColor: Color.lerp(disabledBadgeColor, other?.disabledBadgeColor, t),
        badgeTextColor: Color.lerp(badgeTextColor, other?.badgeTextColor, t),
        disabledBadgeTextColor: Color.lerp(disabledBadgeTextColor, other?.disabledBadgeTextColor, t),
        unselectButtonColor: Color.lerp(unselectButtonColor, other?.unselectButtonColor, t),
        disabledUnselectButtonColor: Color.lerp(disabledUnselectButtonColor, other?.disabledUnselectButtonColor, t),
        unselectButtonIconColor: Color.lerp(unselectButtonIconColor, other?.unselectButtonIconColor, t),
        disabledUnselectButtonIconColor: Color.lerp(disabledUnselectButtonIconColor, other?.disabledUnselectButtonIconColor, t),
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
      disabledBadgeTextColor: this!.disabledBadgeTextColor ?? other?.disabledBadgeTextColor,
      unselectButtonColor: this!.unselectButtonColor ?? other?.unselectButtonColor,
      disabledUnselectButtonColor: this!.disabledUnselectButtonColor ?? other?.disabledUnselectButtonColor,
      unselectButtonIconColor: this!.unselectButtonIconColor ?? other?.unselectButtonIconColor,
      disabledUnselectButtonIconColor: this!.disabledUnselectButtonIconColor ?? other?.disabledUnselectButtonIconColor,
    );
  }
}
