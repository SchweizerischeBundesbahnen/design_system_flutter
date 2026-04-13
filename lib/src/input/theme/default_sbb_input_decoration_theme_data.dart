import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

// Default gap values
const double defaultLeadingInputGap = 8.0;
const double defaultInputTrailingGap = 8.0;
const double defaultFloatingLabelInputGap = 2.0;
const double defaultTitleRowErrorGap = 4.0;
const double defaultErrorBottomPadding = 6.0;

const EdgeInsets defaultContentPadding = .symmetric(horizontal: SBBSpacing.medium);

/// The default input decoration theme is specified with colors for leading/trailing icons and error text.
class DefaultSBBInputDecorationThemeData extends SBBInputDecorationThemeData {
  DefaultSBBInputDecorationThemeData(SBBBaseStyle baseStyle)
    : super(
        leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.colorScheme.iconColor,
        }),
        leadingInputGap: defaultLeadingInputGap,
        trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.colorScheme.iconColor,
        }),
        inputTrailingGap: defaultInputTrailingGap,
        errorTextStyle: SBBTextStyles.extraExtraSmallBold,
        errorForegroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.error, SBBColors.errorDark)),
        titleRowErrorGap: defaultTitleRowErrorGap,
        errorBottomPadding: defaultErrorBottomPadding,
        labelTextStyle: baseStyle.textTheme.defaultTextStyle,
        labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.any: baseStyle.colorScheme.labelColor,
        }),
        floatingLabelTextStyle: SBBTextStyles.extraExtraSmallLight,
        floatingLabelInputGap: defaultFloatingLabelInputGap,
        floatingLabelBehavior: .auto,
        placeholderTextStyle: baseStyle.textTheme.defaultTextStyle,
        placeholderForegroundColor: WidgetStatePropertyAll(baseStyle.themeValue(SBBColors.granite, SBBColors.graphite)),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.error: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
          WidgetState.focused: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          WidgetState.any: SBBColors.transparent,
        }),
        contentPadding: defaultContentPadding,
      );
}
