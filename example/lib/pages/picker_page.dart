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
    'Apple',
    'Mango',
    'Banana',
    'Orange',
  ];

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateTime = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: sbbDefaultSpacing, horizontal: sbbDefaultSpacing * 0.5),
      child: Column(
        children: <Widget>[
          const ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Picker input fields'),
          SBBContentBox(
            child: Column(
              children: [
                SBBDateInput(
                  value: _selectedDate,
                  labelText: 'Date only',
                  onDateChanged: (date) {
                    debugPrint('selected date: $date');
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                SBBDateTimeInput(
                  value: _selectedDateTime,
                  labelText: 'Date and time',
                  onDateTimeChanged: (dateTime) {
                    debugPrint('selected date time: $dateTime');
                    setState(() {
                      _selectedDateTime = dateTime;
                    });
                  },
                ),
                SBBTimeInput(
                  value: _selectedTime,
                  labelText: 'Time only',
                  onTimeChanged: (time) {
                    debugPrint('selected time: $time');
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  isLastElement: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Date Time Picker (date & time)'),
          SBBContentBox(
            child: SBBDateTimePicker(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint('selected date time: $dateTime');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Date Picker (date only)'),
          SBBContentBox(
            child: SBBDatePicker(
              onDateChanged: (DateTime date) {
                debugPrint('selected date: $date');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Time Picker (time only)'),
          SBBContentBox(
            child: SBBTimePicker(
              onTimeChanged: (TimeOfDay time) {
                debugPrint('selected time: $time');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Picker (looping)'),
          SBBContentBox(
            child: SBBPicker.list(
              onSelectedItemChanged: (int index) {
                final selectedItemIndex = index % _fruitNames.length;
                final selectedItem = _fruitNames[selectedItemIndex];
                debugPrint('selected item: $selectedItem');
              },
              items: _fruitNames,
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Picker (non looping)'),
          SBBContentBox(
            child: SBBPicker.list(
              looping: false,
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
