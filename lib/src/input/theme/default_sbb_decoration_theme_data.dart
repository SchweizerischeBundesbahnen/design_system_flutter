import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default decoration theme sets every value of the [SBBDecorationStyle].
///
/// It is the only source of default values for the decoration.
class DefaultSBBDecorationThemeData extends SBBDecorationThemeData {
  DefaultSBBDecorationThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBDecorationStyle(
          leadingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
            WidgetState.any: baseStyle.colorScheme.iconPrimary,
          }),
          leadingInputGap: SBBSpacing.xSmall,
          trailingForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.iconSecondary,
            WidgetState.any: baseStyle.colorScheme.iconPrimary,
          }),
          inputTrailingGap: SBBSpacing.xSmall,
          errorTextStyle: baseStyle.textTheme.xxSmallBold,
          errorForegroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.error),
          titleRowErrorGap: SBBSpacing.xxSmall,
          errorBottomPadding: 6.0,
          labelTextStyle: baseStyle.textTheme.defaultTextStyle,
          labelForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.disabled: baseStyle.colorScheme.textSecondary,
            WidgetState.any: baseStyle.colorScheme.textSecondary,
          }),
          floatingLabelTextStyle: baseStyle.textTheme.xxSmallLight,
          floatingLabelInputGap: 2.0,
          floatingLabelBehavior: .auto,
          placeholderTextStyle: baseStyle.textTheme.defaultTextStyle,
          placeholderForegroundColor: WidgetStatePropertyAll(baseStyle.colorScheme.textSecondary),
          borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.error: baseStyle.colorScheme.error,
            WidgetState.focused: baseStyle.colorScheme.strokePrimary,
            WidgetState.any: SBBColors.transparent,
          }),
          borderType: .boxedOrListed,
          contentPadding: const EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
        ),
      );
}
