import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('paginator', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        const SBBPaginator(numberPages: 1, currentPage: 0),
        const SBBPaginator(numberPages: 2, currentPage: 0),
        const SBBPaginator(numberPages: 5, currentPage: 4),
        // floating
        const SBBPaginatorFloating(numberPages: 1, currentPage: 0),
        const SBBPaginatorFloating(numberPages: 2, currentPage: 0),
        const SBBPaginatorFloating(numberPages: 5, currentPage: 4),
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
