import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default stepper theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=330-12838)
class DefaultSBBStepperThemeData extends SBBStepperThemeData {
  DefaultSBBStepperThemeData(SBBBaseStyle baseStyle)
    : super(
        style: _defaultStyle(baseStyle),
        filledStyle: _filledDefaultStyle(baseStyle),
      );

  static SBBStepperStyle _defaultStyle(SBBBaseStyle baseStyle) {
    return SBBStepperStyle(
      padding: .symmetric(horizontal: SBBSpacing.medium),
      dividerColor: baseStyle.themeValue(
        SBBColors.black.withValues(alpha: 0.3),
        SBBColors.white.withValues(alpha: 0.7),
      ),
      itemStyle: SBBStepperItemStyle(
        backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: baseStyle.colorScheme.primaryColor,
          WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: baseStyle.themeValue(SBBColors.black, SBBColors.white),
        }),
        badgeBackgroundColor: baseStyle.colorScheme.primaryColor,
        badgeIconColor: SBBColors.white,
        foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.white,
          WidgetState.any: baseStyle.colorScheme.defaultTextColor,
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumBold),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
      ),
    );
  }

  static SBBStepperStyle _filledDefaultStyle(SBBBaseStyle baseStyle) {
    return SBBStepperStyle(
      padding: .symmetric(horizontal: SBBSpacing.medium),
      dividerColor: SBBColors.white.withValues(alpha: 0.7),
      itemStyle: SBBStepperItemStyle(
        backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.white,
          WidgetState.any: baseStyle.colorScheme.primaryColor,
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: SBBColors.white,
        }),
        badgeBackgroundColor: baseStyle.colorScheme.primaryColor,
        badgeBorderColor: SBBColors.white,
        badgeIconColor: SBBColors.white,
        foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: baseStyle.colorScheme.primaryColor,
          WidgetState.any: SBBColors.white,
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumBold),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight, color: SBBColors.white),
      ),
    );
  }
}
