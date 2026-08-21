import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'handleKey_whenDraggedPastThreshold_thenOnlyThatInstanceToggles',
    (tester) async {
      await tester.pumpWidget(const TestApp(child: _DemoSlideToToggleList()));
      await tester.pumpAndSettle();

      Finder handleOf(String id) => find.descendant(
        of: find.byKey(ValueKey(id)),
        matching: find.byKey(SBBSlideToToggle.handleKey),
      );

      expect(handleOf('first'), findsOneWidget);
      expect(handleOf('second'), findsOneWidget);
      expect(handleOf('third'), findsOneWidget);

      expect(find.text('first: off'), findsOneWidget);
      expect(find.text('second: off'), findsOneWidget);
      expect(find.text('third: off'), findsOneWidget);

      await tester.drag(handleOf('second'), const Offset(1000, 0));
      await tester.pumpAndSettle();

      expect(find.text('first: off'), findsOneWidget);
      expect(find.text('second: on'), findsOneWidget);
      expect(find.text('third: off'), findsOneWidget);
    },
  );
}

class _DemoSlideToToggleList extends StatefulWidget {
  const _DemoSlideToToggleList();

  @override
  State<_DemoSlideToToggleList> createState() => _DemoSlideToToggleListState();
}

class _DemoSlideToToggleListState extends State<_DemoSlideToToggleList> {
  final _values = {
    'first': SBBSlideToToggleState.off,
    'second': SBBSlideToToggleState.off,
    'third': SBBSlideToToggleState.off,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final id in _values.keys)
          Column(
            children: [
              SBBSlideToToggle(
                key: ValueKey(id),
                value: _values[id]!,
                onChanged: (state) => setState(() => _values[id] = state),
                onToggleDecoration: const SBBSlideToggleDecoration(toggleLabelText: 'On'),
                offToggleDecoration: const SBBSlideToggleDecoration(toggleLabelText: 'Off'),
              ),
              Text('$id: ${_values[id]!.name}'),
            ],
          ),
      ],
    );
  }
}
