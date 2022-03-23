import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

import 'tab_bar_curve_clipper.dart';
import 'tab_bar_draw_data.dart';
import 'tab_item_widget.dart';

/// The TabBar for SBB themed apps with multiple tabs.
/// Items is a list of all tabs that should be shown in the TabBar.
/// OnTabChanged defines what happens when a tab is selected.
/// NavigationDataStream is the current state. A [Stream] of [TabBarNavigationData]
class SBBTabBar extends StatefulWidget {
  const SBBTabBar({
    required this.items,
    required this.onTabChanged,
    required this.navigationDataStream,
    Key? key,
  }) : super(key: key);

  final List<TabBarItem> items;
  final void Function(TabBarItem tab) onTabChanged;
  final Stream<TabBarNavigationData> navigationDataStream;

  @override
  State<SBBTabBar> createState() => _SBBTabBarState();
}

class _TabBarNotification extends Notification {
  _TabBarNotification(this.data);

  final TabBarDrawData data;
}

class _SBBTabBarState extends State<SBBTabBar> with SingleTickerProviderStateMixin {
  late TabBarDrawData tabBarData = TabBarDrawData.empty(widget.items);

  late AnimationController _controller;
  late Animation<double> _animation;

  int? _selectedOverride;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _animation = Tween(begin: 0.0, end: 0.25).animate(_controller);

