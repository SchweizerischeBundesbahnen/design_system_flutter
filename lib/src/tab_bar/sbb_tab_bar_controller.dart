import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/tab_bar_layout_data.dart';

import '../../sbb_design_system_mobile.dart';

class TabBarController {
  TabBarController(this.tabs, this.selectedTab) {
    currentData = TabBarNavigationData(selectedTab, selectedTab, 0.0, false);
  }

  final _navigationController =
      StreamController<TabBarNavigationData>.broadcast();
  final _layoutController = StreamController<TabBarLayoutData>.broadcast();

  Stream<TabBarNavigationData> get navigationStream =>
      _navigationController.stream;

  Stream<TabBarLayoutData> get layoutStream => _layoutController.stream;

  final List<TabBarItem> tabs;
  late TabBarItem selectedTab;
  late TickerProvider vsync;
  late TabBarItem _nextTab;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool _hover;
  late TabBarNavigationData currentData;
  late TabBarLayoutData currentLayoutData =
      TabBarLayoutData(0.0, tabs.map((_) => Offset(-100.0, 0.0)).toList());

  static const _duration = Duration(milliseconds: 100);

  void initialize(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: kThemeAnimationDuration,
    )..addListener(
        () {
          currentData = TabBarNavigationData(
            selectedTab,
            _nextTab,
            _animation.value,
            _hover,
          );
          _navigationController.add(currentData);
        },
      );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  Future<TabBarItem> selectTab(TabBarItem tab) async {
    if (selectedTab == tab) return tab;
    _nextTab = tab;
    _hover = false;
    await _animationController.animateTo(1.0, duration: _duration);
    selectedTab = tab;
    _animationController.reset();
    return tab;
  }

  Future<void> hoverTab(TabBarItem tab) async {
    _nextTab = tab;
    _hover = true;
    await _animationController.animateTo(0.25, duration: _duration);
  }

  Future<void> cancelHover() async {
    await _animationController.animateTo(0, duration: _duration);
    _hover = false;
    _nextTab = selectedTab;
    _animationController.reset();
  }

  void onLayout(List<Offset> positions, double height) {
    currentLayoutData = TabBarLayoutData(height, positions);
    _layoutController.add(currentLayoutData);
  }
}
