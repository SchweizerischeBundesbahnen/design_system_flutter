import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default message theme is specified using the design system values.
class DefaultSBBMessageThemeData extends SBBMessageThemeData {
  DefaultSBBMessageThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBMessageStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumLight),
          titleForegroundColor: baseStyle.colorScheme.textPrimary,
          subtitleTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight),
          subtitleForegroundColor: baseStyle.colorScheme.textSecondary,
          errorTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.xSmallLight),
          errorForegroundColor: baseStyle.colorScheme.textSecondary,
          padding: const .all(SBBSpacing.medium),
          illustrationTitleGap: SBBSpacing.large,
          textGap: SBBSpacing.medium,
          textActionGap: SBBSpacing.large,
        ),
      );
}
