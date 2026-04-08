part of 'sbb_picker.dart';

/// A trigger field that combines [SBBDecoratedText] with [SBBTimePicker].
///
/// Displays the selected time as a read-only [SBBDecoratedText] field. When
/// tapped, it opens an [SBBTimePicker] in a modal bottom sheet via
/// [SBBTimePicker.showBottomSheet], allowing the user to pick a time.
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
/// sheet title defaults to the localised time picker label from
/// [MaterialLocalizations.timePickerInputHelpText].
///
/// ## Example
///
/// ```dart
/// SBBTimeInput(
///   value: _selectedTime,
///   triggerDecoration: SBBInputDecoration(labelText: 'Departure time'),
///   sheetTitleText: 'Select departure time',
///   onTimeChanged: (time) => setState(() => _selectedTime = time),
/// )
/// ```
///
/// See also:
///
/// * [SBBDecoratedText], the trigger widget used to display the selected value.
/// * [SBBDecoratedTextConfig], the configuration object for the trigger field.
/// * [SBBTimePicker], the picker opened when the trigger is tapped.
/// * [SBBTimePicker.showBottomSheet], which is used to display the bottom sheet.
/// * [SBBBottomSheetConfig], the configuration object for the bottom sheet.
/// * [SBBDateTimeInput], variant for date and time values.
/// * [SBBDateInput], variant for date values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBTimeInput extends StatefulWidget {
  const SBBTimeInput({
    super.key,
    required this.onTimeChanged,
    this.value,
    this.minimumTime,
    this.maximumTime,
    this.minuteInterval = _defaultMinuteInterval,
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

  /// Called when the user selects a time in the picker.
  ///
  /// When null, the trigger field is disabled and taps are ignored.
  final ValueChanged<TimeOfDay>? onTimeChanged;

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
  /// title defaults to [MaterialLocalizations.timePickerInputHelpText].
  ///
  /// Cannot be used together with [sheetConfig].
  final String? sheetTitleText;

  /// The label text for the confirm button in the bottom sheet.
  ///
  /// When not provided, defaults to [MaterialLocalizations.timePickerDialHelpText].
  final String? sheetButtonLabelText;

  @override
  State<SBBTimeInput> createState() => _SBBTimeInputState();
}

class _SBBTimeInputState extends State<SBBTimeInput> {
  String get _valueText {
    if (widget.value == null) return '';

    final rawTimeOfDay = SBBTimePicker._clampedAndIntervaledTime(
      widget.value!,
      widget.minimumTime,
      widget.maximumTime,
      widget.minuteInterval,
    );
    return rawTimeOfDay.format(context);
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
      onTap: widget.onTimeChanged != null
          ? () {
              SBBTimePicker.showInsideBottomSheet(
                context: context,
                sheetConfig: widget.sheetConfig,
                sheetTitleText: widget.sheetTitleText,
                sheetButtonLabelText: widget.sheetButtonLabelText,
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
