import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
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
  ];

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(
        context); //Localizations.of(context, MaterialLocalizations);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: sbbDefaultSpacing,
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      child: Column(
        children: <Widget>[
          ThemeModeSegmentedButton(),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('Default Picker (custom values)'),
          SBBGroup(
            child: SBBPicker(
              onSelectedItemChanged: (int index) {
                debugPrint(
                    'Selected: ${_fruitNames[index % _fruitNames.length]}');
              },
              itemBuilder: (BuildContext context, int index) {
                return Text(_fruitNames[index % _fruitNames.length]);
              },
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          // SBBListHeader('CupertinoDatePicker'),
          // Container(
          //   height: 200,
          //   child: CupertinoDatePicker(
          //     mode: CupertinoDatePickerMode.date,
          //     minuteInterval: 15,
          //     onDateTimeChanged: (DateTime value) {
          //       debugPrint(
          //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //   ),
          // ),
          SBBListHeader('SBBDateTimePicker Time'),
          SBBGroup(
            child: SBBDateTimePicker(
              mode: SBBDateTimePickerMode.time,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
            ),
          ),
          SBBListHeader('SBBDateTimePicker Date'),
          SBBGroup(
            child: SBBDateTimePicker(
              mode: SBBDateTimePickerMode.date,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
            ),
          ),
          SBBListHeader('SBBDateTimePicker DateAndTime'),
          SBBGroup(
            child: SBBDateTimePicker(
              // initialDateTime: dateTime,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
            ),
          ),
          SBBListHeader('dateAndTime'),
          SBBGroup(
            child: SBBPicker.dateAndTime(
              // initialDateTime: dateTime,
              minuteInterval: 15,
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint(
                    'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
              },
            ),
          ),
          SBBListHeader('Time'),
          SBBGroup(
            child: SBBPicker.time(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint(
                    'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
              },
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('Time (15 minute interval)'),
          SBBGroup(
            child: SBBPicker.time(
              minuteInterval: 15,
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint(
                    'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
              },
            ),
          ),
          SBBListHeader('Date'),
          SBBGroup(
            child: SBBPicker.date(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint(
                    'Selected: ${localizations.formatShortDate(dateTime)}');
              },
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('SBBDateAndTimePicker'),
          SBBGroup(
            child: SBBDateTimePicker(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint(
                    'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onDateTimeChanged(DateTime dateTime) {
    debugPrint('Selected: ${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(4, '0')} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}');
  }
}
