import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  const title = 'Bessere Übersicht.';
  const description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  testWidgets('promotion box test', (WidgetTester tester) async {
    final widget = Column(children: [
      const SBBPromotionBox(
        badgeText: 'Default',
        title: title,
        description: description,
      ),
      const SizedBox(height: 8.0),
      const SBBPromotionBox(
        badgeText: 'Is Closable = false',
        title: title,
        description: description,
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'Clickable',
        title: title,
        description: description,
        onTap: () {},
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'With way too long title and badge text',
        title:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
        description: description,
        onTap: () {},
      )
    ]);

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'promotion_box',
      find.byType(Column).first,
    );
  });
}
