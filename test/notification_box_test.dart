import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

const title = 'Title';
const text =
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magn…';

void main() {
  testWidgets('alert notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.alert(title: title, text: text, onTap: () {}),
        SizedBox(height: sbbDefaultSpacing),
        SBBNotificationBox.alert(text: text),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'notification_box_alert',
      find.byType(Column).first,
    );
  });

  testWidgets('warning notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.warning(title: title, text: text, onTap: () {}),
        SizedBox(height: sbbDefaultSpacing),
        SBBNotificationBox.warning(text: text),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'notification_box_warning',
      find.byType(Column).first,
    );
  });

  testWidgets('success notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.success(title: title, text: text, onTap: () {}),
        SizedBox(height: sbbDefaultSpacing),
        SBBNotificationBox.success(text: text),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'notification_box_success',
      find.byType(Column).first,
    );
  });

  testWidgets('information notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.information(title: title, text: text, onTap: () {}),
        SizedBox(height: sbbDefaultSpacing),
        SBBNotificationBox.information(text: text),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'notification_box_information',
      find.byType(Column).first,
    );
  });
}
