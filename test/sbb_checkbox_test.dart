import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, bool v1, bool? v2, bool v3) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = CheckboxTest(value1: v1, value2: v2, value3: v3);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        '${name}_initial',
        find.byType(CheckboxTest),
      );
    });
  }

  generateTest('checkbox_test_1', false, false, false);
  generateTest('checkbox_test_2', true, true, true);
  generateTest('checkbox_test_3', false, null, false);
}

class CheckboxTest extends StatelessWidget {
  const CheckboxTest({
    super.key,
    required this.value1,
    this.value2,
    required this.value3,
  });

  final bool value1;
  final bool? value2;
  final bool value3;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBBListHeader('Checkbox'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
            child: Row(
              children: [
                SBBCheckbox(
                  onChanged: (bool? value) {},
                  value: value1,
                ),
                SBBCheckbox(
                  onChanged: null,
                  value: value1,
                ),
                SBBCheckbox(
                  onChanged: (bool? value) {},
                  value: value2,
                  tristate: true,
                ),
                SBBCheckbox(
                  onChanged: null,
                  value: value2,
                  tristate: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('CheckboxItem - List'),
          SBBGroup(
            child: Column(
              children: [
                SBBCheckboxListItem(
                  value: value1,
                  label: 'Default',
                  onChanged: (value) {},
                ),
                SBBCheckboxListItem(
                  value: value2,
                  label: 'Tristate',
                  tristate: true,
                  onChanged: (value) {},
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Leading Icon',
                  onChanged: (value) {},
                  leadingIcon: SBBIcons.alarm_clock_small,
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Trailing Icon',
                  onChanged: (value) {},
                  trailingIcon: SBBIcons.dog_small,
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Leading and Trailing Icon',
                  onChanged: (value) {},
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.dog_small,
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Leading and Trailing Icon (Disabled)',
                  onChanged: null,
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.dog_small,
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Button',
                  onChanged: (value) {},
                  onCallToAction: () {},
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBCheckboxListItem(
                  value: value3,
                  label: 'Leading Icon and Button',
                  onChanged: (value) {},
                  onCallToAction: () {},
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBCheckboxListItem(
                  value: value3,
                  label: 'Leading Icon and Button (Disabled)',
                  onChanged: null,
                  onCallToAction: () {},
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBCheckboxListItem.custom(
                  value: false,
                  label: 'Custom trailing Widget',
                  isLastElement: true,
                  onChanged: (value) {},
                  trailingWidget: const Padding(
                    padding: EdgeInsets.only(top: sbbDefaultSpacing * 0.75, right: sbbDefaultSpacing),
                    child: Text('CHF 0.99'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('CheckboxItem - Boxed'),
          Column(
            spacing: sbbDefaultSpacing * .5,
            children: [
              SBBGroup(
                child: SBBCheckboxListItem.boxed(
                  value: value1,
                  label: 'Default',
                  onChanged: (value) {},
                ),
              ),
              SBBGroup(
                child: SBBCheckboxListItem.boxed(
                  value: value2,
                  label: 'Tristate',
                  tristate: true,
                  onChanged: (value) {},
                ),
              ),
              SBBGroup(
                child: SBBCheckboxListItem.boxed(
                  value: value3,
                  label: 'Leading Icon, Button (Disabled)',
                  onChanged: null,
                  onCallToAction: () {},
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
              ),
              SBBGroup(
                child: SBBCheckboxListItem.custom(
                  value: false,
                  label: 'Custom trailing Widget',
                  isLastElement: true,
                  onChanged: (value) {},
                  trailingWidget: const Padding(
                    padding: EdgeInsets.only(top: sbbDefaultSpacing * 0.75, right: sbbDefaultSpacing),
                    child: Text('CHF 0.99'),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
