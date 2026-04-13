import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default [SBBSegmentedButtonThemeData] used by [SBBTheme].
class DefaultSBBSegmentedButtonThemeData extends SBBSegmentedButtonThemeData {
  DefaultSBBSegmentedButtonThemeData(SBBBaseStyle baseStyle)
    : super(
        leadingHorizontalGapWidth: SBBSpacing.xxSmall,
        style: SBBSegmentedButtonStyle(
          backgroundColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
            WidgetState.any: baseStyle.themeValue(SBBColors.cloud, SBBColors.charcoal),
          }),
          borderColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          }),
          segmentStyle: SBBButtonSegmentStyle(
            foregroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.defaultTextColor),
            textStyle: WidgetStatePropertyAll(baseStyle.textTheme.defaultTextStyle),
          ),
        ),
        filledStyle: SBBSegmentedButtonStyle(
          backgroundColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.colorScheme.primaryColor,
            WidgetState.any: baseStyle.colorScheme.primary125Color,
          }),
          borderColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.colorScheme.primary150Color,
            WidgetState.any: baseStyle.colorScheme.primary125Color,
          }),
          segmentStyle: SBBButtonSegmentStyle(
            foregroundColor: WidgetStatePropertyAll(SBBColors.white),
            textStyle: WidgetStateProperty<TextStyle?>.fromMap({
              WidgetState.selected: baseStyle.textTheme.defaultTextStyle?.boldStyle,
              WidgetState.any: baseStyle.textTheme.defaultTextStyle,
            }),
          ),
        ),
      );
}
