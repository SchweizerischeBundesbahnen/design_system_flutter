import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyle {
  SBBControlStyle({this.color, this.colorDisabled, this.basic});

  factory SBBControlStyle.$default({required SBBBaseStyle baseStyle}) => SBBControlStyle(
    color: baseStyle.primaryColor,
    colorDisabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
    basic: SBBBasicControlStyle.$default(baseStyle: baseStyle),
  );

  final Color? color;
  final Color? colorDisabled;
  final SBBBasicControlStyle? basic;

  SBBControlStyle copyWith({
    Color? color,
    Color? colorDisabled,
    SBBBasicControlStyle? basic,
  }) => SBBControlStyle(
    color: color ?? this.color,
    colorDisabled: colorDisabled ?? this.colorDisabled,
    basic: basic ?? this.basic,
  );

  SBBControlStyle lerp(SBBControlStyle? other, double t) => SBBControlStyle(
    color: Color.lerp(color, other?.color, t),
    colorDisabled: Color.lerp(colorDisabled, other?.colorDisabled, t),
    basic: basic?.lerp(other?.basic, t),
  );
}

extension SBBControlStyleExtension on SBBControlStyle? {
  SBBControlStyle merge(SBBControlStyle? other) {
    if (this == null) return other ?? SBBControlStyle();
    return this!.copyWith(
      color: this!.color ?? other?.color,
      colorDisabled: this!.colorDisabled ?? other?.colorDisabled,
      basic: this!.basic.merge(other?.basic),
    );
  }
}
