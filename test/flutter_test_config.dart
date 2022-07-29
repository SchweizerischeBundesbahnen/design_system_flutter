import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final skipGoldenAssertion = Platform.operatingSystem != 'macos' || !Platform.operatingSystemVersion.contains('12');
  return GoldenToolkit.runWithConfiguration(
    () => TestApp.setupAll().then((value) => testMain()),
    config: GoldenToolkitConfiguration(skipGoldenAssertion: () => skipGoldenAssertion),
  );
}
