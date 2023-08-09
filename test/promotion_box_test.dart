import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('promotion box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
          'Promotion Box',
          Column(children: [
            PromotionBox(
              badgeText: 'Neu',
              title: 'Bessere Übersicht.',
              description:
                  'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.',
            ),
          ]));

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'promotion_box',
        devices: TestApp.native_devices);
  });
}

