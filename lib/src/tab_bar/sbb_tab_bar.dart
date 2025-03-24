import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/common/tab_bar_animation.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_bar_layouter.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';
import 'clipper/tab_bar_curve_clipper.dart';
import 'common/tab_bar_layout.dart';
import 'tab_bar_draw_data.dart';
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
    this.warningSemantics,
    this.showWarning = false,
    int? warningIndex,
  }) : warningIndex = warningIndex ?? items.length - 1;

  final List<TabBarItem> items;
  final Future<void> Function(Future<TabBarItem> tabTask) onTabChanged;
  final void Function(TabBarItem tab)? onTap;
  final SBBTabBarController? controller;
  final TabBarItem? initialItem;
  final String? warningSemantics;
  final bool showWarning;
  final int warningIndex;

  @override
  State<SBBTabBar> createState() => _SBBTabBarState();
}

class _TabBarNotification extends Notification {
  _TabBarNotification(this.data);

  final TabBarDrawData data;
}

class _SBBTabBarState extends State<SBBTabBar> with SingleTickerProviderStateMixin {
  late TabBarDrawData tabBarData = TabBarDrawData.empty(widget.items);
  late SBBTabBarController _controller;
  late TabBarAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SBBTabBarController(vsync: this, length: widget.items.length);
    _controller.animation!.addListener(() {
      setState(() {
        _animation = _controller.tabBarAnimation;

        // TabBarAnimation(
        // index: _controller.index,
        // previousIndex: _controller.previousIndex,
        // previousPercentage: _controller.indexIsChanging ? 1.0 - (_controller.animation?.value ?? 0) : 0.0,
        // percentage: _controller.indexIsChanging ? _controller.animation?.value ?? 1.0 : 1.0,
        // isChanging: _controller.indexIsChanging);
      });
    });
    _animation = _controller.tabBarAnimation;

    // TabBarAnimation(
    // index: _controller.index,
    // previousIndex: _controller.previousIndex,
    // previousPercentage: 0.0,
    // percentage: 1.0,
    // isChanging: _controller.indexIsChanging);
  }

  @override
  Widget build(context) => LayoutBuilder(
        builder: (context, constraints) {
          final layout = TabBarLayouter.calculateLayout(constraints, widget.items.length);
          final cardColor = Theme.of(context).cardTheme.color ?? Theme.of(context).scaffoldBackgroundColor;
          final style = SBBBaseStyle.of(context);
          return SizedBox.fromSize(
            size: Size.fromHeight(TabBarFiller.calcHeight(context)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cardColor.withOpacity(0.0),
                    cardColor.withOpacity(1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: style.themeValue(SBBInternal.defaultBoxShadow, SBBInternal.barrierBoxShadow),
              ),
              child: Stack(
                children: [
                  ...widget.items.mapIndexed(
                    (idx, e) => Positioned(
                      top: layout.spacing,
                      left: (layout.outerPositions[idx].dx + layout.spacing),
                      child: TabItemWidget.fromTabBarItem(e, Size(layout.radius * 2, layout.radius * 2), true),
                    ),
                  ),
                  ClipPath(
                    clipper: TabBarCurveClipper(
                      layout: layout,
                      animation: _animation,
                    ),
                    child: Container(
                      color: style.themeValue(SBBColors.white, SBBColors.charcoal),
                      child: _IconLayer(widget.items, _animation.index, layout),
                    ),
                  ),
                  ...widget.items.mapIndexed(
                    (idx, tab) => Positioned(
                      top: 0,
                      left: (layout.outerPositions[idx].dx + layout.spacing),
                      width: layout.outerRadius * 2,
                      height: layout.outerRadius * 2,
                      child: Semantics(
                        selected: idx == _animation.index,
                        label: tab.translate(context),
                        hint: Localizations.of(context, MaterialLocalizations).tabLabel(
                          tabIndex: widget.items.indexOf(tab) + 1,
                          tabCount: widget.items.length,
                        ),
                        button: true,
                        child: Container(
                          color: SBBColors.transparent,
                          child: GestureDetector(
                            key: Key('${tab.id}_button'),
                            onTap: () {
                              // widget.onTap?.call(tab);
                              if (idx == _animation.previousIndex) return;
                              _controller.animateTo(idx);

                              // widget.onTabChanged(_controller.animateTo());
                            },
                            onTapDown: (_) {
                              if (idx == _animation.index) return;
                              _controller.hoverTo(idx);
                            },
                            onTapCancel: () {
                              _controller.cancelHover();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

class _IconLayer extends StatelessWidget {
  const _IconLayer(
    this.items,
    this.selectedIndex,
    this.layout,
  );

  final List<TabBarItem> items;
  final int selectedIndex;
  final TabBarLayout layout;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Stack(
      children: [
        ...items.mapIndexed((idx, e) => Positioned(
              top: layout.spacing,
              left: (layout.outerPositions[idx].dx + layout.spacing),
              child: Column(
                children: [
                  TabItemWidget.fromTabBarItem(e, Size(layout.radius * 2, layout.radius * 2), false),
                  if (idx == selectedIndex)
                    ExcludeSemantics(
                      child: Text(
                        e.translate(context),
                        style: style.tabBarTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            )),
      ],
    );
  }
}
