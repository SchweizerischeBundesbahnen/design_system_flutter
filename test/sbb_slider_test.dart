import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('slider_1', (WidgetTester tester) async {
    final widget = Column(
      children: [
        SBBSlider(
          onChanged: (value) {},
          value: 50,
          max: 100,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBSlider(
          onChanged: (value) {},
          value: 25,
          max: 100,
          startIcon: null,
          endIcon: null,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBSlider(
          onChanged: null,
          value: 75,
          max: 100,
        ),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'slider_1',
      find.byType(Column).first,
    );
  });
}
