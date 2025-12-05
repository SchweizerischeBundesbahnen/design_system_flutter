import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('status test', (WidgetTester tester) async {
    const String text = 'Lorem ipsum sit dolor';
    final widget = Column(
      spacing: sbbDefaultSpacing,
      children: [
        SBBStatus.alert(labelText: text),
        SBBStatus.warning(labelText: text),
        SBBStatus.success(labelText: text),
        SBBStatus.information(labelText: text),
        SBBStatus.alert(),
        SBBStatus.alert(iconData: SBBIcons.airplane_small),
        SBBStatus.alert(
          style: SBBStatusStyle(backgroundColor: SBBColors.turquoise),
          label: Text('Custom'),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'status',
      find.byType(Column).first,
    );
  });
}
