import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader('DateTimePicker (date & time)'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     mode: SBBDateTimePickerMode.dateAndTime,
          //     minuteInterval: 15,
          //     onDateTimeChanged: _onDateTimeChanged,
          //     initialDateTime: initialDateTime,
          //   ),
          // ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader(
          //     'DateTimePicker (date & time - min date, max date)'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     mode: SBBDateTimePickerMode.dateAndTime,
          //     minuteInterval: 4,
          //     onDateTimeChanged: _onDateTimeChanged,
          //     initialDateTime: initialDateTime,
          //     minimumDateTime: initialDateTime.subtract(Duration(days: 2)),
          //     maximumDateTime:
          //         initialDateTime.add(Duration(days: 2)).copyWith(minute: 58),
          //   ),
          // ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader('DateTimePicker (date - with min and max date)'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     mode: SBBDateTimePickerMode.date,
          //     minuteInterval: 15,
          //     onDateTimeChanged: _onDateTimeChanged,
          //     initialDateTime: initialDateTime,
          //     minimumDateTime: initialDateTime.copyWith(
          //       year: initialDateTime.year - 1,
          //     ),
          //     maximumDateTime: initialDateTime.copyWith(
          //       year: initialDateTime.year + 1,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          Text('${120 ~/ 60}'),
          SBBTimePicker(
            onTimeChanged: (time) {
              debugPrint('CHANGE: $time');
            },
            minuteInterval: 15,
            initialTime: SBBTimePicker.roundToInterval(
                TimeOfDay(hour: 17, minute: 34), 15),
            minimumTime: SBBTimePicker.roundToInterval(
                TimeOfDay(hour: 12, minute: 30), 15),
            maximumTime: SBBTimePicker.roundToInterval(
                TimeOfDay(hour: 20, minute: 45), 15),
          ),
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: _onDateTimeChanged,
              initialDate: initialDateTime,
              minimumDate:
                  initialDateTime.copyWith(year: initialDateTime.year - 2),
              maximumDate:
                  initialDateTime.copyWith(year: initialDateTime.year + 2),
              // maximumDateTime: initialDateTime,
            ),
          ),
          SBBListHeader('DateTimePicker (time - with min and max date)'),
          SBBGroup(
            child: SBBDateTimePicker(
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
              initialDateTime:
                  SBBDateTimePicker.roundToInterval(initialDateTime, 15),
              minimumDateTime:
                  SBBDateTimePicker.roundToInterval(initialDateTime, 15),
              maximumDateTime: initialDateTime.add(Duration(hours: 2)),
              // maximumDateTime: initialDateTime,
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('SBBPicker (looping)'),
          SBBGroup(
            child: SBBPicker(
              isLastElement: true,
              onSelectedItemChanged: (int index) {
                debugPrint(
                    'Selected: ${_fruitNames[index % _fruitNames.length]}');
              },
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
              onSelectedItemChanged: (int index) {
                debugPrint('Selected: ${_fruitNames[index]}');
              },
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

  void _onDateTimeChanged(DateTime dateTime) {
    debugPrint(
        'Selected: ${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(4, '0')} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}');
    setState(() {
      this.dateTime = dateTime;
    });
  }
}
