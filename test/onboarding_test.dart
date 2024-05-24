import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('onboarding', (WidgetTester tester) async {
    final widget = OnboardingTest();

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'onboarding_startpage',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.byKey(Key('start')));

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'onboarding_card1',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'onboarding_card2',
      find.byType(OnboardingTest),
    );

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));

    await Specs.run(
      Specs.mobileSpecs,
      widget,
      tester,
      'onboarding_endpage',
      find.byType(OnboardingTest),
    );
  });
}

class OnboardingTest extends StatelessWidget {
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
  Widget buildStartPage(
    BuildContext context,
    VoidCallback onStartOnboarding,
    VoidCallback onFinish,
  ) =>
      Container(
        color: SBBColors.red,
        child: Center(
          child: SBBTertiaryButtonLarge(
            key: Key('start'),
            label: 'Onboarding starten',
            onPressed: onStartOnboarding,
          ),
        ),
      );

  @override
  Widget buildEndPage(
    BuildContext context,
    VoidCallback onFinish,
  ) =>
      Container(
        color: SBBColors.red,
        child: Center(
          child: SBBTertiaryButtonLarge(
            label: 'Onboarding beenden',
            onPressed: onFinish,
          ),
        ),
      );

  @override
  List<SBBOnboardingCard> buildCards(BuildContext context) => [
        SBBOnboardingCard.basic(
          title: 'Page 1',
          content: 'Page 1',
        ),
        SBBOnboardingCard.basic(
          title: 'Page 2',
          content: 'Page 2',
        ),
      ];

  @override
  void setPopCallback(Future<bool> Function() callback) => {};
}
