import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBPaginationStyle {
  SBBPaginationStyle({
    this.selectedColor,
    this.borderColor,
    this.floatingBackgroundColor,
  });

  factory SBBPaginationStyle.$default({required SBBBaseStyle baseStyle}) {
    final isLightTheme = baseStyle.brightness == Brightness.light;
    return SBBPaginationStyle(
      selectedColor: isLightTheme ? baseStyle.primaryColor : SBBColors.white,
      borderColor: isLightTheme ? SBBColors.metal : SBBColors.graphite,
      floatingBackgroundColor: isLightTheme ? SBBColors.milk : SBBColors.iron,
    );
  }

  final Color? selectedColor;
  final Color? borderColor;
  final Color? floatingBackgroundColor;

  SBBPaginationStyle copyWith({
    Color? selectedColor,
    Color? borderColor,
    Color? floatingBackgroundColor,
  }) =>
      SBBPaginationStyle(
        selectedColor: selectedColor ?? this.selectedColor,
        borderColor: borderColor ?? this.borderColor,
        floatingBackgroundColor:
            floatingBackgroundColor ?? this.floatingBackgroundColor,
      );

  SBBPaginationStyle lerp(SBBPaginationStyle? other, double t) =>
      SBBPaginationStyle(
        selectedColor: Color.lerp(selectedColor, other?.selectedColor, t),
        borderColor: Color.lerp(borderColor, other?.borderColor, t),
        floatingBackgroundColor: Color.lerp(
            floatingBackgroundColor, other?.floatingBackgroundColor, t),
      );
}

extension SBBPaginationStyleExtension on SBBPaginationStyle? {
  SBBPaginationStyle merge(SBBPaginationStyle? other) {
    if (this == null) return other ?? SBBPaginationStyle();
    return this!.copyWith(
      selectedColor: this!.selectedColor ?? other?.selectedColor,
      borderColor: this!.borderColor ?? other?.borderColor,
      floatingBackgroundColor:
          this!.floatingBackgroundColor ?? other?.floatingBackgroundColor,
    );
  }
}
