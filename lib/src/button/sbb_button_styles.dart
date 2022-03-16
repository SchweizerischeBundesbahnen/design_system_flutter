import 'package:flutter/material.dart';
import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

class SBBButtonStyles {
  /// follows https://digital.sbb.ch/de/design-system-mobile-new/elemente/button
  ///
  static ButtonStyle _baseButtonStyle = ButtonStyle(
    overlayColor: SBBInternal.all(SBBColors.transparent),
    shape: SBBInternal.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SBBInternal.defaultButtonHeight / 2,
        ),
      ),
    ),
    fixedSize:
        SBBInternal.all(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding:
        SBBInternal.all(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBInternal.all(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: MaterialStateMouseCursor.clickable,
  );

  static ButtonStyle primaryMobile({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
        overlayColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: theme.primaryButtonBackgroundColorHighlighted,
        ),
        backgroundColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: theme.primaryButtonBackgroundColor,
          disabledValue: theme.primaryButtonBackgroundColorDisabled,
        ),
        foregroundColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonTextStyle.color!,
          pressedValue: theme.primaryButtonTextStyleHighlighted.color,
          disabledValue: theme.primaryButtonTextStyleDisabled.color,
        ),
        textStyle: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonTextStyle,
          pressedValue: theme.primaryButtonTextStyleHighlighted,
          disabledValue: theme.primaryButtonTextStyleDisabled,
        ),
      );

  static ButtonStyle primaryWebLean({required SBBThemeData theme}) =>
      primaryMobile(theme: theme).copyWith(
        shape: SBBInternal.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );

  static ButtonStyle primaryMobileNegative({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
        overlayColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonNegativeBackgroundColor,
          pressedValue: theme.primaryButtonNegativeBackgroundColorHighlighted,
        ),
        backgroundColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonNegativeBackgroundColor,
          pressedValue: theme.primaryButtonNegativeBackgroundColor,
          disabledValue: theme.primaryButtonNegativeBackgroundColorDisabled,
        ),
        foregroundColor: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonNegativeTextStyle.color!,
          pressedValue: theme.primaryButtonNegativeTextStyleHighlighted.color,
          disabledValue: theme.primaryButtonNegativeTextStyleDisabled.color,
        ),
        textStyle: SBBInternal.resolveWith(
          defaultValue: theme.primaryButtonNegativeTextStyle,
          pressedValue: theme.primaryButtonNegativeTextStyleHighlighted,
          disabledValue: theme.primaryButtonNegativeTextStyleDisabled,
        ),
        side: SBBInternal.resolveWith(
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
        shape: SBBInternal.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
}
