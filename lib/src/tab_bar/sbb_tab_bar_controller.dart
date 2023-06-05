import 'dart:async';

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class TabBarController {
  TabBarController(this.selectedTab) {
    currentData = TabBarNavigationData(selectedTab, selectedTab, 0.0, false);
  }

  final _navigationController = StreamController<TabBarNavigationData>.broadcast();

  Stream<TabBarNavigationData> get navigationStream => _navigationController.stream;

  late TabBarItem selectedTab;
  late TickerProvider vsync;
  TabBarItem? nextTab;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _hover = false;
  late TabBarNavigationData currentData;

  static const _duration = Duration(milliseconds: 100);

  void initialize(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: kThemeAnimationDuration,
    )..addListener(
        () {
          currentData = TabBarNavigationData(
            selectedTab,
            nextTab,
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
    nextTab = tab;
    _hover = false;
    await _animationController.animateTo(1.0, duration: _duration);
    selectedTab = tab;
    _animationController.reset();
    return tab;
  }

  Future<void> hoverTab(TabBarItem tab) async {
    if (nextTab == tab) return;
    nextTab = tab;
    _hover = true;
    await _animationController.animateTo(0.25, duration: _duration);
  }

  Future<void> cancelHover() async {
    await _animationController.animateTo(0, duration: _duration);
    _hover = false;
    nextTab = selectedTab;
    _animationController.reset();
  }

  void reset() => _animationController.reset();

  void selectNextTab() {
    if (nextTab == null) return;
    selectTab(nextTab!);
  }
}
