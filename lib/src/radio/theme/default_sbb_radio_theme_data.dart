import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

/// The default radio theme is specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=123-234&p=f).
class DefaultSBBRadioThemeData extends SBBRadioThemeData {
  DefaultSBBRadioThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBRadioStyle(
          fillColor: WidgetStatePropertyAll(baseStyle.colorScheme.backgroundContent),
          innerCircleColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.strokeSecondary,
            WidgetState.any: baseStyle.colorScheme.primary,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.strokeSecondary,
          }),
          tapTargetPadding: .all(8.0),
        ),
      );
}
