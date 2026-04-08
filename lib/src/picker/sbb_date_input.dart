part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBDatePicker].
///
/// Displays the selected date as a read-only [SBBDecoratedText] field. When
/// tapped, it opens an [SBBDatePicker] in a modal bottom sheet via
/// [SBBDatePicker.showModal], allowing the user to pick a date.
///
/// Use [triggerDecoration] to customise the trigger's label, icons, error text,
/// and other decoration properties. By default a [SBBIcons.chevron_small_down_small]
/// trailing icon is added automatically unless a custom trailing widget or trailingIconData is provided.
///
/// Use [triggerConfig] to configure the trigger field's layout and focus
/// behaviour (max/min lines, expands, focus node, autofocus). When omitted,
/// the defaults from [SBBDecoratedTextConfig] are used.
///
/// Use [sheetConfig] to customise the bottom sheet's appearance and behaviour.
/// Use [sheetTitleText] as a flat convenience parameter to set only the sheet
/// title. Cannot be used together with [sheetConfig]. When neither is set, the
/// sheet title defaults to the localised date input label from
/// [MaterialLocalizations.dateInputLabel].
///
/// ## Example
///
/// ```dart
/// SBBDateInput(
///   value: _selectedDate,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure date'),
///   sheetTitleText: 'Select departure date',
///   onDateChanged: (date) => setState(() => _selectedDate = date),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBDecoratedTextConfig], the configuration object for the trigger field.
/// * [SBBDatePicker], the picker opened when the trigger is tapped.
/// * [SBBDatePicker.showModal], which is used to display the bottom sheet.
/// * [SBBBottomSheetConfig], the configuration object for the bottom sheet.
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
    this.triggerConfig = const SBBDecoratedTextConfig(),
    this.visibleItemCount = _defaultVisibleItemCount,
    this.sheetConfig,
    this.sheetTitleText,
    this.sheetButtonLabelText,
  })  : assert(
          visibleItemCount > 0 && visibleItemCount % 2 == 1,
          'visibleItemCount must be a positive odd number, but was $visibleItemCount',
        ),
        assert(
          sheetConfig == null || sheetTitleText == null,
          'sheetTitleText cannot be set while sheetConfig is set!',
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

  /// Configuration for the trigger field's layout and focus behaviour.
  ///
  /// Defaults to [SBBDecoratedTextConfig] with its default values.
  final SBBDecoratedTextConfig triggerConfig;

  /// The number of visible items in the picker. Must be a positive odd number.
  /// Defaults to 7.
  final int visibleItemCount;

  /// Configuration for the bottom sheet's appearance and behaviour.
  ///
  /// Use this to customise the sheet title, icons, dismiss behaviour, and other
  /// properties. See [SBBBottomSheetConfig] for available options.
  ///
  /// Cannot be used together with [sheetTitleText].
  final SBBBottomSheetConfig? sheetConfig;

  /// This is a flat convenience parameter for setting the sheet title only.
  /// If you need more control, use [sheetConfig] instead.
  ///
  /// When neither [sheetConfig] nor [sheetTitleText] is provided, the sheet
  /// title defaults to [MaterialLocalizations.dateInputLabel].
  ///
  /// Cannot be used together with [sheetConfig].
  final String? sheetTitleText;

  /// The label text for the confirm button in the bottom sheet.
  ///
  /// When not provided, defaults to [MaterialLocalizations.datePickerHelpText].
  final String? sheetButtonLabelText;

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
      maxLines: widget.triggerConfig.maxLines,
      minLines: widget.triggerConfig.minLines,
      expands: widget.triggerConfig.expands,
      focusNode: widget.triggerConfig.focusNode,
      autofocus: widget.triggerConfig.autofocus,
      onTap: widget.onDateChanged != null
          ? () {
              SBBDatePicker.showModal(
                context: context,
                sheetConfig: widget.sheetConfig,
                sheetTitleText: widget.sheetTitleText,
                sheetButtonLabelText: widget.sheetButtonLabelText,
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
