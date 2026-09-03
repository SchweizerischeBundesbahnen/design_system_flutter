import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';
import 'widget_tester_extensions.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'selectSbbDate_whenCalledWithTargetDate_thenOnDateChangedReportsTargetDate',
    (tester) async {
      final controller = SBBDatePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDatePicker(initialDate: DateTime(2026, 1, 15), controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      await tester.selectSBBDate(controller, DateTime(2026, 3, 31));

      expect(find.text('selected: 31.3.2026'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetDate_whenTargetMonthReachedThroughShorterIntermediateMonth_thenDayIsPreserved',
    (tester) async {
      final controller = SBBDatePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDatePicker(initialDate: DateTime(2026, 1, 31), controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      await tester.selectSBBDate(controller, DateTime(2026, 3, 31));

      expect(find.text('selected: 31.3.2026'), findsOneWidget);
    },
  );

  testWidgets(
    'dragMonthColumn_whenPassingThroughShorterIntermediateMonth_thenOnDateChangedReportsDisplayedDate',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          child: _DemoDatePicker(initialDate: DateTime(2026, 1, 31)),
        ),
      );
      await tester.pumpAndSettle();

      final monthColumn = find.byType(SBBPickerScrollView).at(1);
      final gesture = await tester.startGesture(tester.getCenter(monthColumn));
      for (var i = 0; i < 9; i++) {
        await gesture.moveBy(const Offset(0, -10));
        await tester.pump();
      }
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text('selected: 31.3.2026'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetDate_whenTargetMonthHasFewerDays_thenDayIsClampedDuringScrollAndEndsOnTarget',
    (tester) async {
      final controller = SBBDatePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDatePicker(initialDate: DateTime(2026, 1, 31), controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setDate(DateTime(2026, 2, 15));
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 15.2.2026'), findsOneWidget);
    },
  );

  testWidgets(
    'controllerSetDate_whenDateAfterMaximumDate_thenSelectionIsClampedToMaximumDate',
    (tester) async {
      final controller = SBBDatePickerController();
      await tester.pumpWidget(
        TestApp(
          child: _DemoDatePicker(
            initialDate: DateTime(2026, 1, 15),
            maximumDate: DateTime(2026, 6, 30),
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final done = controller.setDate(DateTime(2026, 12, 24), animate: false);
      await tester.pumpAndSettle();
      await done;

      expect(find.text('selected: 30.6.2026'), findsOneWidget);
    },
  );
}

class _DemoDatePicker extends StatefulWidget {
  const _DemoDatePicker({required this.initialDate, this.maximumDate, this.controller});

  final DateTime initialDate;
  final DateTime? maximumDate;
  final SBBDatePickerController? controller;

  @override
  State<_DemoDatePicker> createState() => _DemoDatePickerState();
}

class _DemoDatePickerState extends State<_DemoDatePicker> {
  late DateTime _selected = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SBBDatePicker(
          initialDate: widget.initialDate,
          maximumDate: widget.maximumDate,
          controller: widget.controller,
          onDateChanged: (date) => setState(() => _selected = date),
        ),
        Text('selected: ${_selected.day}.${_selected.month}.${_selected.year}'),
      ],
    );
  }
}
