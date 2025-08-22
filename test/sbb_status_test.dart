import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('status test', (WidgetTester tester) async {
    const String text = 'Lorem ipsum sit dolor';
    final widget = Column(
      children: [
        SBBStatus.alert(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatus.warning(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatus.success(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatus.information(text: text),
        const SizedBox(height: sbbDefaultSpacing),
      ],
    );

    await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, 'status', find.byType(Column).first);
  });
}
