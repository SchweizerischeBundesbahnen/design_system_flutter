import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, int? v1, int? v2) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = RadioTest(groupValue: v1, listItemGroupValue: v2);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        '${name}_initial',
        find.byType(RadioTest),
      );
    });
  }

  generateTest('radio_test_1', null, null);
  generateTest('radio_test_2', 1, 1);
  generateTest('radio_test_3', 2, 4);
}

class RadioTest extends StatelessWidget {
  const RadioTest({super.key, required this.groupValue, required this.listItemGroupValue});

  final int? groupValue;
  final int? listItemGroupValue;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SBBListHeader('RadioButton'),
      Padding(
        padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
        child: SBBRadioGroup<int>(
          groupValue: groupValue,
          onChanged: (_) {},
          child: Row(
            children: [
              SBBRadio<int>(value: 1),
              SBBRadio<int>(value: 2, enabled: false),
              SBBRadio<int>(value: 3),
              SBBRadio<int>(value: 4, style: SBBRadioStyle(fillColor: WidgetStatePropertyAll(SBBColors.turquoise))),
            ],
          ),
        ),
      ),
      const SizedBox(height: sbbDefaultSpacing),
      const SBBListHeader('RadioButton Item - List'),
      SBBGroup(
        child: Column(
          children: [
            SBBRadioGroup(
              groupValue: listItemGroupValue,
              onChanged: (_) {},
              child: Column(
                children: [
                  SBBRadioListItem<int>(value: 1, label: 'Label'),
                  SBBRadioListItem<int>(
                    value: 2,
                    label: 'Button',
                    trailingIcon: SBBIcons.circle_information_small_small,
                    onCallToAction: () {},
                  ),
                  SBBRadioListItem<int>(
                    value: 3,
                    label: 'Leading and Button',
                    leadingIcon: SBBIcons.alarm_clock_small,
                    trailingIcon: SBBIcons.circle_information_small_small,
                    onCallToAction: () {},
                  ),

                  SBBRadioListItem<int>(
                    value: 5,
                    label: 'Leading Icon',
                    leadingIcon: SBBIcons.alarm_clock_small,
                  ),
                  SBBRadioListItem<int>(
                    value: 6,
                    label: 'Leading and Trailing Icon',
                    leadingIcon: SBBIcons.alarm_clock_small,
                    trailingIcon: SBBIcons.circle_information_small_small,
                  ),

                  SBBRadioListItem<int>.custom(
                    value: 8,
                    label: 'Custom trailing Widget',
                    trailingWidget: const Padding(
                      padding: EdgeInsets.only(top: sbbDefaultSpacing * .75, right: sbbDefaultSpacing),
                      child: Text('CHF 0.99'),
                    ),
                  ),
                  SBBRadioListItem<int>(
                    value: 9,
                    label: 'Multiline Label with\nSecondary Label',
                    allowMultilineLabel: true,
                    secondaryLabel: 'Test',
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SBBRadioListItem<int>(
                  value: 4,
                  label: 'Leading Icon, Button (Disabled)',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                  onCallToAction: () {},
                ),
                SBBRadioListItem<int>(
                  value: 7,
                  label: 'Leading and Trailing Icon (Disabled)',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                  isLastElement: true,
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: sbbDefaultSpacing),
      const SBBListHeader('RadioButton Item - List'),
      SBBRadioGroup(
        groupValue: listItemGroupValue,
        onChanged: (_) {},
        child: Column(
          spacing: sbbDefaultSpacing * 0.5,
          children: [
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 1,
                label: 'Label',
              ),
            ),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 2,
                label: 'Leading and Trailing Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.dog_small,
              ),
            ),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 3,
                label: 'Button',
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => {},
              ),
            ),
            SBBGroup(
              child: SBBRadioListItem<int>.custom(
                value: 4,
                label: 'Custom trailing Widget',
                trailingWidget: const Padding(
                  padding: EdgeInsets.only(top: sbbDefaultSpacing * .75, right: sbbDefaultSpacing),
                  child: Text('CHF 0.99'),
                ),
                isLastElement: true,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
