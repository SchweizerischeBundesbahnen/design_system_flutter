import 'dart:ui';

import 'package:collection/collection.dart';

/// Holds data relevant for layouting the SBBTabBar.
final class TabBarLayout {
  TabBarLayout({
    required this.outerPositions,
    required this.numTabs,
    required this.radius,
    required this.spacing,
    required this.isTightLayout,
  }) : assert(outerPositions.length == numTabs, 'TabBarLayout: Mismatch between numTabs and positions.');

  /// The positions of the TabBar Icon Items (topLeft position).
  final List<Offset> outerPositions;

  /// The radius of the TabBar Icon Item.
  final double radius;

  /// The spacing between the TabBar Icon Item and its cutout from the filler.
  final double spacing;

  /// The number of tabs. Must be equal to [outerPositions.length].
  final int numTabs;

  /// Tight layout is needed, when the TabBar Items touch each other.
  ///
  /// For portrait: if availableWidth / ([outerRadius] + 2 * [outerRadius] * [numTabs]) <= 1.0
  final bool isTightLayout;

  /// The [radius] and the [spacing] added.
  double get outerRadius => radius + spacing;

  @override
  bool operator ==(Object other) =>
      other is TabBarLayout &&
      other.runtimeType == runtimeType &&
      ListEquality().equals(other.outerPositions, outerPositions) &&
      other.numTabs == numTabs &&
      other.isTightLayout == isTightLayout;

  @override
  int get hashCode => Object.hash(outerPositions, numTabs, isTightLayout);
}
