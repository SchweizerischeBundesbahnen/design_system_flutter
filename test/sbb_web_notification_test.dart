import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  const String _message = 'Notification';
  testWidgets('notification basic test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBWebNotification.confirmation(_message, expand: true),
        SBBWebNotification.hint(_message, expand: true),
        SBBWebNotification.warning(_message, expand: true),
        SBBWebNotification.error(_message, expand: true)
      ],
    );

    await Specs.run(
      Specs.webSpecs,
      widget,
      tester,
      'basic_initial',
      find.byType(Column).first,
      hostType: HostPlatform.web,
    );
  });
}
