import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class TabItemWidget extends StatelessWidget implements PreferredSizeWidget {
  const TabItemWidget(
    this.size,
    this.icon,
    this.selected, {
    super.key,
    this.warning = false,
  });

  factory TabItemWidget.fromTabBarItem(
    TabBarItem item,
    Size? size,
    bool selected,
  ) =>
      TabItemWidget(
        size,
        item.icon,
        selected,
      );

  // factory TabItemWidget.warning() => const TabItemWidget(
  //       SBBIcons.sign_exclamation_point_small,
  //       false,
  //       warning: true,
  //     );

  static const portraitSize = Size(44.0, 44.0);
  static const landscapeSize = Size(36.0, 36.0);

  final Size? size;
  final IconData icon;
  final bool selected;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final resolvedSize = size ?? (portrait ? portraitSize : landscapeSize);

    final foregroundColor = style.themeValue(SBBColors.white, SBBColors.black);
    final backgroundColor = style.themeValue(SBBColors.black, SBBColors.white);
    Color iconColor = selected ? foregroundColor : backgroundColor;

    BoxDecoration? decoration;
    Color? containerColor = SBBColors.transparent;

    if (warning) {
      decoration = const BoxDecoration(
        color: SBBColors.red,
        shape: BoxShape.circle,
      );
      containerColor = null;
      iconColor = SBBColors.white;
    } else if (selected) {
      decoration = BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      );
      containerColor = null;
    }

    final iconWidget = Icon(icon, color: iconColor);
    Widget child = warning
        ? Padding(
            padding: const EdgeInsets.only(left: 1.0, bottom: 4.0),
            child: iconWidget,
          )
        : iconWidget;

    return Container(
      width: resolvedSize.width,
      height: resolvedSize.height,
      margin: const EdgeInsets.only(bottom: 8.0),
      color: containerColor,
      decoration: decoration,
      child: child,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(44.0, 44.0);
}
