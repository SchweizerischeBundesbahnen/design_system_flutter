import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

class SBBButtonStyles {
  /// follows https://digital.sbb.ch/de/design-system-mobile-new/elemente/button
  ///
  static ButtonStyle _baseButtonStyle = ButtonStyle(
    overlayColor: SBBThemeData.allStates(SBBColors.transparent),
    shape: SBBThemeData.allStates(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SBBInternal.defaultButtonHeight / 2,
        ),
      ),
    ),
    fixedSize:
        SBBThemeData.allStates(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding:
        SBBThemeData.allStates(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBThemeData.allStates(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: MaterialStateMouseCursor.clickable,
  );

  static ButtonStyle primaryMobile({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: theme.primaryButtonBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: theme.primaryButtonBackgroundColor,
          disabledValue: theme.primaryButtonBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonTextStyle.color!,
          pressedValue: theme.primaryButtonTextStyleHighlighted.color,
          disabledValue: theme.primaryButtonTextStyleDisabled.color,
        ),
        textStyle: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonTextStyle,
          pressedValue: theme.primaryButtonTextStyleHighlighted,
          disabledValue: theme.primaryButtonTextStyleDisabled,
        ),
      );

  static ButtonStyle primaryWebLean({required SBBThemeData theme}) =>
      primaryMobile(theme: theme).copyWith(
        overlayColor: SBBThemeData.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: SBBColors.red125,
          hoveredValue: SBBColors.red125,
          disabledValue: theme.primaryButtonBackgroundColorDisabled,
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );

  static ButtonStyle primaryMobileNegative({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonNegativeBackgroundColor,
          pressedValue: theme.primaryButtonNegativeBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonNegativeBackgroundColor,
          pressedValue: theme.primaryButtonNegativeBackgroundColor,
          disabledValue: theme.primaryButtonNegativeBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonNegativeTextStyle.color!,
          pressedValue: theme.primaryButtonNegativeTextStyleHighlighted.color,
          disabledValue: theme.primaryButtonNegativeTextStyleDisabled.color,
        ),
        textStyle: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonNegativeTextStyle,
          pressedValue: theme.primaryButtonNegativeTextStyleHighlighted,
          disabledValue: theme.primaryButtonNegativeTextStyleDisabled,
        ),
        side: SBBThemeData.resolveStatesWith(
          defaultValue:
              BorderSide(color: theme.primaryButtonNegativeBorderColor),
          pressedValue: BorderSide(
              color: theme.primaryButtonNegativeBorderColorHighlighted),
          disabledValue:
              BorderSide(color: theme.primaryButtonNegativeBorderColorDisabled),
        ),
      );
  static ButtonStyle primaryWebNegative({required SBBThemeData theme}) =>
      primaryMobileNegative(theme: theme).copyWith(
        overlayColor: SBBThemeData.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: SBBColors.granite,
          hoveredValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          disabledValue: theme.primaryButtonNegativeBackgroundColorDisabled,
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
}
