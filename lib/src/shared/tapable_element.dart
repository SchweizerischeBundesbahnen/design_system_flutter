import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class TapableElement extends StatelessWidget {
  factory TapableElement.roundedBox({
    Key? key,
    GestureTapCallback? onTap,
    Widget? child,
  }) {
    return TapableElement(
      key: key,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(sbbDefaultSpacing),
        ),
      ),
      onTap: onTap,
      child: child,
    );
  }

  factory TapableElement.circle({
    Key? key,
    GestureTapCallback? onTap,
    Widget? child,
  }) {
    return TapableElement(
      key: key,
      customBorder: CircleBorder(),
      onTap: onTap,
      child: child,
    );
  }

  const TapableElement({
    super.key,
    this.customBorder,
    this.onTap,
    this.child,
  });

  final ShapeBorder? customBorder;
  final GestureTapCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final iconStyle = SBBButtonStyles.of(context).iconTextStyle;
    return Material(
      color: SBBColors.transparent,
      child: InkWell(
        focusColor: iconStyle?.backgroundColorHighlighted,
        hoverColor: iconStyle?.backgroundColorHighlighted,
        customBorder: customBorder,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
