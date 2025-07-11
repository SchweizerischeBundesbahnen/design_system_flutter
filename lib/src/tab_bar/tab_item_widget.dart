import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
    this.icon, {
    super.key,
    this.selected = false,
    this.warning,
  });

  static const portraitSize = 44.0;
  static const landscapeSize = 36.0;

  static const portraitCirclePadding = 6.0;
  static const landscapeCirclePadding = 2.0;
  static const horizontalCirclePadding = 4.0;

  final IconData icon;
  final bool selected;
  final SBBTabBarWarningSetting? warning;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = portrait ? portraitSize : landscapeSize;
    final topPadding = portrait ? portraitCirclePadding : landscapeCirclePadding;

    final foregroundColor = style.themeValue(SBBColors.white, SBBColors.black);
    final backgroundColor = style.themeValue(SBBColors.black, SBBColors.white);
    Color iconColor = selected ? foregroundColor : backgroundColor;

    BoxDecoration? decoration;
    Color? containerColor = SBBColors.transparent;
    IconData resolvedIcon = icon;

    if (warning != null && !warning!.shown) {
      decoration = const BoxDecoration(
        color: SBBColors.red,
        shape: BoxShape.circle,
      );
      containerColor = null;
      iconColor = SBBColors.white;
      resolvedIcon = SBBIcons.sign_exclamation_point_small;
    } else if (selected) {
      decoration = BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      );
      containerColor = null;
    }

    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.only(top: topPadding, left: horizontalCirclePadding, right: horizontalCirclePadding),
      color: containerColor,
      decoration: decoration,
      child: Icon(resolvedIcon, color: iconColor),
    );
  }
}
