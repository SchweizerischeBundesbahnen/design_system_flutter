import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('accent_button', (WidgetTester tester) async {
    final pressableKey = ValueKey('pressedButton');
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBAccentButton(key: pressableKey, labelText: 'Default', onPressed: () {}),
          SBBAccentButton(labelText: 'Disabled', onPressed: null),
          SBBAccentButton(
            label: Container(color: SBBColors.platinum, child: Text('Custom!')),
            onPressed: () {},
          ),
          SBBAccentButton(
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
      'accent_button',
      find.byType(Column).first,
    );
    await tester.press(find.byKey(pressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'accent_button_pressed',
      find.byType(Column).first,
    );
  });
}
