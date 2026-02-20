import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// Default theme data for [SBBSlider].
/// The default slider theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile)
class DefaultSBBSliderThemeData extends SBBSliderThemeData {
  DefaultSBBSliderThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBSliderStyle(
          trackColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite),
            WidgetState.any: baseStyle.themeValue(SBBColors.smoke, SBBColors.smoke),
          }),
          activeTrackColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite),
            WidgetState.any: baseStyle.primaryColor,
          }),
          thumbBackgroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.white, SBBColors.midnight)),
          thumbBorderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.smoke, SBBColors.smoke),
            WidgetState.any: baseStyle.primaryColor,
          }),
          leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.iconColor,
          }),
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.iconColor,
          }),
          padding: .symmetric(horizontal: SBBSpacing.medium),
        ),
      );
}
