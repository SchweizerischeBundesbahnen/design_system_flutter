import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_curve_painter.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_curves.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';
import 'tab_item_widget.dart';

part 'sbb_tab_bar.icon.dart';

part 'sbb_tab_bar.icon_delegate.dart';

part 'sbb_tab_bar.label.dart';

part 'sbb_tab_bar.layout.dart';

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
      initialData: _controller.currentLayoutData,
      builder: (context, snapshot) {
        final layoutData = snapshot.requireData;
        final media = MediaQuery.of(context);
        final portrait = media.orientation == Orientation.portrait;
        final curves = layoutData.curves(portrait);
        return StreamBuilder<TabBarNavigationData>(
          stream: _controller.navigationStream,
          initialData: _controller.currentData,
          builder: (context, snapshot) {
            final snapshotData = snapshot.requireData;
            return StreamBuilder<List<TabBarWarningSetting>>(
              stream: _controller.warningStream,
              initialData: _controller.currentWarnings,
              builder: (context, snapshot) {
                final warnings = snapshot.requireData;
                final theme = Theme.of(context);
                final cardColor =
                    theme.cardTheme.color ?? theme.scaffoldBackgroundColor;
                final style = SBBBaseStyle.of(context);

                final from = widget.items.indexOf(snapshotData.selectedTab);
                final to = widget.items.indexOf(snapshotData.nextTab);
                final animation = snapshotData.animation;
                final pos = layoutData.positions;
                final tabStates = pos.mapIndexed((i, p) {
                  return from == i
                      ? 1 - (_controller.hover ? 0.0 : animation)
                      : to == i
                          ? animation
                          : 0.0;
                }).toList();
                curves.mapIndexed((index, p) {
                  final double leftProgress =
                      (index == 0) ? 0.0 : tabStates[index - 1];
                  final double rightProgress =
                      (index == pos.length - 1) ? 0.0 : tabStates[index + 1];

                  final double leftMidX = (index == 0)
                      ? curves[0].midX - (curves[1].midX - curves[0].midX)
                      : curves[index - 1].midX;

                  final double rightMidX = (index == curves.length - 1)
                      ? 0.0 // Changed from 0 to 0.0 to match potential double type for midX
                      : curves[index + 1].midX;

                  p.setProgress(tabStates[index], leftProgress, leftMidX,
                      rightProgress, rightMidX);
                }).toList();

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
                  child: CustomPaint(
                    painter: TabCurvePainter(
                      curves,
                      cardColor,
                      theme.shadowColor,
                    ),
                    child: _TabLayout(
                      items: widget.items,
                      selectedTab: snapshotData.selectedTab,
                      warnings: warnings,
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
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
