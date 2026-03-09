import 'package:flutter/material.dart';

import 'sbb_onboarding_card.dart';

@Deprecated(
  'SBBOnboarding is deprecated since it is no component in the official Design System. Will be removed in v5.',
)
abstract class SBBOnboardingBuilderDelegate {
  Widget buildStartPage(BuildContext context, VoidCallback onStartOnboarding, VoidCallback onFinish);

  Widget buildEndPage(BuildContext context, VoidCallback onFinish);

  List<SBBOnboardingCard> buildCards(BuildContext context);

  void setPopCallback(Future<bool> Function() callback);
}
