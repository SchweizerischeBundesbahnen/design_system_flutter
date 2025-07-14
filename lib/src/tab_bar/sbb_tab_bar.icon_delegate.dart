part of 'sbb_tab_bar.dart';

class _TabIconDelegate extends MultiChildLayoutDelegate {
  _TabIconDelegate(
    this.items,
    this.selectedTab,
    this.portrait,
    this.onPositioned,
    this.gestureInsets,
  );

  final List<SBBTabBarItem> items;
  final SBBTabBarItem selectedTab;
  final bool portrait;
  final Function(List<Offset> positions, double height) onPositioned;
  final EdgeInsets gestureInsets;

  @override
  void performLayout(Size size) {
    final widthWithPadding = size.width - gestureInsets.left - gestureInsets.right;
    final estimatedSize = Size(widthWithPadding, 100);
    final constraints = BoxConstraints.loose(estimatedSize);
    final tabSizes = items.map((e) => layoutChild('${e.id}_tab', constraints)).toList();
    final textSizes = items.map((e) => layoutChild('${e.id}_label', constraints)).toList();

    final itemWidth = tabSizes.map((e) => e.width).max;
    final itemHeight = tabSizes.map((e) => e.height).max + textSizes.map((e) => e.height).max;
    final maxItemWidth = widthWithPadding / tabSizes.length;

    final tabPositions = items.mapIndexed((i, e) {
      final position = Offset(gestureInsets.left + maxItemWidth * (i + 0.5) - itemWidth * 0.5, 0);
      positionChild('${e.id}_tab', position);
      return position;
    }).toList();

    items.mapIndexed((i, e) {
      final tabPosition = tabPositions[i];
      final positionX = gestureInsets.left + maxItemWidth * (i + 0.5) - textSizes[i].width * 0.5;
      final labelX = min(max(sbbDefaultSpacing, positionX), size.width - textSizes[i].width - sbbDefaultSpacing);
      final position = Offset(labelX, tabPosition.dy + tabSizes[i].height);
      positionChild('${e.id}_label', position);
      return position;
    }).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) => onPositioned(tabPositions, itemHeight));
  }

  @override
  bool shouldRelayout(_TabIconDelegate oldDelegate) {
    return selectedTab != oldDelegate.selectedTab ||
        portrait != oldDelegate.portrait ||
        gestureInsets != oldDelegate.gestureInsets;
  }
}
