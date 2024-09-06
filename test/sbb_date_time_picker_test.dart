import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(
    String name,
    DateTime initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
  ) {
    final widget = DateTimePickerTest(
      initialDateTime: initialDateTime,
      minimumDateTime: minimumDateTime,
      maximumDateTime: maximumDateTime,
    );
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(DateTimePickerTest),
      );
    });
  }

  generateTest(
    'date_time_picker_test_1',
    DateTime(2024, 07, 02, 12),
    null,
    null,
  );
  generateTest(
    'date_time_picker_test_2',
    DateTime(2024, 07, 02, 12),
    DateTime(2024, 06, 30, 8),
    DateTime(2024, 07, 04, 16),
  );
  generateTest(
    'date_time_picker_test_3',
    DateTime(2024, 06, 30, 12),
    DateTime(2024, 07, 02, 8),
    DateTime(2024, 07, 04, 16),
  );
  generateTest(
    'date_time_picker_test_4',
    DateTime(2024, 07, 06, 12),
    DateTime(2024, 07, 02, 8),
    DateTime(2024, 07, 04, 16),
  );
}

class DateTimePickerTest extends StatelessWidget {
  const DateTimePickerTest({
    super.key,
    required this.initialDateTime,
    required this.minimumDateTime,
    required this.maximumDateTime,
  });

  final DateTime? initialDateTime;
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
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
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
                    minimumDateTime: minimumDateTime,
                    maximumDateTime: maximumDateTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
                    minimumDateTime: minimumDateTime,
                    maximumDateTime: maximumDateTime,
                    minuteInterval: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              SizedBox(
                width: 185,
                child: SBBGroup(
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
                    minimumDateTime: minimumDateTime,
                    maximumDateTime: maximumDateTime,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 150,
                child: SBBGroup(
                  child: SBBDateTimePicker(
                    onDateTimeChanged: (_) {},
                    initialDateTime: initialDateTime,
                    minimumDateTime: minimumDateTime,
                    maximumDateTime: maximumDateTime,
                    minuteInterval: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
