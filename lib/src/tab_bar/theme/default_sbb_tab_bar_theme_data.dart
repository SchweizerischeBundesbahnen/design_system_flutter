import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

/// The default tab bar theme specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBTabBarThemeData extends SBBTabBarThemeData {
  DefaultSBBTabBarThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBTabBarStyle(
          backgroundColor: baseStyle.colorScheme.backgroundContent,
          iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(SBBColors.white, SBBColors.black),
            WidgetState.any: baseStyle.colorScheme.iconPrimary,
          }),
          itemBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(SBBColors.black, SBBColors.white),
            WidgetState.any: SBBColors.transparent,
          }),
          itemLabelTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight),
          itemLabelForegroundColor: baseStyle.colorScheme.textPrimary,
          warningItemIcon: SBBIcons.sign_exclamation_point_small,
          warningItemBackgroundColor: baseStyle.colorScheme.error,
          warningItemForegroundColor: SBBColors.white,
          badgeForegroundColor: SBBColors.white,
          badgeBackgroundColor: baseStyle.colorScheme.primary,
          badgeTextStyle: SBBTextStyles.xxSmallBold.copyWith(fontWeight: FontWeight.w900),
        ),
      );
}
