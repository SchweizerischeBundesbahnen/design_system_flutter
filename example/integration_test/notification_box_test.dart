import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'dismissButtonKey_whenMultipleInstancesConcurrent_eachIsDismissedIndependentlyByItsOwnKey',
    (tester) async {
      await tester.pumpWidget(const TestApp(child: _DemoNotificationBoxList()));
      await tester.pumpAndSettle();

      Finder dismissButtonOf(String id) => find.descendant(
        of: find.byKey(ValueKey(id)),
        matching: find.byKey(SBBNotificationBox.dismissButtonKey),
      );

      expect(dismissButtonOf('first'), findsOneWidget);
      expect(dismissButtonOf('second'), findsOneWidget);
      expect(dismissButtonOf('third'), findsOneWidget);

      await tester.tap(dismissButtonOf('second'));
      await tester.pumpAndSettle();

      expect(dismissButtonOf('first'), findsOneWidget);
      expect(dismissButtonOf('second'), findsNothing);
      expect(dismissButtonOf('third'), findsOneWidget);
      expect(find.text('second dismissed'), findsOneWidget);
    },
  );
}

class _DemoNotificationBoxList extends StatefulWidget {
  const _DemoNotificationBoxList();

  @override
  State<_DemoNotificationBoxList> createState() => _DemoNotificationBoxListState();
}

class _DemoNotificationBoxListState extends State<_DemoNotificationBoxList> {
  final _ids = ['first', 'second', 'third'];
  String? _lastDismissed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final id in _ids)
          SBBNotificationBox.alert(
            key: ValueKey(id),
            contentText: id,
            onDismissed: () => setState(() {
              _ids.remove(id);
              _lastDismissed = id;
            }),
          ),
        if (_lastDismissed != null) Text('$_lastDismissed dismissed'),
      ],
    );
  }
}
