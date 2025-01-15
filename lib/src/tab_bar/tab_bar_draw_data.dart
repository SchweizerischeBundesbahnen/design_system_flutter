import 'dart:ui';

import 'package:collection/collection.dart';

import 'tab_bar_item.dart';

class TabBarDrawData {
  TabBarDrawData(this.positions, this.sizes, this.paddingBetween);

  factory TabBarDrawData.empty(List<TabBarItem> items) => TabBarDrawData(
        Map.fromIterable(items, value: (_) => 0.0),
        Map.fromIterable(items, value: (_) => Size.zero),
        0,
      );

  final Map<TabBarItem, double> positions;
  final Map<TabBarItem, Size> sizes;
  final double paddingBetween;

  @override
  bool operator ==(Object other) {
    if (other is TabBarDrawData) {
      const mapEquality = MapEquality();
      return mapEquality.equals(positions, other.positions) &&
          mapEquality.equals(sizes, other.sizes) &&
          paddingBetween == paddingBetween;
    }
    return false;
  }

  @override
  int get hashCode => positions.hashCode ^ sizes.hashCode ^ paddingBetween.hashCode;
}
