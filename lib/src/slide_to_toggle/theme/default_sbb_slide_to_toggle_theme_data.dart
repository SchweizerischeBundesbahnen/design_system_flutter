import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default Slide-To-Toggle theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-552)
class DefaultSBBSlideToToggleThemeData extends SBBSlideToToggleThemeData {
  DefaultSBBSlideToToggleThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBSlideToToggleStyle(
          borderColor: WidgetStateProperty.all(baseStyle.themeValue(SBBColors.cement, SBBColors.iron)),
          backgroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.white, SBBColors.charcoal)),
          toggleBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.primaryColor,
          }),
          toggleTextStyle: WidgetStateProperty.all(
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeBold, color: SBBColors.white),
          ),
          helpTextStyle: WidgetStateProperty.all(
            baseStyle.themedTextStyle(
              textStyle: SBBTextStyles.smallLight,
              color: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            ),
          ),
        ),
      );
}
