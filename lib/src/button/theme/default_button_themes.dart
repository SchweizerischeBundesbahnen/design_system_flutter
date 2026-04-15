import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default button themes are specified using the
/// [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12).
class DefaultSBBPrimaryButtonThemeData extends SBBPrimaryButtonThemeData {
  DefaultSBBPrimaryButtonThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBButtonStyle(
          textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.colorScheme.primaryColor,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.primaryColor,
          }),
          foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: SBBColors.white,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.colorScheme.primary125Color,
            WidgetState.any: baseStyle.colorScheme.primaryColor,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.colorScheme.primary125Color,
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.primaryColor,
          }),
        ),
      );
}

class DefaultSBBSecondaryButtonThemeData extends SBBSecondaryButtonThemeData {
  DefaultSBBSecondaryButtonThemeData(SBBBaseStyle baseStyle)
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
              baseStyle.colorScheme.primary125Color,
              SBBColors.white,
            ),
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.themeValue(baseStyle.colorScheme.primaryColor, SBBColors.white),
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
            WidgetState.any: SBBColors.transparent,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.themeValue(baseStyle.colorScheme.primaryColor, SBBColors.smoke),
          }),
        ),
      );
}

class DefaultSBBTertiaryButtonThemeData extends SBBTertiaryButtonThemeData {
  DefaultSBBTertiaryButtonThemeData(SBBBaseStyle baseStyle)
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
            WidgetState.any: baseStyle.colorScheme.defaultTextColor,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
            WidgetState.any: SBBColors.transparent,
          }),
          iconColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
            WidgetState.any: baseStyle.colorScheme.iconColor,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: SBBColors.smoke,
          }),
        ),
      );
}

class DefaultSBBAccentButtonThemeData extends SBBAccentButtonThemeData {
  DefaultSBBAccentButtonThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBButtonStyle(
          textStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.any: baseStyle.themeValue(SBBColors.charcoal, SBBColors.white),
          }),
          foregroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.white, SBBColors.smoke),
            WidgetState.any: baseStyle.themeValue(SBBColors.white, SBBColors.black),
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.black, SBBColors.graphite),
            WidgetState.any: null,
          }),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.focused | WidgetState.pressed: baseStyle.themeValue(SBBColors.black, SBBColors.graphite),
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.any: baseStyle.themeValue(SBBColors.charcoal, SBBColors.white),
          }),
        ),
      );
}
