import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';
import '../../sbb_internal.dart';

extension SBBButtonStyleX on SBBButtonStyle {
  ButtonStyle toButtonStyle() {
    WidgetStateProperty<BorderSide?>? resolvedBorderSide;
    if (borderColor != null) {
      resolvedBorderSide = WidgetStateProperty.resolveWith<BorderSide?>((states) {
        final color = borderColor!.resolve(states);
        return color != null ? BorderSide(color: color, strokeAlign: BorderSide.strokeAlignOutside) : null;
      });
    }

    return baseButtonStyle.copyWith(
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      iconColor: iconColor,
      side: resolvedBorderSide,
    );
  }

  ButtonStyle get baseButtonStyle => ButtonStyle(
    overlayColor: WidgetStatePropertyAll<Color>(SBBColors.transparent),
    fixedSize: WidgetStatePropertyAll<Size>(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
    padding: WidgetStatePropertyAll<EdgeInsets>(const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
    elevation: WidgetStatePropertyAll<double>(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    mouseCursor: WidgetStateMouseCursor.clickable,
  );
}
