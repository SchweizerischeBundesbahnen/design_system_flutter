import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
    return SBBContentBox(
      child: Column(
        mainAxisSize: .min,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            SBBDateTimeInput(onDateTimeChanged: (_) {}),
            SBBDateTimeInput(value: initialDateTime, onDateTimeChanged: (_) {}),
            SBBDateTimeInput(
              triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only'),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Hint', placeholderText: 'Label and Hint'),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Value'),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              triggerDecoration: SBBInputDecoration(labelText: 'Custom date format'),
              dateFormat: DateFormat('dd.MM.yy, H:m'),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Error',
                errorText: 'Error',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Disabled',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateTimeChanged: null,
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Minute interval',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              minuteInterval: 15,
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              minimumDateTime: minimumDateTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date before minimum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateTimeChanged: (_) {},
            ),
            SBBDateTimeInput(
              value: initialDateTime,
              maximumDateTime: maximumDateTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date after maximum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateTimeChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
