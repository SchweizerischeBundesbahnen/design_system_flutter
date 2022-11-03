import 'dart:async';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  final String _message = 'Toast';
  final Stream<bool> _stream1 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> _stream2 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> _stream3 = (StreamController<bool>()..add(true)).stream;
  final Duration _duration = Duration(milliseconds: 0);
  testGoldens('toast basic test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.web))
      ..addScenario(
          'Toasts',
          Column(children: [
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
          ]));

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'sbb_toast_test',
        devices: TestApp.web_devices);
  });
}
