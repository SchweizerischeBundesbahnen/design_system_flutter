import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class PromotionBoxPage extends StatefulWidget {
  const PromotionBoxPage({super.key});

  @override
  State<PromotionBoxPage> createState() => _PromotionBoxPageState();
}

class _PromotionBoxPageState extends State<PromotionBoxPage> {
  late CloseableBoxController defaultController;
  late CloseableBoxController closableController;
  late CloseableBoxController clickableController;
  late CloseableBoxController extraController;

  static const _title = 'Bessere Übersicht.';
  static const _description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        children: [
          const ThemeModeSegmentedButton(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBPromotionBox(
                    badgeText: 'Default',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => defaultController = c,
                  ),
                  const SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'Is Closable = false',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => closableController = c,
                    isCloseable: false,
                  ),
                  const SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'Clickable',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => clickableController = c,
                    onTap: () {},
                  ),
                  const SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'With way too long title and badge text',
                    title:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                    description: _description,
                    onControllerCreated: (c) => extraController = c,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBPromotionBox.custom(
                    content: Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                      style: SBBTextStyles.mediumLight,
                    ),
                    badgeText: 'Custom with different color',
                    badgeColor: SBBColors.royal,
                    badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
                    gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBPromotionBox.custom(
                    content: Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                      style: SBBTextStyles.mediumLight,
                    ),
                    badgeText: 'Custom leading and trailing widget',
                    leading: Icon(SBBIcons.train_large),
                    trailing: SBBTertiaryButtonSmall(label: 'Trailing Button', onPressed: () {}),
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBPromotionBox.custom(
                    content: Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                      style: SBBTextStyles.mediumLight,
                    ),
                    onTap: () {},
                    badgeText: 'Custom with on tap',
                    leading: Icon(SBBIcons.train_large),
                    trailing: SBBTertiaryButtonSmall(label: 'Trailing Button', onPressed: () {}),
                    badgeColor: SBBColors.royal,
                    badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
                    gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
                  )
                ],
              ),
            ),
          ),
          SBBPrimaryButton(
            label: 'Show',
            onPressed: () {
              defaultController.show();
              closableController.show();
              clickableController.show();
              extraController.show();
            },
          ),
          const SizedBox(height: 8.0),
          SBBSecondaryButton(
            label: 'Hide',
            onPressed: () {
              defaultController.hide();
              closableController.hide();
              clickableController.hide();
              extraController.hide();
            },
          ),
        ],
      ),
    );
  }
}
