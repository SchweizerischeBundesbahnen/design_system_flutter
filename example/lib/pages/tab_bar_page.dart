import 'dart:async';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TabBarPage extends StatefulWidget {
  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  final items = <TabBarItem>[
    _DemoItem('1', SBBIcons.train_small),
    _DemoItem('2', SBBIcons.station_small),
    _DemoItem('3', SBBIcons.archive_box_small),
    _DemoItem('4', SBBIcons.arrow_compass_small),
    _DemoItem('5', SBBIcons.arrow_compass_small),
    _DemoItem('6', SBBIcons.arrow_compass_small),
  ];

  final _streamController = StreamController<TabBarNavigationData>();

  late TabBarItem _selectedTab = items[0];
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: kThemeAnimationDuration);
  late Animation<double> _animation =
      Tween(begin: 0.0, end: items.length.toDouble())
          .animate(_animationController);

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() => _streamController.add(
        TabBarNavigationData(
            _animation.value, _animation.value, _selectedTab)));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: ThemeModeSegmentedButton(),
          ),
          Expanded(child: Container()),
          SBBTabBar(
            navigationDataStream: _streamController.stream,
            items: items,
            showWarning: true,
            onTabChanged: (t) {
              _selectedTab = t;
              _animationController.animateTo(items.indexOf(t) / items.length,
                  duration: kThemeAnimationDuration);
            },
          ),
          Expanded(child: Container()),
        ],
      );
}

class _DemoItem extends TabBarItem {
  _DemoItem(String id, IconData icon) : super(id, icon);

  @override
  String translate(BuildContext context) => 'Item $id';

  @override
  String translateSemantics(BuildContext context, int index, int length) =>
      'Element $index von $length';
}
