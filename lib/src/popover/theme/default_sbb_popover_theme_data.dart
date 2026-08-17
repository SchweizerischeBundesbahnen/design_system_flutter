import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default popover theme specified using design system values.
class DefaultSBBPopoverThemeData extends SBBPopoverThemeData {
  DefaultSBBPopoverThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBPopoverStyle(
          titleTextStyle: baseStyle.textTheme.largeLight,
          titleForegroundColor: baseStyle.colorScheme.textPrimary,
          leadingTextStyle: baseStyle.textTheme.defaultTextStyle,
          leadingForegroundColor: baseStyle.colorScheme.iconPrimary,
          trailingTextStyle: baseStyle.textTheme.defaultTextStyle,
          trailingForegroundColor: baseStyle.colorScheme.iconPrimary,
          backgroundColor: baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
          barrierColor: defaultBarrierColor,
          constraints: const BoxConstraints(maxWidth: 430.0),
          padding: const .all(SBBSpacing.medium),
        ),
      );

  /// [SBBColors.black] at 60% opacity, in light and dark mode alike.
  static const defaultBarrierColor = Color(0x99000000);
}
