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
/// OnTap gets called when a tab is tapped.
class SBBTabBar extends StatefulWidget {
  const SBBTabBar({
    required this.items,
    required this.onTabChanged,
    Key? key,
    this.onTap,
    this.controller,
    this.initialItem,
    this.warningSemantics,
    this.showWarning = false,
    int? warningIndex,
  })  : this.warningIndex = warningIndex ?? items.length - 1,
        super(key: key);

  final List<TabBarItem> items;
  final Future<void> Function(Future<TabBarItem> tabTask) onTabChanged;
  final void Function(TabBarItem tab)? onTap;
  final TabBarController? controller;
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
  late TabBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TabBarController(widget.initialItem ?? widget.items.first);
    _controller.initialize(this);
  }

  bool setPositionsAndSizes(_TabBarNotification n) {
    if (n.data != tabBarData) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (!mounted) return;
          setState(() => tabBarData = n.data);
        },
      );
    }
    return true;
  }

  @override
  Widget build(context) => NotificationListener<_TabBarNotification>(
        onNotification: setPositionsAndSizes,
        child: StreamBuilder<TabBarNavigationData>(
          stream: _controller.navigationStream,
          initialData: _controller.currentData,
          builder: (context, snapshot) {
            final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
            final topPadding = portrait ? 8.0 : 1.0;
            final snapshotData = snapshot.requireData;
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
                    ...widget.items.map(
                      (e) => Positioned(
                        top: topPadding,
                        left: tabBarData.positions[e],
                        child: TabItemWidget.fromTabBarItem(e, true),
                      ),
                    ),
                    ClipPath(
                      child: Container(
                        color: style.themeValue(SBBColors.white, SBBColors.charcoal),
                        child: _IconLayer(widget.items, snapshotData.selectedTab),
                      ),
                      clipper: TabBarCurveClipper(
                        widget.items.indexOf(snapshotData.selectedTab),
                        widget.items.indexOf(snapshotData.nextTab),
                        portrait,
                        tabBarData,
                        snapshotData.animation,
                        snapshotData.hover,
                      ),
                    ),
                    if (widget.showWarning)
                      Positioned(
                        top: topPadding,
                        left: tabBarData.positions[widget.items[widget.warningIndex]],
                        child: TabItemWidget.warning(),
                      ),
                    ...widget.items.mapIndexed(
                      (i, tab) => Positioned(
                        top: topPadding,
                        left: tabBarData.positions[tab]! - 8.0,
                        width: tabBarData.sizes[tab]!.width + 16.0,
                        height: tabBarData.sizes[tab]!.height,
                        child: Semantics(
                          selected: snapshotData.selectedTab == tab,
                          value: widget.showWarning && widget.warningIndex == i ? widget.warningSemantics : null,
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
                                widget.onTap?.call(tab);
                                if (snapshotData.selectedTab == tab) return;
                                widget.onTabChanged(_controller.selectTab(tab));
                              },
                              onTapDown: (_) {
                                if (snapshotData.selectedTab == tab) return;
                                _controller.hoverTab(tab);
                              },
                              onTapCancel: () => _controller.cancelHover(),
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
    final style = SBBControlStyles.of(context);
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
              LayoutId(id: e, child: TabItemWidget.fromTabBarItem(e, false)),
              if (!portrait || e == selectedTab)
                LayoutId(
                  id: '${e.id}_text',
                  child: ExcludeSemantics(
                    child: Text(
                      e.translate(context),
                      style: style.tabBarTextStyle,
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

    final tabTop = portrait ? 8.0 : 1.0;
    double width = size.width - padding.left - padding.right;

    if (portrait) {
      double elementWidth = width / items.length;

      for (final tab in items) {
        final center = elementWidth * items.indexOf(tab) + elementWidth / 2.0;
        final iconLeft = center - iconSizes[tab]!.width / 2.0;
        positionChild(tab, Offset(iconLeft, tabTop));
        if (hasChild('${tab.id}_text')) {
          final textLeft = center - textSizes[tab]!.width / 2.0;
          final maxLeft = size.width - sbbDefaultSpacing - textSizes[tab]!.width;
          final iconBottom = tabTop + TabItemWidget.portraitSize;
          final top = iconBottom + (size.height - iconBottom) / 2.0 - textSizes[tab]!.height / 2.0;
          positionChild('${tab.id}_text', Offset(math.max(sbbDefaultSpacing, math.min(textLeft, maxLeft)), top));
        }
        positions.putIfAbsent(tab, () => iconLeft);
        sizes.putIfAbsent(tab, () => iconSizes[tab]!);
      }

      double spaceBetween = 0.0;
      if (positions.values.length > 1) {
        spaceBetween = positions.values.first * 2;
      }

      onNotification(_TabBarNotification(TabBarDrawData(positions, sizes, spaceBetween)));
    } else {
      final spaceBetween = (width - items.map((e) => iconSizes[e]!.width + textSizes[e]!.width + sbbDefaultSpacing).sum) / (items.length + 1);

      double iconLeft = spaceBetween;
      for (final tab in items) {
        final elementSize = Size(iconSizes[tab]!.width + textSizes[tab]!.width + sbbDefaultSpacing, iconSizes[tab]!.height);
        final textLeft = iconLeft + sbbDefaultSpacing + iconSizes[tab]!.width;
        final textTop = iconSizes[tab]!.height / 2.0 - textSizes[tab]!.height / 2.0;

        positionChild(tab, Offset(iconLeft, tabTop));
        positionChild('${tab.id}_text', Offset(textLeft, textTop));
        positions.putIfAbsent(tab, () => iconLeft);
        sizes.putIfAbsent(tab, () => elementSize);

        iconLeft += spaceBetween + elementSize.width;

        onNotification(_TabBarNotification(TabBarDrawData(positions, sizes, spaceBetween)));
      }
    }
  }

  @override
  bool shouldRelayout(_IconLayerDelegate oldDelegate) =>
      padding != oldDelegate.padding || portrait != oldDelegate.portrait || const ListEquality().equals(items, oldDelegate.items);
}
