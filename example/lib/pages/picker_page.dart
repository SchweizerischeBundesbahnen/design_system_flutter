import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class PickerPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: sbbDefaultSpacing,
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      child: Column(
        children: <Widget>[
          ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('DateTimePicker (date & time)'),
          SBBGroup(
            child: SBBDateTimePicker(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint('selected date time: $dateTime');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('DatePicker (date only)'),
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (DateTime date) {
                debugPrint('selected date: $date');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('TimePicker (time only)'),
          SBBGroup(
            child: SBBTimePicker(
              onTimeChanged: (TimeOfDay time) {
                debugPrint('selected time: $time');
              },
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('SBBPicker (looping)'),
          SBBGroup(
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
          SBBListHeader('SBBPicker (non looping)'),
          SBBGroup(
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
