import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('pagination', (WidgetTester tester) async {
    final builder =
        GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
          ..addScenario(
            'test pagination',
            Column(
              children: [
                SBBPagination(numberPages: 1, currentPage: 0),
                SizedBox(height: sbbDefaultSpacing),
                SBBPagination(numberPages: 2, currentPage: 0),
                SizedBox(height: sbbDefaultSpacing),
                SBBPagination(numberPages: 5, currentPage: 4),
                SizedBox(height: sbbDefaultSpacing),
                // floating
                SBBPagination(
                  numberPages: 1,
                  currentPage: 0,
                  isFloating: true,
                ),
                SizedBox(height: sbbDefaultSpacing),
                // add containter to see the shadow and floating box
                Container(
                  color: SBBColors.white,
                  padding: const EdgeInsets.all(sbbDefaultSpacing),
                  child: SBBPagination(
                    numberPages: 2,
                    currentPage: 0,
                    isFloating: true,
                  ),
                ),
                SizedBox(height: sbbDefaultSpacing),
                Container(
                  color: SBBColors.white,
                  padding: const EdgeInsets.all(sbbDefaultSpacing),
                  child: SBBPagination(
                    numberPages: 5,
                    currentPage: 4,
                    isFloating: true,
                  ),
                ),
              ],
            ),
          );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(
      tester,
      'pagination',
      devices: TestApp.native_devices,
    );
  });
}
