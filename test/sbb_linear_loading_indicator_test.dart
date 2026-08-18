import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  generateTest('linear_loading_indicator', const SizedBox(width: 300, child: SBBLinearLoadingIndicator()));
}

void generateTest(String name, Widget widget) {
  testWidgets(name, (WidgetTester tester) async {
    await TestSpecs.runFixedFrame(
      TestSpecs.themedSpecs,
      widget,
      tester,
      name,
      find.byType(TestApp),
    );
  });
}
