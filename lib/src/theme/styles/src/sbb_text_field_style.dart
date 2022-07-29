import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBTextFieldStyle {
  SBBTextFieldStyle({
    this.textStyle,
    this.textStyleDisabled,
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
  });

  factory SBBTextFieldStyle.$default({required SBBBaseStyle baseStyle}) => SBBTextFieldStyle(
        textStyle: baseStyle.themedTextStyle(),
        textStyleDisabled: baseStyle.themedTextStyle(color: SBBColors.metal),
        placeholderTextStyle: baseStyle.themedTextStyle(color: baseStyle.themeValue(SBBColors.metal, SBBColors.cement)),
        placeholderTextStyleDisabled: baseStyle.themedTextStyle(color: SBBColors.metal),
        errorTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.helpersLabel, color: SBBColors.red150),
        dividerColor: baseStyle.dividerColor,
        dividerColorHighlighted: baseStyle.themeValue(SBBColors.black, SBBColors.white),
        dividerColorError: SBBColors.red,
        cursorColor: SBBColors.sky,
        selectionColor: SBBColors.sky.withOpacity(0.5),
        selectionHandleColor: SBBColors.sky,
        iconColor: baseStyle.iconColor,
        iconColorDisabled: SBBColors.metal,
      );

  final TextStyle? textStyle;
  final TextStyle? textStyleDisabled;
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

  SBBTextFieldStyle copyWith({
    TextStyle? textStyle,
    TextStyle? textStyleDisabled,
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
  }) =>
      SBBTextFieldStyle(
        textStyle: textStyle ?? this.textStyle,
        textStyleDisabled: textStyleDisabled ?? this.textStyleDisabled,
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
      );

  SBBTextFieldStyle lerp(SBBTextFieldStyle? other, double t) => SBBTextFieldStyle(
        textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
        textStyleDisabled: TextStyle.lerp(textStyleDisabled, other?.textStyleDisabled, t),
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
      );
}

extension SBBTextFieldStyleExtension on SBBTextFieldStyle? {
  SBBTextFieldStyle merge(SBBTextFieldStyle? other) {
    if (this == null) return other ?? SBBTextFieldStyle();
    return this!.copyWith(
      textStyle: this!.textStyle ?? other?.textStyle,
      textStyleDisabled: this!.textStyleDisabled ?? other?.textStyleDisabled,
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
    );
  }
}
