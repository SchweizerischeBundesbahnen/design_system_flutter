import 'package:flutter/cupertino.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default checkbox theme is specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=123-234&p=f).
class DefaultSBBCheckboxThemeData extends SBBCheckboxThemeData {
  DefaultSBBCheckboxThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBCheckboxStyle(
          fillColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.white, SBBColors.charcoal)),
          checkColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
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
