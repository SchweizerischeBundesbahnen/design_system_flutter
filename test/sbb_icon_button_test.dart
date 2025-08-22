import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('icon_button', (WidgetTester tester) async {
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing / 2),
      child: Column(
        children: [
          const SizedBox(height: sbbDefaultSpacing),
          SBBIconButtonLarge(
            onPressed: () {},
            icon: SBBIcons.glass_cocktail_small,
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBIconButtonLarge(
            onPressed: null,
            icon: SBBIcons.glass_cocktail_small,
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBIconButtonSmall(
            onPressed: () {},
            icon: SBBIcons.glass_cocktail_small,
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBIconButtonSmall(
            onPressed: null,
            icon: SBBIcons.glass_cocktail_small,
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'icon_button',
      find.byType(Column).first,
    );
  });
}
