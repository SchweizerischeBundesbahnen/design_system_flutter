import 'package:flutter/material.dart';

import 'sbb_onboarding_card.dart';

abstract class SBBOnboardingBuilderDelegate {
  Widget buildStartPage(
    BuildContext context,
    VoidCallback onStartOnboarding,
    VoidCallback onFinish,
  );

  Widget buildEndPage(
    BuildContext context,
    VoidCallback onFinish,
  );

  List<SBBOnboardingCard> buildCards(BuildContext context);

  void setPopCallback(Future<bool> Function() callback);
}
