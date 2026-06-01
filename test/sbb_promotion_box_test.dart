import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  const title = 'Bessere Übersicht.';
  const description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';
  const longSubtitle =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.';

  testWidgets('promotion box test', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return Column(
          spacing: SBBSpacing.xSmall,
          children: [
            SBBPromotionBox(badgeText: 'Default', titleText: title, subtitleText: description),
            SBBPromotionBox(badgeText: 'Dismissable', titleText: title, subtitleText: description, isDismissable: true),
            SBBPromotionBox(
              badgeText: 'Clickable',
              titleText: title,
              subtitleText: description,
              onTap: () {},
              isDismissable: true,
            ),
            SBBPromotionBox(
              badgeText: 'With way too long title and badge text',
              titleText: longSubtitle,
              subtitleText: description,
              onTap: () {},
              isDismissable: true,
            ),
            SBBPromotionBox(
              titleText: title,
              subtitleText: longSubtitle,
              badgeText: 'Different colors',
              style: SBBPromotionBoxStyle(subtitleForegroundColor: SBBColors.warning),
              badgeStyle: SBBPromotionBoxBadgeStyle(
                backgroundColor: SBBColors.peach,
                haloColor: SBBColors.peach.withValues(alpha: 0.2),
              ),
            ),
            SBBPromotionBox(
              titleText: title,
              subtitleText: longSubtitle,
              badge: SBBPromotionBoxBadge(labelText: 'Custom trailing widget'),
              trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
            ),
            SBBPromotionBox(
              titleText: 'Custom Badge',
              subtitleText: longSubtitle,
              onTap: () {},
              badge: SBBPromotionBoxBadge(
                label: SizedBox.fromSize(
                  size: Size(160, 32),
                  child: Center(child: Text('Custom 160×32 badge', maxLines: 1)),
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
