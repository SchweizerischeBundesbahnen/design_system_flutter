import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        const DatePickerTest(),
        tester,
        name,
        find.byType(DatePickerTest),
      );
    });
  }

  generateTest('date_input_test_1');
}

class DatePickerTest extends StatelessWidget {
  const DatePickerTest({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDate = DateTime(2024, 07, 03);
    final minimumDate = DateTime(2024, 08, 01);
    final maximumDate = DateTime(2024, 07, 01);
    return SBBGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SBBDateInput(
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            value: initialDate,
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            hintText: 'Hint only',
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            labelText: 'Label and Hint',
            hintText: 'Label and Hint',
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            labelText: 'Label and Value',
            value: initialDate,
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            value: initialDate,
            labelText: 'Custom date format',
            dateFormat: DateFormat('dd.MM.yy'),
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            value: initialDate,
            labelText: 'Error',
            errorText: 'Error',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            value: initialDate,
            labelText: 'Disabled',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateChanged: null,
          ),
          SBBDateInput(
            value: initialDate,
            minimumDate: minimumDate,
            labelText: 'Initial date before minimum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateChanged: (_) {},
          ),
          SBBDateInput(
            value: initialDate,
            maximumDate: maximumDate,
            labelText: 'Initial date after maximum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateChanged: (_) {},
            isLastElement: true,
          ),
        ],
      ),
    );
  }
}
