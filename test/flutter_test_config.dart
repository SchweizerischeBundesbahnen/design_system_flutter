import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final skipGoldenAssertion = 'macos10.16' != '${Platform.operatingSystem}${Platform.operatingSystemVersion}';
  return GoldenToolkit.runWithConfiguration(
    () => TestApp.setupAll().then((value) => testMain()),
    config: GoldenToolkitConfiguration(skipGoldenAssertion: () => skipGoldenAssertion),
  );
}
