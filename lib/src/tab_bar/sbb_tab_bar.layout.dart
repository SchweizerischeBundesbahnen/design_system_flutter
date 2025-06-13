part of 'sbb_tab_bar.dart';

class _TabLayout extends StatelessWidget {
  const _TabLayout({
    required this.items,
    required this.selectedTab,
    required this.warnings,
    required this.portrait,
    required this.onPositioned,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
  });

  final List<SBBTabBarItem> items;
  final SBBTabBarItem selectedTab;
  final List<SBBTabBarWarningSetting> warnings;
  final bool portrait;
  final Function(List<Offset> positions, double height) onPositioned;
  final Function(SBBTabBarItem) onTap;
  final Function(SBBTabBarItem) onTapDown;
  final Function(SBBTabBarItem) onTapCancel;

  @override
  Widget build(BuildContext context) {
    final gestureInsets = MediaQuery.of(context).systemGestureInsets;
    return CustomMultiChildLayout(
      delegate: _TabIconDelegate(items, selectedTab, portrait, onPositioned, gestureInsets),
      children: items
          .mapIndexed((i, e) {
            return _TabIcon(
              item: e,
              selected: e == selectedTab,
              warning: warnings.firstWhereOrNull((w) => w.id == e.id),
              portrait: portrait,
              tabIndex: i,
              tabCount: items.length,
              onTap: () => onTap(e),
              onTapDown: (_) => onTapDown(e),
              onTapCancel: () => onTapCancel(e),
            );
          })
          .cast<Widget>()
          .followedBy(items.map(
            (e) => _TabLabel(
              item: e,
              visible: e == selectedTab && portrait,
            ),
          ))
          .toList(),
    );
  }
}
