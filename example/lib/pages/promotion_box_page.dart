import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class PromotionBoxPage extends StatefulWidget {
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
          ThemeModeSegmentedButton(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: sbbDefaultSpacing),
                  SBBPromotionBox(
                    badgeText: 'Default',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => defaultController = c,
                  ),
                  SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'Is Closable = false',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => closableController = c,
                    isCloseable: true,
                  ),
                  SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'Clickable',
                    title: _title,
                    description: _description,
                    onControllerCreated: (c) => clickableController = c,
                    onTap: () {},
                  ),
                  SizedBox(height: 8.0),
                  SBBPromotionBox(
                    badgeText: 'With way too long title and badge text',
                    title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',
                    description: _description,
                    onControllerCreated: (c) => extraController = c,
                  ),
                  SizedBox(height: sbbDefaultSpacing),
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
          SizedBox(height: 8.0),
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
