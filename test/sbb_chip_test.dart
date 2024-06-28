import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('chip_1', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBChip(
          label: 'Default',
          badgeLabel: '9',
          onSelection: (selected) {},
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'Default & No Badge',
          onSelection: (selected) {},
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'This is a very long text with a longer badge label, that should not be longer than one line.',
          badgeLabel: 'Production',
          onSelection: (selected) {},
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'Selected',
          badgeLabel: '3',
          selected: true,
          onSelection: (selected) {},
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'Selected & No Badge',
          selected: true,
          onSelection: (selected) {},
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'Disabled',
          onSelection: null,
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBChip(
          label: 'Disabled & Selected',
          selected: true,
          onSelection: null,
        ),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'chip_1',
      find.byType(Column).first,
    );
  });
}
