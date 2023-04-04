import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async =>
    GoldenToolkit.runWithConfiguration(
      () => TestApp.setupAll().then((value) => testMain()),
      config: GoldenToolkitConfiguration(skipGoldenAssertion: () => false),
    );
