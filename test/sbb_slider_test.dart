import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('slider', (WidgetTester tester) async {
    final widget = Padding(
      padding: const .all(8.0),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBSlider(onChanged: (value) {}, value: 50, max: 100),
          SBBSlider(
            onChanged: (_) {},
            value: 25,
            max: 100,
            leadingIconData: SBBIcons.walk_slow_small,
            trailingIconData: SBBIcons.walk_fast_small,
          ),
          const SBBSlider(
            onChanged: null,
            value: 75,
            max: 100,
            leadingIconData: SBBIcons.walk_slow_small,
            trailingIconData: SBBIcons.walk_fast_small,
          ),
          SBBSlider(
            onChanged: (_) {},
            value: 75,
            max: 100,
            leading: Container(color: SBBColors.green, width: 10, height: 10),
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'slider',
      find.byType(Column).first,
    );
  });
}
