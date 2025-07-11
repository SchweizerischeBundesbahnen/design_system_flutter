import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';

import 'test_app.dart';

void main() {
  const String title = 'Toast';
  final Stream<bool> stream1 = (StreamController<bool>()..add(true)).stream;
  const Duration duration = Duration(milliseconds: 0);
  testWidgets('toast basic test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        DefaultToastBody(
          title: title,
          duration: duration,
          stream: stream1,
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'sbb_toast_test',
      find.byType(Column).first,
    );
  });
}
