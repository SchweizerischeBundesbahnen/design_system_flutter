import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('divider', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      crossAxisAlignment: .stretch,
      children: [
        const SBBDivider(),
        const SBBDivider(color: SBBColors.red),
        const SBBDivider(color: SBBColors.blue),
        Column(
          crossAxisAlignment: .stretch,
          children: [
            const Text('Above divider'),
            const SBBDivider(),
            const Text('Below divider'),
          ],
        ),
        Container(
          color: SBBColors.milk,
          padding: const EdgeInsets.all(SBBSpacing.medium),
          child: const SBBDivider(color: SBBColors.granite),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'divider',
      find.byType(Column).first,
    );
  });
}
