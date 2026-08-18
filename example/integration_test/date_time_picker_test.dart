import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/testing.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'selectSBBDateTime_whenCalledWithTargetDateTime_thenOnDateTimeChangedReportsTargetDateTime',
    (tester) async {
      await tester.pumpWidget(TestApp(child: _DemoDateTimePicker(initialDateTime: DateTime(2026, 1, 15, 8, 15))));
      await tester.pumpAndSettle();

      await tester.selectSBBDateTime(find.byType(SBBDateTimePicker), DateTime(2026, 3, 31, 14, 45));

      expect(find.text('selected: 31.3.2026 14:45'), findsOneWidget);
    },
  );

  testWidgets(
    'selectSBBDateTime_whenTimeNotOnMinuteInterval_thenSelectionIsRoundedToInterval',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          child: _DemoDateTimePicker(initialDateTime: DateTime(2026, 1, 15, 8, 0), minuteInterval: 15),
        ),
      );
      await tester.pumpAndSettle();

      await tester.selectSBBDateTime(find.byType(SBBDateTimePicker), DateTime(2026, 2, 20, 14, 52));

      expect(find.text('selected: 20.2.2026 14:45'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetDateTime_whenCalledWithTargetDateTime_thenOnDateTimeChangedReportsTargetDateTime',
    (tester) async {
      final controller = SBBDateTimePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDateTimePicker(initialDateTime: DateTime(2026, 1, 15, 8, 15), controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setDateTime(DateTime(2026, 2, 10, 22, 30));
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 10.2.2026 22:30'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetDateTime_whenDateTimeAfterMaximumDateTime_thenSelectionIsClampedToMaximumDateTime',
    (tester) async {
      final controller = SBBDateTimePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDateTimePicker(
            initialDateTime: DateTime(2026, 1, 15, 8, 15),
            maximumDateTime: DateTime(2026, 6, 30, 17, 30),
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setDateTime(DateTime(2026, 12, 24, 23, 45), animate: false);
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 30.6.2026 17:30'), findsOneWidget);
    },
  );
}

class _DemoDateTimePicker extends StatefulWidget {
  const _DemoDateTimePicker({
    required this.initialDateTime,
    this.maximumDateTime,
    this.minuteInterval = 1,
    this.controller,
  });

  final DateTime initialDateTime;
  final DateTime? maximumDateTime;
  final int minuteInterval;
  final SBBDateTimePickerController? controller;

  @override
  State<_DemoDateTimePicker> createState() => _DemoDateTimePickerState();
}

class _DemoDateTimePickerState extends State<_DemoDateTimePicker> {
  late DateTime _selected = widget.initialDateTime;

  @override
  Widget build(BuildContext context) {
    final time = '${_selected.hour}:${_selected.minute.toString().padLeft(2, '0')}';
    return Column(
      children: [
        SBBDateTimePicker(
          initialDateTime: widget.initialDateTime,
          maximumDateTime: widget.maximumDateTime,
          minuteInterval: widget.minuteInterval,
          controller: widget.controller,
          onDateTimeChanged: (dateTime) => setState(() => _selected = dateTime),
        ),
        Text('selected: ${_selected.day}.${_selected.month}.${_selected.year} $time'),
      ],
    );
  }
}
