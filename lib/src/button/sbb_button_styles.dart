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
    fixedSize: SBBThemeData.allStates(
        const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding: SBBThemeData.allStates(
        EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
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

  static ButtonStyle secondaryMobile({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.secondaryButtonBackgroundColor,
          pressedValue: theme.secondaryButtonBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.secondaryButtonBackgroundColor,
          pressedValue: theme.secondaryButtonBackgroundColor,
          disabledValue: theme.secondaryButtonBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.secondaryButtonTextStyle.color!,
          pressedValue: theme.secondaryButtonTextStyleHighlighted.color,
          disabledValue: theme.secondaryButtonTextStyleDisabled.color,
        ),
        textStyle: SBBThemeData.resolveStatesWith(
          defaultValue: theme.secondaryButtonTextStyle,
          pressedValue: theme.secondaryButtonTextStyleHighlighted,
          disabledValue: theme.secondaryButtonTextStyleDisabled,
        ),
      );

  static ButtonStyle primaryWeb({required SBBThemeData theme}) =>
      primaryMobile(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(Size(SBBInternal.webMinButtonWidth,
            SBBInternal.defaultButtonHeightSmall)),
        maximumSize: SBBThemeData.allStates(Size(
            SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
        overlayColor: SBBThemeData.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.primaryButtonBackgroundColor,
          pressedValue: theme.primaryButtonBackgroundColorHighlighted,
          hoveredValue: theme.primaryButtonBackgroundColorHighlighted,
          disabledValue: SBBColors.red.withOpacity(0.4),
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );

  static ButtonStyle iconPrimaryWeb({required SBBThemeData theme}) =>
      primaryWeb(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        fixedSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        padding: SBBThemeData.allStates(EdgeInsets.zero),
      );

  static ButtonStyle iconPrimaryWebNegative({required SBBThemeData theme}) =>
      primaryWebNegative(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        fixedSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        padding: SBBThemeData.allStates(EdgeInsets.zero),
      );

  static ButtonStyle iconSecondaryWeb({required SBBThemeData theme}) =>
      secondaryWeb(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        fixedSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        padding: SBBThemeData.allStates(EdgeInsets.zero),
      );

  static ButtonStyle iconGhostWeb({required SBBThemeData theme}) =>
      webGhost(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        fixedSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeightSmall,
            SBBInternal.defaultButtonHeightSmall)),
        padding: SBBThemeData.allStates(EdgeInsets.zero),
      );

  static ButtonStyle secondaryWeb({required SBBThemeData theme}) =>
      secondaryMobile(theme: theme).copyWith(
        minimumSize: SBBThemeData.allStates(Size(SBBInternal.webMinButtonWidth,
            SBBInternal.defaultButtonHeightSmall)),
        maximumSize: SBBThemeData.allStates(Size(
            SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
        overlayColor: SBBThemeData.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: SBBColors.silver,
          pressedValue: SBBColors.cement,
          hoveredValue: SBBColors.cement,
          disabledValue: SBBColors.silver,
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          disabledValue: SBBColors.iron.withOpacity(0.5),
        ),
        side: SBBThemeData.resolveStatesWith(
          defaultValue: BorderSide(color: SBBColors.silver),
          pressedValue: BorderSide(color: SBBColors.cement),
          hoveredValue: BorderSide(color: SBBColors.cement),
          disabledValue: BorderSide(color: SBBColors.silver),
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
        minimumSize: SBBThemeData.allStates(Size(SBBInternal.webMinButtonWidth,
            SBBInternal.defaultButtonHeightSmall)),
        maximumSize: SBBThemeData.allStates(Size(
            SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
        overlayColor: SBBThemeData.allStates(
          SBBColors.transparent,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: SBBColors.granite,
          hoveredValue: SBBColors.iron,
          pressedValue: SBBColors.iron,
          disabledValue: SBBColors.granite.withOpacity(0.4),
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
  static ButtonStyle webGhost({required SBBThemeData theme}) =>
      _baseButtonStyle.copyWith(
          minimumSize: SBBThemeData.allStates(Size(
              SBBInternal.webMinButtonWidth,
              SBBInternal.defaultButtonHeightSmall)),
          maximumSize: SBBThemeData.allStates(Size(
              SBBInternal.webMaxButtonWidth, SBBInternal.defaultButtonHeight)),
          overlayColor: SBBThemeData.resolveStatesWith(
            defaultValue: theme.primaryButtonNegativeBackgroundColor,
            pressedValue: theme.primaryButtonNegativeBackgroundColorHighlighted,
          ),
          backgroundColor: SBBThemeData.allStates(SBBColors.transparent),
          foregroundColor: SBBThemeData.resolveStatesWith(
            defaultValue: SBBColors.granite,
            pressedValue: SBBColors.iron,
            hoveredValue: SBBColors.iron,
            selectedValue: SBBColors.iron,
            disabledValue: SBBColors.granite.withOpacity(0.5),
          ),
          textStyle: SBBThemeData.resolveStatesWith(
            defaultValue: theme.primaryButtonNegativeTextStyle,
            pressedValue: theme.primaryButtonNegativeTextStyleHighlighted,
            disabledValue: theme.primaryButtonNegativeTextStyleDisabled,
          ),
          side: SBBThemeData.resolveStatesWith(
            defaultValue: BorderSide(color: SBBColors.granite),
            pressedValue: BorderSide(color: SBBColors.iron),
            disabledValue:
                BorderSide(color: SBBColors.granite.withOpacity(0.4)),
          ),
          shape: SBBThemeData.allStates(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
          ));
}
