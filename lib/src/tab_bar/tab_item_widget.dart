import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(this.tab, this.selected, {Key? key}) : super(key: key);

  static const portraitSize = 44.0;
  static const landscapeSize = 36.0;

  final TabBarItem tab;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final isDark = SBBTheme.of(context).isDark;
    final foregroundColor = isDark ? SBBColors.black : SBBColors.white;
    final backgroundColor = isDark ? SBBColors.white : SBBColors.black;
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = portrait ? portraitSize : landscapeSize;

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Center(
        child: Icon(
          tab.icon,
          color: selected ? foregroundColor : backgroundColor,
        ),
      ),
      color: selected ? null : SBBColors.transparent,
      decoration: selected
          ? BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            )
          : null,
    );
  }
}
