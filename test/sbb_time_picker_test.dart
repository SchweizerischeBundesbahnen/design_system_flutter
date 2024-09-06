import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(
    String name,
    TimeOfDay initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
  ) {
    final widget = TimePickerTest(
      initialTime: initialTime,
      minimumTime: minimumTime,
      maximumTime: maximumTime,
    );
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(TimePickerTest),
      );
    });
  }

  generateTest(
    'time_picker_test_1',
    const TimeOfDay(hour: 13, minute: 37),
    null,
    null,
  );
  generateTest(
    'time_picker_test_2',
    const TimeOfDay(hour: 13, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
  generateTest(
    'time_picker_test_3',
    const TimeOfDay(hour: 11, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
  generateTest(
    'time_picker_test_4',
    const TimeOfDay(hour: 14, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
}

class TimePickerTest extends StatelessWidget {
  const TimePickerTest({
    super.key,
    required this.initialTime,
    required this.minimumTime,
    required this.maximumTime,
  });

  final TimeOfDay? initialTime;
  final TimeOfDay? minimumTime;
  final TimeOfDay? maximumTime;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minuteInterval: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                    minuteInterval: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 150,
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                    minuteInterval: 5,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 120,
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                    minuteInterval: 15,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 100,
                child: SBBGroup(
                  child: SBBTimePicker(
                    onTimeChanged: (_) {},
                    initialTime: initialTime,
                    minimumTime: minimumTime,
                    maximumTime: maximumTime,
                    minuteInterval: 30,
                  ),
                ),
              ),
            ],
          )
        ],
      );
}
