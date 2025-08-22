import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        const DateTimePickerTest(),
        tester,
        name,
        find.byType(DateTimePickerTest),
      );
    });
  }

  generateTest('date_time_input_test_1');
}

class DateTimePickerTest extends StatelessWidget {
  const DateTimePickerTest({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateTime(2024, 07, 03, 12, 33);
    final minimumDateTime = DateTime(2024, 08, 01, 16, 12);
    final maximumDateTime = DateTime(2024, 07, 01, 08, 43);
    return SBBGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SBBDateTimeInput(onDateTimeChanged: (_) {}),
          SBBDateTimeInput(value: initialDateTime, onDateTimeChanged: (_) {}),
          SBBDateTimeInput(hintText: 'Hint only', onDateTimeChanged: (_) {}),
          SBBDateTimeInput(
            labelText: 'Label and Hint',
            hintText: 'Label and Hint',
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            labelText: 'Label and Value',
            value: initialDateTime,
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            labelText: 'Custom date format',
            dateFormat: DateFormat('dd.MM.yy, H:m'),
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            labelText: 'Error',
            errorText: 'Error',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            labelText: 'Disabled',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateTimeChanged: null,
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            labelText: 'Minute interval',
            minuteInterval: 15,
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            minimumDateTime: minimumDateTime,
            labelText: 'Initial date before minimum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateTimeChanged: (_) {},
          ),
          SBBDateTimeInput(
            value: initialDateTime,
            maximumDateTime: maximumDateTime,
            labelText: 'Initial date after maximum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onDateTimeChanged: (_) {},
            isLastElement: true,
          ),
        ],
      ),
    );
  }
}
