import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/testing.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'selectSbbTime_whenCalledWithTargetTime_thenOnTimeChangedReportsTargetTime',
    (tester) async {
      await tester.pumpWidget(TestApp(child: _DemoTimePicker(initialTime: TimeOfDay(hour: 8, minute: 15))));
      await tester.pumpAndSettle();

      await tester.selectSBBTime(find.byType(SBBTimePicker), TimeOfDay(hour: 14, minute: 45));

      expect(find.text('selected: 14:45'), findsOneWidget);
    },
  );

  testWidgets(
    'selectSbbTime_whenTimeNotOnMinuteInterval_thenSelectionIsRoundedToInterval',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          child: _DemoTimePicker(initialTime: TimeOfDay(hour: 8, minute: 0), minuteInterval: 15),
        ),
      );
      await tester.pumpAndSettle();

      await tester.selectSBBTime(find.byType(SBBTimePicker), TimeOfDay(hour: 14, minute: 52));

      expect(find.text('selected: 14:45'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetTime_whenCalledWithTargetTime_thenOnTimeChangedReportsTargetTime',
    (tester) async {
      final controller = SBBTimePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoTimePicker(initialTime: TimeOfDay(hour: 8, minute: 15), controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setTime(TimeOfDay(hour: 22, minute: 30));
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 22:30'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetTime_whenTimeAfterMaximumTime_thenSelectionIsClampedToMaximumTime',
    (tester) async {
      final controller = SBBTimePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoTimePicker(
            initialTime: TimeOfDay(hour: 8, minute: 15),
            maximumTime: TimeOfDay(hour: 17, minute: 30),
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setTime(TimeOfDay(hour: 23, minute: 45), animate: false);
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 17:30'), findsOneWidget);
    },
  );
}

class _DemoTimePicker extends StatefulWidget {
  const _DemoTimePicker({required this.initialTime, this.maximumTime, this.minuteInterval = 1, this.controller});

  final TimeOfDay initialTime;
  final TimeOfDay? maximumTime;
  final int minuteInterval;
  final SBBTimePickerController? controller;

  @override
  State<_DemoTimePicker> createState() => _DemoTimePickerState();
}

class _DemoTimePickerState extends State<_DemoTimePicker> {
  late TimeOfDay _selected = widget.initialTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SBBTimePicker(
          initialTime: widget.initialTime,
          maximumTime: widget.maximumTime,
          minuteInterval: widget.minuteInterval,
          controller: widget.controller,
          onTimeChanged: (time) => setState(() => _selected = time),
        ),
        Text('selected: ${_selected.hour}:${_selected.minute.toString().padLeft(2, '0')}'),
      ],
    );
  }
}
