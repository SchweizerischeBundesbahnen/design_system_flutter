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

  DateTime initialDateTime =
      DateTime.now().copyWith(day: 31, month: 7, year: 2026);
  late DateTime dateTime = initialDateTime;
  final controller = SBBPickerScrollController(initialItem: 4);

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
          SBBListHeader('SBBDateTimePicker Date'),
          SBBGroup(
            child: SBBDateTimePicker(
              mode: SBBDateTimePickerMode.time,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
              minimumDate: DateTime.now().subtract(Duration(hours: 10)),
              maximumDate: DateTime.now().add(Duration(hours: 5)),
            ),
          ),
          SBBListHeader('TEST'),
          // SBBGroup(
          //   child: SBBPicker.custom(
          //     child: SBBPickerScrollView(
          //       // controller: controller,
          //       onSelectedItemChanged: (int index) {
          //         debugPrint('Selected: ${_fruitNames[index]}');
          //       },
          //       itemBuilder: (BuildContext context, int index) {
          //         if (index < 0 || index >= _fruitNames.length) {
          //           return (false, null);
          //         }
          //         return (
          //           true,
          //           Text(_fruitNames[index]),
          //         );
          //       },
          //       looping: false,
          //     ),
          //   ),
          // ),
          // SBBGroup(
          //   child: SBBPicker.custom(
          //     child: SBBPickerScrollView(
          //       looping: false,
          //       controller: controller,
          //       onSelectedItemChanged: (int index) {
          //         debugPrint(
          //             'Selected: ${_fruitNames[index % _fruitNames.length]}');
          //       },
          //       itemBuilder: (BuildContext context, int index) {
          //         if (index < 0 || index >= _fruitNames.length) {
          //           return null;
          //         }
          //         return (
          //           true,
          //           Text('$index ${_fruitNames[index % _fruitNames.length]}'),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          // SBBPrimaryButton(
          //   label: 'test',
          //   onPressed: () {
          //     controller.animateToItem(4);
          //   },
          // ),
          // SBBGroup(
          //   child: SBBPicker.custom(
          //     child: SBBPickerScrollView(
          //       looping: true,
          //       controller: SBBPickerScrollController(initialItem: 0),
          //       onSelectedItemChanged: (int index) {
          //         debugPrint(
          //             'Selected: ${_fruitNames[index % _fruitNames.length]}');
          //       },
          //       itemBuilder: (BuildContext context, int index) {
          //         return (
          //           true,
          //           Text('$index ${_fruitNames[index % _fruitNames.length]}'),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          SBBListHeader('Default Picker (custom values)'),
          SBBGroup(
            child: Row(
              children: [
                Expanded(
                  child: SBBPicker(
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
                    initialSelectedIndex: 5,
                    looping: false,
                  ),
                ),
                Expanded(
                  child: SBBPicker(
                    initialSelectedIndex: 5,
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
              ],
            ),
          ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader('CupertinoDatePicker'),
          // Container(
          //   height: 200,
          //   child: CupertinoDatePicker(
          //     mode: CupertinoDatePickerMode.date,
          //     minuteInterval: 1,
          //     onDateTimeChanged: (DateTime value) {
          //       debugPrint(
          //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //     // initialDateTime: DateTime(1, 1, 1),
          //     minimumDate: DateTime.now().subtract(Duration(days: 31)),
          //     maximumDate: DateTime.now().add(Duration(days: 360)),
          //   ),
          // ),
          // // Container(
          // //   height: 200,
          // //   child: CupertinoDatePicker(
          // //     mode: CupertinoDatePickerMode.time,
          // //     onDateTimeChanged: (DateTime value) {
          // //       debugPrint(
          // //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          // //     },
          // //     minimumDate: DateTime.now().subtract(Duration(hours: 24)),
          // //     use24hFormat: true,
          // //   ),
          // // ),
          // // SBBListHeader('SBBDateTimePicker Time'),
          // // SBBGroup(
          // //   child: SBBDateTimePicker(
          // //     mode: SBBDateTimePickerMode.time,
          // //     minuteInterval: 15,
          // //     onDateTimeChanged: _onDateTimeChanged,
          // //   ),
          // // ),
          SBBListHeader(
              'SBBDateTimePicker Date ${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(4, '0')}'),
          SBBGroup(
            child: SBBDateTimePicker(
              mode: SBBDateTimePickerMode.date,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
              initialDateTime: initialDateTime,
              minimumDate: initialDateTime.copyWith(year: 2020),
              maximumDate: initialDateTime.copyWith(year: 2029),
            ),
          ),
          // Text('${dateTime.toString()}'),
          // SBBListHeader('SBBDateTimePicker DateAndTime'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     // initialDateTime: dateTime,
          //     minuteInterval: 15,
          //     onDateTimeChanged: _onDateTimeChanged,
          //   ),
          // ),
          // SBBListHeader('dateAndTime'),
          // SBBGroup(
          //   child: Container(
          //     height: 200,
          //     child: CupertinoDatePicker(
          //       minimumDate: DateTime.now(),
          //       mode: CupertinoDatePickerMode.date,
          //       onDateTimeChanged: (date) {
          //         debugPrint('DATE: $date');
          //       },
          //     ),
          //   ),
          // ),
          // // SBBGroup(
          // //   child: SBBPicker.dateAndTime(
          // //     // initialDateTime: dateTime,
          // //     minuteInterval: 15,
          // //     onDateTimeChanged: (DateTime dateTime) {
          // //       debugPrint(
          // //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          // //     },
          // //   ),
          // // ),
          // // SBBListHeader('Time'),
          // // SBBGroup(
          // //   child: SBBPicker.time(
          // //     onDateTimeChanged: (DateTime dateTime) {
          // //       debugPrint(
          // //           'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          // //     },
          // //   ),
          // // ),
          // // const SizedBox(
          // //   height: sbbDefaultSpacing,
          // // ),
          // // SBBListHeader('Time (15 minute interval)'),
          // // SBBGroup(
          // //   child: SBBPicker.time(
          // //     minuteInterval: 15,
          // //     onDateTimeChanged: (DateTime dateTime) {
          // //       debugPrint(
          // //           'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          // //     },
          // //   ),
          // // ),
          // // SBBListHeader('Date'),
          // // SBBGroup(
          // //   child: SBBPicker.date(
          // //     onDateTimeChanged: (DateTime dateTime) {
          // //       debugPrint(
          // //           'Selected: ${localizations.formatShortDate(dateTime)}');
          // //     },
          // //   ),
          // // ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader('SBBDateAndTimePicker'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     onDateTimeChanged: (DateTime dateTime) {
          //       debugPrint(
          //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //   ),
          // ),
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
