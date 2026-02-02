import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default stepper theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=330-12838)
class DefaultSBBStepperThemeData extends SBBStepperThemeData {
  DefaultSBBStepperThemeData(SBBBaseStyle baseStyle)
    : super(
        style: _defaultStyle(baseStyle),
        coloredStyle: _coloredDefaultStyle(baseStyle),
      );

  static SBBStepperStyle _defaultStyle(SBBBaseStyle baseStyle) {
    return SBBStepperStyle(
      padding: EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
      dividerColor: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
      itemStyle: SBBStepperItemStyle(
        backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: baseStyle.primaryColor,
          WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: baseStyle.themeValue(SBBColors.black, SBBColors.white),
        }),
        badgeBackgroundColor: baseStyle.primaryColor,
        badgeIconColor: SBBColors.white,
        iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.white,
          WidgetState.any: baseStyle.themeValue(SBBColors.black, SBBColors.white),
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(
            textStyle: SBBTextStyles.mediumBold,
            color: SBBColors.white,
          ),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
      ),
    );
  }

  static SBBStepperStyle _coloredDefaultStyle(SBBBaseStyle baseStyle) {
    return SBBStepperStyle(
      padding: EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
      dividerColor: SBBColors.white.withValues(alpha: 0.7),
      itemStyle: SBBStepperItemStyle(
        backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.white,
          WidgetState.any: baseStyle.primaryColor,
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: SBBColors.white,
        }),
        badgeBackgroundColor: baseStyle.primaryColor,
        badgeBorderColor: SBBColors.white,
        badgeIconColor: SBBColors.white,
        iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: baseStyle.primaryColor,
          WidgetState.any: SBBColors.white,
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(
            textStyle: SBBTextStyles.mediumBold,
            color: baseStyle.primaryColor,
          ),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight, color: SBBColors.white),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight, color: SBBColors.white),
      ),
    );
  }
}
