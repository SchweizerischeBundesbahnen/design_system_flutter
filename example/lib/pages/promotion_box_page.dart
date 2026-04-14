import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class PromotionBoxPage extends StatefulWidget {
  const PromotionBoxPage({super.key});

  @override
  State<PromotionBoxPage> createState() => _PromotionBoxPageState();
}

class _PromotionBoxPageState extends State<PromotionBoxPage> {
  late ClosableBoxController defaultController;
  late ClosableBoxController closableController;
  late ClosableBoxController clickableController;
  late ClosableBoxController extraController;

  static const _title = 'Bessere Übersicht.';
  static const _description = 'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.';

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: Row(
          spacing: SBBSpacing.xSmall,
          mainAxisAlignment: .center,
          children: [
            SBBTertiaryButtonSmall(
              labelText: 'Show',
              onPressed: () {
                defaultController.show();
                closableController.show();
                clickableController.show();
                extraController.show();
              },
            ),
            SBBTertiaryButtonSmall(
              labelText: 'Hide',
              onPressed: () {
                defaultController.hide();
                closableController.hide();
                clickableController.hide();
                extraController.hide();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SBBPromotionBox(
            badgeText: 'Default',
            title: _title,
            subtitle: _description,
            onControllerCreated: (c) => defaultController = c,
            onClose: () {},
          ),
          const SizedBox(height: 8.0),
          SBBPromotionBox(
            badgeText: 'onClose null',
            title: _title,
            subtitle: _description,
            onControllerCreated: (c) => closableController = c,
          ),
          const SizedBox(height: 8.0),
          SBBPromotionBox(
            badgeText: 'Clickable',
            title: _title,
            subtitle: _description,
            onControllerCreated: (c) => clickableController = c,
            onTap: () {},
            onClose: () {},
          ),
          const SizedBox(height: 8.0),
          SBBPromotionBox(
            badgeText: 'With way too long title and badge text',
            title:
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
            subtitle: _description,
            onControllerCreated: (c) => extraController = c,
            onClose: () {},
          ),
          const SizedBox(height: SBBSpacing.medium),
          SBBPromotionBox.custom(
            content: Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
              style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
            ),
            badgeText: 'Custom with different color',
            style: _customBoxStyle(context),
          ),
          const SizedBox(height: SBBSpacing.medium),
          SBBPromotionBox.custom(
            content: Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
              style: SBBTextStyles.mediumLight,
            ),
            badgeText: 'Custom leading and trailing widget',
            leading: Icon(SBBIcons.train_large),
            trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
          ),
          const SizedBox(height: SBBSpacing.medium),
          SBBPromotionBox.custom(
            content: Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
              style: SBBTextStyles.mediumLight.copyWith(color: SBBColors.black),
            ),
            onTap: () {},
            badgeText: 'Custom with on tap',
            leading: Icon(SBBIcons.train_large),
            trailing: SBBTertiaryButtonSmall(labelText: 'Trailing Button', onPressed: () {}),
            style: _customBoxStyle(context),
          ),
        ],
      ),
    );
  }
}

PromotionBoxStyle _customBoxStyle(BuildContext context) =>
    PromotionBoxStyle.$default(baseStyle: Theme.of(context).sbbBaseStyle).copyWith(
      badgeColor: SBBColors.royal,
      badgeShadowColor: SBBColors.royal.withAlpha((255.0 * 0.2).round()),
      gradientColors: [SBBColors.cloud, SBBColors.milk, SBBColors.milk, SBBColors.cloud],
    );
