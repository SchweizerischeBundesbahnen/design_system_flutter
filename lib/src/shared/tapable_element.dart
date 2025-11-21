import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class TapableElement extends StatelessWidget {
  factory TapableElement.roundedBox({Key? key, GestureTapCallback? onTap, Color? color, Widget? child}) {
    return TapableElement(
      key: key,
      customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
      onTap: onTap,
      color: color,
      child: child,
    );
  }

  factory TapableElement.circle({Key? key, GestureTapCallback? onTap, Color? color, Widget? child}) => TapableElement(
    key: key,
    customBorder: const CircleBorder(),
    onTap: onTap,
    color: color,
    child: child,
  );

  const TapableElement({super.key, this.customBorder, this.onTap, this.color, this.child});

  final ShapeBorder? customBorder;
  final GestureTapCallback? onTap;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // TODO: replace this with color in each Widget
    final color = Theme.of(context).iconTheme.color;
    return Material(
      color: color ?? SBBColors.transparent,
      shape: customBorder,
      child: InkWell(
        focusColor: color,
        hoverColor: color,
        customBorder: customBorder,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
