import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/contentbox/contentbox.dart';

import 'test_app.dart';

void main() {
  testWidgets('contentbox', (WidgetTester tester) async {
    content(String text) =>
        SizedBox(height: sbbDefaultSpacing * 2, width: double.infinity, child: Center(child: Text(text)));

    final widget = Column(
      children: [
        SBBContentbox(child: content('Default')),
        SBBContentbox(color: SBBColors.royal, child: content('Different Color')),
        SBBContentbox(padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing), child: content('Extra padding')),
        SBBContentbox(margin: EdgeInsets.all(sbbDefaultSpacing * 4), child: content('Extra margin')),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'contentbox_1',
      find.byType(Column).first,
    );
  });
}
