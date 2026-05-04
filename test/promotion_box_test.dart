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
            SBBPromotionBox(badgeText: 'Default', titleText: title, subtitleText: description, onClose: () {}),
            const SizedBox(height: 8.0),
            SBBPromotionBox(badgeText: 'onClose null', titleText: title, subtitleText: description, onClose: null),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              badgeText: 'Clickable',
              titleText: title,
              subtitleText: description,
              onTap: () {},
              onClose: () {},
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              badgeText: 'With way too long title and badge text',
              titleText:
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
              subtitleText: description,
              onTap: () {},
              onClose: () {},
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
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
              style: _customBoxStyle(context),
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                style: SBBTextStyles.mediumLight,
              ),
              badge: SBBPromotionBoxBadge(labelText: 'Custom leading and trailing widget'),
              leading: Icon(SBBIcons.train_large),
              trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
            ),
            const SizedBox(height: 8.0),
            SBBPromotionBox(
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
              leading: Icon(SBBIcons.train_large),
              trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
              style: _customBoxStyle(context),
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

PromotionBoxStyle _customBoxStyle(BuildContext context) =>
    PromotionBoxStyle.$default(baseStyle: Theme.of(context).sbbBaseStyle).copyWith(
      badgeColor: SBBColors.royal,
      badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
      gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
    );
