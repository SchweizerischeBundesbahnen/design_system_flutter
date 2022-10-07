import '../../design_system_flutter.dart';

/// The data of the current state of the [SBBTabBar]
class TabBarNavigationData {
  const TabBarNavigationData(
    this.selectedTab,
    this.nextTab,
    this.animation,
    this.hover,
  );

  final TabBarItem selectedTab;
  final TabBarItem nextTab;
  final double animation;
  final bool hover;
}
