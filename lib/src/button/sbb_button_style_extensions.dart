import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

extension SBBButtonStylesExtension on SBBButtonStyles {
  /// follows https://digital.sbb.ch/de/design-system-mobile-new/elemente/button
  ///
  static ButtonStyle _baseButtonStyle = ButtonStyle(
    overlayColor: SBBTheme.allStates(SBBColors.transparent),
    shape: SBBTheme.allStates(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SBBInternal.defaultButtonHeight / 2,
        ),
      ),
    ),
    fixedSize: SBBTheme.allStates(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding: SBBTheme.allStates(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBTheme.allStates(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: MaterialStateMouseCursor.clickable,
  );

  ButtonStyle get primaryMobile => primaryStyle!.overrideButtonStyle(_baseButtonStyle);

  ButtonStyle get primaryWebLean => primaryMobile.copyWith(
        overlayColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: primaryStyle!.backgroundColor!,
          pressedValue: SBBColors.red125,
          hoveredValue: SBBColors.red125,
          disabledValue: primaryStyle?.backgroundColorDisabled,
        ),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );

  ButtonStyle get primaryMobileNegative => primaryNegativeStyle!.overrideButtonStyle(_baseButtonStyle);

  ButtonStyle get primaryWebNegative => primaryMobileNegative.copyWith(
        overlayColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.granite,
          hoveredValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          disabledValue: primaryNegativeStyle?.backgroundColorDisabled,
        ),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
}
