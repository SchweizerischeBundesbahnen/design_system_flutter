import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('slider_1', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
      ..addScenario(
        'slider tests',
        Column(
          children: [
            SBBSlider(
              onChanged: (value) {},
              value: 50,
              max: 100,
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSlider(
              onChanged: (value) {},
              value: 25,
              max: 100,
              startIcon: null,
              endIcon: null,
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSlider(
              onChanged: null,
              value: 75,
              max: 100,
            ),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(
      tester,
      'slider_1',
      devices: TestApp.native_devices,
    );
  });
}
