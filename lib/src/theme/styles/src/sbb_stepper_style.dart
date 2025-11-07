import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBStepperStyle {
  SBBStepperStyle({
    this.iconColor,
    this.selectedIconColor,
    this.textColor,
    this.selectedTextColor,
    this.dividerColor,
    this.labelTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.backgroundBorderColor,
    this.selectedBackgroundBorderColor,
    this.checkedBackgroundColor,
    this.checkedBorderColor,
  });

  // TODO: Handle Dark Mode
  factory SBBStepperStyle.$default({required SBBBaseStyle baseStyle}) => SBBStepperStyle(
    iconColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
    selectedIconColor: SBBColors.white,
    textColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
    selectedTextColor: SBBColors.white,
    dividerColor: baseStyle.themeValue(SBBColors.platinum, SBBColors.smoke),
    labelTextColor: baseStyle.defaultTextColor,
    backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
    selectedBackgroundColor: baseStyle.primaryColor,
    backgroundBorderColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
    selectedBackgroundBorderColor: null,
    checkedBackgroundColor: baseStyle.primaryColor,
    checkedBorderColor: SBBColors.white,
  );

  factory SBBStepperStyle.$colored({required SBBBaseStyle baseStyle}) => SBBStepperStyle(
    iconColor: SBBColors.white,
    selectedIconColor: baseStyle.primaryColor,
    textColor: SBBColors.white,
    selectedTextColor: baseStyle.primaryColor,
    dividerColor: SBBColors.white.withValues(alpha: 0.7),
    labelTextColor: SBBColors.white,
    backgroundColor: baseStyle.primaryColor,
    selectedBackgroundColor: SBBColors.white,
    backgroundBorderColor: SBBColors.white,
    selectedBackgroundBorderColor: null,
    checkedBackgroundColor: baseStyle.primaryColor,
    checkedBorderColor: SBBColors.white,
  );

  final Color? iconColor;
  final Color? selectedIconColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? dividerColor;
  final Color? labelTextColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? backgroundBorderColor;
  final Color? selectedBackgroundBorderColor;
  final Color? checkedBackgroundColor;
  final Color? checkedBorderColor;

  SBBStepperStyle copyWith({
    Color? iconColor,
    Color? selectedIconColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? dividerColor,
    Color? labelTextColor,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? backgroundBorderColor,
    Color? selectedBackgroundBorderColor,
    Color? checkedBackgroundColor,
    Color? checkedBorderColor,
  }) => SBBStepperStyle(
    selectedIconColor: selectedIconColor ?? this.selectedIconColor,
    textColor: textColor ?? this.textColor,
    selectedTextColor: selectedTextColor ?? this.selectedTextColor,
    dividerColor: dividerColor ?? this.dividerColor,
    labelTextColor: labelTextColor ?? this.labelTextColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
    backgroundBorderColor: backgroundBorderColor ?? this.backgroundBorderColor,
    selectedBackgroundBorderColor: selectedBackgroundBorderColor ?? this.selectedBackgroundBorderColor,
    checkedBackgroundColor: checkedBackgroundColor ?? this.checkedBackgroundColor,
    checkedBorderColor: checkedBorderColor ?? this.checkedBorderColor,
  );

  SBBStepperStyle lerp(SBBStepperStyle? other, double t) => SBBStepperStyle(
    iconColor: Color.lerp(iconColor, other?.iconColor, t),
    selectedIconColor: Color.lerp(selectedIconColor, other?.selectedIconColor, t),
    textColor: Color.lerp(textColor, other?.textColor, t),
    selectedTextColor: Color.lerp(selectedTextColor, other?.selectedTextColor, t),
    dividerColor: Color.lerp(dividerColor, other?.dividerColor, t),
    labelTextColor: Color.lerp(labelTextColor, other?.labelTextColor, t),
    backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
    selectedBackgroundColor: Color.lerp(selectedBackgroundColor, other?.selectedBackgroundColor, t),
    backgroundBorderColor: Color.lerp(backgroundBorderColor, other?.backgroundBorderColor, t),
    selectedBackgroundBorderColor: Color.lerp(selectedBackgroundBorderColor, other?.selectedBackgroundBorderColor, t),
    checkedBackgroundColor: Color.lerp(checkedBackgroundColor, other?.checkedBackgroundColor, t),
    checkedBorderColor: Color.lerp(checkedBorderColor, other?.checkedBorderColor, t),
  );
}

extension SBBStepperStyleExtension on SBBStepperStyle? {
  SBBStepperStyle merge(SBBStepperStyle? other) {
    if (this == null) return other ?? SBBStepperStyle();
    return this!.copyWith(
      selectedIconColor: this!.selectedIconColor ?? other?.selectedIconColor,
      textColor: this!.textColor ?? other?.textColor,
      selectedTextColor: this!.selectedTextColor ?? other?.selectedTextColor,
      dividerColor: this!.dividerColor ?? other?.dividerColor,
      labelTextColor: this!.labelTextColor ?? other?.labelTextColor,
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      selectedBackgroundColor: this!.selectedBackgroundColor ?? other?.selectedBackgroundColor,
      backgroundBorderColor: this!.backgroundBorderColor ?? other?.backgroundBorderColor,
      selectedBackgroundBorderColor: this!.selectedBackgroundBorderColor ?? other?.selectedBackgroundBorderColor,
      checkedBackgroundColor: this!.checkedBackgroundColor ?? other?.checkedBackgroundColor,
      checkedBorderColor: this!.checkedBorderColor ?? other?.checkedBorderColor,
    );
  }
}
