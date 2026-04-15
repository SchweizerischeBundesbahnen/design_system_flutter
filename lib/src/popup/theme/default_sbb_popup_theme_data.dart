import 'package:flutter/cupertino.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default popup theme specified using design system values.
class DefaultSBBPopupThemeData extends SBBPopupThemeData {
  DefaultSBBPopupThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBPopupStyle(
          titleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight),
          titleForegroundColor: baseStyle.colorScheme.defaultTextColor,
          backgroundColor: baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
          clipBehavior: .hardEdge,
          constraints: BoxConstraints(maxWidth: 640.0),
          barrierColor: const Color(0x80000000),
          titleBodyGap: SBBSpacing.small,
          padding: const .symmetric(horizontal: SBBSpacing.medium, vertical: SBBSpacing.small),
          alignment: .center,
          margin: const .symmetric(horizontal: SBBSpacing.xLarge, vertical: SBBSpacing.large),
        ),
      );
}
