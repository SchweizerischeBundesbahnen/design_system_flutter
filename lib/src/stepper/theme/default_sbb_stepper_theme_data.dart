import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
          WidgetState.selected: baseStyle.colorScheme.primary,
          WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: baseStyle.colorScheme.strokePrimary,
        }),
        badgeBackgroundColor: baseStyle.colorScheme.primary,
        badgeIconColor: SBBColors.white,
        foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.white,
          WidgetState.any: baseStyle.colorScheme.textPrimary,
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumBold),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumLight),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight),
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
          WidgetState.any: baseStyle.colorScheme.primary,
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: SBBColors.white,
        }),
        badgeBackgroundColor: baseStyle.colorScheme.primary,
        badgeBorderColor: SBBColors.white,
        badgeIconColor: SBBColors.white,
        foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: baseStyle.colorScheme.primary,
          WidgetState.any: SBBColors.white,
        }),
        textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
          WidgetState.selected: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumBold),
          WidgetState.any: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.mediumLight),
        }),
        labelTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight, color: SBBColors.white),
      ),
    );
  }
}
