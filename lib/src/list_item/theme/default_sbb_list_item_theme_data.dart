import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default list item theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBListItemThemeData extends SBBListItemThemeData {
  DefaultSBBListItemThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBListItemStyle(
          padding: const .symmetric(horizontal: 16.0, vertical: 10.0),
          leadingHorizontalGapWidth: 8.0,
          subtitleVerticalGapHeight: 4.0,
          trailingHorizontalGapWidth: 16.0,
          titleTextStyle: baseStyle.textTheme.mediumLight,
          titleTextMaxLines: 1,
          subtitleTextStyle: baseStyle.textTheme.smallLight,
          subtitleTextMaxLines: null,
          titleForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.textSecondary,
            WidgetState.any: baseStyle.colorScheme.textPrimary,
          }),
          subtitleForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.colorScheme.textSecondary,
          }),
          leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
            WidgetState.any: baseStyle.colorScheme.iconPrimary,
          }),
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
            WidgetState.any: baseStyle.colorScheme.iconPrimary,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
          }),
          backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: SBBColors.transparent,
          }),
        ),
      );
}
