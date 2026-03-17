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
    final theme = Theme.of(context);
    final textInputDecorationTheme = theme.sbbInputDecorationTheme;
    final withVerticalPadding = textInputDecorationTheme?.copyWith(
      contentPadding: EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
    );

    return SingleChildScrollView(
      padding: const .symmetric(vertical: SBBSpacing.medium, horizontal: SBBSpacing.xSmall),
      child: Column(
        children: [
          const ThemeModeSegmentedButton(),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Picker input fields'),
          ExtendedTheme(
            themeData: withVerticalPadding!,
            child: SBBContentBox(
              child: Column(
                children: SBBListItem.divideListItems(
                  context: context,
                  items: [
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
                    ),
                  ],
                ).toList(growable: false),
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Date Time Picker (date & time)'),
          SBBContentBox(
            child: SBBDateTimePicker(
              onDateTimeChanged: (DateTime dateTime) {
                debugPrint('selected date time: $dateTime');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Date Picker (date only)'),
          SBBContentBox(
            child: SBBDatePicker(
              onDateChanged: (DateTime date) {
                debugPrint('selected date: $date');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Time Picker (time only)'),
          SBBContentBox(
            child: SBBTimePicker(
              onTimeChanged: (TimeOfDay time) {
                debugPrint('selected time: $time');
              },
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
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
          const SizedBox(height: SBBSpacing.medium),
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


/// Overrides and/or extends the current theme with a [ThemeExtension] for
/// the given [child]. The theme change is animated.
class ExtendedTheme<T extends ThemeExtension<T>> extends StatelessWidget {
  const ExtendedTheme({
    super.key,
    required this.themeData,
    required this.child,
  });

  final ThemeExtension<T> themeData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedTheme(
      data: theme.copyWith(
        extensions: {...theme.extensions, T: themeData}.values,
      ),
      child: child,
    );
  }
}