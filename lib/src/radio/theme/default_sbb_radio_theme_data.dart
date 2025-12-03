import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default radio theme is specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=123-234&p=f).
class DefaultSBBRadioThemeData extends SBBRadioThemeData {
  DefaultSBBRadioThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBRadioStyle(
          fillColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.white, SBBColors.charcoal)),
          innerCircleColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.primaryColor,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          }),
          padding: EdgeInsets.all(8.0),
        ),
      );
}
