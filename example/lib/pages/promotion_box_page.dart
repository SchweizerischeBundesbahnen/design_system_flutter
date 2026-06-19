import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _longSubtitleText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus. ';

class PromotionBoxPage extends StatefulWidget {
  const PromotionBoxPage({super.key});

  @override
  State<PromotionBoxPage> createState() => _PromotionBoxPageState();
}

class _PromotionBoxPageState extends State<PromotionBoxPage> {
  final defaultController = SBBPromotionBoxController();
  final dismissableController = SBBPromotionBoxController();
  final clickableController = SBBPromotionBoxController();
  final tooLongTextController = SBBPromotionBoxController();

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
                dismissableController.show();
                clickableController.show();
                tooLongTextController.show();
              },
            ),
            SBBTertiaryButtonSmall(
              labelText: 'Hide',
              onPressed: () {
                defaultController.hide();
                dismissableController.hide();
                clickableController.hide();
                tooLongTextController.hide();
              },
            ),
          ],
        ),
      ),
      body: Column(
        spacing: SBBSpacing.xSmall,
        children: [
          SBBPromotionBox(
            badgeText: 'Default',
            titleText: 'Default Promotion Box',
            subtitleText: 'The default promotion box.',
            controller: defaultController,
          ),
          SBBPromotionBox(
            badgeText: 'Dismissable',
            titleText: 'Dismissable Promotion Box',
            subtitleText: 'Promotion Box that cannot be dismissed.',
            isDismissable: true,
            controller: dismissableController,
          ),
          SBBPromotionBox(
            badgeText: 'Tappable',
            titleText: 'Tappable Promotion Box',
            subtitleText: 'This Promotion Box will react to taps and display a bottom sheet.',
            controller: clickableController,
            onTap: () => showSBBBottomSheet(
              context: context,
              titleText: 'Promotion Box Information',
              body: Text('Some more information'),
            ),
            isDismissable: true,
          ),
          SBBPromotionBox(
            badgeText: 'With way too long title and badge text',
            titleText: _longSubtitleText,
            subtitleText: _longSubtitleText * 3,
            controller: tooLongTextController,
            isDismissable: true,
          ),
        ],
      ),
    );
  }
}
