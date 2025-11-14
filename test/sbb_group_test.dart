import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('group', (WidgetTester tester) async {
    content(String text) => SizedBox(
      height: sbbDefaultSpacing * 2,
      width: double.infinity,
      child: Center(child: Text(text)),
    );

    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
      child: Column(
        children: [
          SizedBox(height: sbbDefaultSpacing),
          SBBGroup(child: content('Default')),
          SizedBox(height: sbbDefaultSpacing),
          SBBGroup(color: SBBColors.royal, child: content('Different Color')),
          SizedBox(height: sbbDefaultSpacing),
          SBBGroup(
            padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing),
            child: content('Extra padding'),
          ),
          SizedBox(height: sbbDefaultSpacing),
          SBBGroup(margin: EdgeInsets.all(sbbDefaultSpacing * 4), child: content('Extra margin')),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'group_1',
      find.byType(Column).first,
    );
  });
}
