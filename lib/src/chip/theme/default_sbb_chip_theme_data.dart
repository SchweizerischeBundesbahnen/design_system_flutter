import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default chip theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBChipThemeData extends SBBChipThemeData {
  DefaultSBBChipThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBChipStyle(
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: baseStyle.colorScheme.strokeSecondary,
          }),
          backgroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.backgroundContent),
          labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.textSecondary,
            WidgetState.any: baseStyle.colorScheme.textPrimary,
          }),
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
            WidgetState.disabled: SBBColors.white,
            WidgetState.selected: baseStyle.colorScheme.iconPrimary,
            WidgetState.any: SBBColors.white,
          }),
          labelTextStyle: baseStyle.textTheme.mediumLight,
          trailingTextStyle: baseStyle.textTheme.smallBold,
          trailingBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.selected: baseStyle.themeValue(SBBColors.cloud, SBBColors.granite),
            WidgetState.any: baseStyle.colorScheme.primary,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
          }),
        ),
      );
}
