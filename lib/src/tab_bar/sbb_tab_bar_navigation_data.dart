import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

/// The data of the current state of the [SBBTabBar]
class SBBTabBarNavigationData {
  const SBBTabBarNavigationData(this.selectedTab, this.nextTab, this.animation, this.hover);

  final SBBTabBarItem selectedTab;
  final SBBTabBarItem nextTab;
  final double animation;
  final bool hover;
}
