import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, bool v1, bool v2, bool v3) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = SwitchTest(value1: v1, value2: v2, value3: v3);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(SwitchTest),
      );
    });
  }

  generateTest('switch_test_1', false, false, false);
  generateTest('switch_test_2', true, true, true);
  generateTest('switch_test_3', false, false, true);
}

class SwitchTest extends StatelessWidget {
  const SwitchTest({super.key, required this.value1, required this.value2, required this.value3});

  final bool value1;
  final bool value2;
  final bool value3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBBListHeader('SBBSwitch'),
          Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
            child: Row(
              spacing: sbbDefaultSpacing * .25,
              children: [
                SBBSwitch(onChanged: (_) {}, value: value1),
                SBBSwitch(onChanged: null, value: value1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
            child: Row(
              spacing: sbbDefaultSpacing * .25,
              children: [
                SBBSwitch(
                  onChanged: (_) {},
                  value: value1,
                  style: SBBSwitchStyle(trackColor: WidgetStatePropertyAll(SBBColors.blue)),
                ),
                SBBSwitch(
                  onChanged: null,
                  value: value1,
                  style: SBBSwitchStyle(trackColor: WidgetStatePropertyAll(SBBColors.green)),
                ),
              ],
            ),
          ),
          const SBBListHeader('SBBSwitchItem - List'),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: sbbDefaultSpacing * .5,
            children: [
              SBBSwitchListItemBoxed(value: value1, titleText: 'Default', onChanged: (value) {}),
              SBBSwitchListItemBoxed(
                value: value2,
                titleText: 'Leading Icon',
                leadingIconData: SBBIcons.dog_small,
                onChanged: (value) {},
              ),
              SBBSwitchListItemBoxed(
                value: value3,
                title: Text(
                  'Very Looooooooooooooooooooooooooooooooooooooooooooooong Multiline Label With SubtitleText',
                ),
                subtitleText: 'SubtitleText',
                onChanged: (value) {},
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'With Link',
                onChanged: (value) {},
                links: [
                  SBBListItem(
                    titleText: 'Link Text',
                    onTap: () => {},
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                ],
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'With 2 Links',
                onChanged: (value) {},
                links: [
                  SBBListItem(
                    titleText: 'Link Text 1',
                    onTap: () => {},
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                  SBBListItem(
                    titleText: 'Link Text 2',
                    onTap: () => {},
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                ],
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'Disabled, Link enabled',
                onChanged: null,
                links: [
                  SBBListItem(
                    titleText: 'Link Text',
                    onTap: () => {},
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                ],
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'Only Link disabled',
                onChanged: (value) {},
                links: [
                  SBBListItem(
                    titleText: 'Link Text',
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                ],
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'All disabled',
                onChanged: null,
                links: [
                  SBBListItem(
                    titleText: 'Link Text',
                    trailingIconData: SBBIcons.chevron_small_right_small,
                  ),
                ],
              ),
              SBBSwitchListItemBoxed(
                value: false,
                titleText: 'Custom LinkWidget',
                onChanged: (value) {},
                links: [Text('My custom Link Widget')],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
