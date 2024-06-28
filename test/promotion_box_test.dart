import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  const _title = 'Bessere Übersicht.';
  const _description =
      'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  testWidgets('promotion box test', (WidgetTester tester) async {
    final widget = Column(children: [
      SBBPromotionBox(
        badgeText: 'Default',
        title: _title,
        description: _description,
      ),
      SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'Is Closable = false',
        title: _title,
        description: _description,
      ),
      SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'Clickable',
        title: _title,
        description: _description,
        onTap: () {},
      ),
      SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'With way too long title and badge text',
        title:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
        description: _description,
        onTap: () {},
      )
    ]);

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'promotion_box',
      find.byType(Column).first,
    );
  });
}
