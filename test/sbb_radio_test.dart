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
      SBBContentBox(
        child: Column(
          children: [
            SBBRadioGroup(
              groupValue: listItemGroupValue,
              onChanged: (_) {},
              child: Column(
                children: SBBListItemV5.divideListItems(
                  context: context,
                  items: [
                    SBBRadioListItem<int>(value: 1, titleText: 'Label'),
                    SBBRadioListItem<int>(
                      value: 2,
                      titleText: 'Button',
                      padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                      trailing: SBBTertiaryButtonSmall(
                        iconData: SBBIcons.circle_information_small_small,
                        onPressed: () {},
                      ),
                    ),
                    SBBRadioListItem<int>(
                      value: 3,
                      titleText: 'Leading and Button',
                      padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                      trailing: SBBTertiaryButtonSmall(
                        iconData: SBBIcons.circle_information_small_small,
                        onPressed: () {},
                      ),
                    ),
                    SBBRadioListItem<int>(
                      value: 4,
                      enabled: false,
                      titleText: 'Leading Icon, Button (Disabled)',
                      padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                      trailing: SBBTertiaryButtonSmall(
                        iconData: SBBIcons.circle_information_small_small,
                        onPressed: null,
                      ),
                    ),
                    SBBRadioListItem<int>(
                      value: 5,
                      titleText: 'Leading Icon',
                      leadingIconData: SBBIcons.alarm_clock_small,
                    ),
                    SBBRadioListItem<int>(
                      value: 6,
                      titleText: 'Leading and Trailing Icon',
                      leadingIconData: SBBIcons.alarm_clock_small,
                      trailingIconData: SBBIcons.circle_information_small_small,
                    ),
                    SBBRadioListItem<int>(
                      value: 7,
                      titleText: 'Leading and Trailing Icon (Disabled)',
                      leadingIconData: SBBIcons.alarm_clock_small,
                      trailingIconData: SBBIcons.circle_information_small_small,
                    ),
                    SBBRadioListItem<int>(
                      value: 8,
                      titleText: 'Custom Trailing',
                      trailing: Text('CHF 0.99'),
                    ),
                    SBBRadioListItem<int>(
                      value: 7,
                      titleText: 'Leading and Trailing Icon (Disabled)',
                      leadingIconData: SBBIcons.alarm_clock_small,
                      trailingIconData: SBBIcons.circle_information_small_small,
                      enabled: false,
                    ),
                    SBBRadioListItem<int>(
                      value: 9,
                      title: Text('Multiline Label with\nSecondary Label'),
                      subtitleText: 'Test',
                    ),
                  ],
                ).toList(growable: false),
              ),
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
            SBBRadioListItemBoxed<int>(
              value: 1,
              titleText: 'Label',
            ),
            SBBRadioListItemBoxed<int>(
              value: 2,
              titleText: 'Leading and Trailing Icon',
              leadingIconData: SBBIcons.alarm_clock_small,
              trailingIconData: SBBIcons.dog_small,
            ),
            SBBRadioListItemBoxed<int>(
              value: 3,
              titleText: 'Button',
              padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
              trailing: SBBTertiaryButtonSmall(
                iconData: SBBIcons.circle_information_small_small,
                onPressed: () {},
              ),
            ),
            SBBRadioListItemBoxed<int>(
              value: 4,
              titleText: 'Custom Trailing',
              trailing: Text('CHF 0.99'),
            ),
          ],
        ),
      ),
    ],
  );
}
