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
            children: SBBListItemV5.divideListItems(
              context: context,
              items: [
                SBBListItemV5(
                  key: pressableKey,
                  titleText: 'Default',
                  leadingIconData: SBBIcons.dog_small,
                  onTap: () {},
                ),
                SBBListItemV5(titleText: 'Disabled', leadingIconData: SBBIcons.dog_small, enabled: false),
                SBBListItemV5(titleText: 'With trailing', trailingIconData: SBBIcons.dog_small, onTap: () {}),
                SBBListItemV5(titleText: 'With subtitle', subtitleText: loremIpsum, onTap: () {}),
                SBBListItemV5(
                  titleText: 'Ellipse! ' * 20,
                  subtitleText: 'The title will be clamped to one line',
                  onTap: () {},
                ),
                SBBListItemV5(
                  titleText: 'With links!',
                  links: [
                    SBBListItemV5(
                      titleText: 'Link 1',
                      trailingIconData: SBBIcons.chevron_small_right_small,
                    ),
                  ],
                  onTap: () {},
                ),
                SBBListItemV5(
                  title: Container(color: SBBColors.platinum, child: Text('Custom!')),
                  leading: Container(height: 20, width: 30, color: SBBColors.red),
                  onTap: () {},
                ),
                SBBListItemV5(
                  onTap: null,
                  titleText: 'Custom Style',
                  style: SBBListItemV5Style(backgroundColor: WidgetStatePropertyAll(SBBColors.silver)),
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
