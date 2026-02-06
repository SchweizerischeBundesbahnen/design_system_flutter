import 'package:flutter/widgets.dart';

enum SBBTabBarItemBadgeDisplayMode {
  always,
  whenSelected,
  whenUnselected,
}

class SBBTabBarItemBadge {
  const SBBTabBarItemBadge({
    required this.id,
    required this.badge,
    this.displayMode = SBBTabBarItemBadgeDisplayMode.whenUnselected,
    this.autoDismiss = false,
    this.offset = Offset.zero,
  });

  @override
  String toString() {
    return 'SBBTabBarItemBadge{id: $id'
        ', displayMode: $displayMode'
        ', autoDismiss: $autoDismiss'
        ', badge: $badge'
        ', offset: $offset'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBTabBarItemBadge &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayMode == other.displayMode &&
          autoDismiss == other.autoDismiss &&
          badge == other.badge &&
          offset == other.offset;

  @override
  int get hashCode => Object.hash(id, displayMode, autoDismiss, badge, offset);
  final String id;
  final SBBTabBarItemBadgeDisplayMode displayMode;
  final bool autoDismiss;
  final Widget badge;
  final Offset offset;
}
