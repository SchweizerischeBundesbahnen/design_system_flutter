part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBDatePicker].
///
/// Displays the selected date as a read-only [SBBDecoratedText] field. When
/// tapped, it opens an [SBBDatePicker] in a modal bottom sheet via
/// [SBBDatePicker.showModal], allowing the user to pick a date.
///
/// The visual trigger is fully customizable through the `trigger`-prefixed
/// parameters, which map directly to the corresponding [SBBDecoratedText]
/// properties.
///
/// ## Example
///
/// ```dart
/// SBBDateInput(
///   value: _selectedDate,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure date'),
///   onDateChanged: (date) => setState(() => _selectedDate = date),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBDatePicker], the picker opened when the trigger is tapped.
/// * [SBBDatePicker.showModal], which is used to display the bottom sheet.
/// * [SBBDateTimeInput], variant for date and time values.
/// * [SBBTimeInput], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateInput extends StatefulWidget {
  const SBBDateInput({
    super.key,
    this.value,
    this.minimumDate,
    this.maximumDate,
    this.dateFormat,
    required this.onDateChanged,
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

  /// The currently selected date. Displayed in the trigger field using
  /// [dateFormat]. When null, the trigger shows an empty value.
  final DateTime? value;

  /// The earliest selectable date in the picker. Defaults to no lower bound.
  final DateTime? minimumDate;

  /// The latest selectable date in the picker. Defaults to no upper bound.
  final DateTime? maximumDate;

  /// The format used to display [value] in the trigger field.
  ///
  /// Defaults to [DateFormat.yMMMMd] for the current locale.
  final DateFormat? dateFormat;

  /// Called when the user selects a date in the picker.
  ///
  /// When null, the trigger field is disabled and taps are ignored.
  final ValueChanged<DateTime>? onDateChanged;

  /// The decoration applied to the [SBBDecoratedText] trigger.
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
  State<SBBDateInput> createState() => _SBBDateInputState();
}

class _SBBDateInputState extends State<SBBDateInput> {
  late final DateFormat _dateFormat =
      widget.dateFormat ?? DateFormat.yMMMMd(Localizations.maybeLocaleOf(context).toString());

  String get _valueText {
    var value = widget.value;
    if (value == null) {
      return '';
    }
    value = SBBDatePicker._initialDate(widget.value, widget.minimumDate, widget.maximumDate);
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
      onTap: widget.onDateChanged != null
          ? () {
              SBBDatePicker.showModal(
                context: context,
                title: widget.triggerDecoration?.labelText,
                initialDate: widget.value,
                minimumDate: widget.minimumDate,
                maximumDate: widget.maximumDate,
                visibleItemCount: widget.visibleItemCount,
                onDateChanged: widget.onDateChanged,
              );
            }
          : null,
    );
  }
}
