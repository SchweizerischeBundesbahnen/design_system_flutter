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
            foregroundColor: WidgetStatePropertyAll(baseStyle.defaultTextColor),
            textStyle: WidgetStatePropertyAll(baseStyle.defaultTextStyle),
          ),
        ),
        filledStyle: SBBSegmentedButtonStyle(
          backgroundColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.primaryColor,
            WidgetState.any: SBBColors.red125,
          }),
          borderColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: SBBColors.red150,
            WidgetState.any: SBBColors.red125,
          }),
          segmentStyle: SBBButtonSegmentStyle(
            foregroundColor: WidgetStatePropertyAll(SBBColors.white),
            textStyle: WidgetStateProperty<TextStyle?>.fromMap({
              WidgetState.selected: baseStyle.defaultTextStyle?.boldStyle,
              WidgetState.any: baseStyle.defaultTextStyle,
            }),
          ),
        ),
      );
}
