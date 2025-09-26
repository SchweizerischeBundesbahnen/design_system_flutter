import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBTextFieldStyle {
  SBBTextFieldStyle({
    this.textStyle,
    this.textStyleDisabled,
    this.textStyleError,
    this.labelTextStyle,
    this.placeholderTextStyle,
    this.placeholderTextStyleDisabled,
    this.errorTextStyle,
    this.dividerColor,
    this.dividerColorHighlighted,
    this.dividerColorError,
    this.cursorColor,
    this.selectionColor,
    this.selectionHandleColor,
    this.iconColor,
    this.iconColorDisabled,
    this.prefixIconColorError,
  });

  factory SBBTextFieldStyle.$default({required SBBBaseStyle baseStyle}) => SBBTextFieldStyle(
    textStyle: baseStyle.themedTextStyle(),
    textStyleDisabled: baseStyle.themedTextStyle(color: baseStyle.labelColor),
    textStyleError: baseStyle.themedTextStyle(color: baseStyle.themeValue(SBBColors.red, SBBColors.redDark)),
    labelTextStyle: baseStyle.themedTextStyle(
      textStyle: SBBTextStyles.mediumLight.copyWith(height: 12.0 / 10.0, fontSize: 10.0),
      color: baseStyle.labelColor,
    ),
    placeholderTextStyle: baseStyle.themedTextStyle(color: baseStyle.labelColor),
    placeholderTextStyleDisabled: baseStyle.themedTextStyle(color: baseStyle.labelColor),
    errorTextStyle: baseStyle.themedTextStyle(
      textStyle: SBBTextStyles.helpersLabel,
      color: baseStyle.themeValue(SBBColors.red, SBBColors.redDark),
    ),
    dividerColor: baseStyle.dividerColor,
    dividerColorHighlighted: baseStyle.themeValue(SBBColors.black, SBBColors.white),
    dividerColorError: SBBColors.red,
    cursorColor: SBBColors.sky,
    selectionColor: SBBColors.sky.withValues(alpha: 0.5),
    selectionHandleColor: SBBColors.sky,
    iconColor: baseStyle.iconColor,
    iconColorDisabled: baseStyle.labelColor,
    prefixIconColorError: SBBColors.red,
  );

  final TextStyle? textStyle;
  final TextStyle? textStyleDisabled;
  final TextStyle? textStyleError;
  final TextStyle? labelTextStyle;
  final TextStyle? placeholderTextStyle;
  final TextStyle? placeholderTextStyleDisabled;
  final TextStyle? errorTextStyle;
  final Color? dividerColor;
  final Color? dividerColorHighlighted;
  final Color? dividerColorError;
  final Color? cursorColor;
  final Color? selectionColor;
  final Color? selectionHandleColor;
  final Color? iconColor;
  final Color? iconColorDisabled;
  final Color? prefixIconColorError;

  SBBTextFieldStyle copyWith({
    TextStyle? textStyle,
    TextStyle? textStyleDisabled,
    TextStyle? textStyleError,
    TextStyle? labelTextStyle,
    TextStyle? placeholderTextStyle,
    TextStyle? placeholderTextStyleDisabled,
    TextStyle? errorTextStyle,
    Color? dividerColor,
    Color? dividerColorHighlighted,
    Color? dividerColorError,
    Color? cursorColor,
    Color? selectionColor,
    Color? selectionHandleColor,
    Color? iconColor,
    Color? iconColorDisabled,
    Color? prefixIconColorError,
  }) => SBBTextFieldStyle(
    textStyle: textStyle ?? this.textStyle,
    textStyleDisabled: textStyleDisabled ?? this.textStyleDisabled,
    textStyleError: textStyleError ?? this.textStyleError,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
    placeholderTextStyleDisabled: placeholderTextStyleDisabled ?? this.placeholderTextStyleDisabled,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerColorHighlighted: dividerColorHighlighted ?? this.dividerColorHighlighted,
    dividerColorError: dividerColorError ?? this.dividerColorError,
    cursorColor: cursorColor ?? this.cursorColor,
    selectionColor: selectionColor ?? this.selectionColor,
    selectionHandleColor: selectionHandleColor ?? this.selectionHandleColor,
    iconColor: iconColor ?? this.iconColor,
    iconColorDisabled: iconColorDisabled ?? this.iconColorDisabled,
    prefixIconColorError: prefixIconColorError ?? this.prefixIconColorError,
  );

  SBBTextFieldStyle lerp(SBBTextFieldStyle? other, double t) => SBBTextFieldStyle(
    textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
    textStyleDisabled: TextStyle.lerp(textStyleDisabled, other?.textStyleDisabled, t),
    textStyleError: TextStyle.lerp(textStyleError, other?.textStyleError, t),
    labelTextStyle: TextStyle.lerp(labelTextStyle, other?.labelTextStyle, t),
    placeholderTextStyle: TextStyle.lerp(placeholderTextStyle, other?.placeholderTextStyle, t),
    placeholderTextStyleDisabled: TextStyle.lerp(placeholderTextStyleDisabled, other?.placeholderTextStyleDisabled, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other?.errorTextStyle, t),
    dividerColor: Color.lerp(dividerColor, other?.dividerColor, t),
    dividerColorHighlighted: Color.lerp(dividerColorHighlighted, other?.dividerColorHighlighted, t),
    dividerColorError: Color.lerp(dividerColorError, other?.dividerColorError, t),
    cursorColor: Color.lerp(cursorColor, other?.cursorColor, t),
    selectionColor: Color.lerp(selectionColor, other?.selectionColor, t),
    selectionHandleColor: Color.lerp(selectionHandleColor, other?.selectionHandleColor, t),
    iconColor: Color.lerp(iconColor, other?.iconColor, t),
    iconColorDisabled: Color.lerp(iconColorDisabled, other?.iconColorDisabled, t),
    prefixIconColorError: Color.lerp(prefixIconColorError, other?.prefixIconColorError, t),
  );
}

extension SBBTextFieldStyleExtension on SBBTextFieldStyle? {
  SBBTextFieldStyle merge(SBBTextFieldStyle? other) {
    if (this == null) return other ?? SBBTextFieldStyle();
    return this!.copyWith(
      textStyle: this!.textStyle ?? other?.textStyle,
      textStyleDisabled: this!.textStyleDisabled ?? other?.textStyleDisabled,
      textStyleError: this!.textStyleError ?? other?.textStyleError,
      labelTextStyle: this!.labelTextStyle ?? other?.labelTextStyle,
      placeholderTextStyle: this!.placeholderTextStyle ?? other?.placeholderTextStyle,
      placeholderTextStyleDisabled: this!.placeholderTextStyleDisabled ?? other?.placeholderTextStyleDisabled,
      errorTextStyle: this!.errorTextStyle ?? other?.errorTextStyle,
      dividerColor: this!.dividerColor ?? other?.dividerColor,
      dividerColorHighlighted: this!.dividerColorHighlighted ?? other?.dividerColorHighlighted,
      dividerColorError: this!.dividerColorError ?? other?.dividerColorError,
      cursorColor: this!.cursorColor ?? other?.cursorColor,
      selectionColor: this!.selectionColor ?? other?.selectionColor,
      selectionHandleColor: this!.selectionHandleColor ?? other?.selectionHandleColor,
      iconColor: this!.iconColor ?? other?.iconColor,
      iconColorDisabled: this!.iconColorDisabled ?? other?.iconColorDisabled,
      prefixIconColorError: this!.prefixIconColorError ?? other?.prefixIconColorError,
    );
  }
}
