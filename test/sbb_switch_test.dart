import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, bool v1, bool v2, bool v3) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = SwitchTest(value1: v1, value2: v2, value3: v3);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        '${name}_initial',
        find.byType(SwitchTest),
      );
    });
  }

  generateTest('switch_test_1', false, false, false);
  generateTest('switch_test_2', true, true, true);
  generateTest('switch_test_3', false, false, true);
}

class SwitchTest extends StatelessWidget {
  const SwitchTest({
    super.key,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  final bool value1;
  final bool value2;
  final bool value3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SBBListHeader('SBBSwitch'),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
          child: Row(
            children: [
              SBBSwitch(
                onChanged: (bool? value) {},
                value: value1,
              ),
              SizedBox(width: sbbDefaultSpacing * .25),
              SBBSwitch(
                onChanged: null,
                value: value1,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .5),
        const SBBListHeader('SBBSwitchItem - List'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: value1,
            title: 'Default',
            onChanged: (value) {},
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: value2,
            title: 'Leading Icon',
            leadingIcon: SBBIcons.dog_small,
            onChanged: (value) {},
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: value3,
            title: 'Very Looooooooooooooooooooooooooooooooooooooooooooooong Multiline Label With Subtitle',
            allowMultilineLabel: true,
            subtitle: 'Subtitle',
            onChanged: (value) {},
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: false,
            title: 'With Link',
            onChanged: (value) {},
            links: [
              SBBSwitchListItemLink(
                text: 'Link Text',
                onPressed: () => {},
              )
            ],
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: Column(
            children: [
              SBBSwitchListItem(
                value: false,
                title: 'With 2 Links',
                onChanged: (value) {},
                links: [
                  SBBSwitchListItemLink(
                    text: 'Link Text 1',
                    onPressed: () {},
                  ),
                  SBBSwitchListItemLink(
                    text: 'Link Text 2',
                    onPressed: () {},
                  ),
                ],
                isLastElement: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: false,
            title: 'Disabled, Link enabled',
            onChanged: null,
            links: [
              SBBSwitchListItemLink(
                text: 'Link still enabled',
                onPressed: () {},
              )
            ],
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: false,
            title: 'Only Link disabled',
            onChanged: (value) {},
            links: [
              SBBSwitchListItemLink(
                text: 'Link disabled',
                onPressed: null,
              ),
            ],
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem(
            value: false,
            title: 'All disabled',
            onChanged: null,
            links: [
              SBBSwitchListItemLink(
                text: 'Link disabled',
                onPressed: null,
              ),
            ],
            isLastElement: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing * .25),
        SBBGroup(
          child: SBBSwitchListItem.custom(
            value: false,
            title: 'Custom LinkWidget',
            onChanged: (value) {},
            linksWidgets: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('My custom Link Widget'),
              )
            ],
            isLastElement: true,
          ),
        ),
      ],
    );
  }
}
