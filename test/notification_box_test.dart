import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

const title = 'Title';
const text =
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magn…';

void main() {
  testGoldens('alert notification box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
        'alert notification box',
        Column(
          children: [
            SBBNotificationBox.alert(title: title, text: text, onTap: () {}),
            SizedBox(height: sbbDefaultSpacing),
            SBBNotificationBox.alert(text: text),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'notification_box_alert',
        devices: TestApp.native_devices);
  });
  testGoldens('warning notification box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
        'warning notification box',
        Column(
          children: [
            SBBNotificationBox.warning(title: title, text: text, onTap: () {}),
            SizedBox(height: sbbDefaultSpacing),
            SBBNotificationBox.warning(text: text),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'notification_box_warning',
        devices: TestApp.native_devices);
  });
  testGoldens('success notification box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
        'success notification box',
        Column(
          children: [
            SBBNotificationBox.success(title: title, text: text, onTap: () {}),
            SizedBox(height: sbbDefaultSpacing),
            SBBNotificationBox.success(text: text),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'notification_box_success',
        devices: TestApp.native_devices);
  });
  testGoldens('information notification box test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.native))
      ..addScenario(
        'information notification box',
        Column(
          children: [
            SBBNotificationBox.information(title: title, text: text, onTap: () {}),
            SizedBox(height: sbbDefaultSpacing),
            SBBNotificationBox.information(text: text),
          ],
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'notification_box_information',
        devices: TestApp.native_devices);
  });
}
