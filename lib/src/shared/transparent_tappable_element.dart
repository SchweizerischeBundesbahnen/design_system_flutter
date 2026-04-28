import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

// TODO: replace this element with separate implementations
class TransparentTappableElement extends StatelessWidget {
  factory TransparentTappableElement.roundedBox({Key? key, GestureTapCallback? onTap, Widget? child}) {
    return TransparentTappableElement(
      key: key,
      customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SBBSpacing.medium))),
      onTap: onTap,
      child: child,
    );
  }

  factory TransparentTappableElement.circle({Key? key, GestureTapCallback? onTap, Widget? child}) =>
      TransparentTappableElement(
        key: key,
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: child,
      );

  const TransparentTappableElement({super.key, this.customBorder, this.onTap, this.child});

  final ShapeBorder? customBorder;
  final GestureTapCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).sbbBaseStyle;
    final highlightedColor = baseStyle.themeValue(SBBColors.milk, SBBColors.iron);
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
