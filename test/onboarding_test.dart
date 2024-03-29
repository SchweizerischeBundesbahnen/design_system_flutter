import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('onboarding', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
      wrap: (w) => SizedBox(
        height: 538.0,
        width: double.infinity,
        child: TestApp(
          child: w,
        ),
      ),
    )..addScenario(
        'onboarding tests',
        OnboardingTest(),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'onboarding_startpage',
        devices: TestApp.native_devices);

    await tester.tap(find.byKey(Key('start')));
    await multiScreenGolden(tester, 'onboarding_card1',
        devices: TestApp.native_devices);

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));
    await multiScreenGolden(tester, 'onboarding_card2',
        devices: TestApp.native_devices);

    await tester.tap(find.bySemanticsLabel('Nächste Seite'));
    await multiScreenGolden(tester, 'onboarding_endpage',
        devices: TestApp.native_devices);
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
