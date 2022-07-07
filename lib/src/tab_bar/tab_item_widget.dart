import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
    this.icon,
    this.selected, {
    Key? key,
    this.warning = false,
  }) : super(key: key);

  factory TabItemWidget.fromTabBarItem(
    TabBarItem item,
    bool selected,
  ) =>
      TabItemWidget(
        item.icon,
        selected,
      );

  factory TabItemWidget.warning() => TabItemWidget(
        SBBIcons.sign_exclamation_point_small,
        false,
        warning: true,
      );

  static const portraitSize = 44.0;
  static const landscapeSize = 36.0;

  final IconData icon;
  final bool selected;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final isDark = SBBTheme.of(context).isDark;
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = portrait ? portraitSize : landscapeSize;

    final foregroundColor = isDark ? SBBColors.black : SBBColors.white;
    final backgroundColor = isDark ? SBBColors.white : SBBColors.black;
    Color iconColor = selected ? foregroundColor : backgroundColor;

    BoxDecoration? decoration;
    Color? containerColor = SBBColors.transparent;

    if (warning) {
      decoration = BoxDecoration(
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

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Icon(
        icon,
        color: iconColor,
      ),
      color: containerColor,
      decoration: decoration,
    );
  }
}
