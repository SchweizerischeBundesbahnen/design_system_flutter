import 'dart:async';

import 'test_app.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await TestApp.setupAll();
  await testMain();
}
