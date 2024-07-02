import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, Widget widget) {
    testWidgets(name, (WidgetTester tester) async {
      await Specs.run(
        Specs.mobileSpecs,
        widget,
        tester,
        name,
        find.byType(widget.runtimeType),
      );
    });
  }

  void generatePickerTest(
    String name,
    int initialItem,
    int? minItem,
    int? maxItem,
  ) {
    final widget = PickerTest(
      initialItem: initialItem,
      minItem: minItem,
      maxItem: maxItem,
    );
    generateTest(name, widget);
  }

  void generateDateTimePickerTest(
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
    generateTest(name, widget);
  }

  void generateDatePickerTest(
    String name,
    DateTime initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  ) {
    final widget = DatePickerTest(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    );
    generateTest(name, widget);
  }

  void generateTimePickerTest(
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
    generateTest(name, widget);
  }

  // value picker
  generatePickerTest('picker_test_1', 0, null, null);
  generatePickerTest('picker_test_2', 5, null, null);
  generatePickerTest('picker_test_3', 3, 2, 4);

  // date time picker
  generateDateTimePickerTest(
    'picker_date_time_test_1',
    DateTime(2024, 07, 02, 12),
    null,
    null,
  );
  generateDateTimePickerTest(
    'picker_date_time_test_2',
    DateTime(2024, 07, 02, 12),
    DateTime(2024, 06, 30, 8),
    DateTime(2024, 07, 04, 16),
  );
  generateDateTimePickerTest(
    'picker_date_time_test_3',
    DateTime(2024, 06, 30, 12),
    DateTime(2024, 07, 02, 8),
    DateTime(2024, 07, 04, 16),
  );
  generateDateTimePickerTest(
    'picker_date_time_test_4',
    DateTime(2024, 07, 06, 12),
    DateTime(2024, 07, 02, 8),
    DateTime(2024, 07, 04, 16),
  );

  // date picker
  generateDatePickerTest(
    'picker_date_test_1',
    DateTime(2024, 07, 02),
    null,
    null,
  );
  generateDatePickerTest(
    'picker_date_test_2',
    DateTime(2024, 07, 02),
    DateTime(2024, 06, 30),
    DateTime(2024, 07, 04),
  );
  generateDatePickerTest(
    'picker_date_test_3',
    DateTime(2024, 06, 30),
    DateTime(2024, 07, 02),
    DateTime(2024, 07, 04),
  );
  generateDatePickerTest(
    'picker_date_test_4',
    DateTime(2024, 07, 06),
    DateTime(2024, 07, 02),
    DateTime(2024, 07, 04),
  );

  // time picker
  generateTimePickerTest(
    'picker_time_test_1',
    const TimeOfDay(hour: 13, minute: 37),
    null,
    null,
  );
  generateTimePickerTest(
    'picker_time_test_2',
    const TimeOfDay(hour: 13, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
  generateTimePickerTest(
    'picker_time_test_3',
    const TimeOfDay(hour: 11, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
  generateTimePickerTest(
    'picker_time_test_4',
    const TimeOfDay(hour: 14, minute: 37),
    const TimeOfDay(hour: 12, minute: 37),
    const TimeOfDay(hour: 13, minute: 38),
  );
}

class PickerTest extends StatelessWidget {
  const PickerTest({
    super.key,
    required this.initialItem,
    required this.minItem,
    required this.maxItem,
  });

  static const List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];

  final int initialItem;
  final int? minItem;
  final int? maxItem;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBPicker.list(
                    onSelectedItemChanged: (_) {},
                    looping: true,
                    initialSelectedIndex: initialItem,
                    items: _fruitNames,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker.list(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    items: _fruitNames,
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
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: true,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isEnabled =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
                      final item = _fruitNames[index % _fruitNames.length];
                      return SBBPickerItem(item, isEnabled: isEnabled);
                    },
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isInRange =
                          (index >= 0) && (index < _fruitNames.length);
                      if (!isInRange) {
                        return null;
                      }
                      final isEnabled =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
                      final item = _fruitNames[index];
                      return SBBPickerItem(item, isEnabled: isEnabled);
                    },
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isInRange =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
                      if (!isInRange) {
                        return null;
                      }
                      final item = _fruitNames[index % _fruitNames.length];
                      return SBBPickerItem(item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
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

class DatePickerTest extends StatelessWidget {
  const DatePickerTest({
    super.key,
    required this.initialDate,
    required this.minimumDate,
    required this.maximumDate,
  });

  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (_) {},
              initialDate: initialDate,
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (_) {},
              initialDate: initialDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              SizedBox(
                width: 225,
                child: SBBGroup(
                  child: SBBDatePicker(
                    onDateChanged: (_) {},
                    initialDate: initialDate,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 180,
                child: SBBGroup(
                  child: SBBDatePicker(
                    onDateChanged: (_) {},
                    initialDate: initialDate,
                  ),
                ),
              ),
            ],
          ),
        ],
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
