import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('chip_1', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
      ..addScenario(
        'test chips',
        Column(
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
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(
      tester,
      'chip_1',
      devices: TestApp.native_devices,
    );
  });
}
