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
    fixedSize: SBBTheme.allStates(
        const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding:
        SBBTheme.allStates(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBTheme.allStates(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: MaterialStateMouseCursor.clickable,
  );

  ButtonStyle get primaryMobile =>
      primaryStyle!.overrideButtonStyle(_baseButtonStyle);

  ButtonStyle get primaryWebLean => primaryMobile.copyWith(
        minimumSize: SBBTheme.allStates(Size(SBBInternal.webMinButtonWidth,
            SBBInternal.defaultButtonHeightSmall)),
        maximumSize: SBBTheme.allStates(Size(
            SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
        overlayColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: primaryStyle!.backgroundColor!,
          pressedValue: SBBColors.red125,
          hoveredValue: SBBColors.red125,
          disabledValue: primaryStyle!.backgroundColor!.withOpacity(0.4),
        ),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        side: SBBTheme.resolveStatesWith(
          defaultValue: BorderSide(color: primaryStyle!.backgroundColor!),
          pressedValue: BorderSide(color: SBBColors.red125),
          hoveredValue: BorderSide(color: SBBColors.red125),
          disabledValue: BorderSide(color: SBBColors.transparent),
        ),
      );

  ButtonStyle get primaryMobileNegative =>
      primaryNegativeStyle!.overrideButtonStyle(_baseButtonStyle);

  ButtonStyle get primaryWebNegative => primaryMobileNegative.copyWith(
        minimumSize: SBBTheme.allStates(Size(SBBInternal.webMinButtonWidth,
            SBBInternal.defaultButtonHeightSmall)),
        maximumSize: SBBTheme.allStates(Size(
            SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
        overlayColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.granite,
          hoveredValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          disabledValue: SBBColors.granite.withOpacity(0.4),
        ),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
  ButtonStyle get secondaryWebLean => primaryWebLean.copyWith(
        backgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.silver,
          pressedValue: SBBColors.cement,
          hoveredValue: SBBColors.cement,
          disabledValue: SBBColors.silver,
        ),
        foregroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          hoveredValue: SBBColors.iron,
          disabledValue: SBBColors.iron.withOpacity(0.5),
        ),
        side: SBBTheme.resolveStatesWith(
          defaultValue: BorderSide(color: SBBColors.silver),
          pressedValue: BorderSide(color: SBBColors.cement),
          hoveredValue: BorderSide(color: SBBColors.cement),
          disabledValue: BorderSide(color: SBBColors.silver),
        ),
      );

  ButtonStyle get ghostWebLean => primaryWebLean.copyWith(
        backgroundColor: SBBTheme.allStates(SBBColors.transparent),
        foregroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.granite,
          pressedValue: SBBColors.iron,
          hoveredValue: SBBColors.iron,
          selectedValue: SBBColors.iron,
          disabledValue: SBBColors.granite.withOpacity(0.5),
        ),
        side: SBBTheme.resolveStatesWith(
          defaultValue: BorderSide(color: SBBColors.granite),
          pressedValue: BorderSide(color: SBBColors.iron),
          disabledValue: BorderSide(color: SBBColors.granite.withOpacity(0.4)),
        ),
      );

  ButtonStyle get iconLargeWebLean => ButtonStyle(
        minimumSize: SBBTheme.allStates(const Size(
            SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
        fixedSize: SBBTheme.allStates(const Size(
            SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
        padding: SBBTheme.allStates(EdgeInsets.zero),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );

  ButtonStyle get iconSmallWebLean => ButtonStyle(
        minimumSize: SBBTheme.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        fixedSize: SBBTheme.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        padding: SBBTheme.allStates(EdgeInsets.zero),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
}
