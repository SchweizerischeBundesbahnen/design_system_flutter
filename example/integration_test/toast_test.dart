import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('showToast_whenCalled_thenRendersToast', (tester) async {
    await tester.pumpWidget(
      TestApp(
        child: Builder(
          builder: (context) => SBBPrimaryButton(
            labelText: 'Show toast',
            onPressed: () => SBBToast.of(context).show(
              titleText: 'Item deleted',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Show toast'));
    await tester.pumpAndSettle();

    expect(find.text('Item deleted'), findsOneWidget);
  });

  testWidgets('toastActionKey_whenSearchedForAndTapped_isFoundAndDismissesTheToast', (tester) async {
    const actionKey = ValueKey('toast-undo-action');

    await tester.pumpWidget(
      TestApp(
        child: Builder(
          builder: (context) => SBBPrimaryButton(
            labelText: 'Show toast',
            onPressed: () => SBBToast.of(context).show(
              titleText: 'Item deleted',
              action: SBBToastAction(key: actionKey, title: 'Undo', onTap: () {}),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Show toast'));
    await tester.pumpAndSettle();

    expect(find.text('Item deleted'), findsOneWidget);
    expect(find.byKey(actionKey), findsOneWidget);

    await tester.tap(find.byKey(actionKey));
    await tester.pumpAndSettle();

    expect(find.text('Item deleted'), findsNothing);
  });
}
