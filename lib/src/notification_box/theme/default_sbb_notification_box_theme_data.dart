import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import '../notification_box.dart';


class DefaultSBBNotificationBoxThemeData extends SBBNotificationBoxThemeData {
  DefaultSBBNotificationBoxThemeData({required SBBBaseStyle baseStyle})
      : super(
    alert: SBBNotificationBoxStyle(
      textStyle: SBBTextStyles.mediumLight,
      titleTextStyle: SBBTextStyles.mediumBold,
      foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
      backgroundColor: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
      borderColor: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
      iconColor: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
      alphaValue: 0.05,
      leadingIconData: SBBIcons.circle_cross_small,
    ),
    warning: SBBNotificationBoxStyle(
      textStyle: SBBTextStyles.mediumLight,
      titleTextStyle: SBBTextStyles.mediumBold,
      foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
      backgroundColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark),
      borderColor: baseStyle.themeValue(SBBColors.warning, SBBColors.warningDark),
      iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.warningDark),
      alphaValue: 0.05,
      leadingIconData: SBBIcons.circle_exclamation_point_small,
    ),
    success: SBBNotificationBoxStyle(
      textStyle: SBBTextStyles.mediumLight,
      titleTextStyle: SBBTextStyles.mediumBold,
      foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
      backgroundColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
      borderColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
      iconColor: baseStyle.themeValue(SBBColors.success, SBBColors.successDark),
      alphaValue: 0.05,
      leadingIconData: SBBIcons.circle_tick_small,
    ),
    information: SBBNotificationBoxStyle(
      textStyle: SBBTextStyles.mediumLight,
      titleTextStyle: SBBTextStyles.mediumBold,
      foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
      backgroundColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite),
      borderColor: baseStyle.themeValue(SBBColors.smoke, SBBColors.anthracite),
      iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.anthracite),
      alphaValue: 0.05,
      leadingIconData: SBBIcons.circle_information_small,
    ),
  );
}