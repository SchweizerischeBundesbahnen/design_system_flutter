import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBDecoratedThemeData extends SBBDecoratedThemeData {
  DefaultSBBDecoratedThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBDecoratedStyle(
          contentTextStyle: baseStyle.textTheme.defaultTextStyle,
          contentForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.textSecondary,
            WidgetState.error: baseStyle.colorScheme.error,
            WidgetState.any: baseStyle.colorScheme.textPrimary,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
          }),
        ),
      );
}
