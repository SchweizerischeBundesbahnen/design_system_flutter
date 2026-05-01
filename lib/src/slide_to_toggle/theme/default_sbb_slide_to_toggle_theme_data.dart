import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default Slide-To-Toggle theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-552)
class DefaultSBBSlideToToggleThemeData extends SBBSlideToToggleThemeData {
  DefaultSBBSlideToToggleThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBSlideToToggleStyle(
          borderColor: WidgetStateProperty.all(baseStyle.themeValue(SBBColors.cement, SBBColors.iron)),
          backgroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.backgroundContent),
          toggleBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.primary,
          }),
          toggleForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: SBBColors.white,
          }),
          loadingIndicatorColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: SBBColors.white,
          }),
          toggleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeBold, color: SBBColors.white),
          helpTextStyle: baseStyle.themedTextStyle(
            textStyle: SBBTextStyles.smallLight,
            color: baseStyle.colorScheme.textSecondary,
          ),
        ),
      );
}
