import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// The focused state is drawn as the border color of the decoration container.
  Color? borderColorOf(WidgetTester tester, String id) {
    final container = tester.widget<AnimatedContainer>(
      find.descendant(of: find.byKey(ValueKey(id)), matching: find.byType(AnimatedContainer)),
    );
    return (container.decoration! as BoxDecoration).border!.bottom.color;
  }

  // A child that manages its own focus is the reason SBBDecorated cannot derive its
  // focused state from its own InkWell alone. Neither the golden tests nor the
  // analyzer can reach this: it needs focus to actually move at runtime.
  testWidgets('decorated_whenDescendantOfChildTakesFocus_thenOnlyThatFieldIsFocused', (tester) async {
    final firstInnerFocusNode = FocusNode();
    final secondInnerFocusNode = FocusNode();
    addTearDown(firstInnerFocusNode.dispose);
    addTearDown(secondInnerFocusNode.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Column(
          children: [
            SBBDecorated(
              key: const ValueKey('first'),
              decoration: SBBInputDecoration(labelText: 'First', borderType: .standalone),
              onTap: () {},
              child: Focus(focusNode: firstInnerFocusNode, child: const Text('First content')),
            ),
            SBBDecorated(
              key: const ValueKey('second'),
              decoration: SBBInputDecoration(labelText: 'Second', borderType: .standalone),
              onTap: () {},
              child: Focus(focusNode: secondInnerFocusNode, child: const Text('Second content')),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    final unfocused = borderColorOf(tester, 'first');
    expect(borderColorOf(tester, 'second'), unfocused);

    firstInnerFocusNode.requestFocus();
    await tester.pumpAndSettle();

    expect(
      borderColorOf(tester, 'first'),
      isNot(unfocused),
      reason: 'a focused descendant of the child focuses the field it belongs to',
    );
    expect(
      borderColorOf(tester, 'second'),
      unfocused,
      reason: 'sibling fields must not react to another field gaining focus',
    );
  });
}
