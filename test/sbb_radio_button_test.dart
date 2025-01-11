import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
            child: Row(
              children: [
                SBBRadioButton<int>(
                  groupValue: groupValue,
                  onChanged: (newValue) {},
                  value: 1,
                ),
                SBBRadioButton<int>(
                  groupValue: groupValue,
                  onChanged: null,
                  value: 2,
                ),
                SBBRadioButton<int>(
                  groupValue: groupValue,
                  onChanged: (newValue) {},
                  value: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('RadioButton Item - List'),
          SBBGroup(
            child: Column(
              children: [
                SBBRadioButtonListItem<int>(
                  value: 1,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Label',
                ),
                SBBRadioButtonListItem<int>(
                  value: 2,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Button',
                  trailingIcon: SBBIcons.circle_information_small_small,
                  onCallToAction: () {},
                ),
                SBBRadioButtonListItem<int>(
                  value: 3,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Leading and Button',
                  trailingIcon: SBBIcons.circle_information_small_small,
                  onCallToAction: () {},
                ),
                SBBRadioButtonListItem<int>(
                  value: 4,
                  groupValue: listItemGroupValue,
                  onChanged: null,
                  label: 'Leading Icon, Button (Disabled)',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                  onCallToAction: () {},
                ),
                SBBRadioButtonListItem<int>(
                  value: 5,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Leading Icon',
                  leadingIcon: SBBIcons.alarm_clock_small,
                ),
                SBBRadioButtonListItem<int>(
                  value: 6,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Leading and Trailing Icon',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBRadioButtonListItem<int>(
                  value: 7,
                  groupValue: listItemGroupValue,
                  onChanged: null,
                  label: 'Leading and Trailing Icon (Disabled)',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBRadioButtonListItem<int>.custom(
                  value: 8,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Custom trailing Widget',
                  trailingWidget: const Padding(
                    padding: EdgeInsets.only(
                      top: sbbDefaultSpacing * .75,
                      right: sbbDefaultSpacing,
                    ),
                    child: Text('CHF 0.99'),
                  ),
                ),
                SBBRadioButtonListItem<int>(
                  value: 9,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Multiline Label with\nSecondary Label',
                  allowMultilineLabel: true,
                  secondaryLabel: 'Test',
                  isLastElement: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('RadioButton Item - List'),
          Column(
            // spacing: sbbDefaultSpacing * 0.5,  add once support for Flutter SDK 3.24.5 removed
            // and remove SizedBoxes below
            children: [
              SBBGroup(
                child: SBBRadioButtonListItem<int>.boxed(
                  value: 1,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Label',
                ),
              ),
              SizedBox(height: sbbDefaultSpacing * .5),
              SBBGroup(
                child: SBBRadioButtonListItem<int>.boxed(
                  value: 2,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Leading and Trailing Icon',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.dog_small,
                ),
              ),
              SizedBox(height: sbbDefaultSpacing * .5),
              SBBGroup(
                child: SBBRadioButtonListItem<int>.boxed(
                  value: 3,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Button',
                  trailingIcon: SBBIcons.circle_information_small_small,
                  onCallToAction: () => {},
                ),
              ),
              SizedBox(height: sbbDefaultSpacing * .5),
              SBBGroup(
                child: SBBRadioButtonListItem<int>.custom(
                  value: 4,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Custom trailing Widget',
                  trailingWidget: const Padding(
                    padding: EdgeInsets.only(
                      top: sbbDefaultSpacing * .75,
                      right: sbbDefaultSpacing,
                    ),
                    child: Text('CHF 0.99'),
                  ),
                  isLastElement: false,
                ),
              ),
            ],
          )
        ],
      );
}
