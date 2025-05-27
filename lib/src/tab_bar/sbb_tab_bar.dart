import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_bar_layout_data.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';
import 'tab_bar_curve_clipper.dart';

import 'tab_item_widget.dart';

/// The TabBar for SBB themed apps with multiple tabs.
/// Items is a list of all tabs that should be shown in the TabBar.
/// OnTabChanged defines what happens when a tab is selected.
/// OnTap gets called when a tab is tapped.
class SBBTabBar extends StatefulWidget {
  const SBBTabBar({
    required this.items,
    required this.onTabChanged,
    super.key,
    this.onTap,
    this.controller,
    this.initialItem,
  });

  final List<TabBarItem> items;
  final Future<void> Function(Future<TabBarItem> tabTask) onTabChanged;
  final void Function(TabBarItem tab)? onTap;
  final TabBarController? controller;
  final TabBarItem? initialItem;

  @override
  State<SBBTabBar> createState() => _SBBTabBarState();
}

class _SBBTabBarState extends State<SBBTabBar>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabBarController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = widget.controller ??
        TabBarController(
            widget.items, widget.initialItem ?? widget.items.first);
    _controller.initialize(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }

  @override
  Widget build(context) {
    return StreamBuilder<TabBarLayoutData>(
      stream: _controller.layoutStream,
      builder: (context, snapshot) {
        final layoutData = snapshot.data ?? _controller.currentLayoutData;
        return StreamBuilder<TabBarNavigationData>(
          stream: _controller.navigationStream,
          initialData: _controller.currentData,
          builder: (context, snapshot) {
            final portrait =
                MediaQuery.of(context).orientation == Orientation.portrait;
            final snapshotData = snapshot.requireData;
            final theme = Theme.of(context);
            final cardColor =
                theme.cardTheme.color ?? theme.scaffoldBackgroundColor;
            final style = SBBBaseStyle.of(context);
            return Container(
              height: layoutData.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cardColor.withValues(alpha: 0.0),
                    cardColor.withValues(alpha: 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: style.themeValue(
                  SBBInternal.defaultBoxShadow,
                  SBBInternal.barrierBoxShadow,
                ),
              ),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TabBarCurveClipper(
                      widget.items.indexOf(snapshotData.selectedTab),
                      widget.items.indexOf(snapshotData.nextTab),
                      portrait,
                      snapshotData.animation,
                      snapshotData.hover,
                      layoutData.positions,
                    ),
                    child: Container(
                      color: style.themeValue(
                        SBBColors.white,
                        SBBColors.charcoal,
                      ),
                    ),
                  ),
                  _TabLayout(
                    items: widget.items,
                    selectedTab: snapshotData.selectedTab,
                    portrait: portrait,
                    onPositioned: _controller.onLayout,
                    onTap: (e) {
                      widget.onTap?.call(e);
                      if (snapshotData.selectedTab == e) return;
                      widget.onTabChanged(_controller.selectTab(e));
                    },
                    onTapDown: (e) {
                      if (snapshotData.selectedTab == e) return;
                      _controller.hoverTab(e);
                    },
                    onTapCancel: (e) => _controller.cancelHover(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TabLayout extends StatelessWidget {
  const _TabLayout({
    super.key,
    required this.items,
    required this.selectedTab,
    required this.portrait,
    required this.onPositioned,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
  });

  final List<TabBarItem> items;
  final TabBarItem selectedTab;
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
          .mapIndexed(
            (i, e) => _TabIcon(
              item: e,
              selected: e == selectedTab,
              portrait: portrait,
              tabIndex: i,
              tabCount: items.length,
              onTap: () => onTap(e),
              onTapDown: (_) => onTapDown(e),
              onTapCancel: () => onTapCancel(e),
            ),
          )
          .cast<Widget>()
          .followedBy(
            items.map(
              (e) => _TabLabel(
                item: e,
                visible: e == selectedTab && portrait,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TabIconDelegate extends MultiChildLayoutDelegate {
  _TabIconDelegate(
      this.items, this.selectedTab, this.portrait, this.onPositioned);

  final List<TabBarItem> items;
  final TabBarItem selectedTab;
  final bool portrait;
  final Function(List<Offset> positions, double height) onPositioned;

  @override
  void performLayout(Size size) {
    final estimatedSize = Size(size.width, 100);
    final constraints = BoxConstraints.loose(estimatedSize);
    final tabSizes =
        items.map((e) => layoutChild('${e.id}_tab', constraints)).toList();
    final textSizes =
        items.map((e) => layoutChild('${e.id}_label', constraints)).toList();

    final itemWidth = tabSizes.map((e) => e.width).max;
    final itemHeight =
        tabSizes.map((e) => e.height).max + textSizes.map((e) => e.height).max;
    final maxItemWidth = size.width / tabSizes.length;

    final tabPositions = items.mapIndexed((i, e) {
      final position = Offset(maxItemWidth * (i + 0.5) - itemWidth * 0.5, 0);
      positionChild('${e.id}_tab', position);
      return position;
    }).toList();

    final labelPositions = items.mapIndexed((i, e) {
      final tabPosition = tabPositions[i];
      final position = Offset(
        maxItemWidth * (i + 0.5) - textSizes[i].width * 0.5,
        tabPosition.dy + tabSizes[i].height,
      );
      positionChild('${e.id}_label', position);
      return position;
    }).toList();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => onPositioned(tabPositions, itemHeight));
  }

  @override
  bool shouldRelayout(_TabIconDelegate oldDelegate) {
    return selectedTab != oldDelegate.selectedTab || portrait != portrait;
  }
}

class _TabIcon extends StatelessWidget {
  const _TabIcon({
    super.key,
    required this.item,
    required this.selected,
    required this.portrait,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
    required this.tabIndex,
    required this.tabCount,
  });

  final TabBarItem item;
  final bool selected;
  final bool portrait;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final int tabIndex;
  final int tabCount;

  @override
  Widget build(BuildContext context) {
    final label = item.translate(context);
    final semanticsHint = Localizations.of(
      context,
      MaterialLocalizations,
    ).tabLabel(
      tabIndex: tabIndex + 1,
      tabCount: tabCount,
    );
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = portrait ? 0.0 : max(viewPaddingBottom, 8.0);
    return LayoutId(
      id: '${item.id}_tab',
      child: Semantics(
        selected: selected,
        label: label,
        hint: semanticsHint,
        button: true,
        excludeSemantics: true,
        child: Container(
          padding: EdgeInsets.only(bottom: bottomPadding),
          color: SBBColors.transparent,
          child: GestureDetector(
            onTap: onTap,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                TabItemWidget.fromTabBarItem(item, selected),
                if (!portrait)
                  Text(
                    item.translate(context),
                    style: SBBControlStyles.of(context).tabBarTextStyle,
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    super.key,
    required this.item,
    required this.visible,
  });

  final TabBarItem item;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = max(viewPaddingBottom, 8.0);
    return LayoutId(
      id: '${item.id}_label',
      child: Visibility(
        visible: visible,
        child: ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: bottomPadding),
            child: Text(
              item.translate(context),
              style: SBBControlStyles.of(context).tabBarTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
