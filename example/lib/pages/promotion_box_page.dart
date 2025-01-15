import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

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
                    isCloseable: true,
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
