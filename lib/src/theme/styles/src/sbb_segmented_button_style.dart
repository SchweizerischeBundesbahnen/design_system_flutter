import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBSegmentedButtonStyle {
  SBBSegmentedButtonStyle({this.defaultStyle, this.selectedStyle, this.iconColor});

  factory SBBSegmentedButtonStyle.$default({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonStyle(
    defaultStyle: SBBSegmentedButtonInnerStyle.$default(baseStyle: baseStyle),
    selectedStyle: SBBSegmentedButtonInnerStyle.selected(baseStyle: baseStyle),
  );

  factory SBBSegmentedButtonStyle.red({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonStyle(
    defaultStyle: SBBSegmentedButtonInnerStyle.red(baseStyle: baseStyle),
    selectedStyle: SBBSegmentedButtonInnerStyle.redSelected(baseStyle: baseStyle),
    iconColor: SBBColors.white,
  );

  final SBBSegmentedButtonInnerStyle? defaultStyle;
  final SBBSegmentedButtonInnerStyle? selectedStyle;
  final Color? iconColor;

  SBBSegmentedButtonStyle copyWith({
    SBBSegmentedButtonInnerStyle? defaultStyle,
    SBBSegmentedButtonInnerStyle? selectedStyle,
    Color? iconColor,
  }) => SBBSegmentedButtonStyle(
    defaultStyle: defaultStyle ?? this.defaultStyle,
    selectedStyle: selectedStyle ?? this.selectedStyle,
    iconColor: iconColor ?? this.iconColor,
  );

  SBBSegmentedButtonStyle lerp(SBBSegmentedButtonStyle? other, double t) => SBBSegmentedButtonStyle(
    defaultStyle: defaultStyle?.lerp(other?.defaultStyle, t),
    selectedStyle: selectedStyle?.lerp(other?.selectedStyle, t),
    iconColor: Color.lerp(iconColor, other?.iconColor, t),
  );
}

extension SBBSegmentedButtonStyleExtension on SBBSegmentedButtonStyle? {
  SBBSegmentedButtonStyle merge(SBBSegmentedButtonStyle? other) {
    if (this == null) return other ?? SBBSegmentedButtonStyle();
    return this!.copyWith(
      defaultStyle: this!.defaultStyle.merge(other?.defaultStyle),
      selectedStyle: this!.selectedStyle.merge(other?.selectedStyle),
      iconColor: this!.iconColor ?? other?.iconColor,
    );
  }

  TextStyle? getTextStyle(bool selected) {
    if (this == null) return null;
    return (selected ? this!.selectedStyle : this!.defaultStyle)?.textStyle;
  }
}
