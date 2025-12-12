import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('chip_1', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBChip(labelText: 'Default', trailingText: '9', onChanged: (selected) {}),
        const SizedBox(height: sbbDefaultSpacing),
        SBBChip(labelText: 'Default & No Badge', onChanged: (selected) {}),
        const SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          labelText: 'This is a very long text with a longer badge label, that should not be longer than one line.',
          trailingText: 'Production',
          onChanged: (selected) {},
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBChip(labelText: 'Selected', trailingText: '3', selected: true, onChanged: (selected) {}),
        const SizedBox(height: sbbDefaultSpacing),
        SBBChip(labelText: 'Selected & No Badge', selected: true, onChanged: (selected) {}),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBChip(labelText: 'Disabled', onChanged: null),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBChip(labelText: 'Disabled & Selected', selected: true, onChanged: null),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'chip_1',
      find.byType(Column).first,
    );
  });
}
