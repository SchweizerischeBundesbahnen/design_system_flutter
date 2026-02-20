import '../../../sbb_design_system_mobile.dart';

/// The default message theme is specified using the design system values.
class DefaultSBBMessageThemeData extends SBBMessageThemeData {
  DefaultSBBMessageThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBMessageStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
          titleForegroundColor: baseStyle.defaultTextColor,
          subtitleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          subtitleForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          errorTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraSmallLight),
          errorForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          padding: const .all(SBBSpacing.medium),
          illustrationTitleGap: SBBSpacing.large,
          textGap: SBBSpacing.medium,
          textActionGap: SBBSpacing.large,
        ),
      );
}
