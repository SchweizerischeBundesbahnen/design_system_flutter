import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('status test', (WidgetTester tester) async {
    const String text = 'Lorem ipsum sit dolor';
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
        'Status',
        Column(
          children: [
            SBBStatusMobile.alert(text: text),
            const SizedBox(height: sbbDefaultSpacing),
            SBBStatusMobile.warning(text: text),
            const SizedBox(height: sbbDefaultSpacing),
            SBBStatusMobile.success(text: text),
            const SizedBox(height: sbbDefaultSpacing),
            SBBStatusMobile.information(text: text),
            const SizedBox(height: sbbDefaultSpacing),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'status',
        devices: TestApp.native_devices);
  });
}
