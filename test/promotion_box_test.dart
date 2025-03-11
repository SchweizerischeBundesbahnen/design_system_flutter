import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  const title = 'Bessere Übersicht.';
  const description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  testWidgets('promotion box test', (WidgetTester tester) async {
    final widget = Column(children: [
      SBBPromotionBox(
        badgeText: 'Default',
        title: title,
        description: description,
        onClose: () {},
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'onClose null',
        title: title,
        description: description,
        onClose: null,
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'Clickable',
        title: title,
        description: description,
        onTap: () {},
        onClose: () {},
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox(
        badgeText: 'With way too long title and badge text',
        title:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
        description: description,
        onTap: () {},
        onClose: () {},
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox.custom(
        content: Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
          style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
        ),
        badgeText: 'Custom with different color',
        badgeColor: SBBColors.royal,
        badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
        gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox.custom(
        content: Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
          style: SBBTextStyles.mediumLight,
        ),
        badgeText: 'Custom leading and trailing widget',
        leading: Icon(SBBIcons.train_large),
        trailing: SBBTertiaryButtonSmall(label: 'Trailing Button', onPressed: () {}),
      ),
      const SizedBox(height: 8.0),
      SBBPromotionBox.custom(
        content: Text(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
          style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
        ),
        onTap: () {},
        badgeText: 'Custom with on tap',
        leading: Icon(SBBIcons.train_large),
        trailing: SBBTertiaryButtonSmall(label: 'Trailing Button', onPressed: () {}),
        badgeColor: SBBColors.royal,
        badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
        gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
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
