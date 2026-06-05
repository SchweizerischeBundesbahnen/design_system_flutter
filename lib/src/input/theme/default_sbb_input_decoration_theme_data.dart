import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
          WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
          WidgetState.any: baseStyle.colorScheme.iconPrimary,
        }),
        leadingInputGap: defaultLeadingInputGap,
        trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
          WidgetState.any: baseStyle.colorScheme.iconPrimary,
        }),
        inputTrailingGap: defaultInputTrailingGap,
        errorTextStyle: baseStyle.textTheme.xxSmallBold,
        errorForegroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.error),
        titleRowErrorGap: defaultTitleRowErrorGap,
        errorBottomPadding: defaultErrorBottomPadding,
        labelTextStyle: baseStyle.textTheme.defaultTextStyle,
        labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.colorScheme.textSecondary,
          WidgetState.any: baseStyle.colorScheme.textSecondary,
        }),
        floatingLabelTextStyle: baseStyle.textTheme.xxSmallLight,
        floatingLabelInputGap: defaultFloatingLabelInputGap,
        floatingLabelBehavior: .auto,
        placeholderTextStyle: baseStyle.textTheme.defaultTextStyle,
        placeholderForegroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.textSecondary),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.error: baseStyle.colorScheme.error,
          WidgetState.focused: baseStyle.colorScheme.strokePrimary,
          WidgetState.any: SBBColors.transparent,
        }),
        borderType: .boxedOrListed,
        contentPadding: defaultContentPadding,
      );
}
