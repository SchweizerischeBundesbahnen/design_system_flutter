import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  const _title = 'Bessere Übersicht.';
  const _description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  testGoldens('promotion box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
          'Promotion Box',
          Column(children: [
            PromotionBox(
              badgeText: 'Default',
              title: _title,
              description: _description,
            ),
            SizedBox(height: 8.0),
            PromotionBox(
              badgeText: 'Is Closable = false',
              title: _title,
              description: _description,
              isClosable: false,
            ),
            SizedBox(height: 8.0),
            PromotionBox(
              badgeText: 'Clickable',
              title: _title,
              description: _description,
              onTap: () {},
            )
          ]));

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'promotion_box',
        devices: TestApp.native_devices);
  });
}
