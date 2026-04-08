part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBDateTimePicker].
///
/// Displays the selected date and time as a read-only [SBBDecoratedText] field.
/// When tapped, it opens an [SBBDateTimePicker] in a modal bottom sheet via
/// [SBBDateTimePicker.showBottomSheet], allowing the user to pick a date and time.
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
/// SBBDateTimeInput(
///   value: _selectedDateTime,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure'),
///   sheetTitleText: 'Select departure',
///   onDateTimeChanged: (dt) => setState(() => _selectedDateTime = dt),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBDecoratedTextConfig], the configuration object for the trigger field.
/// * [SBBDateTimePicker], the picker opened when the trigger is tapped.
/// * [SBBDateTimePicker.showBottomSheet], which is used to display the bottom sheet.
/// * [SBBBottomSheetConfig], the configuration object for the bottom sheet.
/// * [SBBDateInput], variant for date values.
/// * [SBBTimeInput], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateTimeInput extends StatefulWidget {
  const SBBDateTimeInput({
    super.key,
    required this.onDateTimeChanged,
    this.value,
    this.minimumDateTime,
    this.maximumDateTime,
    this.minuteInterval = _defaultMinuteInterval,
    this.dateFormat,
    this.visibleItemCount = _defaultVisibleItemCount,
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerConfig = const SBBDecoratedTextConfig(),
    this.sheetConfig,
    this.sheetTitleText,
    this.sheetButtonLabelText,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       ),
       assert(
         sheetConfig == null || sheetTitleText == null,
         'sheetTitleText cannot be set while sheetConfig is set!',
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
      maxLines: widget.triggerConfig.maxLines,
      minLines: widget.triggerConfig.minLines,
      expands: widget.triggerConfig.expands,
      focusNode: widget.triggerConfig.focusNode,
      autofocus: widget.triggerConfig.autofocus,
      onTap: widget.onDateTimeChanged != null
          ? () {
              SBBDateTimePicker.showBottomSheet(
                context: context,
                sheetConfig: widget.sheetConfig,
                sheetTitleText: widget.sheetTitleText,
                sheetButtonLabelText: widget.sheetButtonLabelText,
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
