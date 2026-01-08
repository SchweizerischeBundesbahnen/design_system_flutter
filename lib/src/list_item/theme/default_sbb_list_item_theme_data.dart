import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default list item theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBListItemThemeData extends SBBListItemThemeData {
  DefaultSBBListItemThemeData({required SBBBaseStyle baseStyle})
    : super(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        trailingHorizontalGapWidth: 16.0,
        leadingHorizontalGapWidth: 8.0,
        subtitleVerticalGapHeight: 4.0,
        style: SBBListItemV5Style(
          titleTextStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
          }),
          subtitleTextStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          }),
          titleForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.defaultTextColor,
          }),
          subtitleForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          }),
          leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.iconColor,
          }),
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.iconColor,
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
