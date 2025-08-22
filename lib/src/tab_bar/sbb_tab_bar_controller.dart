import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'tab_bar.dart';
import 'tab_curves.dart';

/// With this Controller, the [SBBTabBar] can be controlled externally.
class SBBTabBarController {
  SBBTabBarController(this.tabs, this.selectedTab) {
    currentData = SBBTabBarNavigationData(selectedTab, selectedTab, 0.0, false);
  }

  final _navigationController = StreamController<SBBTabBarNavigationData>.broadcast();
  final _layoutController = StreamController<SBBTabBarLayoutData>.broadcast();
  final _warningController = StreamController<List<SBBTabBarWarningSetting>>.broadcast();

  /// The current navigation data.
  Stream<SBBTabBarNavigationData> get navigationStream => _navigationController.stream;

  /// The current layout data
  Stream<SBBTabBarLayoutData> get layoutStream => _layoutController.stream;

  /// Currently active warnings.
  Stream<List<SBBTabBarWarningSetting>> get warningStream => _warningController.stream;

  final List<SBBTabBarItem> tabs;
  late SBBTabBarItem selectedTab;
  late TickerProvider vsync;
  late SBBTabBarItem _nextTab;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late SBBTabBarNavigationData currentData;
  late SBBTabBarLayoutData currentLayoutData = SBBTabBarLayoutData(0.0, tabs.map((_) => Offset(-100.0, 0.0)).toList());
  late List<SBBTabBarWarningSetting> currentWarnings = [];

  bool hover = false;
  List<TabCurves> curves = [];

  static const _duration = Duration(milliseconds: 200);

  /// Index of the currently selected Tab
  int get from => tabs.indexOf(currentData.selectedTab);

  /// Index of the next Tab (same value as from when the animation is not active)
  int get to => tabs.indexOf(currentData.nextTab);

  /// Recalculating the curves for the Tabs
  void changeOrientation(bool portrait) {
    curves = currentLayoutData.curves(portrait);
  }

  /// Current tabStates for the animation
  List<double> get tabStates {
    return currentLayoutData.positions.mapIndexed((i, p) {
      if (i == from) return 1 - (hover ? 0.0 : _animation.value);
      if (i == to) return _animation.value;
      return 0.0;
    }).toList();
  }

  /// Initializing the controller with the animation controller
  void initialize(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: kThemeAnimationDuration,
    )..addListener(
      () {
        currentData = SBBTabBarNavigationData(
          selectedTab,
          _nextTab,
          _animation.value,
          hover,
        );
        _navigationController.add(currentData);
        updateCurveAnimation();
      },
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void updateCurveAnimation() {
    curves.mapIndexed((i, p) {
      final leftProgress = (i == 0) ? 0.0 : tabStates[i - 1];
      final rightProgress = (i == currentLayoutData.positions.length - 1) ? 0.0 : tabStates[i + 1];

      final double leftMidX =
          curves.length < 2
              ? 0.0
              : (i == 0)
              ? curves[0].midX - (curves[1].midX - curves[0].midX)
              : curves[i - 1].midX;

      final double rightMidX = (i == curves.length - 1) ? 0.0 : curves[i + 1].midX;

      p.setProgress(tabStates[i], leftProgress, leftMidX, rightProgress, rightMidX);
    }).toList();
  }

  void setWarnings(List<SBBTabBarWarningSetting> warnings) {
    _updateWarnings(warnings);
  }

  void _setWarningShown(String id) {
    final warnings = currentWarnings.map((w) => w.id == id ? w.copyWith(shown: true) : w).toList();
    _updateWarnings(warnings);
  }

  void _updateWarnings(List<SBBTabBarWarningSetting> warnings) {
    currentWarnings = warnings;
    _warningController.add(warnings);
  }

  Future<SBBTabBarItem> selectTab(SBBTabBarItem tab) async {
    _setWarningShown(tab.id);
    if (selectedTab == tab) return tab;
    _nextTab = tab;
    hover = false;
    await _animationController.animateTo(1.0, duration: _duration, curve: Curves.easeInOut);
    selectedTab = tab;
    _animationController.reset();
    return tab;
  }

  Future<void> hoverTab(SBBTabBarItem tab) async {
    _nextTab = tab;
    hover = true;
    await _animationController.animateTo(0.25, duration: _duration, curve: Curves.easeInOut);
  }

  Future<void> cancelHover() async {
    await _animationController.animateTo(0, duration: _duration, curve: Curves.easeInOut);
    hover = false;
    _nextTab = selectedTab;
    _animationController.reset();
  }

  void onLayout(List<Offset> positions, double height) {
    if (positions.equals(currentLayoutData.positions) && height == currentLayoutData.height) return;
    currentLayoutData = SBBTabBarLayoutData(height, positions);
    _layoutController.add(currentLayoutData);
  }
}
