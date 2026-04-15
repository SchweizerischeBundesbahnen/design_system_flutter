import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBHeaderBoxThemeData extends SBBHeaderBoxThemeData {
  DefaultSBBHeaderBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBHeaderBoxStyle.$default(baseStyle: baseStyle),
        largeStyle: SBBHeaderBoxStyle.$default(baseStyle: baseStyle).copyWith(
          titleSubtitleGap: SBBSpacing.xxSmall,
          padding: .all(SBBSpacing.medium),
        ),
        flapStyle: SBBHeaderBoxFlapStyle(
          iconSize: 20,
          labelForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          leadingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          trailingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          padding: EdgeInsets.fromLTRB(SBBSpacing.medium, SBBSpacing.xSmall, SBBSpacing.medium, SBBSpacing.xSmall),
        ),
      );
}
