import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('Test TabBar', (WidgetTester tester) async {
    final icons = [
      SBBIcons.train_small,
      SBBIcons.station_small,
      SBBIcons.archive_box_small,
      SBBIcons.arrow_compass_small,
    ];
    final items = Iterable.generate(1, (i) => _DemoItem('${i}_a', icons[i % icons.length])).toList();
    final items2 = Iterable.generate(2, (i) => _DemoItem('${i}_b', icons[i % icons.length])).toList();
    final items3 = Iterable.generate(3, (i) => _DemoItem('${i}_c', icons[i % icons.length])).toList();
    final items4 = Iterable.generate(4, (i) => _DemoItem('${i}_d', icons[i % icons.length])).toList();
    final items5 = Iterable.generate(5, (i) => _DemoItem('${i}_e', icons[i % icons.length])).toList();
    final items6 = Iterable.generate(6, (i) => _DemoItem('${i}_f', icons[i % icons.length])).toList();
    final controller1 = SBBTabBarController(items3, items3[0])
      ..setBadges([
        SBBTabBarItemBadge(
          id: '1_c',
          badge: SBBTabBarBadgeIcon(badgeIcon: SBBBadgeIconData.checkmark),
        ),
      ]);
    final controller2 = SBBTabBarController(items4, items4.last)
      ..setBadges([
        SBBTabBarItemBadge(
          id: '2_d',
          badge: SBBTabBarBadgeText(labelText: '99+'),
        ),
      ]);

    final widget = Column(
      children: [
        SBBTabBar.items(items: items, onTabChanged: (tab) async {}, onTap: (tab) {}),
        SBBTabBar.items(items: items2, onTabChanged: (tab) async {}, initialItem: items2.last, onTap: (tab) {}),
        SBBTabBar.controller(controller: controller1, onTabChanged: (tab) async {}, onTap: (tab) {}),
        SBBTabBar.controller(controller: controller2, onTabChanged: (tab) async {}, onTap: (tab) {}),
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

  testWidgets('tab items are selectable via their consumer-supplied key', (WidgetTester tester) async {
    final icons = [SBBIcons.train_small, SBBIcons.station_small, SBBIcons.archive_box_small];
    final items = [
      _DemoItem('tab_a', icons[0], key: const ValueKey('tab_a')),
      _DemoItem('tab_b', icons[1], key: const ValueKey('tab_b')),
      _DemoItem('tab_c', icons[2], key: const ValueKey('tab_c')),
    ];

    SBBTabBarItem? tapped;
    await tester.pumpWidget(
      TestApp(
        child: SBBTabBar.items(
          items: items,
          initialItem: items.first,
          onTabChanged: (tab) async {},
          onTap: (tab) => tapped = tab,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('tab_b')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('tab_b')));
    await tester.pumpAndSettle();

    expect(tapped, items[1]);
  });
}

class _DemoItem extends SBBTabBarItem {
  _DemoItem(super.id, super.icon, {super.key});

  @override
  String translate(BuildContext context) => 'Item $id';
}
