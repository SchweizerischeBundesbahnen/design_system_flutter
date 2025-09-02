import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'tab_item_widget.dart';
import 'tab_curve_clipper.dart';
import 'tab_curve_painter.dart';

part 'sbb_tab_bar.icon.dart';

part 'sbb_tab_bar.icon_delegate.dart';

part 'sbb_tab_bar.label.dart';

part 'sbb_tab_bar.layout.dart';

/// The TabBar for SBB themed apps with multiple tabs.
/// Items is a list of all tabs that should be shown in the TabBar.
/// OnTabChanged defines what happens when a tab is selected.
/// OnTap gets called when a tab is tapped.
class SBBTabBar extends StatefulWidget {
  const SBBTabBar._({required this.controller, required this.onTabChanged, required this.onTap, super.key});

  factory SBBTabBar.items({
    required List<SBBTabBarItem> items,
    required Future<void> Function(Future<SBBTabBarItem> tabTask) onTabChanged,
    required void Function(SBBTabBarItem tab) onTap,
    Key? key,
    SBBTabBarItem? initialItem,
  }) =>
      SBBTabBar._(
        key: key,
        controller: SBBTabBarController(items, initialItem ?? items.first),
        onTabChanged: onTabChanged,
        onTap: onTap,
      );

  factory SBBTabBar.controller({
    required SBBTabBarController controller,
    required Future<void> Function(Future<SBBTabBarItem> tabTask) onTabChanged,
    required void Function(SBBTabBarItem tab) onTap,
    Key? key,
  }) =>
      SBBTabBar._(key: key, controller: controller, onTabChanged: onTabChanged, onTap: onTap);

  final Future<void> Function(Future<SBBTabBarItem> tabTask) onTabChanged;
  final void Function(SBBTabBarItem tab) onTap;
  final SBBTabBarController controller;

  @override
  State<SBBTabBar> createState() => _SBBTabBarState();
}

class _SBBTabBarState extends State<SBBTabBar> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  SBBTabBarController get _controller => widget.controller;

  List<SBBTabBarItem> get _tabs => _controller.tabs;

  bool get portrait => MediaQuery.of(context).orientation == Orientation.portrait;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    return StreamBuilder<SBBTabBarLayoutData>(
      stream: _controller.layoutStream,
      initialData: _controller.currentLayoutData,
      builder: (context, snapshot) {
        final layoutData = snapshot.requireData;
        return StreamBuilder<SBBTabBarNavigationData>(
          stream: _controller.navigationStream,
          initialData: _controller.currentData,
          builder: (context, snapshot) {
            final navData = snapshot.requireData;
            return StreamBuilder<List<SBBTabBarWarningSetting>>(
              stream: _controller.warningStream,
              initialData: _controller.currentWarnings,
              builder: (context, snapshot) {
                final warnings = snapshot.requireData;
                final theme = Theme.of(context);
                final cardColor = SBBGroupStyle.of(context).color ?? theme.scaffoldBackgroundColor;
                _controller.changeOrientation(portrait);
                _controller.updateCurveAnimation();
                return Container(
                  height: layoutData.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cardColor.withValues(alpha: 0.0), cardColor.withValues(alpha: 1.0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ..._tabs.mapIndexed(
                        (i, e) => Positioned(
                          left: layoutData.positions[i].dx,
                          child: TabItemWidget(
                            e.icon,
                            selected: true,
                            onTap: () => _onTap(e, navData),
                          ),
                        ),
                      ),
                      CustomPaint(
                        painter: TabCurvePainter(_controller.curves, cardColor, theme.shadowColor),
                        child: ClipPath(
                          clipper: TabCurveClipper(curves: _controller.curves),
                          child: _TabLayout(
                            items: _tabs,
                            selectedTab: navData.selectedTab,
                            warnings: warnings,
                            portrait: portrait,
                            onPositioned: _controller.onLayout,
                            onTap: (e) => _onTap(e, navData),
                            onTapDown: (e) {
                              if (navData.selectedTab == e) return;
                              _controller.hoverTab(e);
                            },
                            onTapCancel: (e) => _controller.cancelHover(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onTap(SBBTabBarItem item, SBBTabBarNavigationData navData) {
    widget.onTap.call(item);
    if (navData.selectedTab == item) return;
    widget.onTabChanged(_controller.selectTab(item));
  }
}
