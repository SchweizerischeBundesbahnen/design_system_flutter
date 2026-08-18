import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  generateTest('linear_loading_indicator', const SizedBox(width: 300, child: SBBLinearLoadingIndicator()));
}

void generateTest(String name, Widget widget) {
  // infinitely repeating animation. Pump a single fixed frame  instead.
  testWidgets(name, (WidgetTester tester) async {
    for (final spec in TestSpecs.themedSpecs) {
      await tester.binding.setSurfaceSize(spec.size);
      tester.view.physicalSize = spec.size;
      tester.view.devicePixelRatio = 1.0;
      tester.platformDispatcher.platformBrightnessTestValue = spec.brightness;

      await tester.pumpWidget(TestApp(child: widget));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 900));

      await expectLater(find.byType(TestApp), matchesGoldenFile('goldens/$name.${spec.name}.png'));
    }
  });
}
