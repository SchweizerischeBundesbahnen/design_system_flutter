import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('chip_1', (WidgetTester tester) async {
    final widget = Column(
      spacing: sbbDefaultSpacing,
      children: [
        SBBChip(labelText: 'Default', trailingText: '9', onChanged: (selected) {}),
        SBBChip(labelText: 'L${"o" * 100}ng Text', trailingText: '99', onChanged: (selected) {}),
        SBBChip(labelText: 'Selected', trailingText: '3', selected: true, onChanged: (selected) {}),
        const SBBChip(labelText: 'Disabled', onChanged: null, trailingText: '99'),
        const SBBChip(labelText: 'Disabled & Selected', selected: true, onChanged: null, trailingText: '9'),
        SBBChip(
          label: Container(
            color: SBBColors.blue,
            child: Text('Custom', style: sbbTextStyle.copyWith(color: SBBColors.white)),
          ),
          onChanged: (_) {},
          trailing: Container(width: 10, height: 10, color: SBBColors.turquoise),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'chip_1',
      find.byType(Column).first,
    );
  });
}
