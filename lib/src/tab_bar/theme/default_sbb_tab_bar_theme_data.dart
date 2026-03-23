import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default tab bar theme specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBTabBarThemeData extends SBBTabBarThemeData {
  DefaultSBBTabBarThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBTabBarStyle(
          backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(SBBColors.white, SBBColors.black),
            WidgetState.any: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          }),
          itemBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(SBBColors.black, SBBColors.white),
            WidgetState.any: SBBColors.transparent,
          }),
          itemLabelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          itemLabelForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          warningItemIcon: SBBIcons.sign_exclamation_point_small,
          warningItemBackgroundColor: SBBColors.red,
          warningItemForegroundColor: SBBColors.white,
        ),
      );
}

