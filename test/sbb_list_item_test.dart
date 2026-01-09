import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    ' Curabitur finibus, nulla nec tempor ornare, purus orci dictum tortor, non tristique velit tellus eu ligula.';

void main() {
  testWidgets('list_item', (WidgetTester tester) async {
    final pressableKey = ValueKey('pressedListItem');
    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2, vertical: sbbDefaultSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: SBBListItem.divideListItems(
              context: context,
              items: [
                SBBListItem(
                  key: pressableKey,
                  titleText: 'Default',
                  leadingIconData: SBBIcons.dog_small,
                  onTap: () {},
                ),
                SBBListItem(titleText: 'Disabled', leadingIconData: SBBIcons.dog_small, enabled: false),
                SBBListItem(titleText: 'With trailing', trailingIconData: SBBIcons.dog_small, onTap: () {}),
                SBBListItem(titleText: 'With subtitle', subtitleText: loremIpsum, onTap: () {}),
                SBBListItem(
                  titleText: 'Ellipse! ' * 20,
                  subtitleText: 'The title will be clamped to one line',
                  onTap: () {},
                ),
                SBBListItem(
                  titleText: 'With links!',
                  links: [
                    SBBListItem(
                      titleText: 'Link 1',
                      trailingIconData: SBBIcons.chevron_small_right_small,
                    ),
                  ],
                  onTap: () {},
                ),
                SBBListItem(
                  title: Container(color: SBBColors.platinum, child: Text('Custom!')),
                  leading: Container(height: 20, width: 30, color: SBBColors.red),
                  onTap: () {},
                ),
                SBBListItem(
                  onTap: null,
                  titleText: 'Custom Style',
                  style: SBBListItemStyle(backgroundColor: WidgetStatePropertyAll(SBBColors.silver)),
                ),
              ],
            ).toList(),
          ),
        );
      },
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'list_item',
      find.byType(SBBContentBox).first,
    );
    await tester.press(find.byKey(pressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'list_item_pressed',
      find.byType(SBBContentBox).first,
    );
  });
}
