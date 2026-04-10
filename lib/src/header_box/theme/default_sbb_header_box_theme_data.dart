import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBHeaderBoxThemeData extends SBBHeaderBoxThemeData {
  DefaultSBBHeaderBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBHeaderBoxStyle(
          titleTextStyle: SBBTextStyles.mediumBold.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          secondaryLabelColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          largeSecondaryLabelColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          flapBackgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.midnight),
        ),
      );
}
