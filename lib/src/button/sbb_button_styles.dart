import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

class SBBButtonStyles {
  /// follows https://digital.sbb.ch/de/design-system-mobile-new/elemente/button
  ///
  static ButtonStyle _baseButtonStyle = ButtonStyle(
    overlayColor: SBBThemeData.allStates(SBBColors.transparent),
    shape: SBBThemeData.allStates(RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SBBInternal.defaultButtonHeight / 2))),
    fixedSize: SBBThemeData.allStates(
        const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding: SBBThemeData.allStates(
        EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: SBBThemeData.allStates(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: MaterialStateMouseCursor.clickable,
  );

  static ButtonStyle primaryButtonStyle(SBBThemeData theme) {
    ButtonStyle primaryMobile = _baseButtonStyle.copyWith(
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

    if (theme.hostPlatform == HostPlatform.native)
      return primaryMobile;
    else
      return primaryMobile.copyWith(
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
          disabledValue: theme.primaryButtonBackgroundColor.withOpacity(0.4),
        ),
        shape: SBBThemeData.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        side: SBBThemeData.resolveStatesWith(
          defaultValue: BorderSide(color: theme.primaryButtonBackgroundColor),
          pressedValue:
              BorderSide(color: theme.primaryButtonBackgroundColorHighlighted),
          hoveredValue:
              BorderSide(color: theme.primaryButtonBackgroundColorHighlighted),
          disabledValue: BorderSide(color: SBBColors.transparent),
        ),
      );
  }

  static ButtonStyle secondaryButtonStyle(SBBThemeData theme) {
    final ButtonStyle secondaryMobile = _baseButtonStyle.copyWith(
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
    if (theme.hostPlatform == HostPlatform.native)
      return secondaryMobile;
    else
      return primaryButtonStyle(theme).copyWith(
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: SBBColors.silver,
          pressedValue: SBBColors.cement,
          hoveredValue: SBBColors.cement,
          disabledValue: SBBColors.silver,
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
  }

  static ButtonStyle primaryNegativeButtonStyle(SBBThemeData theme) {
    final ButtonStyle primaryMobileNegative = _baseButtonStyle.copyWith(
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
        defaultValue: BorderSide(color: theme.primaryButtonNegativeBorderColor),
        pressedValue: BorderSide(
            color: theme.primaryButtonNegativeBorderColorHighlighted),
        disabledValue:
            BorderSide(color: theme.primaryButtonNegativeBorderColorDisabled),
      ),
    );
    if (theme.hostPlatform == HostPlatform.native)
      return primaryMobileNegative;
    else
      // Alternative Primary Button in Web
      return primaryMobileNegative.copyWith(
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
  }

  static ButtonStyle ghostButtonStyle(SBBThemeData theme) =>
      primaryButtonStyle(theme).copyWith(
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
        side: SBBThemeData.resolveStatesWith(
          defaultValue: BorderSide(color: SBBColors.granite),
          pressedValue: BorderSide(color: SBBColors.iron),
          disabledValue: BorderSide(color: SBBColors.granite.withOpacity(0.4)),
        ),
      );

  static ButtonStyle iconLarge(SBBThemeData theme) {
    if (theme.hostPlatform == HostPlatform.native)
      return _baseButtonStyle.copyWith(
        minimumSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
        fixedSize: SBBThemeData.allStates(const Size(
            SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
        padding: SBBThemeData.allStates(EdgeInsets.zero),
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonLargeBackgroundColor,
          pressedValue: theme.iconButtonLargeBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonLargeBackgroundColor,
          pressedValue: theme.iconButtonLargeBackgroundColor,
          disabledValue: theme.iconButtonLargeBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonLargeIconColor,
          pressedValue: theme.iconButtonLargeIconColorHighlighted,
          disabledValue: theme.iconButtonLargeIconColorDisabled,
        ),
        side: SBBThemeData.resolveStatesWith(
          defaultValue: BorderSide(color: theme.iconButtonLargeBorderColor),
          pressedValue:
              BorderSide(color: theme.iconButtonLargeBorderColorHighlighted),
          disabledValue:
              BorderSide(color: theme.iconButtonLargeBorderColorDisabled),
        ),
      );
    else
      return makeLargeIconButton(primaryButtonStyle(theme));
  }

  static ButtonStyle iconSmall(SBBThemeData theme) {
    if (theme.hostPlatform == HostPlatform.native)
      return makeSmallIconButton(_baseButtonStyle.copyWith(
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallBackgroundColor,
          pressedValue: theme.iconButtonSmallBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallBackgroundColor,
          pressedValue: theme.iconButtonSmallBackgroundColor,
          disabledValue: theme.iconButtonSmallBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallIconColor,
          pressedValue: theme.iconButtonSmallIconColorHighlighted,
          disabledValue: theme.iconButtonSmallIconColorDisabled,
        ),
        side: SBBThemeData.resolveStatesWith(
          defaultValue: BorderSide(color: theme.iconButtonSmallBorderColor),
          pressedValue:
              BorderSide(color: theme.iconButtonSmallBorderColorHighlighted),
          disabledValue:
              BorderSide(color: theme.iconButtonSmallBorderColorDisabled),
        ),
      ));
    else
      return makeSmallIconButton(primaryButtonStyle(theme));
  }

  static ButtonStyle iconSmallNegative(SBBThemeData theme) {
    if (theme.hostPlatform == HostPlatform.native)
      return makeSmallIconButton(_baseButtonStyle.copyWith(
          overlayColor: SBBThemeData.resolveStatesWith(
            defaultValue: theme.iconButtonSmallNegativeBackgroundColor,
            pressedValue:
                theme.iconButtonSmallNegativeBackgroundColorHighlighted,
          ),
          backgroundColor: SBBThemeData.resolveStatesWith(
            defaultValue: theme.iconButtonSmallNegativeBackgroundColor,
            pressedValue: theme.iconButtonSmallNegativeBackgroundColor,
            disabledValue: theme.iconButtonSmallNegativeBackgroundColorDisabled,
          ),
          foregroundColor: SBBThemeData.resolveStatesWith(
            defaultValue: theme.iconButtonSmallNegativeIconColor,
            pressedValue: theme.iconButtonSmallNegativeIconColorHighlighted,
            disabledValue: theme.iconButtonSmallNegativeIconColorDisabled,
          ),
          side: SBBThemeData.resolveStatesWith(
            defaultValue:
                BorderSide(color: theme.iconButtonSmallNegativeBorderColor),
            pressedValue: BorderSide(
                color: theme.iconButtonSmallNegativeBorderColorHighlighted),
            disabledValue: BorderSide(
                color: theme.iconButtonSmallNegativeBorderColorDisabled),
          )));
    else
      return makeSmallIconButton(primaryButtonStyle(theme));
  }

  static ButtonStyle iconSmallBorderless(SBBThemeData theme) {
    if (theme.hostPlatform == HostPlatform.native)
      return makeSmallIconButton(_baseButtonStyle.copyWith(
        overlayColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallBorderlessBackgroundColor,
          pressedValue:
              theme.iconButtonSmallBorderlessBackgroundColorHighlighted,
        ),
        backgroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallBorderlessBackgroundColor,
          pressedValue: theme.iconButtonSmallBorderlessBackgroundColor,
          disabledValue: theme.iconButtonSmallBorderlessBackgroundColorDisabled,
        ),
        foregroundColor: SBBThemeData.resolveStatesWith(
          defaultValue: theme.iconButtonSmallBorderlessIconColor,
          pressedValue: theme.iconButtonSmallBorderlessIconColorHighlighted,
          disabledValue: theme.iconButtonSmallBorderlessIconColorDisabled,
        ),
        side: SBBThemeData.allStates(BorderSide(style: BorderStyle.none)),
      ));
    else
      return makeSmallIconButton(primaryButtonStyle(theme));
  }

  static ButtonStyle iconAlternateWeb(SBBThemeData theme) =>
      makeLargeIconButton(primaryNegativeButtonStyle(theme));

  static ButtonStyle iconSecondaryWeb(SBBThemeData theme) =>
      makeLargeIconButton(secondaryButtonStyle(theme));

  static ButtonStyle iconGhostWeb(SBBThemeData theme) =>
      makeLargeIconButton(ghostButtonStyle(theme));

  static ButtonStyle makeSmallIconButton(ButtonStyle baseButtonStyle) =>
      baseButtonStyle.copyWith(
          minimumSize: SBBThemeData.allStates(const Size(
              SBBInternal.defaultButtonHeightSmall,
              SBBInternal.defaultButtonHeightSmall)),
          fixedSize: SBBThemeData.allStates(const Size(
              SBBInternal.defaultButtonHeightSmall,
              SBBInternal.defaultButtonHeightSmall)),
          padding: SBBThemeData.allStates(EdgeInsets.zero));

  static ButtonStyle makeLargeIconButton(ButtonStyle baseButtonStyle) =>
      baseButtonStyle.copyWith(
          minimumSize: SBBThemeData.allStates(const Size(
              SBBInternal.defaultButtonHeight,
              SBBInternal.defaultButtonHeight)),
          fixedSize: SBBThemeData.allStates(const Size(
              SBBInternal.defaultButtonHeight,
              SBBInternal.defaultButtonHeight)),
          padding: SBBThemeData.allStates(EdgeInsets.zero));
}
