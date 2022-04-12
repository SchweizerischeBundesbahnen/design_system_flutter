import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('Test TabBar', (WidgetTester tester) async {
    final icons = [SBBIcons.train_small, SBBIcons.station_small, SBBIcons.archive_box_small, SBBIcons.arrow_compass_small];
    final items = Iterable.generate(1, (i) => _DemoItem('${i}_a', icons[i % icons.length])).toList();
    final items2 = Iterable.generate(2, (i) => _DemoItem('${i}_b', icons[i % icons.length])).toList();
    final items3 = Iterable.generate(3, (i) => _DemoItem('${i}_c', icons[i % icons.length])).toList();
    final items4 = Iterable.generate(4, (i) => _DemoItem('${i}_d', icons[i % icons.length])).toList();
    final items5 = Iterable.generate(5, (i) => _DemoItem('${i}_e', icons[i % icons.length])).toList();
    final items6 = Iterable.generate(6, (i) => _DemoItem('${i}_f', icons[i % icons.length])).toList();
    final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
      ..addScenario(
        'Test TabBar',
        Column(
          children: [
            SBBTabBar(
              items: items,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items, items.first)),
            ),
            SBBTabBar(
              items: items2,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items2, items2.last)),
            ),
            SBBTabBar(
              items: items3,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items3, items3.skip(1).first)),
            ),
            SBBTabBar(
              items: items4,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items4, items4.skip(2).first)),
            ),
            SBBTabBar(
              items: items5,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items5, items5.skip(2).first)),
            ),
            SBBTabBar(
              items: items6,
              onTabChanged: (tab) => {},
              navigationDataStream: Stream.value(TabBarNavigationData.simple(items6, items6.skip(2).first)),
            ),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'tab_bar', devices: TestApp.devices);
  });
}

class _DemoItem extends TabBarItem {
  _DemoItem(String id, IconData icon) : super(id, icon);

  @override
  String translate(BuildContext context) => 'Item $id';

  @override
  String translateSemantics(BuildContext context, int index, int length) => 'Element $index von $length';
}
