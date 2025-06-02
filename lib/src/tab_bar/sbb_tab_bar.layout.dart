part of 'sbb_tab_bar.dart';

class _TabLayout extends StatelessWidget {
  const _TabLayout({
    super.key,
    required this.items,
    required this.selectedTab,
    required this.warnings,
    required this.portrait,
    required this.onPositioned,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
  });

  final List<TabBarItem> items;
  final TabBarItem selectedTab;
  final List<TabBarWarningSetting> warnings;
  final bool portrait;
  final Function(List<Offset> positions, double height) onPositioned;
  final Function(TabBarItem) onTap;
  final Function(TabBarItem) onTapDown;
  final Function(TabBarItem) onTapCancel;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _TabIconDelegate(items, selectedTab, portrait, onPositioned),
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
