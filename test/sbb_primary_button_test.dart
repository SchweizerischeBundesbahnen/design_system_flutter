import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('primary_button', (WidgetTester tester) async {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2),
      child: Column(
        children: [
          const SizedBox(height: sbbDefaultSpacing),
          SBBPrimaryButton(label: "Default", onPressed: () {}),
          const SizedBox(height: sbbDefaultSpacing),
          SBBPrimaryButton(label: "Disabled", onPressed: null),
        ],
      ),
    );
    await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, 'primary_button', find.byType(Column).first);
  });
}
