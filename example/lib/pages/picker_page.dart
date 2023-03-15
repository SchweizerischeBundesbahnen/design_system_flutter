import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class PickerPage extends StatelessWidget {
  final List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = Localizations.of(context, MaterialLocalizations);
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
        ],
      ),
    );
  }
}
