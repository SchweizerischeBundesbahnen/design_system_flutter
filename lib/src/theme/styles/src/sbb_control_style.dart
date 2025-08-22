import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBControlStyle {
  SBBControlStyle({
    this.color,
    this.colorDisabled,
    this.basic,
    this.listItem,
  });

  factory SBBControlStyle.$default({required SBBBaseStyle baseStyle}) => SBBControlStyle(
    color: baseStyle.primaryColor,
    colorDisabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
    basic: SBBBasicControlStyle.$default(baseStyle: baseStyle),
    listItem: SBBListItemStyle.$default(baseStyle: baseStyle),
  );

  final Color? color;
  final Color? colorDisabled;
  final SBBBasicControlStyle? basic;
  final SBBListItemStyle? listItem;

  SBBControlStyle copyWith({
    Color? color,
    Color? colorDisabled,
    SBBBasicControlStyle? basic,
    SBBListItemStyle? listItem,
  }) => SBBControlStyle(
    color: color ?? this.color,
    colorDisabled: colorDisabled ?? this.colorDisabled,
    basic: basic ?? this.basic,
    listItem: listItem ?? this.listItem,
  );

  SBBControlStyle lerp(SBBControlStyle? other, double t) => SBBControlStyle(
    color: Color.lerp(color, other?.color, t),
    colorDisabled: Color.lerp(colorDisabled, other?.colorDisabled, t),
    basic: basic?.lerp(other?.basic, t),
    listItem: listItem?.lerp(other?.listItem, t),
  );
}

extension SBBControlStyleExtension on SBBControlStyle? {
  SBBControlStyle merge(SBBControlStyle? other) {
    if (this == null) return other ?? SBBControlStyle();
    return this!.copyWith(
      color: this!.color ?? other?.color,
      colorDisabled: this!.colorDisabled ?? other?.colorDisabled,
      basic: this!.basic.merge(other?.basic),
      listItem: this!.listItem.merge(other?.listItem),
    );
  }
}
