import 'package:flutter/cupertino.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default bottom sheet theme specified using design system values.
class DefaultSBBBottomSheetThemeData extends SBBBottomSheetThemeData {
  DefaultSBBBottomSheetThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBBottomSheetStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight),
          titleForegroundColor: baseStyle.defaultTextColor,
          leadingTextStyle: baseStyle.defaultTextStyle,
          leadingForegroundColor: baseStyle.iconColor,
          trailingTextStyle: baseStyle.defaultTextStyle,
          trailingForegroundColor: baseStyle.iconColor,
          backgroundColor: baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
          clipBehavior: .hardEdge,
          constraints: null,
          barrierColor: const Color(0x80000000),
          titleBodyGap: SBBSpacing.small,
          titleMinHeight: SBBSpacing.xLarge,
          padding: EdgeInsets.symmetric(
            horizontal: SBBSpacing.medium,
            vertical: SBBSpacing.small,
          ).copyWith(bottom: 0.0),
        ),
      );
}
