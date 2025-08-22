import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(TestSpecs.themedSpecs, const TimePickerTest(), tester, name, find.byType(TimePickerTest));
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
    return SBBGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SBBTimeInput(onTimeChanged: (_) {}),
          SBBTimeInput(value: initialTime, onTimeChanged: (_) {}),
          SBBTimeInput(hintText: 'Hint only', onTimeChanged: (_) {}),
          SBBTimeInput(labelText: 'Label and Hint', hintText: 'Label and Hint', onTimeChanged: (_) {}),
          SBBTimeInput(labelText: 'Label and Value', value: initialTime, onTimeChanged: (_) {}),
          SBBTimeInput(
            value: initialTime,
            labelText: 'Custom date format',
            dateFormat: DateFormat('dd.MM.yy, H:m'),
            onTimeChanged: (_) {},
          ),
          SBBTimeInput(
            value: initialTime,
            labelText: 'Error',
            errorText: 'Error',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onTimeChanged: (_) {},
          ),
          const SBBTimeInput(
            value: initialTime,
            labelText: 'Disabled',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onTimeChanged: null,
          ),
          SBBTimeInput(
            value: initialTime,
            labelText: 'Minute interval',
            minuteInterval: 15,
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onTimeChanged: (_) {},
          ),
          SBBTimeInput(
            value: initialTime,
            minimumTime: minimumTime,
            labelText: 'Initial date before minimum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onTimeChanged: (_) {},
          ),
          SBBTimeInput(
            value: initialTime,
            maximumTime: maximumTime,
            labelText: 'Initial date after maximum date',
            prefixIcon: SBBIcons.calendar_small,
            suffixIcon: SBBIcons.arrow_circle_reset_small,
            onTimeChanged: (_) {},
            isLastElement: true,
          ),
        ],
      ),
    );
  }
}
