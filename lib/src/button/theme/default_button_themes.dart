import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default button themes are specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12).
class DefaultSBBPrimaryButtonTheme extends SBBPrimaryButtonThemeData {
  DefaultSBBPrimaryButtonTheme(SBBBaseStyle baseStyle)
    : super(
        style: SBBButtonStyle(
          textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.primaryColor,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
            WidgetState.any: baseStyle.primaryColor,
          }),
          foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: SBBColors.white,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.primaryColorDark,
            WidgetState.any: baseStyle.primaryColor,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.primaryColorDark,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
            WidgetState.any: baseStyle.primaryColor,
          }),
        ),
      );
}

class DefaultSBBSecondaryButtonTheme extends SBBSecondaryButtonThemeData {
  DefaultSBBSecondaryButtonTheme(SBBBaseStyle baseStyle)
    : super(
        style: SBBButtonStyle(
          textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.charcoal),
            WidgetState.disabled: SBBColors.transparent,
            WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
          }),
          foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(
              baseStyle.primaryColorDark,
              SBBColors.white,
            ),
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.themeValue(baseStyle.primaryColor, SBBColors.white),
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
            WidgetState.any: SBBColors.transparent,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.themeValue(baseStyle.primaryColor, SBBColors.smoke),
          }),
        ),
      );
}

class DefaultSBBTertiaryButtonTheme extends SBBTertiaryButtonThemeData {
  DefaultSBBTertiaryButtonTheme(SBBBaseStyle baseStyle)
    : super(
        style: SBBButtonStyle(
          textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
            WidgetState.disabled: SBBColors.transparent,
            WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          }),
          foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.defaultTextColor,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
            WidgetState.any: SBBColors.transparent,
          }),
          iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.iconColor,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: SBBColors.smoke,
          }),
        ),
      );
}
