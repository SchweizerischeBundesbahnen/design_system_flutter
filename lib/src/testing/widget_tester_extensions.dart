import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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

  /// Selects [dateTime] in the [SBBDateTimePicker] matched by [finder].
  ///
  /// [finder] may either match the [SBBDateTimePicker] itself or a widget that
  /// contains exactly one [SBBDateTimePicker]. The picker does not need an
  /// [SBBDateTimePickerController] attached for this helper to work.
  ///
  /// [dateTime] is rounded to the picker's minute interval and clamped to its
  /// minimum/maximum date time, see [SBBDateTimePickerController.setDateTime].
  /// Pumps until the resulting scroll animations have settled.
  Future<void> selectSBBDateTime(Finder finder, DateTime dateTime) async {
    final pickerFinder = find.descendant(of: finder, matching: find.byType(SBBDateTimePicker), matchRoot: true);
    final pickerState = state<State<SBBDateTimePicker>>(pickerFinder) as SBBDateTimePickerDriver;
    final done = pickerState.setDateTime(dateTime);
    await pumpAndSettle();
    await done;
  }

  /// Sets the [SBBSlider] matched by [finder] to the reachable value closest
  /// to [value].
  ///
  /// [finder] may either match the [SBBSlider] itself or a widget that
  /// contains exactly one [SBBSlider]. The value is driven through the
  /// slider's built-in [SemanticsAction.increase]/[SemanticsAction.decrease]
  /// accessibility actions — no drag gestures involved.
  /// [SBBSlider.onChangeStart], [SBBSlider.onChanged] and
  /// [SBBSlider.onChangeEnd] fire for every step taken, so the widget must be
  /// rebuilt with the new value by its [SBBSlider.onChanged] (as in any real
  /// usage) for the helper to make progress.
  ///
  /// The slider moves in discrete semantic steps: `(max - min) / divisions`
  /// when [SBBSlider.divisions] is set, otherwise a platform-dependent
  /// fraction of the range (10% on iOS/macOS, 5% on other platforms, matching
  /// [Slider]'s semantic adjustment unit). [value] is clamped to the slider's
  /// range and reached only up to that step granularity: exact-value
  /// assertions should account for the step rounding or use
  /// [SBBSlider.divisions].
  Future<void> setSBBSliderValue(Finder finder, double value) async {
    final sliderFinder = find.descendant(of: finder, matching: find.byType(SBBSlider), matchRoot: true);
    final materialSliderFinder = find.descendant(of: sliderFinder, matching: find.byType(Slider));

    final semanticsHandle = ensureSemantics();
    try {
      final slider = widget<Slider>(materialSliderFinder);
      final target = value.clamp(slider.min, slider.max).toDouble();
      double current() => widget<Slider>(materialSliderFinder).value;

      Future<bool> performStep(SemanticsAction action) async {
        final before = current();
        final node = _sliderSemanticsNode(materialSliderFinder, action);
        node.owner!.performAction(node.id, action);
        await pumpAndSettle();
        return current() != before;
      }

      while (current() != target) {
        final before = current();
        final action = target > before ? SemanticsAction.increase : SemanticsAction.decrease;
        if (!await performStep(action)) break; // no progress, clamped at min/max
        final after = current();
        if ((target - after).abs() >= (target - before).abs()) {
          final reverse = action == SemanticsAction.increase ? SemanticsAction.decrease : SemanticsAction.increase;
          await performStep(reverse);
          if ((target - current()).abs() > (target - after).abs()) {
            await performStep(action);
          }
          break;
        }
      }
    } finally {
      semanticsHandle.dispose();
    }
  }
}

/// Returns the [SemanticsNode] within the [Slider] matched by [finder] that
/// supports [action].
///
/// The adjustable node belongs to the slider's internal render object, not to
/// the [Slider] widget's outermost one, so this searches the slider's render
/// subtree instead of using `WidgetController.semantics.find` (which only
/// walks up to ancestors).
SemanticsNode _sliderSemanticsNode(Finder finder, SemanticsAction action) {
  SemanticsNode? result;
  void visit(RenderObject renderObject) {
    if (result != null) return;
    final node = renderObject.debugSemantics;
    if (node != null && node.getSemanticsData().hasAction(action)) {
      result = node;
      return;
    }
    renderObject.visitChildren(visit);
  }

  visit(finder.evaluate().single.renderObject!);
  if (result == null) {
    throw StateError(
      'No semantics node supporting $action found on the matched Slider. '
      'Is the slider enabled (onChanged != null) and are semantics enabled?',
    );
  }
  return result!;
}
