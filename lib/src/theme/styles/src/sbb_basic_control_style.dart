import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBBasicControlStyle {
  SBBBasicControlStyle({
    this.backgroundColor,
    this.backgroundColorHighlighted,
    this.backgroundColorDisabled,
    this.borderColor,
    this.borderColorDisabled,
  });

  factory SBBBasicControlStyle.$default({required SBBBaseStyle baseStyle}) =>
      SBBBasicControlStyle(
        backgroundColor: SBBColors.transparent,
        backgroundColorHighlighted: SBBColors.transparent,
        backgroundColorDisabled: SBBColors.transparent,
        borderColor: baseStyle.themeValue(SBBColors.granite, SBBColors.cement),
        borderColorDisabled: baseStyle.themeValue(
          SBBColors.cloud,
          SBBColors.iron,
        ),
      );

  final Color? backgroundColor;
  final Color? backgroundColorHighlighted;
  final Color? backgroundColorDisabled;
  final Color? borderColor;
  final Color? borderColorDisabled;

  SBBBasicControlStyle copyWith({
    Color? backgroundColor,
    Color? backgroundColorHighlighted,
    Color? backgroundColorDisabled,
    Color? borderColor,
    Color? borderColorDisabled,
  }) => SBBBasicControlStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    backgroundColorHighlighted:
        backgroundColorHighlighted ?? this.backgroundColorHighlighted,
    backgroundColorDisabled:
        backgroundColorDisabled ?? this.backgroundColorDisabled,
    borderColor: borderColor ?? this.borderColor,
    borderColorDisabled: borderColorDisabled ?? this.borderColorDisabled,
  );

  SBBBasicControlStyle lerp(
    SBBBasicControlStyle? other,
    double t,
  ) => SBBBasicControlStyle(
    backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t)!,
    backgroundColorHighlighted: Color.lerp(
      backgroundColorHighlighted,
      other?.backgroundColorHighlighted,
      t,
    ),
    backgroundColorDisabled:
        Color.lerp(backgroundColorDisabled, other?.backgroundColorDisabled, t)!,
    borderColor: Color.lerp(borderColor, other?.borderColor, t)!,
    borderColorDisabled:
        Color.lerp(borderColorDisabled, other?.borderColorDisabled, t)!,
  );
}

extension SBBBasicControlStyleExtension on SBBBasicControlStyle? {
  SBBBasicControlStyle merge(SBBBasicControlStyle? other) {
    if (this == null) return other ?? SBBBasicControlStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      backgroundColorHighlighted:
          this!.backgroundColorHighlighted ?? other?.backgroundColorHighlighted,
      backgroundColorDisabled:
          this!.backgroundColorDisabled ?? other?.backgroundColorDisabled,
      borderColor: this!.borderColor ?? other?.borderColor,
      borderColorDisabled:
          this!.borderColorDisabled ?? other?.borderColorDisabled,
    );
  }
}
