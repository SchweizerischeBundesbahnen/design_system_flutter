import 'dart:math';

/// Holds all data relevant to animating the TabBar.
class TabBarAnimation {
  const TabBarAnimation({
    required this.previousPercentage,
    required this.percentage,
    required this.index,
    required this.previousIndex,
    required this.isChanging,
  });

  final double previousPercentage;
  final double percentage;
  final int index;
  final int previousIndex;
  final bool isChanging;

  /// In LTR direction, the index of the left 'Hole'
  int get leftIndex => min(index, previousIndex);

  /// In LTR direction, the index of the right 'Hole'
  int get rightIndex => max(index, previousIndex);

  /// In LTR direction, the animated percentage of the left 'Hole'
  double get leftPercentage => index < previousIndex ? percentage : previousPercentage;

  /// In LTR direction, the animated percentage of the right 'Hole'
  double get rightPercentage => index < previousIndex ? previousPercentage : percentage;

  @override
  bool operator ==(Object other) =>
      other is TabBarAnimation &&
      other.runtimeType == runtimeType &&
      other.percentage == percentage &&
      other.previousPercentage == previousPercentage &&
      other.index == index &&
      other.previousIndex == previousIndex &&
      other.isChanging == isChanging;

  @override
  int get hashCode => Object.hash(previousPercentage, percentage, index, previousIndex, isChanging);
}
