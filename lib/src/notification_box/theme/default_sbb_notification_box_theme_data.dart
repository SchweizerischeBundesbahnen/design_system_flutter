import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBNotificationBoxThemeData extends SBBNotificationBoxThemeData {
  DefaultSBBNotificationBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        alert: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.colorScheme.error,
          borderColor: baseStyle.colorScheme.error,
          iconColor: baseStyle.colorScheme.error,
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          alphaValue: 0.05,
          leadingIconData: SBBIcons.circle_cross_small,
        ),
        warning: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark),
          borderColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark),
          iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.warningDark),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          alphaValue: 0.05,
          leadingIconData: SBBIcons.circle_exclamation_point_small,
        ),
        success: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
          borderColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
          iconColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          alphaValue: 0.05,
          leadingIconData: SBBIcons.circle_tick_small,
        ),
        information: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite),
          borderColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite),
          iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.anthracite),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          alphaValue: 0.05,
          leadingIconData: SBBIcons.circle_information_small,
        ),
      );
}
