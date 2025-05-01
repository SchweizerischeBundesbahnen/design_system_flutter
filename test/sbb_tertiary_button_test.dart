import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('tertiary_button', (WidgetTester tester) async {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2),
      child: Column(
        children: [
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonLarge(label: "Default", onPressed: () {}),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonLarge(label: "Disabled", onPressed: null),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonLarge(label: "Icon", onPressed: () {}, icon: SBBIcons.dog_small),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonLarge(label: "Icon Disabled", onPressed: null, icon: SBBIcons.dog_small),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonSmall(label: "Default", onPressed: () {}),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonSmall(label: "Disabled", onPressed: null),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonSmall(label: "Icon", onPressed: () {}, icon: SBBIcons.dog_small),
          const SizedBox(height: sbbDefaultSpacing),
          SBBTertiaryButtonSmall(label: "Icon Disabled", onPressed: null, icon: SBBIcons.dog_small),
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
