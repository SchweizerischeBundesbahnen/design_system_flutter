import 'package:flutter/widgets.dart';

/// Display mode options for the tab bar item badge.
enum SBBTabBarItemBadgeDisplayMode {
  /// Badge is always displayed, regardless of tab selection state.
  always,

  /// Badge is only displayed when the associated tab is selected.
  whenSelected,

  /// Badge is only displayed when the associated tab is not selected.
  whenUnselected,
}

/// A small badge widget displayed in the top-right corner of a tab bar item.
///
/// The badge is positioned relative to the tab item and can be configured to
/// display conditionally based on the tab's selection state.
///
/// The [id] must match the [id] of the corresponding [SBBTabBarItem] to ensure
/// the badge is associated with the correct tab.
class SBBTabBarItemBadge {
  const SBBTabBarItemBadge({
    /// Unique identifier that must match the id of the corresponding [SBBTabBarItem].
    required this.id,

    /// The widget to display as the badge content.
    ///
    /// This is typically a [SBBTabBarBadge] widget.
    required this.badge,

    /// Controls when the badge is displayed. Defaults to [SBBTabBarItemBadgeDisplayMode.whenUnselected].
    this.displayMode = SBBTabBarItemBadgeDisplayMode.whenUnselected,

    /// If true, the badge automatically dismisses after the associated tab is selected. Defaults to false.
    ///
    /// This will reset if the [SBBTabBarController.setBadges] method is called again.
    this.autoDismiss = false,

    /// The offset of the badge position relative to the top-right corner. Defaults to [Offset.zero].
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
