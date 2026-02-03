import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('paginator', (WidgetTester tester) async {
    final widget = Column(
      children: [
        const SBBPaginator(numberPages: 1, currentPage: 0),
        const SizedBox(height: SBBSpacing.medium),
        const SBBPaginator(numberPages: 2, currentPage: 0),
        const SizedBox(height: SBBSpacing.medium),
        const SBBPaginator(numberPages: 5, currentPage: 4),
        const SizedBox(height: SBBSpacing.medium),
        // floating
        const SBBPaginator(numberPages: 1, currentPage: 0, isFloating: true),
        const SizedBox(height: SBBSpacing.medium),
        // add containter to see the shadow and floating box
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(SBBSpacing.medium),
          child: const SBBPaginator(numberPages: 2, currentPage: 0, isFloating: true),
        ),
        const SizedBox(height: SBBSpacing.medium),
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(SBBSpacing.medium),
          child: const SBBPaginator(numberPages: 5, currentPage: 4, isFloating: true),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'paginator',
      find.byType(Column).first,
    );
  });
}
