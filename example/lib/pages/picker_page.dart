import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({super.key});

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  final List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Raspberry',
    'Kiwi',
    'Coconut',
    'Peach',
  ];

  // 🚂 Hogwarts
  DateTime _selectedDate = DateTime(1991, 9, 1);

  // 💣 Back to the Future
  DateTime _selectedDateTime = DateTime(1985, 10, 26, 1, 21);
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .symmetric(vertical: SBBSpacing.medium, horizontal: SBBSpacing.xSmall),
      child: Column(
        children: [
          const ThemeModeSegmentedButton(),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Picker input fields'),
          SBBContentBox(
            child: Column(
              children: SBBListItem.divideListItems(
                context: context,
                items: [
                  SBBDateInput(
                    value: _selectedDate,
                    triggerDecoration: const SBBInputDecoration(
                      labelText: 'Date only',
                      leadingIconData: SBBIcons.calendar_one_day_small,
                    ),
                    sheetTitleText: 'Select date only',
                    onDateChanged: (date) {
                      debugPrint('selected date: $date');
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  SBBDateTimeInput(
                    value: _selectedDateTime,
                    triggerDecoration: const SBBInputDecoration(
                      labelText: 'Date and time',
                      leadingIconData: SBBIcons.calendar_weekday_small,
                    ),
                    sheetTitleText: 'Select date and time',
                    onDateTimeChanged: (dateTime) {
                      debugPrint('selected date time: $dateTime');
                      setState(() {
                        _selectedDateTime = dateTime;
                      });
                    },
                  ),
                  SBBTimeInput(
                    value: _selectedTime,
                    triggerDecoration: const SBBInputDecoration(
                      labelText: 'Time only',
                      leadingIconData: SBBIcons.clock_small,
                    ),
                    sheetTitleText: 'Select Time',
                    onTimeChanged: (time) {
                      debugPrint('selected time: $time');
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Date Time Picker (date & time)'),
          SBBContentBox(
            child: SBBDateTimePicker(
              visibleItemCount: 5,
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint('selected date time: $dateTime');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Date Picker (date only)'),
          SBBContentBox(
            child: SBBDatePicker(
              minimumDate: DateTime.now().subtract(Duration(days: 1)),
              maximumDate: DateTime.now().add(Duration(days: 2)),
              onDateChanged: (DateTime date) {
                debugPrint('selected date: $date');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Time Picker (time only)'),
          SBBContentBox(
            child: SBBTimePicker(
              initialTime: TimeOfDay(hour: 20, minute: 15),
              onTimeChanged: (TimeOfDay time) {
                debugPrint('selected time: $time');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Picker (looping)'),
          SBBContentBox(
            child: SBBPicker.list(
              visibleItemCount: 5,
              initialSelectedIndex: 1,
              onSelectedItemChanged: (int index) {
                final selectedItemIndex = index % _fruitNames.length;
                final selectedItem = _fruitNames[selectedItemIndex];
                debugPrint('selected item: $selectedItem');
              },
              items: _fruitNames,
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Picker (non looping)'),
          SBBContentBox(
            child: SBBPicker.list(
              looping: false,
              initialSelectedIndex: 1,
              onSelectedItemChanged: (int index) {
                final selectedItem = _fruitNames[index];
                debugPrint('selected item: $selectedItem');
              },
              items: _fruitNames,
            ),
          ),
        ],
      ),
    );
  }
}
