import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('segmented_button_1', (WidgetTester tester) async {
    final builder =
        GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
          ..addScenario(
            'segmented button tests',
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 580.0,
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Column(
                  children: [
                    SBBSegmentedButton(
                      values: ['Option 1', 'Option 2', 'Option 3'],
                      selectedStateIndex: 2,
                      selectedIndexChanged: (_) {},
                    ),
                    const SizedBox(height: sbbDefaultSpacing),
                    SBBSegmentedButton.redText(
                      values: ['Option 1', 'Option 2', 'Option 3'],
                      selectedStateIndex: 2,
                      selectedIndexChanged: (_) {},
                    ),
                  ],
                ),
              ),
            ),
          );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(
      tester,
      'segmented_button_1',
      devices: TestApp.native_devices,
    );
  });
}
