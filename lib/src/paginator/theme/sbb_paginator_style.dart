import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SBBPaginatorStyle {
  SBBPaginatorStyle({this.selectedColor, this.borderColor, this.floatingBackgroundColor});

  factory SBBPaginatorStyle.$default({required SBBBaseStyle baseStyle}) {
    final isLightTheme = baseStyle.brightness == Brightness.light;
    return SBBPaginatorStyle(
      selectedColor: isLightTheme ? baseStyle.primaryColor : SBBColors.white,
      borderColor: isLightTheme ? SBBColors.metal : SBBColors.graphite,
      floatingBackgroundColor: isLightTheme ? SBBColors.milk : SBBColors.iron,
    );
  }

  final Color? selectedColor;
  final Color? borderColor;
  final Color? floatingBackgroundColor;

  SBBPaginatorStyle copyWith({
    Color? selectedColor,
    Color? borderColor,
    Color? floatingBackgroundColor,
  }) => SBBPaginatorStyle(
    selectedColor: selectedColor ?? this.selectedColor,
    borderColor: borderColor ?? this.borderColor,
    floatingBackgroundColor: floatingBackgroundColor ?? this.floatingBackgroundColor,
  );

  SBBPaginatorStyle lerp(SBBPaginatorStyle? other, double t) => SBBPaginatorStyle(
    selectedColor: Color.lerp(selectedColor, other?.selectedColor, t),
    borderColor: Color.lerp(borderColor, other?.borderColor, t),
    floatingBackgroundColor: Color.lerp(floatingBackgroundColor, other?.floatingBackgroundColor, t),
  );
}

extension SBBPaginatorStyleExtension on SBBPaginatorStyle? {
  SBBPaginatorStyle merge(SBBPaginatorStyle? other) {
    if (this == null) return other ?? SBBPaginatorStyle();
    return this!.copyWith(
      selectedColor: this!.selectedColor ?? other?.selectedColor,
      borderColor: this!.borderColor ?? other?.borderColor,
      floatingBackgroundColor: this!.floatingBackgroundColor ?? other?.floatingBackgroundColor,
    );
  }
}
