import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/picker/picker_driver.dart';

/// Test helpers for driving SBB design system widgets from a [WidgetTester].
extension SBBWidgetTesterExtensions on WidgetTester {
  /// Selects [date] in the [SBBDatePicker] matched by [finder].
  ///
  /// [finder] may either match the [SBBDatePicker] itself or a widget that
  /// contains exactly one [SBBDatePicker]. The picker does not need an
  /// [SBBDatePickerController] attached for this helper to work.
  ///
  /// [date] is clamped to the picker's minimum/maximum date and its time
  /// components are ignored, see [SBBDatePickerController.setDate]. Pumps
  /// until the resulting scroll animations have settled.
  Future<void> selectSBBDate(Finder finder, DateTime date) async {
    final pickerFinder = find.descendant(of: finder, matching: find.byType(SBBDatePicker), matchRoot: true);
    final pickerState = state<State<SBBDatePicker>>(pickerFinder) as SBBDatePickerDriver;
    final done = pickerState.setDate(date);
    await pumpAndSettle();
    await done;
  }

  /// Selects [time] in the [SBBTimePicker] matched by [finder].
  ///
  /// [finder] may either match the [SBBTimePicker] itself or a widget that
  /// contains exactly one [SBBTimePicker]. The picker does not need an
  /// [SBBTimePickerController] attached for this helper to work.
  ///
  /// [time] is rounded to the picker's minute interval and clamped to its
  /// minimum/maximum time, see [SBBTimePickerController.setTime]. Pumps until
  /// the resulting scroll animations have settled.
  Future<void> selectSBBTime(Finder finder, TimeOfDay time) async {
    final pickerFinder = find.descendant(of: finder, matching: find.byType(SBBTimePicker), matchRoot: true);
    final pickerState = state<State<SBBTimePicker>>(pickerFinder) as SBBTimePickerDriver;
    final done = pickerState.setTime(time);
    await pumpAndSettle();
    await done;
  }
}
