import 'package:flutter/cupertino.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default switch theme is specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile).
class DefaultSBBSwitchThemeData extends SBBSwitchThemeData {
  DefaultSBBSwitchThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBSwitchStyle(
          trackColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.primaryColor?.withValues(alpha: 0.4),
            WidgetState.selected: baseStyle.primaryColor,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite).withValues(alpha: 0.5),
            WidgetState.any: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite),
          }),
          knobBackgroundColor: WidgetStateProperty.all(SBBColors.white),
          knobBorderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.primaryColor?.withValues(alpha: 0.4),
            WidgetState.selected: baseStyle.primaryColor,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite).withValues(alpha: 0.5),
            WidgetState.any: baseStyle.themeValue(SBBColors.graphite, SBBColors.granite),
          }),
          knobForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.primaryColor?.withValues(alpha: 0.4),
            WidgetState.selected: baseStyle.primaryColor,
            WidgetState.any: SBBColors.white,
          }),
        ),
      );
}
