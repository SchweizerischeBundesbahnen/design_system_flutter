import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
            WidgetState.selected: baseStyle.colorScheme.strokeSecondary,
            WidgetState.any: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          }),
          segmentStyle: SBBButtonSegmentStyle(
            foregroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.textPrimary),
            textStyle: WidgetStatePropertyAll(baseStyle.textTheme.defaultTextStyle),
          ),
        ),
        filledStyle: SBBSegmentedButtonStyle(
          backgroundColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.colorScheme.primary,
            WidgetState.any: baseStyle.colorScheme.primary125,
          }),
          borderColor: WidgetStateProperty<Color?>.fromMap({
            WidgetState.selected: baseStyle.colorScheme.primary150,
            WidgetState.any: baseStyle.colorScheme.primary125,
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

  static const defaultButtonHeight = 44.0;
}
