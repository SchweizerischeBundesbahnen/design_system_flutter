import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/common/tab_bar_layout.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_item_widget.dart';

const _maxSpacing = 6.0;
const _radiusSpacingRatio = _maxSpacing / 22.0;
const _tightLayoutMinRatio = 0.63;
const _wideLayoutMinRatio = 0.80;

class TabBarLayouter {
  // _radius = (portrait ? 44.0 : 36.0) / 2.0 {
  // final space = portrait ? 6.0 : 2.0;
  static TabBarLayout calculateLayout(BoxConstraints constraints, int numTabs) {
    final isTightLayout = _isTightLayout(constraints, numTabs, 22.0 + 6.0);
    final innerRadius = _calculateRadius(constraints, numTabs, isTightLayout);
    final spacing = _calculateSpacing(innerRadius);
    final outerRadius = innerRadius + spacing;
    final positions = _calculatePositions(constraints, numTabs, outerRadius);

    return TabBarLayout(
      outerPositions: positions,
      numTabs: numTabs,
      radius: innerRadius,
      spacing: spacing,
      isTightLayout: isTightLayout,
    );
  }

  static List<Offset> _calculatePositions(BoxConstraints constraints, int numTabs, double outerRadius) {
    final singleWidth = (constraints.maxWidth) / numTabs;
    final List<Offset> result = [];
    for (int i = 0; i < numTabs; i++) {
      result.add(Offset((singleWidth / 2 - outerRadius) + i * singleWidth, 0.0));
    }
    return result;
  }

  static double _calculateRadius(BoxConstraints constraints, int numTabs, bool isTightLayout) {
    if (!isTightLayout) return 22.0;
    final theoreticalRadius = (constraints.maxWidth - _tightLayoutMinRatio * numTabs) /
        (4 * _tightLayoutMinRatio * numTabs * (1 + _radiusSpacingRatio));
    return min(theoreticalRadius, 22.0);
    // return theoreticalRadius;
  }

  static bool _isTightLayout(BoxConstraints constraints, int numTabs, double outerRadius) {
    return ((constraints.maxWidth) / ((4 * outerRadius) * numTabs)) <= _wideLayoutMinRatio;
  }

  static List<Offset> _calculateTightPositions(Size size, int numTabs, double outerRadius) {
    return [];
  }

  static _calculateSpacing(double innerRadius) {
    final spacingRatio = _maxSpacing / (TabItemWidget.portraitSize.width / 2);
    return spacingRatio * innerRadius;
  }
}
