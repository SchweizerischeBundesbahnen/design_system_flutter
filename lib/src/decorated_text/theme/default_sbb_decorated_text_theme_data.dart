import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default [SBBDecoratedTextThemeData] as specified in the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236).
class DefaultSBBDecoratedTextThemeData extends SBBDecoratedTextThemeData {
  DefaultSBBDecoratedTextThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBDecoratedTextStyle(
          valueTextStyle: baseStyle.textTheme.defaultTextStyle,
          valueForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.error: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
            WidgetState.any: baseStyle.colorScheme.defaultTextColor,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
          }),
        ),
      );
}
