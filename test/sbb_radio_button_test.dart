import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, int? v1, int? v2) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = RadioTest(groupValue: v1, listItemGroupValue: v2);

      await Specs.run(
        Specs.mobileSpecs,
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
  const RadioTest(
      {Key? key, required this.groupValue, required this.listItemGroupValue})
      : super(key: key);

  final int? groupValue;
  final int? listItemGroupValue;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBBListHeader('RadioButton'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
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
          SBBListHeader('RadioButtonListItem'),
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
                  label: 'Call to Action',
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBRadioButtonListItem<int>(
                  value: 3,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Icon',
                  leadingIcon: SBBIcons.alarm_clock_small,
                ),
                SBBRadioButtonListItem<int>(
                  value: 4,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Icon, Call to Action',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBRadioButtonListItem<int>(
                  value: 4,
                  groupValue: listItemGroupValue,
                  onChanged: null,
                  label: 'Disabled, Icon, Call to Action',
                  leadingIcon: SBBIcons.alarm_clock_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                SBBRadioButtonListItem<int>.custom(
                  value: 5,
                  groupValue: listItemGroupValue,
                  onChanged: (newValue) {},
                  label: 'Custom trailing Widget',
                  trailingWidget: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text('CHF 0.99'),
                  ),
                ),
                SBBRadioButtonListItem<int>(
                  value: 6,
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
        ],
      );
}
