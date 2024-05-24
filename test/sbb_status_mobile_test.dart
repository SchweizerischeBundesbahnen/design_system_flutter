import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('status test', (WidgetTester tester) async {
    const String text = 'Lorem ipsum sit dolor';
    final widget = Column(
      children: [
        SBBStatusMobile.alert(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatusMobile.warning(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatusMobile.success(text: text),
        const SizedBox(height: sbbDefaultSpacing),
        SBBStatusMobile.information(text: text),
        const SizedBox(height: sbbDefaultSpacing),
      ],
    );

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'status',
      find.byType(Column).first,
    );
  });
}
