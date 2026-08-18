import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('closeButtonKey_whenSearchedForAndPressed_isFoundAndDismissesPopover', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Center(
          child: SBBPopover(
            controller: controller,
            titleText: 'Title',
            targetBuilder: (context, showPopover) => SBBPrimaryButton(labelText: 'Open', onPressed: showPopover),
            builder: (context, hidePopover) => const Text('Popover content'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byKey(SBBPopover.closeButtonKey), findsOneWidget);

    await tester.tap(find.byKey(SBBPopover.closeButtonKey));
    await tester.pumpAndSettle();

    expect(find.byKey(SBBPopover.closeButtonKey), findsNothing);
  });
}
