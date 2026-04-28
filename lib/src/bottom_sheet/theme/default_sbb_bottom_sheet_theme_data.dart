import 'package:flutter/cupertino.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default bottom sheet theme specified using design system values.
class DefaultSBBBottomSheetThemeData extends SBBBottomSheetThemeData {
  DefaultSBBBottomSheetThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBBottomSheetStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.largeLight),
          titleForegroundColor: baseStyle.colorScheme.defaultTextColor,
          leadingTextStyle: baseStyle.textTheme.defaultTextStyle,
          leadingForegroundColor: baseStyle.colorScheme.iconColor,
          trailingTextStyle: baseStyle.textTheme.defaultTextStyle,
          trailingForegroundColor: baseStyle.colorScheme.iconColor,
          backgroundColor: baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
          clipBehavior: .hardEdge,
          constraints: null,
          barrierColor: const Color(0x80000000),
          titleBodyGap: SBBSpacing.small,
          titleMinHeight: SBBSpacing.xLarge,
          padding: .symmetric(horizontal: SBBSpacing.medium).copyWith(top: SBBSpacing.small),
        ),
      );
}
