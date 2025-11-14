import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('tertiary_button', (WidgetTester tester) async {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: sbbDefaultSpacing, horizontal: sbbDefaultSpacing / 2),
      child: Column(
        spacing: sbbDefaultSpacing,
        children: [
          SBBTertiaryButton(labelText: "Default", onPressed: () {}),
          SBBTertiaryButton(labelText: "Disabled", onPressed: null),
          SBBTertiaryButton(labelText: "Icon", onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButton(labelText: "Icon Disabled", onPressed: null, iconData: SBBIcons.dog_small),
          SBBTertiaryButton(
            label: Container(color: SBBColors.platinum, child: Text('Custom!')),
            onPressed: () {},
          ),
          SBBTertiaryButtonSmall(labelText: "Default", onPressed: () {}),
          SBBTertiaryButtonSmall(labelText: "Disabled", onPressed: null),
          SBBTertiaryButtonSmall(labelText: "Icon", onPressed: () {}, iconData: SBBIcons.dog_small),
          SBBTertiaryButtonSmall(labelText: "Icon Disabled", onPressed: null, iconData: SBBIcons.dog_small),
          SBBTertiaryButtonSmall(
            label: Container(color: SBBColors.platinum, child: Text('Custom!')),
            onPressed: () {},
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
  });
}
