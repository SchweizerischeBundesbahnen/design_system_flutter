import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('segmented_button_1', (WidgetTester tester) async {
    final widget = Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(sbbDefaultSpacing),
        child: Column(
          children: [
            SBBSegmentedButton(
              values: ['Option 1', 'Option 2', 'Option 3'],
              selectedStateIndex: 0,
              selectedIndexChanged: (_) {},
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSegmentedButton.icon(
              icons: {
                SBBIcons.microscooter_profile_small: 'Micro',
                SBBIcons.bicycle_small: 'Bicycle',
                SBBIcons.scooter_profile_small: 'Scooter',
              },
              selectedStateIndex: 1,
              selectedIndexChanged: (_) {},
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSegmentedButton.icon(
              icons: {
                SBBIcons.microscooter_profile_small: 'Micro',
                SBBIcons.bicycle_small: 'Bicycle',
                SBBIcons.scooter_profile_small: 'Scooter',
              },
              selectedStateIndex: 2,
              selectedIndexChanged: (_) {},
              withText: true,
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSegmentedButton.redText(
              values: ['Option 1', 'Option 2', 'Option 3'],
              selectedStateIndex: 2,
              selectedIndexChanged: (_) {},
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSegmentedButton.redIcon(
              icons: {
                SBBIcons.microscooter_profile_small: 'Micro',
                SBBIcons.bicycle_small: 'Bicycle',
                SBBIcons.scooter_profile_small: 'Scooter',
              },
              selectedStateIndex: 1,
              selectedIndexChanged: (_) {},
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBSegmentedButton.redIcon(
              icons: {
                SBBIcons.microscooter_profile_small: 'Micro',
                SBBIcons.bicycle_small: 'Bicycle',
                SBBIcons.scooter_profile_small: 'Scooter',
              },
              selectedStateIndex: 0,
              selectedIndexChanged: (_) {},
              withText: true,
            ),
          ],
        ),
      ),
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'segmented_button_1',
      find.byType(Align).first,
    );
  });
}
