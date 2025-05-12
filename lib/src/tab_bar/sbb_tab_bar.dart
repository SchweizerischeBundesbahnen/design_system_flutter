import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  late final _keys = Map.fromEntries(
    widget.items.map((e) => MapEntry(e, GlobalKey())),
  );

  late List<double> positions = widget.items.map((_) => -100.0).toList();

  final _rowKey = GlobalKey();
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = widget.controller ??
        TabBarController(widget.initialItem ?? widget.items.first);
    _controller.initialize(this);
    _updatePositions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _updatePositions();
  }

  void _updatePositions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final positions = _keys.values.map((e) {
        final parentData = e.currentContext?.findRenderObject()?.parentData;
        return (parentData as FlexParentData?)?.offset.dx ?? -100.0;
      });
      height = _rowKey.currentContext?.size?.height ?? 0.0;
      setState(() => this.positions = positions.toList());
    });
  }

  @override
  Widget build(context) {
    return StreamBuilder<TabBarNavigationData>(
      stream: _controller.navigationStream,
      initialData: _controller.currentData,
      builder: (context, snapshot) {
        final mediaQuery = MediaQuery.of(context);
        final portrait = mediaQuery.orientation == Orientation.portrait;
        final viewPaddingBottom = mediaQuery.viewPadding.bottom;
        final topPadding = portrait ? 8.0 : 1.0;
        final snapshotData = snapshot.requireData;
        final theme = Theme.of(context);
        final cardColor =
            theme.cardTheme.color ?? theme.scaffoldBackgroundColor;
        final style = SBBBaseStyle.of(context);
        return Container(
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
                  positions,
                ),
                child: Container(
                  color: style.themeValue(
                    SBBColors.white,
                    SBBColors.charcoal,
                  ),
                  height: height + viewPaddingBottom,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: topPadding,
                  bottom: viewPaddingBottom,
                ),
                child: Row(
                  key: _rowKey,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.items.map(
                    (e) {
                      final selected = snapshotData.selectedTab == e;
                      final style = SBBControlStyles.of(context);
                      final label = e.translate(context);
                      final children = [
                        TabItemWidget.fromTabBarItem(e, selected),
                        if (!portrait) SizedBox(width: 8.0),
                        if (selected || !portrait)
                          Text(
                            label,
                            style: style.tabBarTextStyle,
                            textAlign: TextAlign.center,
                          ),
                      ];
                      final semanticsHint = Localizations.of(
                        context,
                        MaterialLocalizations,
                      ).tabLabel(
                        tabIndex: widget.items.indexOf(e) + 1,
                        tabCount: widget.items.length,
                      );
                      return Semantics(
                        key: _keys[e],
                        selected: selected,
                        label: label,
                        hint: semanticsHint,
                        button: true,
                        excludeSemantics: true,
                        child: GestureDetector(
                          onTap: () {
                            widget.onTap?.call(e);
                            if (selected) return;
                            widget.onTabChanged(_controller.selectTab(e));
                          },
                          onTapDown: (_) {
                            if (selected) return;
                            _controller.hoverTab(e);
                          },
                          onTapCancel: () => _controller.cancelHover(),
                          child: portrait
                              ? Column(children: children)
                              : Row(children: children),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
