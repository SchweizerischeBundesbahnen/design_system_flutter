import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('primary_button', (WidgetTester tester) async {
    final pressableKey = ValueKey('pressedPrimaryButton');
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2, vertical: sbbDefaultSpacing),
      child: Column(
        spacing: sbbDefaultSpacing,
        children: [
          SBBPrimaryButton(key: pressableKey, labelText: "Default", onPressed: () {}),
          SBBPrimaryButton(labelText: "Disabled", onPressed: null),
          SBBPrimaryButton(
            label: Container(color: SBBColors.platinum, child: Text('Custom!')),
            onPressed: () {},
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'primary_button',
      find.byType(Column).first,
    );
    await tester.press(find.byKey(pressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'primary_button_pressed',
      find.byType(Column).first,
    );
  });
}
