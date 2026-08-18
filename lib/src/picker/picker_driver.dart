/// Internal contracts implemented by picker states so that picker controllers
/// and the `WidgetTester` helpers in
/// `package:sbb_design_system_mobile/testing.dart` can set picker values
/// programmatically.
///
/// Not exported as public API.
library;

import 'package:flutter/material.dart';

/// Implemented by the private state of `SBBDatePicker`.
abstract interface class SBBDatePickerDriver {
  /// Sets the selected date, see `SBBDatePickerController.setDate`.
  Future<void> setDate(DateTime date, {bool animate = true});
}

/// Implemented by the private state of `SBBTimePicker`.
abstract interface class SBBTimePickerDriver {
  /// Sets the selected time, see `SBBTimePickerController.setTime`.
  Future<void> setTime(TimeOfDay time, {bool animate = true});
}

/// Implemented by the private state of `SBBDateTimePicker`.
abstract interface class SBBDateTimePickerDriver {
  /// Sets the selected date time, see `SBBDateTimePickerController.setDateTime`.
  Future<void> setDateTime(DateTime dateTime, {bool animate = true});
}
