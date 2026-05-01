import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

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
          labelForegroundColor: baseStyle.colorScheme.textPrimary,
          leadingForegroundColor: baseStyle.colorScheme.iconPrimary,
          trailingForegroundColor: baseStyle.colorScheme.iconPrimary,
          labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          padding: EdgeInsets.fromLTRB(SBBSpacing.medium, SBBSpacing.xSmall, SBBSpacing.medium, SBBSpacing.xSmall),
        ),
      );
}
