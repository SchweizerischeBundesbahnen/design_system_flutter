import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class PromotionBoxPage extends StatefulWidget {
  @override
  State<PromotionBoxPage> createState() => _PromotionBoxPageState();
}

class _PromotionBoxPageState extends State<PromotionBoxPage> {
  late PromotionBoxController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        children: [
          ThemeModeSegmentedButton(),
          Spacer(),
          PromotionBox(
            badgeText: 'Neu',
            title: 'Bessere Übersicht.',
            description:
                'Erkennen Sie nun schneller, auf welchen Perrons Durchsagen vorhanden sind.',
            onControllerCreated: (controller) => this.controller = controller,
          ),
          Spacer(),
          SBBPrimaryButton(
            label: 'Show',
            onPressed: () => controller.show(),
          ),
          SizedBox(height: 8.0),
          SBBSecondaryButton(
            label: 'Hide',
            onPressed: () => controller.hide(),
          ),
        ],
      ),
    );
  }
}
