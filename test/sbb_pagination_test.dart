import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('pagination', (WidgetTester tester) async {
    final widget = Column(
      children: [
        const SBBPagination(numberPages: 1, currentPage: 0),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBPagination(numberPages: 2, currentPage: 0),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBPagination(numberPages: 5, currentPage: 4),
        const SizedBox(height: sbbDefaultSpacing),
        // floating
        const SBBPagination(
          numberPages: 1,
          currentPage: 0,
          isFloating: true,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        // add containter to see the shadow and floating box
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: const SBBPagination(
            numberPages: 2,
            currentPage: 0,
            isFloating: true,
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: const SBBPagination(
            numberPages: 5,
            currentPage: 4,
            isFloating: true,
          ),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'pagination',
      find.byType(Column).first,
    );
  });
}
