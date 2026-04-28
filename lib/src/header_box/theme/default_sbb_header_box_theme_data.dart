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
          labelForegroundColor: baseStyle.colorScheme.defaultTextColor,
          leadingForegroundColor: baseStyle.colorScheme.iconColor,
          trailingForegroundColor: baseStyle.colorScheme.iconColor,
          labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          padding: EdgeInsets.fromLTRB(SBBSpacing.medium, SBBSpacing.xSmall, SBBSpacing.medium, SBBSpacing.xSmall),
        ),
      );
}
