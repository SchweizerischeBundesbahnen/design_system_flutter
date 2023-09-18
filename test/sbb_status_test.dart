import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('status test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.web))
      ..addScenario(
          'Status',
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SBBStatus.valid(),
            SBBStatus.warning(),
            SBBStatus.invalid(),
            SBBStatus.inProgress(),
            SBBStatus.inactive(),
            SBBStatus.valid(
              showIcon: false,
              text: 'Success',
            ),
            SBBStatus.warning(
              showIcon: false,
              text: 'Warning',
            ),
            SBBStatus.invalid(
              showIcon: false,
              text: 'Failure',
            ),
            SBBStatus.inProgress(
              showIcon: false,
              text: 'In Progress',
            ),
            SBBStatus.inactive(
              showIcon: false,
              text: 'Offline',
            ),
            SBBStatus.valid(
              text: 'Everything is valid',
            ),
            SBBStatus.warning(
              text: 'There is a potential problem',
            ),
            SBBStatus.invalid(
              text: 'Somethign needs to be corrected',
            ),
            SBBStatus.inProgress(
              text: 'Process is in progress',
            ),
            SBBStatus.inactive(
              text: 'Application is offline',
            ),
          ]));

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'status_test', devices: TestApp.web_devices);
  });
}
