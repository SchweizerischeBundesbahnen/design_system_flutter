import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBStatusThemeData extends SBBStatusThemeData {
  DefaultSBBStatusThemeData({required SBBBaseStyle baseStyle})
    : super(
        alert: SBBStatusStyle(
          textStyle: SBBTextStyles.smallLight,
          foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: baseStyle.themeValue(SBBColors.red, SBBColors.redDark),
          borderColor: baseStyle.themeValue(SBBColors.red, SBBColors.redDark),
          iconColor: SBBColors.white,
        ),
        warning: SBBStatusStyle(
          textStyle: SBBTextStyles.smallLight,
          foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          borderColor: baseStyle.themeValue(SBBColors.peach, SBBColors.peachDark),
          iconColor: SBBColors.white,
        ),
        success: SBBStatusStyle(
          textStyle: SBBTextStyles.smallLight,
          foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          borderColor: baseStyle.themeValue(SBBColors.green, SBBColors.greenDark),
          iconColor: SBBColors.white,
        ),
        information: SBBStatusStyle(
          textStyle: SBBTextStyles.smallLight,
          foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          backgroundColor: SBBColors.smoke,
          borderColor: SBBColors.smoke,
          iconColor: SBBColors.white,
        ),
      );
}
