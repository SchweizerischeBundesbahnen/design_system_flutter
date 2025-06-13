import 'dart:ui';

import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';

import '../../sbb_design_system_mobile.dart';

/// Represents the positions of a [SBBTabBarItem] in [SBBTabBar]
class SBBTabBarLayoutData {
  SBBTabBarLayoutData(
    this.height,
    this.positions,
  );

  final double height;
  final List<Offset> positions;

  List<TabCurves> curves(bool portrait) {
    final diameter = portrait ? 44.0 : 36.0;
    final radius = diameter / 2.0;
    return positions.map((p) {
      return TabCurves(
        midX: p.dx + radius + 4.0,
        waveRadius: radius + (portrait ? 8.0 : 2.0),
      );
    }).toList();
  }
}
