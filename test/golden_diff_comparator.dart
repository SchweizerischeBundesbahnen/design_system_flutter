import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class GoldenDiffComparator extends LocalFileComparator {
  GoldenDiffComparator(
      String testFile, {
        this.tolerance = 0.005,
      }) : super(Uri.parse(testFile));

  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final ComparisonResult result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent > tolerance) {
      final String error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    if (!result.passed) {
      log('A tolerable difference of ${result.diffPercent * 100}% was found when comparing $golden.');
    }
    return result.passed || result.diffPercent <= tolerance;
  }
}