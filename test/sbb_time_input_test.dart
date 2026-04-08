import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        const TimePickerTest(),
        tester,
        name,
        find.byType(TimePickerTest),
      );
    });
  }

  generateTest('time_input_test_1');
}

class TimePickerTest extends StatelessWidget {
  const TimePickerTest({super.key});

  @override
  Widget build(BuildContext context) {
    const initialTime = TimeOfDay(hour: 12, minute: 33);
    const minimumTime = TimeOfDay(hour: 16, minute: 12);
    const maximumTime = TimeOfDay(hour: 08, minute: 43);
    return SBBContentBox(
      child: Column(
        mainAxisSize: .min,
        children: SBBListItem.divideListItems(
          context: context,
          items: [
            SBBTimeInput(onTimeChanged: (_) {}),
            SBBTimeInput(value: initialTime, onTimeChanged: (_) {}),
            SBBTimeInput(
              triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only'),
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Hint', placeholderText: 'Label and Hint'),
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              value: initialTime,
              triggerDecoration: SBBInputDecoration(labelText: 'Label and Value'),
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              value: initialTime,
              triggerDecoration: SBBInputDecoration(labelText: 'Custom date format'),
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              value: initialTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Error',
                errorText: 'Error',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onTimeChanged: (_) {},
            ),
            const SBBTimeInput(
              value: initialTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Disabled',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onTimeChanged: null,
            ),
            SBBTimeInput(
              value: initialTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Minute interval',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              minuteInterval: 15,
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              value: initialTime,
              minimumTime: minimumTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date before minimum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onTimeChanged: (_) {},
            ),
            SBBTimeInput(
              value: initialTime,
              maximumTime: maximumTime,
              triggerDecoration: SBBInputDecoration(
                labelText: 'Initial date after maximum date',
                leadingIconData: SBBIcons.calendar_small,
                trailingIconData: SBBIcons.arrow_circle_reset_small,
              ),
              onTimeChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
