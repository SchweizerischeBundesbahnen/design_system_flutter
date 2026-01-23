import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// TODO: replace this element with separate implementations
class TransparentTapableElement extends StatelessWidget {
  factory TransparentTapableElement.roundedBox({Key? key, GestureTapCallback? onTap, Widget? child}) {
    return TransparentTapableElement(
      key: key,
      customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
      onTap: onTap,
      child: child,
    );
  }

  factory TransparentTapableElement.circle({Key? key, GestureTapCallback? onTap, Widget? child}) =>
      TransparentTapableElement(
        key: key,
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: child,
      );

  const TransparentTapableElement({super.key, this.customBorder, this.onTap, this.child});

  final ShapeBorder? customBorder;
  final GestureTapCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).extension<SBBBaseStyle>();
    final highlightedColor = baseStyle?.themeValue(SBBColors.milk, SBBColors.iron);
    return Material(
      color: SBBColors.transparent,
      shape: customBorder,
      child: InkWell(
        focusColor: highlightedColor,
        hoverColor: highlightedColor,
        customBorder: customBorder,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
