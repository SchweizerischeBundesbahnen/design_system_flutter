part of 'sbb_tab_bar.dart';

class _TabIconDelegate extends MultiChildLayoutDelegate {
  _TabIconDelegate(
    this.items,
    this.selectedTab,
    this.portrait,
    this.onPositioned,
  );

  final List<SBBTabBarItem> items;
  final SBBTabBarItem selectedTab;
  final bool portrait;
  final Function(List<Offset> positions, double height) onPositioned;

  @override
  void performLayout(Size size) {
    final estimatedSize = Size(size.width, 100);
    final constraints = BoxConstraints.loose(estimatedSize);
    final tabSizes = items.map((e) => layoutChild('${e.id}_tab', constraints)).toList();
    final textSizes = items.map((e) => layoutChild('${e.id}_label', constraints)).toList();

    final itemWidth = tabSizes.map((e) => e.width).max;
    final itemHeight = tabSizes.map((e) => e.height).max + textSizes.map((e) => e.height).max;
    final maxItemWidth = size.width / tabSizes.length;

    final tabPositions = items.mapIndexed((i, e) {
      final position = Offset(maxItemWidth * (i + 0.5) - itemWidth * 0.5, 0);
      positionChild('${e.id}_tab', position);
      return position;
    }).toList();

    items.mapIndexed((i, e) {
      final tabPosition = tabPositions[i];
      final labelX = switch (i) {
        0 => tabPosition.dx,
        _ => min(
            maxItemWidth * (i + 0.5) - textSizes[i].width * 0.5,
            tabPositions.last.dx + tabSizes.last.width - textSizes[i].width,
          ),
      };
      final position = Offset(labelX, tabPosition.dy + tabSizes[i].height);
      positionChild('${e.id}_label', position);
      return position;
    }).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) => onPositioned(tabPositions, itemHeight));
  }

  @override
  bool shouldRelayout(_TabIconDelegate oldDelegate) {
    return selectedTab != oldDelegate.selectedTab || portrait != portrait;
  }
}
