part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBDateTimePicker].
///
/// Displays the selected date and time as a read-only [SBBDecoratedText] field.
/// When tapped, it opens an [SBBDateTimePicker] in a modal bottom sheet via
/// [SBBDateTimePicker.showModal], allowing the user to pick a date and time.
///
/// The visual trigger is fully customizable through the `trigger`-prefixed
/// parameters, which map directly to the corresponding [SBBDecoratedText]
/// properties.
///
/// ## Example
///
/// ```dart
/// SBBDateTimeInput(
///   value: _selectedDateTime,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure'),
///   onDateTimeChanged: (dt) => setState(() => _selectedDateTime = dt),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBDateTimePicker], the picker opened when the trigger is tapped.
/// * [SBBDateTimePicker.showModal], which is used to display the bottom sheet.
/// * [SBBDateInput], variant for date values.
/// * [SBBTimeInput], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateTimeInput extends StatefulWidget {
  const SBBDateTimeInput({
    super.key,
    this.value,
    this.minimumDateTime,
    this.maximumDateTime,
    this.minuteInterval = _defaultMinuteInterval,
    this.dateFormat,
    required this.onDateTimeChanged,
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

  /// The currently selected date and time. Displayed in the trigger field using
  /// [dateFormat]. When null, the trigger shows an empty value.
  final DateTime? value;

  /// The earliest selectable date and time in the picker. Defaults to no lower bound.
  final DateTime? minimumDateTime;

  /// The latest selectable date and time in the picker. Defaults to no upper bound.
  final DateTime? maximumDateTime;

  /// The interval between minutes shown in the picker.
  ///
  /// Defaults to 1. Must be a divisor of 60.
  final int minuteInterval;

  /// The format used to display [value] in the trigger field.
  ///
  /// Defaults to [DateFormat.yMMMMd] combined with [DateFormat.Hm] for the
  /// current locale.
  final DateFormat? dateFormat;

  /// Called when the user selects a date and time in the picker.
  ///
  /// When null, the trigger field is disabled and taps are ignored.
  final ValueChanged<DateTime>? onDateTimeChanged;

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
  State<SBBDateTimeInput> createState() => _SBBDateTimeInputState();
}

class _SBBDateTimeInputState extends State<SBBDateTimeInput> {
  late final DateFormat _dateFormat =
      widget.dateFormat ?? DateFormat.yMMMMd(Localizations.maybeLocaleOf(context).toString()).add_Hm();

  String get _valueText {
    var value = widget.value;
    if (value == null) {
      return '';
    }
    value = SBBDateTimePicker._initialDateTime(
      widget.value,
      widget.minimumDateTime,
      widget.maximumDateTime,
      widget.minuteInterval,
    );
    return _dateFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return SBBDecoratedText(
      key: widget.key,
      value: _valueText,
      decoration: widget.triggerDecoration,
      style: widget.triggerStyle,
      maxLines: widget.triggerMaxLines,
      minLines: widget.triggerMinLines,
      expands: widget.triggerExpands,
      focusNode: widget.triggerFocusNode,
      autofocus: widget.triggerAutofocus,
      onTap: widget.onDateTimeChanged != null
          ? () {
              SBBDateTimePicker.showModal(
                context: context,
                title: widget.triggerDecoration?.labelText,
                initialDateTime: widget.value,
                minimumDateTime: widget.minimumDateTime,
                maximumDateTime: widget.maximumDateTime,
                minuteInterval: widget.minuteInterval,
                visibleItemCount: widget.visibleItemCount,
                onDateTimeChanged: widget.onDateTimeChanged,
              );
            }
          : null,
    );
  }
}
