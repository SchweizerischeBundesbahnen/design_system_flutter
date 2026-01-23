import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('content_box', (WidgetTester tester) async {
    content(String text) => SizedBox(
      height: SBBSpacing.xLarge,
      width: double.infinity,
      child: Center(child: Text(text)),
    );

    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBContentBox(child: content('Default')),
          SBBContentBox(color: SBBColors.royal, child: content('Different Color')),
          SBBContentBox(
            padding: EdgeInsets.symmetric(vertical: SBBSpacing.medium),
            child: content('Extra padding'),
          ),
          SBBContentBox(margin: EdgeInsets.all(SBBSpacing.medium * 4), child: content('Extra margin')),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'content_box_1',
      find.byType(Column).first,
    );
  });
}
