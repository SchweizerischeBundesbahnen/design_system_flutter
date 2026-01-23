import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default input decoration theme is specified with colors for leading/trailing icons and error text.
class DefaultSBBInputDecorationThemeData extends SBBInputDecorationThemeData {
  DefaultSBBInputDecorationThemeData(SBBBaseStyle baseStyle)
    : super(
        leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.iconColor,
        }),
        trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.iconColor,
        }),
        errorTextStyle: SBBTextStyles.extraExtraSmallBold,
        errorForegroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.error, SBBColors.errorDark)),
        labelTextStyle: baseStyle.defaultTextStyle,
        labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.labelColor,
        }),
        floatingLabelTextStyle: SBBTextStyles.extraExtraSmallLight,
        placeholderTextStyle: baseStyle.defaultTextStyle,
        placeholderForegroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.granite, SBBColors.graphite)),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.error: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
          WidgetState.focused: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          WidgetState.any: SBBColors.transparent,
        }),
      );
}
