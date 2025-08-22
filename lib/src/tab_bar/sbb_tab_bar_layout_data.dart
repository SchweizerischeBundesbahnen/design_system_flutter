import 'dart:ui';

import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_item_widget.dart';

import '../../sbb_design_system_mobile.dart';

/// Represents the positions of a [SBBTabBarItem] in [SBBTabBar]
class SBBTabBarLayoutData {
  SBBTabBarLayoutData(this.height, this.positions);

  final double height;
  final List<Offset> positions;

  List<TabCurves> curves(bool portrait) {
    final diameter = portrait ? TabItemWidget.portraitSize : TabItemWidget.landscapeSize;
    final radius = diameter / 2.0;
    return positions.map((p) {
      return TabCurves(
        midX: p.dx + radius + 4.0,
        waveRadius: radius + (portrait ? TabItemWidget.portraitCirclePadding : TabItemWidget.landscapeCirclePadding),
      );
    }).toList();
  }
}
