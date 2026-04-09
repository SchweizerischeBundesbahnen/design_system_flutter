part of 'sbb_picker.dart';

/// This is basically a convenience combination of a [SBBDecoratedText] and a [SBBDatePicker].
///
/// Displays the selected time as a read-only [SBBDecoratedText] field. When tapped, it opens an [SBBDatePicker]
/// in a [SBBBottomSheet] via [SBBDatePicker.showInsideBottomSheet], allowing the user to pick a time.
///
/// Use [triggerDecoration] to customise the trigger's label, icons, error text, and other decoration properties.
///
/// Use [triggerConfig] to configure the trigger field's layout and focus behaviour (max/min lines, expands,
/// focus node, autofocus). When omitted, the defaults from [SBBDecoratedTextConfig] are used.
///
/// Use [sheetConfig] to customise the bottom sheet's appearance and behavior. Use [sheetTitleText] as a flat
/// convenience parameter to set only the sheet title. Cannot be used together with [sheetConfig].
/// When neither is set, the sheet title defaults to the localised time picker label from
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
/// * [SBBDatePicker.showInsideBottomSheet], which is used to display the bottom sheet.
/// * [SBBBottomSheetConfig], the configuration object for the bottom sheet.
/// * [SBBDateTimeInput], variant for date and time values.
/// * [SBBTimeInput], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateInput extends StatelessWidget {
  const SBBDateInput({
    super.key,
    required this.onDateChanged,
    this.value,
    this.minimumDate,
    this.maximumDate,
    this.dateFormat,
    this.visibleItemCount = _defaultVisibleItemCount,
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerConfig = const SBBDecoratedTextConfig(),
    this.sheetConfig,
    this.sheetTitleText,
    this.sheetButtonLabelText,
    this.pickerStyle,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       ),
       assert(
         sheetConfig == null || sheetTitleText == null,
         'sheetTitleText cannot be set while sheetConfig is set!',
       );

  /// The currently selected date. Displayed in the trigger field formatted by
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

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
  ///
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

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  @override
  Widget build(BuildContext context) {
    return SBBDecoratedText(
      value: _formattedValue(context),
      decoration: triggerDecoration,
      style: triggerStyle,
      maxLines: triggerConfig.maxLines,
      minLines: triggerConfig.minLines,
      expands: triggerConfig.expands,
      focusNode: triggerConfig.focusNode,
      autofocus: triggerConfig.autofocus,
      onTap: onDateChanged != null
          ? () {
              SBBDatePicker.showInsideBottomSheet(
                context: context,
                onDateChanged: onDateChanged,
                sheetConfig: sheetConfig,
                sheetTitleText: sheetTitleText,
                sheetButtonLabelText: sheetButtonLabelText,
                initialDate: value,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                visibleItemCount: visibleItemCount,
                pickerStyle: pickerStyle,
              );
            }
          : null,
    );
  }

  String _formattedValue(BuildContext context) {
    if (value == null) return '';

    final DateFormat effectiveDateFormat =
        dateFormat ?? DateFormat.yMMMMd(Localizations.maybeLocaleOf(context).toString());

    final rawDate = SBBDatePicker._clampedDateOnly(
      value!,
      minimumDate,
      maximumDate,
    );
    return effectiveDateFormat.format(rawDate);
  }
}
