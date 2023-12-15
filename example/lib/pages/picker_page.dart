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
    'Last',
  ];

  DateTime initialDateTime = DateTime.now();
  late DateTime dateTime = initialDateTime;
  late TimeOfDay time = TimeOfDay.fromDateTime(initialDateTime);
  final controller = SBBPickerScrollController(initialItem: 4);

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
              onDateTimeChanged: (DateTime dateTime) {},
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('DatePicker (date only)'),
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (DateTime date) {},
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBListHeader('TimePicker (time only)'),
          SBBGroup(
            child: SBBTimePicker(
              onTimeChanged: (TimeOfDay time) {},
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('SBBPicker (looping)'),
          SBBGroup(
            child: SBBPicker(
              isLastElement: true,
              onSelectedItemChanged: (int index) {},
              itemBuilder: (BuildContext context, int index) {
                return (
                  true,
                  Text(_fruitNames[index % _fruitNames.length]),
                );
              },
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('SBBPicker (non looping)'),
          SBBGroup(
            child: SBBPicker(
              looping: false,
              isLastElement: true,
              onSelectedItemChanged: (int index) {},
              itemBuilder: (BuildContext context, int index) {
                if (index < 0 || index >= _fruitNames.length) {
                  return null;
                }
                return (
                  true,
                  Text(_fruitNames[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
