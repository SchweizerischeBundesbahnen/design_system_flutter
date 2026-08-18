import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('segment_whenSearchedForByKeyAndTapped_isFoundAndSelectsTheSegment', (tester) async {
    String? selected;
    await tester.pumpWidget(
      TestApp(
        child: SBBSegmentedButton<String>(
          segments: const [
            SBBButtonSegment(value: 'day', labelText: 'Day', key: ValueKey('day')),
            SBBButtonSegment(value: 'week', labelText: 'Week', key: ValueKey('week')),
            SBBButtonSegment(value: 'month', labelText: 'Month', key: ValueKey('month')),
          ],
          selected: 'day',
          onSelectionChanged: (value) => selected = value,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('month')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('month')));
    await tester.pumpAndSettle();

    expect(selected, 'month');
  });
}
