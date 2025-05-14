import 'dart:ui';

import '../../sbb_design_system_mobile.dart';

/// The data of the current state of the [SBBTabBar]
class TabBarLayoutData {
  const TabBarLayoutData(
    this.height,
    this.positions,
  );

  final double height;
  final List<Offset> positions;
}
