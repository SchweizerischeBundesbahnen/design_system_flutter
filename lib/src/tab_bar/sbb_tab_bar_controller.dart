import 'dart:async';

import 'package:flutter/material.dart';

import 'tab_bar.dart';

class TabBarController {
  TabBarController(this.tabs, this.selectedTab) {
    currentData = TabBarNavigationData(selectedTab, selectedTab, 0.0, false);
  }

  final _navigationController =
      StreamController<TabBarNavigationData>.broadcast();
  final _layoutController = StreamController<TabBarLayoutData>.broadcast();
  final _warningController =
      StreamController<List<TabBarWarningSetting>>.broadcast();

  Stream<TabBarNavigationData> get navigationStream =>
      _navigationController.stream;

  Stream<TabBarLayoutData> get layoutStream => _layoutController.stream;

  Stream<List<TabBarWarningSetting>> get warningStream =>
      _warningController.stream;

  final List<TabBarItem> tabs;
  late TabBarItem selectedTab;
  late TickerProvider vsync;
  late TabBarItem _nextTab;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool hover = false;
  late TabBarNavigationData currentData;
  late TabBarLayoutData currentLayoutData =
      TabBarLayoutData(0.0, tabs.map((_) => Offset(-100.0, 0.0)).toList());
  late List<TabBarWarningSetting> currentWarnings = [];

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
            hover,
          );
          _navigationController.add(currentData);
        },
      );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void setWarnings(List<TabBarWarningSetting> warnings) {
    _updateWarnings(warnings);
  }

  void _setWarningShown(String id) {
    final warnings = currentWarnings
        .map((w) => w.id == id ? w.copyWith(shown: true) : w)
        .toList();
    _updateWarnings(warnings);
  }

  void _updateWarnings(List<TabBarWarningSetting> warnings) {
    currentWarnings = warnings;
    _warningController.add(warnings);
  }

  Future<TabBarItem> selectTab(TabBarItem tab) async {
    _setWarningShown(tab.id);
    if (selectedTab == tab) return tab;
    _nextTab = tab;
    hover = false;
    await _animationController.animateTo(1.0, duration: _duration);
    selectedTab = tab;
    _animationController.reset();
    return tab;
  }

  Future<void> hoverTab(TabBarItem tab) async {
    _nextTab = tab;
    hover = true;
    await _animationController.animateTo(0.25, duration: _duration);
  }

  Future<void> cancelHover() async {
    await _animationController.animateTo(0, duration: _duration);
    hover = false;
    _nextTab = selectedTab;
    _animationController.reset();
  }

  void onLayout(List<Offset> positions, double height) {
    currentLayoutData = TabBarLayoutData(height, positions);
    _layoutController.add(currentLayoutData);
  }
}
