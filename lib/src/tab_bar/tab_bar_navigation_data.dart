import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';

/// The data of the current state of the [SbbTabBar]
class TabBarNavigationData {
  const TabBarNavigationData(this.currentPage, this.previousPage, this.selectedTab);

  factory TabBarNavigationData.simple(List<TabBarItem> items, TabBarItem selectedTab) {
    final page = items.indexOf(selectedTab).toDouble();
    return TabBarNavigationData(page, page, selectedTab);
  }

  /// Either the currently visible Tab or the current page scroll state if used together with a [PageView]
  final double currentPage;
  /// Either the currently visible Tab or the current page scroll state if used together with a [PageView]
  final double previousPage;
  final TabBarItem selectedTab;
}
