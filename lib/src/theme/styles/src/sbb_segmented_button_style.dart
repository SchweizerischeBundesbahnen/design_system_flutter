// import 'package:flutter/material.dart';
// import 'package:sbb_design_system_mobile/src/theme/styles/src/sbb_segmented_button_inner_style.dart';
//
// import '../../theme.dart';
//
// class SBBSegmentedButtonStyle {
//   SBBSegmentedButtonStyle({this.defaultStyle, this.selectedStyle});
//
//   factory SBBSegmentedButtonStyle.$default({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonStyle(
//     defaultStyle: SBBSegmentedButtonInnerStyle.$default(baseStyle: baseStyle),
//     selectedStyle: SBBSegmentedButtonInnerStyle.selected(baseStyle: baseStyle),
//   );
//
//   factory SBBSegmentedButtonStyle.red({required SBBBaseStyle baseStyle}) => SBBSegmentedButtonStyle(
//     defaultStyle: SBBSegmentedButtonInnerStyle.red(baseStyle: baseStyle),
//     selectedStyle: SBBSegmentedButtonInnerStyle.redSelected(baseStyle: baseStyle),
//   );
//
//   final SBBSegmentedButtonInnerStyle? defaultStyle;
//   final SBBSegmentedButtonInnerStyle? selectedStyle;
//
//   SBBSegmentedButtonStyle copyWith({
//     SBBSegmentedButtonInnerStyle? defaultStyle,
//     SBBSegmentedButtonInnerStyle? selectedStyle,
//     Color? iconColor,
//   }) => SBBSegmentedButtonStyle(
//     defaultStyle: defaultStyle ?? this.defaultStyle,
//     selectedStyle: selectedStyle ?? this.selectedStyle,
//   );
//
//   SBBSegmentedButtonStyle lerp(SBBSegmentedButtonStyle? other, double t) => SBBSegmentedButtonStyle(
//     defaultStyle: defaultStyle?.lerp(other?.defaultStyle, t),
//     selectedStyle: selectedStyle?.lerp(other?.selectedStyle, t),
//   );
// }
//
// extension SBBSegmentedButtonStyleExtension on SBBSegmentedButtonStyle? {
//   SBBSegmentedButtonStyle merge(SBBSegmentedButtonStyle? other) {
//     if (this == null) return other ?? SBBSegmentedButtonStyle();
//     return this!.copyWith(
//       defaultStyle: this!.defaultStyle.merge(other?.defaultStyle),
//       selectedStyle: this!.selectedStyle.merge(other?.selectedStyle),
//     );
//   }
//
//   TextStyle? getTextStyle(bool selected) => (selected ? this?.selectedStyle : this?.defaultStyle)?.textStyle;
//
//   Color? getIconColor(bool selected) => (selected ? this?.selectedStyle : this?.defaultStyle)?.iconColor;
// }
