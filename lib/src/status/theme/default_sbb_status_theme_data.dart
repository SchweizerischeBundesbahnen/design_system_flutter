import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBStatusThemeData extends SBBStatusThemeData {
  DefaultSBBStatusThemeData({required SBBBaseStyle baseStyle})
    : super(
        alert: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: baseStyle.colorScheme.errorColor,
          borderColor: baseStyle.colorScheme.errorColor,
          iconColor: SBBColors.white,
          alphaValue: .25,
        ),
        warning: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          borderColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          iconColor: SBBColors.white,
          alphaValue: .25,
        ),
        success: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          borderColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          iconColor: SBBColors.white,
          alphaValue: .25,
        ),
        information: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: SBBColors.smoke,
          borderColor: SBBColors.smoke,
          iconColor: SBBColors.white,
          alphaValue: .25,
        ),
      );
}
