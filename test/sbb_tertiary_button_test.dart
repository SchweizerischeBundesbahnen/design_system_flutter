import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('tertiary_button', (WidgetTester tester) async {
    final pressableKey = ValueKey('pressedButton');
    final pressableSmallKey = ValueKey('pressedSmallButton');
    final pressableIconKey = ValueKey('pressedIconButton');
    final pressableSmallIconKey = ValueKey('pressedSmallIconButton');
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: sbbDefaultSpacing, horizontal: sbbDefaultSpacing / 2),
      child: Column(
        spacing: sbbDefaultSpacing,
        children: [
          SBBTertiaryButton(key: pressableKey, labelText: "Default", onPressed: () {}),
          SBBTertiaryButton(labelText: "Disabled", onPressed: null),
          SBBTertiaryButton(labelText: "Icon", onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButton(labelText: "Icon Disabled", onPressed: null, iconData: SBBIcons.dog_small),
          SBBTertiaryButton(key: pressableIconKey, onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButton(
            label: Container(color: SBBColors.platinum, child: Text('Custom Label!')),
            onPressed: () {},
          ),
          SBBTertiaryButton(
            onPressed: null,
            labelText: 'Custom Style',
            style: SBBButtonStyle(backgroundColor: WidgetStatePropertyAll(SBBColors.silver)),
          ),
          SBBTertiaryButton(
            onPressed: null,
            iconData: SBBIcons.airplane_small,
            style: SBBButtonStyle(
              backgroundColor: WidgetStatePropertyAll(SBBColors.silver),
              iconColor: WidgetStatePropertyAll(SBBColors.turquoise),
            ),
          ),
          SBBTertiaryButtonSmall(key: pressableSmallKey, labelText: "Default", onPressed: () {}),
          SBBTertiaryButtonSmall(labelText: "Disabled", onPressed: null),
          SBBTertiaryButtonSmall(labelText: "Icon", onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButtonSmall(labelText: "Icon Disabled", onPressed: null, iconData: SBBIcons.dog_small),
          SBBTertiaryButtonSmall(key: pressableSmallIconKey, onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButtonSmall(
            label: Container(color: SBBColors.platinum, child: Text('Custom label!')),
            onPressed: () {},
          ),
          SBBTertiaryButtonSmall(
            onPressed: null,
            labelText: 'Custom Style',
            style: SBBButtonStyle(backgroundColor: WidgetStatePropertyAll(SBBColors.cement)),
          ),
          SBBTertiaryButtonSmall(
            onPressed: null,
            iconData: SBBIcons.airplane_small,
            style: SBBButtonStyle(
              backgroundColor: WidgetStatePropertyAll(SBBColors.cement),
              iconColor: WidgetStatePropertyAll(SBBColors.turquoise),
            ),
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'tertiary_button',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(pressableKey));
    await tester.press(find.byKey(pressableSmallKey));
    await tester.press(find.byKey(pressableIconKey));
    await tester.press(find.byKey(pressableSmallIconKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'tertiary_button_pressed',
      find.byType(Column).first,
    );
  });
}
