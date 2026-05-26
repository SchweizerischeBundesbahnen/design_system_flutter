import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

const title = 'Title';
const text =
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magn…';

void main() {
  testWidgets('alert notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.alert(titleText: title, text: text, onTap: () {}),
        const SizedBox(height: SBBSpacing.medium),
        SBBNotificationBox.alert(text: text),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_alert',
      find.byType(Column).first,
    );
  });

  testWidgets('warning notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.warning(titleText: title, text: text, onTap: () {}),
        const SizedBox(height: SBBSpacing.medium),
        SBBNotificationBox.warning(text: text),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_warning',
      find.byType(Column).first,
    );
  });

  testWidgets('success notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.success(titleText: title, text: text, onTap: () {}),
        const SizedBox(height: SBBSpacing.medium),
        SBBNotificationBox.success(text: text),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_success',
      find.byType(Column).first,
    );
  });

  testWidgets('information notification box test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBNotificationBox.information(titleText: title, text: text, onTap: () {}),
        const SizedBox(height: SBBSpacing.medium),
        SBBNotificationBox.information(text: text),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_information',
      find.byType(Column).first,
    );
  });
}
