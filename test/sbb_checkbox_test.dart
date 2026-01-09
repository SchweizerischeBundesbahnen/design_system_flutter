import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
  const CheckboxTest({super.key, required this.value1, this.value2, required this.value3});

  final bool value1;
  final bool? value2;
  final bool value3;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SBBListHeader('Checkbox'),
      SBBContentBox(
        padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
        child: Row(
          children: [
            SBBCheckbox(onChanged: (bool? value) {}, value: value1),
            SBBCheckbox(onChanged: null, value: value1),
            SBBCheckbox(onChanged: (bool? value) {}, value: value2, tristate: true),
            SBBCheckbox(onChanged: null, value: value2, tristate: true),
          ],
        ),
      ),
      const SizedBox(height: sbbDefaultSpacing),
      const SBBListHeader('CheckboxItem - List'),
      SBBContentBox(
        child: Column(
          children: SBBListItemV5.divideListItems(
            context: context,
            items: [
              SBBCheckboxListItem(value: value1, titleText: 'Default', onChanged: (value) {}),
              SBBCheckboxListItem(value: value2, titleText: 'Tristate', tristate: true, onChanged: (value) {}),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Leading Icon',
                onChanged: (value) {},
                leadingIconData: SBBIcons.alarm_clock_small,
              ),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Trailing Icon',
                onChanged: (value) {},
                trailingIconData: SBBIcons.dog_small,
              ),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Leading and Trailing Icon',
                onChanged: (value) {},
                leadingIconData: SBBIcons.alarm_clock_small,
                trailingIconData: SBBIcons.dog_small,
              ),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Leading and Trailing Icon (Disabled)',
                enabled: false,
                onChanged: (_) {},
                leadingIconData: SBBIcons.alarm_clock_small,
                trailingIconData: SBBIcons.dog_small,
              ),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Button',
                onChanged: (_) {},
                padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                trailing: SBBTertiaryButtonSmall(
                  iconData: SBBIcons.circle_information_small_small,
                  onPressed: () {},
                ),
              ),
              SBBCheckboxListItem(
                value: value3,
                titleText: 'Leading Icon and Button',
                onChanged: (_) {},
                padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                trailing: SBBTertiaryButtonSmall(
                  iconData: SBBIcons.circle_information_small_small,
                  onPressed: () {},
                ),
                leadingIconData: SBBIcons.alarm_clock_small,
              ),
              SBBCheckboxListItem(
                value: value3,
                onChanged: null,
                titleText: 'Leading Icon and Button (Disabled)',
                padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                trailing: SBBTertiaryButtonSmall(
                  iconData: SBBIcons.circle_information_small_small,
                  onPressed: null,
                ),
                leadingIconData: SBBIcons.alarm_clock_small,
              ),
              SBBCheckboxListItem(
                value: false,
                titleText: 'Custom Trailing',
                onChanged: (value) {},
                trailing: Text('CHF 0.99'),
              ),
            ],
          ).toList(growable: false),
        ),
      ),
      const SizedBox(height: sbbDefaultSpacing),
      const SBBListHeader('CheckboxItem - Boxed'),
      Column(
        spacing: sbbDefaultSpacing * .5,
        children: [
          SBBCheckboxListItemBoxed(value: value1, titleText: 'Default', onChanged: (value) {}),
          SBBCheckboxListItemBoxed(
            value: value2,
            titleText: 'Tristate',
            tristate: true,
            onChanged: (value) {},
          ),
          SBBCheckboxListItemBoxed(
            value: value3,
            titleText: 'Leading Icon and Button (Disabled)',
            onChanged: null,
            padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
            trailing: SBBTertiaryButtonSmall(
              iconData: SBBIcons.circle_information_small_small,
              onPressed: null,
            ),
            leadingIconData: SBBIcons.alarm_clock_small,
          ),
          SBBCheckboxListItemBoxed(
            value: false,
            titleText: 'Custom Trailing',
            onChanged: (value) {},
            trailing: Text('CHF 0.99'),
          ),
        ],
      ),
    ],
  );
}
