import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('closeButtonKey_whenSearchedForAndPressed_isFoundAndDismissesPopup', (tester) async {
    await tester.pumpWidget(
      TestApp(
        child: Builder(
          builder: (context) => SBBPrimaryButton(
            labelText: 'Open',
            onPressed: () => showSBBPopup(
              context: context,
              titleText: 'Title',
              body: const Text('Body'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byKey(SBBPopup.closeButtonKey), findsOneWidget);

    await tester.tap(find.byKey(SBBPopup.closeButtonKey));
    await tester.pumpAndSettle();

    expect(find.byKey(SBBPopup.closeButtonKey), findsNothing);
  });
}
