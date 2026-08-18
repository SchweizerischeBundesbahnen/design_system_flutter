import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tabBarItem_whenSearchedForByKeyAndTapped_isFoundAndSelectsTheTab', (tester) async {
    final items = [
      _DemoTabItem('home', SBBIcons.house_small, key: const ValueKey('home')),
      _DemoTabItem('favorites', SBBIcons.heart_small, key: const ValueKey('favorites')),
      _DemoTabItem('profile', SBBIcons.user_small, key: const ValueKey('profile')),
    ];

    SBBTabBarItem? selected;
    await tester.pumpWidget(
      TestApp(
        child: SBBTabBar.items(
          items: items,
          initialItem: items.first,
          onTabChanged: (tab) async {},
          onTap: (tab) => selected = tab,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('profile')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('profile')));
    await tester.pumpAndSettle();

    expect(selected, items.last);
  });
}

class _DemoTabItem extends SBBTabBarItem {
  _DemoTabItem(super.id, super.icon, {super.key});

  @override
  String translate(BuildContext context) => id;
}
