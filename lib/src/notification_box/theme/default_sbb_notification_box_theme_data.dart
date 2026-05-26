import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBNotificationBoxThemeData extends SBBNotificationBoxThemeData {
  DefaultSBBNotificationBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        alert: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          contentMaxLines: 3,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.colorScheme.error?.withValues(alpha: 0.05),
          borderColor: baseStyle.colorScheme.error,
          iconColor: baseStyle.colorScheme.error,
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          leadingIconData: SBBIcons.circle_cross_small,
          padding: EdgeInsets.all(SBBSpacing.medium),
        ),
        warning: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          contentMaxLines: 3,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark).withValues(alpha: 0.05),
          borderColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark),
          iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.warningDark),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          leadingIconData: SBBIcons.circle_exclamation_point_small,
          padding: EdgeInsets.all(SBBSpacing.medium),
        ),
        success: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          contentMaxLines: 3,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark).withValues(alpha: 0.05),
          borderColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
          iconColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          leadingIconData: SBBIcons.circle_tick_small,
          padding: EdgeInsets.all(SBBSpacing.medium),
        ),
        information: SBBNotificationBoxStyle(
          contentTextStyle: baseStyle.textTheme.smallLight,
          contentMaxLines: 3,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite).withValues(alpha: 0.05),
          borderColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite),
          iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          leadingIconData: SBBIcons.circle_information_small,
          padding: EdgeInsets.all(SBBSpacing.medium),
        ),
      );
}
