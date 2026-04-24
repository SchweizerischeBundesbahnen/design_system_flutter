import 'package:flutter/material.dart';

import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default toast theme is specified using the design system values.
class DefaultSBBToastThemeData extends SBBToastThemeData {
  DefaultSBBToastThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBToastStyle(
          titleTextStyle: SBBTextStyles.smallLight.copyWith(decoration: TextDecoration.none),
          titleMaxLines: 2,
          titleForegroundColor: SBBColors.white,
          actionTextStyle: SBBTextStyles.smallBold.copyWith(decoration: TextDecoration.none),
          actionForegroundColor: SBBColors.white,
          titleActionHorizontalGap: SBBSpacing.large,
          titleActionVerticalGap: SBBSpacing.xSmall,
          actionOverflowThreshold: 0.25,
          backgroundColor: baseStyle.themeValue(SBBColors.metal, SBBColors.smoke),
          padding: const .symmetric(vertical: 6.0, horizontal: SBBSpacing.medium),
          margin: const .symmetric(horizontal: SBBSpacing.medium),
        ),
      );
}
