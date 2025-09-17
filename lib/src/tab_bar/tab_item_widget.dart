import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
    this.icon, {
    required this.interactions,
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
  final TabItemInteractions interactions;
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

    Color color = SBBColors.transparent;
    IconData resolvedIcon = icon;

    if (warning != null && !warning!.shown) {
      color = SBBColors.red;
      iconColor = SBBColors.white;
      resolvedIcon = SBBIcons.sign_exclamation_point_small;
    } else if (selected) {
      color = backgroundColor;
    }

    return ExcludeSemantics(
      excluding: selected,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, left: horizontalCirclePadding, right: horizontalCirclePadding),
        child: SizedBox.square(
          dimension: size,
          child: InkResponse(
            focusNode: interactions.focusNode,
            onTap: interactions.onTap,
            onTapDown: (_) => interactions.onTapDown(),
            onTapCancel: interactions.onTapCancel,
            radius: size / 2.0 + 4.0,
            onFocusChange: (f) {
              if (f) interactions.onTapDown();
            },
            child: Material(shape: const CircleBorder(), color: color, child: Icon(resolvedIcon, color: iconColor)),
          ),
        ),
      ),
    );
  }
}