    _controller.addListener(() {
      if (!mounted) return;
      setState(() => {});
    });
  }

  bool setPositionsAndSizes(_TabBarNotification n) {
    if (n.data != tabBarData) {
      WidgetsBinding.instance?.addPostFrameCallback(
            (_) {
              if (!mounted) return;
              setState(() => tabBarData = n.data);
            },
      );
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => NotificationListener<_TabBarNotification>(
    onNotification: setPositionsAndSizes,
    child: StreamBuilder<TabBarNavigationData>(
      stream: widget.navigationDataStream,
      initialData: TabBarNavigationData(0.0, 0.0, widget.items.first),
      builder: (context, snapshot) {
        final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
        final sbbTheme = SBBTheme.of(context);
        final topPadding = portrait ? 8.0 : 1.0;
        final snapshotData = snapshot.requireData;
        return SizedBox.fromSize(
          size: Size.fromHeight(TabBarFiller.calcHeight(context)),
          child: Container(
            decoration: BoxDecoration(
              color: SBBColors.transparent,
              boxShadow: SBBTheme.of(context).isDark
                  ? [
                const BoxShadow(
                  color: SBBInternal.barrierColor,
                  blurRadius: 15,
                ),
              ]
                  : SBBInternal.defaultBoxShadow,
            ),
            child: Stack(
              children: [
                ...widget.items.map(
                      (e) => Positioned(
                    top: topPadding,
                    left: tabBarData.positions[e],
                    child: TabItemWidget(e, true),
                  ),
                ),
                ClipPath(
                  child: Container(
                    color: sbbTheme.isDark ? SBBColors.charcoal : SBBColors.white,
                    child: _IconLayer(widget.items, snapshotData.selectedTab),
                  ),
                  clipper: TabBarCurveClipper(
                    snapshotData.currentPage,
                    snapshotData.previousPage,
                    widget.items.indexOf(snapshotData.selectedTab),
                    portrait,
                    tabBarData,
                    _animation.value,
                    _selectedOverride,
                  ),
                ),
                ...widget.items.map(
                      (tab) => Positioned(
                    top: topPadding,
                    left: tabBarData.positions[tab]! - 8.0,
                    width: tabBarData.sizes[tab]!.width + 16.0,
                    height: tabBarData.sizes[tab]!.height,
                    child: Semantics(
                      selected: snapshotData.selectedTab == tab,
                      value: tab.translate(context),
                      hint: tab.translateSemantics(context, widget.items.indexOf(tab) + 1, widget.items.length),
                      child: Container(
                        color: SBBColors.transparent,
                        child: GestureDetector(
                          key: Key('${tab.id}_button'),
                          onTap: () => widget.onTabChanged(tab),
                          onTapDown: (_) {
                            if (snapshotData.selectedTab == tab) return;
                            _controller.reset();
                            _controller.forward();
                            _selectedOverride = widget.items.indexOf(tab);
                          },
                          onTapUp: (_) => setState(() => _selectedOverride = null),
                          onTapCancel: () => setState(() => _selectedOverride = null),
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
    ),
  );
}

class _IconLayer extends StatelessWidget {
  const _IconLayer(
      this.items,
      this.selectedTab, {
        Key? key,
      }) : super(key: key);

  final List<TabBarItem> items;
  final TabBarItem selectedTab;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portrait = mediaQuery.orientation == Orientation.portrait;
    return CustomMultiChildLayout(
      delegate: _IconLayerDelegate(
        items,
            (notification) => notification.dispatch(context),
        mediaQuery.padding,
        portrait,
      ),
      children: items
          .expand(
            (e) => [
          LayoutId(id: e, child: TabItemWidget(e, false)),
          if (!portrait || e == selectedTab)
            LayoutId(
              id: '${e.id}_text',
              child: Semantics(
                child: Text(
                  e.translate(context),
                  style: SBBTheme.of(context).tabBarTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      )
          .toList(),
    );
  }
}

class _IconLayerDelegate extends MultiChildLayoutDelegate {
  _IconLayerDelegate(this.items, this.onNotification, this.padding, this.portrait);

  final List<TabBarItem> items;
  final void Function(_TabBarNotification notification) onNotification;
  final EdgeInsets padding;
  final bool portrait;

  @override
  void performLayout(Size size) {
    final sizes = <TabBarItem, Size>{};
    final iconSizes = <TabBarItem, Size>{};
    final textSizes = <TabBarItem, Size>{};
    final positions = <TabBarItem, double>{};

    for (final tab in items) {
      final iconSize = layoutChild(tab, BoxConstraints.loose(size));
      iconSizes.putIfAbsent(tab, () => iconSize);

      if (hasChild('${tab.id}_text')) {
        final textSize = layoutChild('${tab.id}_text', BoxConstraints.loose(size));
        textSizes.putIfAbsent(tab, () => textSize);
      }
    }

    double calculatedSize = size.width - sbbDefaultSpacing * 2 - padding.left - padding.right - iconSizes.values.map((e) => e.width).reduce((a, b) => a + b);

    if (!portrait) {
      calculatedSize -= (sbbDefaultSpacing * iconSizes.length + textSizes.values.map((e) => e.width).reduce((a, b) => a + b));
    }

    final spaceBetween = calculatedSize / (items.length - 1);

    double left = sbbDefaultSpacing + padding.left;
    final tabTop = portrait ? 8.0 : 1.0;

    for (final tab in items) {
      positionChild(tab, Offset(left, tabTop));
      positions.putIfAbsent(tab, () => left);
      if (portrait) {
        if (hasChild('${tab.id}_text')) {
          final textLeft = left + iconSizes[tab]!.width / 2.0 - textSizes[tab]!.width / 2.0;
          final maxLeft = size.width - sbbDefaultSpacing - textSizes[tab]!.width;
          final iconBottom = tabTop + TabItemWidget.portraitSize;
          final top = iconBottom + (size.height - iconBottom) / 2.0 - textSizes[tab]!.height / 2.0;
          positionChild('${tab.id}_text', Offset(math.max(sbbDefaultSpacing, math.min(textLeft, maxLeft)), top));
        }
        left += spaceBetween + iconSizes[tab]!.width;

        sizes.putIfAbsent(tab, () => iconSizes[tab]!);
      } else {
        left += iconSizes[tab]!.width + sbbDefaultSpacing;
        positionChild('${tab.id}_text', Offset(left, iconSizes[tab]!.height / 2.0 - textSizes[tab]!.height / 2.0));
        left += spaceBetween + textSizes[tab]!.width;

        sizes.putIfAbsent(tab, () => Size(iconSizes[tab]!.width + textSizes[tab]!.width + sbbDefaultSpacing, iconSizes[tab]!.height));
      }
    }

    onNotification(_TabBarNotification(TabBarDrawData(positions, sizes, spaceBetween)));
  }

  @override
  bool shouldRelayout(_IconLayerDelegate oldDelegate) =>
      padding != oldDelegate.padding || portrait != oldDelegate.portrait || const ListEquality().equals(items, oldDelegate.items);
}
