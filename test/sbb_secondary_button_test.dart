import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('secondary_button', (WidgetTester tester) async {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2, vertical: sbbDefaultSpacing),
      child: Column(
        spacing: sbbDefaultSpacing,
        children: [
          SBBSecondaryButton(labelText: "Default", onPressed: () {}),
          SBBSecondaryButton(labelText: "Disabled", onPressed: null),
          SBBSecondaryButton(
            label: Container(color: SBBColors.platinum, child: Text('Custom!')),
            onPressed: () {},
          ),
          SBBSecondaryButton(
            onPressed: null,
            labelText: 'Custom Style',
            style: SBBButtonStyle(backgroundColor: WidgetStatePropertyAll(SBBColors.silver)),
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'secondary_button',
      find.byType(Column).first,
    );
  });
}
