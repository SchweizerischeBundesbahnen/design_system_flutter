import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'golden_diff_comparator.dart';
import 'test_app.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final testUrl = (goldenFileComparator as LocalFileComparator).basedir;
  goldenFileComparator = GoldenDiffComparator('$testUrl/test.dart');
  return GoldenToolkit.runWithConfiguration(
        () => TestApp.setupAll().then((value) => testMain()),
    config: GoldenToolkitConfiguration(skipGoldenAssertion: () => false),
  );
}
