import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('segmented_button_1', (WidgetTester tester) async {
    final widget = Padding(
      padding: EdgeInsets.all(SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBSegmentedButton<String>(
            segments: const [
              SBBButtonSegment(value: 'option1', labelText: 'Option 1'),
              SBBButtonSegment(value: 'option2', labelText: 'Option 2'),
              SBBButtonSegment(value: 'option3', labelText: 'Option 3'),
            ],
            selected: 'option1',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButton<String>(
            segments: const [
              SBBButtonSegment(value: 'micro', leadingIconData: SBBIcons.microscooter_profile_small),
              SBBButtonSegment(value: 'bicycle', leadingIconData: SBBIcons.bicycle_small),
              SBBButtonSegment(value: 'scooter', leadingIconData: SBBIcons.scooter_profile_small),
            ],
            selected: 'bicycle',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButton<String>(
            segments: const [
              SBBButtonSegment(
                value: 'micro',
                leadingIconData: SBBIcons.microscooter_profile_small,
                labelText: 'Micro',
              ),
              SBBButtonSegment(value: 'bicycle', leadingIconData: SBBIcons.bicycle_small, labelText: 'Bicycle'),
              SBBButtonSegment(value: 'scooter', leadingIconData: SBBIcons.scooter_profile_small, labelText: 'Scooter'),
            ],
            selected: 'scooter',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButtonFilled<String>(
            segments: const [
              SBBButtonSegment(value: 'option1', labelText: 'Option 1'),
              SBBButtonSegment(value: 'option2', labelText: 'Option 2'),
              SBBButtonSegment(value: 'option3', labelText: 'Option 3'),
            ],
            selected: 'option3',
            onSelectionChanged: (_) {},
            style: SBBSegmentedButtonStyle(
              segmentStyle: SBBButtonSegmentStyle(
                foregroundColor: WidgetStatePropertyAll(SBBColors.red),
              ),
            ),
          ),
          SBBSegmentedButtonFilled<String>(
            segments: const [
              SBBButtonSegment(value: 'micro', leadingIconData: SBBIcons.microscooter_profile_small),
              SBBButtonSegment(value: 'bicycle', leadingIconData: SBBIcons.bicycle_small),
              SBBButtonSegment(value: 'scooter', leadingIconData: SBBIcons.scooter_profile_small),
            ],
            selected: 'bicycle',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButtonFilled<String>(
            segments: const [
              SBBButtonSegment(
                value: 'micro',
                leadingIconData: SBBIcons.microscooter_profile_small,
                labelText: 'Micro',
              ),
              SBBButtonSegment(value: 'bicycle', leadingIconData: SBBIcons.bicycle_small, labelText: 'Bicycle'),
              SBBButtonSegment(value: 'scooter', leadingIconData: SBBIcons.scooter_profile_small, labelText: 'Scooter'),
            ],
            selected: 'micro',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButton<String>(
            segments: const [
              SBBButtonSegment(value: 'option', labelText: 'Single Option'),
            ],
            selected: 'option',
            onSelectionChanged: (_) {},
          ),
          SBBSegmentedButton<String>(
            segments: const [
              SBBButtonSegment(value: 'user', leadingIconData: SBBIcons.user_small, labelText: 'Single'),
            ],
            selected: 'user',
            onSelectionChanged: (_) {},
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'segmented_button_1',
      find.byType(Column).first,
    );
  });

  testWidgets('segmented_button_custom_label', (WidgetTester tester) async {
    final widget = Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(SBBSpacing.medium),
        child: SBBSegmentedButton<String>(
          segments: [
            SBBButtonSegment(
              value: 'badge1',
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: SBBColors.green,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text('Custom Label 1', style: TextStyle(color: SBBColors.white)),
              ),
            ),
            SBBButtonSegment(
              value: 'badge2',
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: SBBColors.green,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text('Custom Label 2', style: TextStyle(color: SBBColors.white)),
              ),
            ),
            SBBButtonSegment(
              value: 'badge3',
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: SBBColors.green,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text('Custom Label 3', style: TextStyle(color: SBBColors.white)),
              ),
            ),
          ],
          selected: 'badge2',
          onSelectionChanged: (_) {},
        ),
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'segmented_button_custom_label',
      find.byType(Align).first,
    );
  });
}
