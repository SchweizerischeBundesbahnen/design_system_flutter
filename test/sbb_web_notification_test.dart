import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  final String _message = 'Notification';
  testGoldens('notification basic test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.web))
      ..addScenario(
          'Expanded Notifications',
          Column(children: [
            SBBWebNotification.confirmation(_message, expand: true),
            SBBWebNotification.hint(_message, expand: true),
            SBBWebNotification.warning(_message, expand: true),
            SBBWebNotification.error(_message, expand: true)
          ]));

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'basic_initial',
        devices: TestApp.web_devices);
  });
}
