import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

extension SBBButtonStylesExtension on SBBButtonStyles {
  /// follows https://digital.sbb.ch/de/design-system-mobile-new/elemente/button
  ///
  static final ButtonStyle _baseButtonStyle = ButtonStyle(
    overlayColor: SBBTheme.allStates(SBBColors.transparent),
    shape: SBBTheme.allStates(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SBBInternal.defaultButtonHeight / 2,
        ),
      ),
    ),
    fixedSize: SBBTheme.allStates(
        const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding: SBBTheme.allStates(
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBTheme.allStates(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: WidgetStateMouseCursor.clickable,
  );

  ButtonStyle get primaryMobile =>
      primaryStyle!.overrideButtonStyle(_baseButtonStyle);

  ButtonStyle get primaryMobileNegative =>
      primaryNegativeStyle!.overrideButtonStyle(_baseButtonStyle);
}
