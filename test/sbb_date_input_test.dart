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
        const DateInputTest(),
        tester,
        name,
        find.byType(DateInputTest),
      );
    });
  }

  generateTest('date_input_test');
}

class DateInputTest extends StatelessWidget {
  const DateInputTest({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDate = DateTime(2024, 07, 03);
    final minimumDate = DateTime(2024, 08, 01);
    final maximumDate = DateTime(2024, 07, 01);
    return SBBContentBox(
      child: Column(
        mainAxisSize: .min,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            SBBDateInput(onDateChanged: (_) {}),
            SBBDateInput(value: initialDate, onDateChanged: (_) {}),
            SBBDateInput(
              triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only'),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Hint', placeholderText: 'Label and Hint'),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              value: initialDate,
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Value'),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              value: initialDate,
              triggerDecoration: SBBInputDecoration(labelText: 'Custom date format'),
              dateFormat: DateFormat('dd.MM.yy'),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              value: initialDate,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Error',
                errorText: 'Error',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              value: initialDate,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Disabled',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateChanged: null,
            ),
            SBBDateInput(
              value: initialDate,
              minimumDate: minimumDate,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date before minimum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateChanged: (_) {},
            ),
            SBBDateInput(
              value: initialDate,
              maximumDate: maximumDate,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date after maximum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onDateChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
