import 'package:flutter/material.dart';

// Layout constants
const pickerItemDefaultHeight = 30.0;
const pickerDefaultVisibleItemCount = 7;
const pickerItemDefaultPadding = 12.0;
const pickerItemMinPadding = 4.0;
const pickerWidgetHorizontalPadding = pickerItemDefaultPadding;
const pickerTimeItemTextDefaultWidth = pickerItemDefaultPadding * 4;
const pickerTimeItemCount = 2;

// Time constants
const pickerLastMinuteOfHour = TimeOfDay.minutesPerHour - 1;
const pickerStartOfDay = TimeOfDay(hour: 0, minute: 0);
const pickerEndOfDay = TimeOfDay(hour: TimeOfDay.hoursPerDay - 1, minute: pickerLastMinuteOfHour);
const pickerDefaultMinuteInterval = 1;
