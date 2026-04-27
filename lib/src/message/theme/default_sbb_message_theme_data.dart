import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default message theme is specified using the design system values.
class DefaultSBBMessageThemeData extends SBBMessageThemeData {
  DefaultSBBMessageThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBMessageStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumLight),
          titleForegroundColor: baseStyle.colorScheme.defaultTextColor,
          subtitleTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight),
          subtitleForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          errorTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.xSmallLight),
          errorForegroundColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          padding: const .all(SBBSpacing.medium),
          illustrationTitleGap: SBBSpacing.large,
          textGap: SBBSpacing.medium,
          textActionGap: SBBSpacing.large,
        ),
      );
}
