import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
    this.icon, {
    required this.interactions,
    super.key,
    this.selected = false,
    this.warning,
    this.badge,
    this.style,
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
  final SBBTabBarItemBadge? badge;

  /// Style to use for this item. If null, resolves from [SBBTabBarThemeData].
  final SBBTabBarStyle? style;

  @override
  Widget build(BuildContext context) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = portrait ? portraitSize : landscapeSize;
    final topPadding = portrait ? portraitCirclePadding : landscapeCirclePadding;

    final effectiveStyle = style ?? Theme.of(context).sbbTabBarTheme?.style;

    final states = <WidgetState>{
      if (selected) WidgetState.selected,
    };

    final iconColor = effectiveStyle?.iconColor?.resolve(states);
    final itemBgColor = effectiveStyle?.itemBackgroundColor?.resolve(states) ?? SBBColors.transparent;
    final warningIcon = effectiveStyle?.warningItemIcon ?? SBBIcons.sign_exclamation_point_small;
    final warningBgColor = effectiveStyle?.warningItemBackgroundColor ?? SBBColors.red;
    final warningFgColor = effectiveStyle?.warningItemForegroundColor ?? SBBColors.white;

    Color color = SBBColors.transparent;
    IconData resolvedIcon = icon;
    Color resolvedIconColor = iconColor ?? SBBColors.transparent;

    if (warning != null && !warning!.shown) {
      color = warningBgColor;
      resolvedIconColor = warningFgColor;
      resolvedIcon = warningIcon;
    } else if (selected) {
      color = itemBgColor;
    }

    Widget child = SizedBox.square(
      dimension: size,
      child: InkResponse(
        splashFactory: NoSplash.splashFactory,
        focusNode: interactions.focusNode,
        onTap: interactions.onTap,
        onTapDown: (_) => interactions.onTapDown(),
        onTapCancel: interactions.onTapCancel,
        radius: size / 2.0 + 4.0,
        onFocusChange: (f) {
          if (f) interactions.onTapDown();
        },
        child: Material(
          shape: const CircleBorder(),
          color: color,
          child: Icon(resolvedIcon, color: resolvedIconColor),
        ),
      ),
    );

    if (_shouldShowBadge) {
      child = Stack(
        clipBehavior: .none,
        children: [
          child,
          Positioned(
            top: badge!.offset.dy,
            right: badge!.offset.dx,
            child: IgnorePointer(child: badge!.badge),
          ),
        ],
      );
    }

    return ExcludeSemantics(
      excluding: selected,
      child: Padding(
        padding: .only(
          top: topPadding,
          left: horizontalCirclePadding,
          right: horizontalCirclePadding,
        ),
        child: child,
      ),
    );
  }

  bool get _shouldShowBadge {
    if (badge == null) return false;
    return switch (badge!.displayMode) {
      SBBTabBarItemBadgeDisplayMode.always => true,
      SBBTabBarItemBadgeDisplayMode.whenSelected => selected,
      SBBTabBarItemBadgeDisplayMode.whenUnselected => !selected,
    };
  }
}
