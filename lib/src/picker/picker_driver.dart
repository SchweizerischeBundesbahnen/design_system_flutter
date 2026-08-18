/// Internal contracts implemented by picker states so that picker controllers
/// and the `WidgetTester` helpers in
/// `package:sbb_design_system_mobile/testing.dart` can set picker values
/// programmatically.
///
/// Not exported as public API.
library;

/// Implemented by the private state of `SBBDatePicker`.
abstract interface class SBBDatePickerDriver {
  /// Sets the selected date, see `SBBDatePickerController.setDate`.
  Future<void> setDate(DateTime date, {bool animate = true});
}
