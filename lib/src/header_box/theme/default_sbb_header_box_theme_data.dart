import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header_box/theme/sbb_header_box_flap_style.dart';

class DefaultSBBHeaderBoxThemeData extends SBBHeaderBoxThemeData {
  DefaultSBBHeaderBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBHeaderBoxStyle(
          titleTextStyle: SBBTextStyles.mediumBold.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          titleForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          subtitleTextStyle: SBBTextStyles.smallLight,
          subtitleForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          leadingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          flapBackgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.midnight),
          headerBoxShadow: baseStyle.themeValue(
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.2), blurRadius: 8.0)],
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.4), blurRadius: 8.0)],
          ),
          shadowOverFlap: baseStyle.themeValue(
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.2), blurRadius: 4.0)],
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.4), blurRadius: 4.0)],
          ),
          titleSubtitleGap: 0.0,
          padding: .symmetric(
            horizontal: SBBSpacing.medium,
            vertical: 14,
          ),
          appBarOverlap: 24.0,
          margin: .symmetric(horizontal: SBBSpacing.xSmall),
        ),
        largeStyle: SBBHeaderBoxStyle(
          titleTextStyle: SBBTextStyles.mediumBold.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          titleForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          subtitleTextStyle: SBBTextStyles.smallLight,
          subtitleForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),

          leadingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          flapBackgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.midnight),
          headerBoxShadow: baseStyle.themeValue(
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.2), blurRadius: 8.0)],
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.4), blurRadius: 8.0)],
          ),
          shadowOverFlap: baseStyle.themeValue(
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.2), blurRadius: 4.0)],
            [BoxShadow(color: SBBColors.black.withValues(alpha: 0.4), blurRadius: 4.0)],
          ),
          titleSubtitleGap: SBBSpacing.xxSmall,
          padding: .all(SBBSpacing.medium),
          appBarOverlap: 24.0,
          margin: .symmetric(horizontal: SBBSpacing.xSmall),
        ),
        flapStyle: SBBHeaderBoxFlapStyle(
          iconSize: 20,
          labelForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          leadingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          trailingForegroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          labelTextStyle: SBBTextStyles.smallLight,
          padding: EdgeInsets.fromLTRB(SBBSpacing.medium, SBBSpacing.xSmall, SBBSpacing.medium, SBBSpacing.xSmall),
        ),
      );
}
