import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBPopoverStyle extends ThemeExtension<SBBPopoverStyle> {
  SBBPopoverStyle({
    this.popoverColor,
    this.modalBarrierColor,
    this.popoverClipBehavior,
  });

  factory SBBPopoverStyle.$default({required SBBBaseStyle baseStyle}) => SBBPopoverStyle(
    popoverColor: baseStyle.backgroundColor,
    modalBarrierColor: SBBColors.black.withValues(alpha: .6),
    popoverClipBehavior: Clip.hardEdge,
  );

  static SBBPopoverStyle of(BuildContext context) => Theme.of(context).extension<SBBPopoverStyle>()!;

  final Color? popoverColor;
  final Color? modalBarrierColor;
  final Clip? popoverClipBehavior;

  @override
  SBBPopoverStyle copyWith({
    Color? popoverColor,
    Color? modalBarrierColor,
    Clip? popoverClipBehavior,
  }) => SBBPopoverStyle(
    popoverColor: popoverColor ?? this.popoverColor,
    modalBarrierColor: modalBarrierColor ?? this.modalBarrierColor,
    popoverClipBehavior: popoverClipBehavior ?? this.popoverClipBehavior,
  );

  @override
  SBBPopoverStyle lerp(ThemeExtension<SBBPopoverStyle>? other, double t) {
    if (other is! SBBPopoverStyle) return this;
    return SBBPopoverStyle(
      popoverColor: Color.lerp(popoverColor, other.popoverColor, t),
      modalBarrierColor: Color.lerp(modalBarrierColor, other.modalBarrierColor, t),
      popoverClipBehavior: t < 0.5 ? popoverClipBehavior : other.popoverClipBehavior,
    );
  }
}

extension SBBPopoverStyleExtension on SBBPopoverStyle? {
  SBBPopoverStyle merge(SBBPopoverStyle? other) {
    if (this == null) return other ?? SBBPopoverStyle();
    return this!.copyWith(
      popoverColor: this!.popoverColor ?? other?.popoverColor,
      modalBarrierColor: this!.modalBarrierColor ?? other?.modalBarrierColor,
      popoverClipBehavior: this!.popoverClipBehavior ?? other?.popoverClipBehavior,
    );
  }
}
