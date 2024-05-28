import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('pagination', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBPagination(numberPages: 1, currentPage: 0),
        SizedBox(height: sbbDefaultSpacing),
        SBBPagination(numberPages: 2, currentPage: 0),
        SizedBox(height: sbbDefaultSpacing),
        SBBPagination(numberPages: 5, currentPage: 4),
        SizedBox(height: sbbDefaultSpacing),
        // floating
        SBBPagination(
          numberPages: 1,
          currentPage: 0,
          isFloating: true,
        ),
        SizedBox(height: sbbDefaultSpacing),
        // add containter to see the shadow and floating box
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBPagination(
            numberPages: 2,
            currentPage: 0,
            isFloating: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        Container(
          color: SBBColors.white,
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBPagination(
            numberPages: 5,
            currentPage: 4,
            isFloating: true,
          ),
        ),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'pagination',
      find.byType(Column).first,
    );
  });
}
