import 'dart:async';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  const String _message = 'Toast';
  final Stream<bool> _stream1 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> _stream2 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> _stream3 = (StreamController<bool>()..add(true)).stream;
  final Duration _duration = Duration(milliseconds: 0);
  testWidgets('toast basic test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        Toast.confirmation(
          message: _message,
          duration: _duration,
          stream: _stream1,
        ),
        Toast.warning(
          message: _message,
          duration: _duration,
          stream: _stream2,
        ),
        Toast.error(
          message: _message,
          duration: _duration,
          stream: _stream3,
        ),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'sbb_toast_test',
      find.byType(Column).first,
    );
  });
}
