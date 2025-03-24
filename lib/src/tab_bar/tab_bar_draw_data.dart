import 'dart:ui';

import 'package:collection/collection.dart';

import 'tab_bar_item.dart';

class TabBarDrawData {
  TabBarDrawData(this.positions, this.sizes);

  factory TabBarDrawData.empty(List<TabBarItem> items) => TabBarDrawData(
        Map.fromIterable(items, value: (_) => 0.0),
        Map.fromIterable(items, value: (_) => Size.zero),
      );

  final Map<TabBarItem, double> positions;
  final Map<TabBarItem, Size> sizes;

  @override
  bool operator ==(Object other) {
    if (other is TabBarDrawData) {
      const mapEquality = MapEquality();
      return mapEquality.equals(positions, other.positions) && mapEquality.equals(sizes, other.sizes);
    }
    return false;
  }

  @override
  int get hashCode => positions.hashCode ^ sizes.hashCode;
}
