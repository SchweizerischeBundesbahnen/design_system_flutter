import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('onboarding', (WidgetTester tester) async {
    const widget = OnboardingTest();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'onboarding_startpage',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.byKey(const Key('start')));

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'onboarding_card1',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'onboarding_card2',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'onboarding_endpage',
      find.byType(OnboardingTest),
    );
  });
}

class OnboardingTest extends StatelessWidget {
  const OnboardingTest({super.key});

  @override
  Widget build(BuildContext context) => SBBOnboarding(
        builderDelegate: TestOnboardingBuilderDelegate(),
        onFinish: () => Navigator.of(context).pop(),
        forwardSemanticsLabel: 'Nächste Seite',
        backSemanticsLabel: 'Vorherige Seite',
        cancelLabel: 'Onboarding abbrechen',
      );
}

class TestOnboardingBuilderDelegate extends SBBOnboardingBuilderDelegate {
  @override
  Widget buildStartPage(BuildContext context, VoidCallback onStartOnboarding, VoidCallback onFinish) => Container(
        color: SBBColors.red,
        child: Center(
          child: SBBTertiaryButtonLarge(
              key: const Key('start'), label: 'Onboarding starten', onPressed: onStartOnboarding),
        ),
      );

  @override
  Widget buildEndPage(BuildContext context, VoidCallback onFinish) => Container(
        color: SBBColors.red,
        child: Center(child: SBBTertiaryButtonLarge(label: 'Onboarding beenden', onPressed: onFinish)),
      );

  @override
  List<SBBOnboardingCard> buildCards(BuildContext context) => [
        SBBOnboardingCard.basic(title: 'Page 1', content: 'Page 1'),
        SBBOnboardingCard.basic(title: 'Page 2', content: 'Page 2'),
      ];

  @override
  void setPopCallback(Future<bool> Function() callback) => {};
}
