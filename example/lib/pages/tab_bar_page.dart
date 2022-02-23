import 'dart:async';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TabBarPage extends StatefulWidget {
  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  final items = <TabBarItem>[
    _Item1(),
    _Item2(),
    _Item3(),
    _Item4(),
  ];

  final _streamController = StreamController<TabBarNavigationData>();

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
          SbbTabBar(
            navigationDataStream: _streamController.stream,
            items: items,
            onTabChanged: (t) => _streamController.add(TabBarNavigationData.simple(items, t)),
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
  String translateSemantics(BuildContext context, int index, int length) => 'Element $index von $length';
}

class _Item1 extends _DemoItem {
  _Item1() : super('1', SBBIcons.train_small);
}

class _Item2 extends _DemoItem {
  _Item2() : super('2', SBBIcons.station_small);
}

class _Item3 extends _DemoItem {
  _Item3() : super('3', SBBIcons.archive_box_small);
}

class _Item4 extends _DemoItem {
  _Item4() : super('4', SBBIcons.arrow_compass_small);
}
