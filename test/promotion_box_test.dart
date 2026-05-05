import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  const title = 'Bessere Übersicht.';
  const description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  testWidgets('promotion box test', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return Column(
          children: [
            SBBPromotionBox(badgeText: 'Default', titleText: title, subtitleText: description),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              badgeText: 'onClose null',
              titleText: title,
              subtitleText: description,
              isDismissable: false,
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              badgeText: 'Clickable',
              titleText: title,
              subtitleText: description,
              onTap: () {},
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              badgeText: 'With way too long title and badge text',
              titleText:
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
              subtitleText: description,
              onTap: () {},
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              titleText: 'Title',
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
              ),
              badge: SBBPromotionBoxBadge(
                labelText: 'Custom with different color',
                style: SBBPromotionBoxBadgeStyle(
                  backgroundColor: SBBColors.peach,
                  haloColor: SBBColors.peach.withValues(alpha: 0.2),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              titleText: 'Title',
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                style: SBBTextStyles.mediumLight,
              ),
              badge: SBBPromotionBoxBadge(labelText: 'Custom leading and trailing widget'),
              trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              titleText: 'Title',
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
              ),
              onTap: () {},
              badge: SBBPromotionBoxBadge(
                label: SizedBox(
                  width: 160,
                  height: 32,
                  child: Center(
                    child: Text('Custom 160×32 badge', maxLines: 1),
                  ),
                ),
                style: SBBPromotionBoxBadgeStyle(
                  backgroundColor: SBBColors.peach,
                  haloColor: SBBColors.peach.withValues(alpha: 0.2),
                ),
              ),
              trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
            ),
          ],
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'promotion_box',
      find.byType(Column).first,
    );
  });
}
