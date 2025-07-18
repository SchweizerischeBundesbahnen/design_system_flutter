import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('Test TabBar', (WidgetTester tester) async {
    final icons = [
      SBBIcons.train_small,
      SBBIcons.station_small,
      SBBIcons.archive_box_small,
      SBBIcons.arrow_compass_small
    ];
    final items = Iterable.generate(1, (i) => _DemoItem('${i}_a', icons[i % icons.length])).toList();
    final items2 = Iterable.generate(2, (i) => _DemoItem('${i}_b', icons[i % icons.length])).toList();
    final items3 = Iterable.generate(3, (i) => _DemoItem('${i}_c', icons[i % icons.length])).toList();
    final items4 = Iterable.generate(4, (i) => _DemoItem('${i}_d', icons[i % icons.length])).toList();
    final items5 = Iterable.generate(5, (i) => _DemoItem('${i}_e', icons[i % icons.length])).toList();
    final items6 = Iterable.generate(6, (i) => _DemoItem('${i}_f', icons[i % icons.length])).toList();
    final widget = Column(
      children: [
        SBBTabBar.items(
          items: items,
          onTabChanged: (tab) async {},
          onTap: (tab) {},
        ),
        SBBTabBar.items(
          items: items2,
          onTabChanged: (tab) async {},
          initialItem: items2.last,
          onTap: (tab) {},
        ),
        SBBTabBar.items(
          items: items3,
          onTabChanged: (tab) async {},
          initialItem: items3.skip(1).first,
          onTap: (tab) {},
        ),
        SBBTabBar.items(
          items: items4,
          onTabChanged: (tab) async {},
          initialItem: items4.skip(2).first,
          onTap: (tab) {},
        ),
        SBBTabBar.items(
          items: items5,
          onTabChanged: (tab) async {},
          initialItem: items5.skip(2).first,
          onTap: (tab) {},
        ),
        SBBTabBar.items(
          items: items6,
          onTabChanged: (tab) async {},
          initialItem: items6.skip(2).first,
          onTap: (tab) {},
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'tab_bar',
      find.byType(Column).first,
    );
  });
}

class _DemoItem extends SBBTabBarItem {
  _DemoItem(super.id, super.icon);

  @override
  String translate(BuildContext context) => 'Item $id';
}
