import 'dart:async';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  const String message = 'Toast';
  final Stream<bool> stream1 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream2 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream3 = (StreamController<bool>()..add(true)).stream;
  const Duration duration = Duration(milliseconds: 0);
  testWidgets('toast basic test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        Toast.confirmation(
          message: message,
          duration: duration,
          stream: stream1,
        ),
        Toast.warning(
          message: message,
          duration: duration,
          stream: stream2,
        ),
        Toast.error(
          message: message,
          duration: duration,
          stream: stream3,
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
