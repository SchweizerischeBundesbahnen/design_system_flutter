part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBTimePicker].
///
/// Displays the selected time as a read-only [SBBDecoratedText] field. When
/// tapped, it opens an [SBBTimePicker] in a modal bottom sheet via
/// [SBBTimePicker.showModal], allowing the user to pick a time.
///
/// The visual trigger is fully customizable through the `trigger`-prefixed
/// parameters, which map directly to the corresponding [SBBDecoratedText]
/// properties.
///
/// ## Example
///
/// ```dart
/// SBBTimeInput(
///   value: _selectedTime,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure time'),
///   onTimeChanged: (time) => setState(() => _selectedTime = time),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBTimePicker], the picker opened when the trigger is tapped.
/// * [SBBTimePicker.showModal], which is used to display the bottom sheet.
/// * [SBBDateTimeInput], variant for date and time values.
/// * [SBBDateInput], variant for date values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBTimeInput extends StatefulWidget {
  const SBBTimeInput({
    super.key,
    this.value,
    this.minimumTime,
    this.maximumTime,
    this.minuteInterval = _defaultMinuteInterval,
    this.dateFormat,
    required this.onTimeChanged,
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerMaxLines = 1,
    this.triggerMinLines,
    this.triggerExpands = false,
    this.triggerFocusNode,
    this.triggerAutofocus = false,
    this.visibleItemCount = _defaultVisibleItemCount,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       );

  /// The currently selected time. Displayed in the trigger field. When null,
  /// the trigger shows an empty value.
  final TimeOfDay? value;

  /// The earliest selectable time in the picker. Defaults to no lower bound.
  final TimeOfDay? minimumTime;

  /// The latest selectable time in the picker. Defaults to no upper bound.
  final TimeOfDay? maximumTime;

  /// The interval between minutes shown in the picker.
  ///
  /// Defaults to 1. Must be a divisor of 60.
  final int minuteInterval;

  /// The format used to display [value] in the trigger field.
  ///
  /// When null, [TimeOfDay.format] is used for the current locale.
  final DateFormat? dateFormat;

  /// Called when the user selects a time in the picker.
  ///
  /// When null, the trigger field is disabled and taps are ignored.
  final ValueChanged<TimeOfDay>? onTimeChanged;

  /// The decoration applied to the [SBBDecoratedText] trigger.
  ///
  /// Use this to configure the label, placeholder, error text, leading/trailing
  /// icons, and other visual properties of the trigger field.
  ///
  /// See [SBBInputDecoration] for available options.
  final SBBInputDecoration? triggerDecoration;

  /// The visual style applied to the [SBBDecoratedText] trigger.
  ///
  /// Non-null properties override the corresponding theme values.
  /// See [SBBDecoratedTextStyle] for available options.
  final SBBDecoratedTextStyle? triggerStyle;

  /// The maximum number of lines for the trigger field's text display.
  ///
  /// Defaults to 1 (single-line). Set to null together with
  /// [triggerExpands] = true for an expanding multiline trigger.
  final int? triggerMaxLines;

  /// The minimum number of lines reserved in the trigger field.
  final int? triggerMinLines;

  /// Whether the trigger field should expand to fill available vertical space.
  ///
  /// When true, both [triggerMaxLines] and [triggerMinLines] must be null.
  /// Defaults to false.
  final bool triggerExpands;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? triggerFocusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool triggerAutofocus;

  /// The number of visible items in the picker. Must be a positive odd number.
  /// Defaults to 7.
  final int visibleItemCount;

  @override
  State<SBBTimeInput> createState() => _SBBTimeInputState();
}

class _SBBTimeInputState extends State<SBBTimeInput> {
  String get _valueText {
    var value = widget.value;
    if (value == null) {
      return '';
    }
    value = SBBTimePicker._initialTime(widget.value, widget.minimumTime, widget.maximumTime, widget.minuteInterval);
    return value.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return SBBDecoratedText(
      key: widget.key,
      value: _valueText,
      enabled: widget.onTimeChanged != null,
      decoration: widget.triggerDecoration,
      style: widget.triggerStyle,
      maxLines: widget.triggerMaxLines,
      minLines: widget.triggerMinLines,
      expands: widget.triggerExpands,
      focusNode: widget.triggerFocusNode,
      autofocus: widget.triggerAutofocus,
      onTap: widget.onTimeChanged != null
          ? () {
              SBBTimePicker.showModal(
                context: context,
                title: widget.triggerDecoration?.labelText,
                initialTime: widget.value,
                minimumTime: widget.minimumTime,
                maximumTime: widget.maximumTime,
                minuteInterval: widget.minuteInterval,
                visibleItemCount: widget.visibleItemCount,
                onTimeChanged: widget.onTimeChanged,
              );
            }
          : null,
    );
  }
}
