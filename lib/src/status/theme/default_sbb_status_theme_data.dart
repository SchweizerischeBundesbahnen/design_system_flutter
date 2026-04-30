import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBStatusThemeData extends SBBStatusThemeData {
  DefaultSBBStatusThemeData({required SBBBaseStyle baseStyle})
    : super(
        alert: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.colorScheme.error,
          borderColor: baseStyle.colorScheme.error,
          iconColor: SBBColors.white,
          alphaValue: .05,
        ),
        warning: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          borderColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          iconColor: SBBColors.white,
          alphaValue: .05,
        ),
        success: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          borderColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          iconColor: SBBColors.white,
          alphaValue: .05,
        ),
        information: SBBStatusStyle(
          textStyle: baseStyle.textTheme.smallLight,
          foregroundColor: baseStyle.colorScheme.textPrimary,
          backgroundColor: SBBColors.smoke,
          borderColor: SBBColors.smoke,
          iconColor: SBBColors.white,
          alphaValue: .05,
        ),
      );
}
