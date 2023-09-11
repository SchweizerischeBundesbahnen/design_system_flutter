import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBChipStyle {
  SBBChipStyle({
    this.borderColor,
    this.disabledBorderColor,
    this.badgeColor,
    this.disabledBadgeColor,
    this.badgeTextStyle,
    this.labelTextStyle,
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
      badgeTextStyle: SBBTextStyle(
        textStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallBold, color: SBBColors.white),
        textStyleDisabled: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallBold, color: SBBColors.white),
      ),
      labelTextStyle: SBBTextStyle(
        textStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight, color: isDarkTheme ? SBBColors.white : SBBColors.black),
        textStyleDisabled: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight, color: isDarkTheme ? SBBColors.graphite : SBBColors.granite),
      ),
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
  final SBBTextStyle? badgeTextStyle;
  final SBBTextStyle? labelTextStyle;
  final Color? unselectButtonColor;
  final Color? disabledUnselectButtonColor;
  final Color? unselectButtonIconColor;
  final Color? disabledUnselectButtonIconColor;

  SBBChipStyle copyWith({
    Color? borderColor,
    Color? disabledBorderColor,
    Color? badgeColor,
    Color? disabledBadgeColor,
    SBBTextStyle? badgeTextStyle,
    SBBTextStyle? labelTextStyle,
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
        badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
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
        badgeTextStyle: badgeTextStyle?.lerp(other?.badgeTextStyle, t),
        labelTextStyle: labelTextStyle?.lerp(other?.labelTextStyle, t),
        unselectButtonColor: Color.lerp(unselectButtonColor, other?.unselectButtonColor, t),
        disabledUnselectButtonColor: Color.lerp(disabledUnselectButtonColor, other?.disabledUnselectButtonColor, t),
        unselectButtonIconColor: Color.lerp(unselectButtonIconColor, other?.unselectButtonIconColor, t),
        disabledUnselectButtonIconColor: Color.lerp(disabledUnselectButtonIconColor, other?.disabledUnselectButtonIconColor, t),
      );
}

extension SBBChipStyleExtension on SBBChipStyle? {
  SBBChipStyle merge(SBBChipStyle? other) {
    if (this == null) return other ?? SBBChipStyle();
    return this!.copyWith(
      borderColor: this!.borderColor ?? other?.borderColor,
      disabledBorderColor: this!.disabledBorderColor ?? other?.disabledBorderColor,
      badgeColor: this!.badgeColor ?? other?.badgeColor,
      disabledBadgeColor: this!.disabledBadgeColor ?? other?.disabledBadgeColor,
      badgeTextStyle: this!.badgeTextStyle ?? other?.badgeTextStyle,
      labelTextStyle: this!.labelTextStyle ?? other?.labelTextStyle,
      unselectButtonColor: this!.unselectButtonColor ?? other?.unselectButtonColor,
      disabledUnselectButtonColor: this!.disabledUnselectButtonColor ?? other?.disabledUnselectButtonColor,
      unselectButtonIconColor: this!.unselectButtonIconColor ?? other?.unselectButtonIconColor,
      disabledUnselectButtonIconColor: this!.disabledUnselectButtonIconColor ?? other?.disabledUnselectButtonIconColor,
    );
  }
}
