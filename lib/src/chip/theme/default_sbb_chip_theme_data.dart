import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';
import '../chip.dart';

/// The default chip.dart theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class DefaultSBBChipThemeData extends SBBChipThemeData {
  DefaultSBBChipThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBChipStyle(
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
            WidgetState.any: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          }),
          backgroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.white, SBBColors.charcoal)),
          labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.any: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          }),
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
            WidgetState.disabled: SBBColors.white,
            WidgetState.selected: baseStyle.themeValue(SBBColors.black, SBBColors.white),
            WidgetState.any: SBBColors.white,
          }),
          labelTextStyle: WidgetStateProperty.fromMap(<WidgetStatesConstraint, TextStyle?>{
            WidgetState.disabled: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
            WidgetState.any: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
          }),
          trailingTextStyle: WidgetStatePropertyAll(baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallBold)),
          trailingBackgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected & WidgetState.disabled: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
            WidgetState.disabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.iron),
            WidgetState.selected: baseStyle.themeValue(SBBColors.cloud, SBBColors.granite),
            WidgetState.any: baseStyle.primaryColor,
          }),
          overlayColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.any: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
          }),
        ),
      );
}
