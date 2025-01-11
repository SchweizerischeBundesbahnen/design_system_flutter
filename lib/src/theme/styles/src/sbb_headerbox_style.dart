import 'package:flutter/material.dart';

import '../../../../sbb_design_system_mobile.dart';

class SBBHeaderBoxStyle extends ThemeExtension<SBBHeaderBoxStyle> {
  SBBHeaderBoxStyle({
    this.backgroundColor,
    this.flapBackgroundColor,
  });

  factory SBBHeaderBoxStyle.$default({required SBBBaseStyle baseStyle}) => SBBHeaderBoxStyle(
        backgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
        flapBackgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.midnight),
      );

  static SBBHeaderBoxStyle of(BuildContext context) => Theme.of(context).extension<SBBHeaderBoxStyle>()!;

  final Color? backgroundColor;
  final Color? flapBackgroundColor;

  @override
  SBBHeaderBoxStyle copyWith({
    Color? backgroundColor,
    Color? flapBackgroundColor,
  }) =>
      SBBHeaderBoxStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        flapBackgroundColor: flapBackgroundColor ?? this.flapBackgroundColor,
      );

  @override
  SBBHeaderBoxStyle lerp(SBBHeaderBoxStyle? other, double t) => SBBHeaderBoxStyle(
        backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
        flapBackgroundColor: Color.lerp(flapBackgroundColor, other?.flapBackgroundColor, t),
      );
}

extension SBBHeaderBoxStyleExtension on SBBHeaderBoxStyle? {
  SBBHeaderBoxStyle merge(SBBHeaderBoxStyle? other) {
    if (this == null) return other ?? SBBHeaderBoxStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      flapBackgroundColor: this!.flapBackgroundColor ?? other?.flapBackgroundColor,
    );
  }
}
