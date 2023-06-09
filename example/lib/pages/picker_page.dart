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

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
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
          SBBListHeader('TEST'),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: SBBColors.white,
                height: _scrollAreaHeight,
                child: ListView.builder(
                  physics: _PickerScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: _itemHeight * 3),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < 0 || index >= _fruitNames.length) {
                      return null;
                    }
                    return Container(
                      color: index % 2 == 0 ? SBBColors.lemon : SBBColors.brown,
                      height: _itemHeight,
                      child: Text(_fruitNames[index]),
                    );
                  },
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                color: Color(0x55000000),
              ),
            ],
          ),
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
                        return (false, null);
                      }
                      return (
                        true,
                        Text(_fruitNames[index]),
                      );
                    },
                    initialSelectedIndex: 1,
                    looping: false,
                  ),
                ),
                Expanded(
                  child: SBBPicker(
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
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBListHeader('CupertinoDatePicker'),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minuteInterval: 1,
              onDateTimeChanged: (DateTime value) {
                debugPrint(
                    'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
              },
              initialDateTime: DateTime(1, 1, 1),
              // minimumDate: DateTime.now(),
              maximumDate: DateTime.now().add(Duration(days: 360)),
            ),
          ),
          // Container(
          //   height: 200,
          //   child: CupertinoDatePicker(
          //     mode: CupertinoDatePickerMode.time,
          //     onDateTimeChanged: (DateTime value) {
          //       debugPrint(
          //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //     minimumDate: DateTime.now().subtract(Duration(hours: 24)),
          //     use24hFormat: true,
          //   ),
          // ),
          // SBBListHeader('SBBDateTimePicker Time'),
          // SBBGroup(
          //   child: SBBDateTimePicker(
          //     mode: SBBDateTimePickerMode.time,
          //     minuteInterval: 15,
          //     onDateTimeChanged: _onDateTimeChanged,
          //   ),
          // ),
          SBBListHeader('SBBDateTimePicker Date'),
          SBBGroup(
            child: SBBDateTimePicker(
              mode: SBBDateTimePickerMode.date,
              minuteInterval: 15,
              onDateTimeChanged: _onDateTimeChanged,
              minimumDate: DateTime.now(),
              maximumDate: DateTime.now().add(Duration(days: 360)),
            ),
          ),
          Text('${dateTime.toString()}'),
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
            child: Container(
              height: 200,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  debugPrint('DATE: $date');
                },
              ),
            ),
          ),
          // SBBGroup(
          //   child: SBBPicker.dateAndTime(
          //     // initialDateTime: dateTime,
          //     minuteInterval: 15,
          //     onDateTimeChanged: (DateTime dateTime) {
          //       debugPrint(
          //           'Selected: ${localizations.formatCompactDate(dateTime)} - ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //   ),
          // ),
          // SBBListHeader('Time'),
          // SBBGroup(
          //   child: SBBPicker.time(
          //     onDateTimeChanged: (DateTime dateTime) {
          //       debugPrint(
          //           'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //   ),
          // ),
          // const SizedBox(
          //   height: sbbDefaultSpacing,
          // ),
          // SBBListHeader('Time (15 minute interval)'),
          // SBBGroup(
          //   child: SBBPicker.time(
          //     minuteInterval: 15,
          //     onDateTimeChanged: (DateTime dateTime) {
          //       debugPrint(
          //           'Selected: ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(dateTime))}');
          //     },
          //   ),
          // ),
          // SBBListHeader('Date'),
          // SBBGroup(
          //   child: SBBPicker.date(
          //     onDateTimeChanged: (DateTime dateTime) {
          //       debugPrint(
          //           'Selected: ${localizations.formatShortDate(dateTime)}');
          //     },
          //   ),
          // ),
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
    debugPrint(
        'Selected: ${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(4, '0')} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}');
    setState(() {
      this.dateTime = dateTime;
    });
  }
}


const _itemHeight = 30.0;
const _highlightedAreaHeight = 34.0;
const _visibleItemCount = 7;
const _scrollAreaHeight = _itemHeight * _visibleItemCount;
const _visibleItemHeights = [
  28.0,
  28.0,
  30.0,
  38.0,
  30.0,
  28.0,
  28.0,
];

class _PickerScrollPhysics extends ScrollPhysics {
  const _PickerScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  _PickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _PickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position,
      double velocity,
      ) {
    if (velocity == 0.0) {
      final scrollPosition = position.pixels;
      final target = _calculateTargetScrollPosition(scrollPosition);
      if (target != scrollPosition) {
        return ScrollSpringSimulation(
          spring,
          scrollPosition,
          target,
          velocity,
          tolerance: toleranceFor(position),
        );
      }
    }

    return parent!.createBallisticSimulation(position, velocity);
  }

  static double _calculateTargetScrollPosition(double scrollPosition) {
    final itemsOfBothListsVisible =
        scrollPosition < 0 && scrollPosition > -_scrollAreaHeight;
    if (itemsOfBothListsVisible) {
      // Because the heights of list items vary depending on their positions,
      // it's necessary to handle the area where items from both the positive
      // and negative lists are visible differently. This is because the
      // calculation for the target scroll position isn't accurate when both
      // lists are scrolling simultaneously. Therefore, the calculation for the
      // target scroll position must be adjusted.
      for (var i = 0; i < _visibleItemCount; i++) {
        var threshold = 0.0;
        for (var j = 0; j < i; j++) {
          threshold -= _visibleItemHeights[j];
        }
        threshold -= _visibleItemHeights[i] * 0.5;
        if (scrollPosition > threshold) {
          return threshold + _visibleItemHeights[i] * 0.5;
        }
      }
    }

    return (scrollPosition / _itemHeight).round() * _itemHeight;
  }

  @override
  bool get allowImplicitScrolling => false;
}
