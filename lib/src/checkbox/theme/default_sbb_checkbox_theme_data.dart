import 'package:flutter/cupertino.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default checkbox theme is specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=123-234&p=f).
class DefaultSBBCheckboxThemeData extends SBBCheckboxThemeData {
  DefaultSBBCheckboxThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBCheckboxStyle(
          fillColor: WidgetStatePropertyAll(baseStyle.colorScheme.backgroundContent),
          checkColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
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
