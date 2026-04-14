import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../sbb_design_system_mobile.dart';
import '../sbb_picker_constants.dart';
import '../sbb_picker_utils.dart';

/// This is basically a convenience combination of a [SBBDecoratedText] and a [SBBDateTimePicker].
///
/// Displays the selected time as a read-only [SBBDecoratedText] field. When tapped, it opens an [SBBDateTimePicker]
/// in a [SBBBottomSheet] via [SBBDateTimePicker.showInsideBottomSheet], allowing the user to pick a time.
///
/// Use [triggerDecoration] to customise the trigger's label, icons, error text, and other decoration properties.
///
/// Use [triggerConfig] to configure the trigger field's layout and focus behaviour (max/min lines, expands,
/// focus node, autofocus). When omitted, the defaults from [SBBDecoratedTextConfig] are used.
///
/// Use [sheetConfig] to customise the bottom sheet's appearance and behavior. Use [sheetTitleText] as a flat
/// convenience parameter to set only the sheet title. Cannot be used together with [sheetConfig].
/// When neither is set, the sheet title falls back to the localised time picker label from
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
/// * [SBBDateTimePicker.showInsideBottomSheet], which is used to display the bottom sheet.
/// * [SBBBottomSheetConfig], the configuration object for the bottom sheet.
/// * [SBBDateInput], variant for date values.
/// * [SBBTimeInput], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateTimeInput extends StatelessWidget {
  const SBBDateTimeInput({
    super.key,
    required this.onDateTimeChanged,
    this.value,
    this.minimumDateTime,
    this.maximumDateTime,
    this.minuteInterval = pickerDefaultMinuteInterval,
    this.dateFormat,
    this.visibleItemCount = pickerDefaultVisibleItemCount,
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

  /// Called when the user selects a date and time in the picker.
  ///
  /// When null, the trigger field is disabled and taps are ignored.
  final ValueChanged<DateTime>? onDateTimeChanged;

  /// The currently selected date and time. Displayed in the trigger field formatted by
  /// [dateFormat]. When null, the trigger shows an empty value.
  final DateTime? value;

  /// The earliest selectable date and time in the picker.
  final DateTime? minimumDateTime;

  /// The latest selectable date and time in the picker.
  final DateTime? maximumDateTime;

  /// The interval between minutes shown in the picker.
  ///
  /// Must be a divisor of 60.
  final int minuteInterval;

  /// The format used to display [value] in the trigger field.
  ///
  /// Defaults to [DateFormat.yMMMMd] combined with [DateFormat.Hm] for the
  /// current locale.
  final DateFormat? dateFormat;

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
  final SBBDecoratedTextConfig triggerConfig;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
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
  /// title falls back to [MaterialLocalizations.dateInputLabel].
  ///
  /// Cannot be used together with [sheetConfig].
  final String? sheetTitleText;

  /// The label text for the confirm button in the bottom sheet.
  ///
  /// When not provided, falls back to [MaterialLocalizations.datePickerHelpText].
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
      onTap: onDateTimeChanged != null
          ? () {
              SBBDateTimePicker.showInsideBottomSheet(
                context: context,
                sheetConfig: sheetConfig,
                sheetTitleText: sheetTitleText,
                sheetButtonLabelText: sheetButtonLabelText,
                initialDateTime: value,
                minimumDateTime: minimumDateTime,
                maximumDateTime: maximumDateTime,
                minuteInterval: minuteInterval,
                visibleItemCount: visibleItemCount,
                pickerStyle: pickerStyle,
                onDateTimeChanged: onDateTimeChanged,
              );
            }
          : null,
    );
  }

  String _formattedValue(BuildContext context) {
    if (value == null) return '';
    final DateFormat effectiveDateFormat =
        dateFormat ?? DateFormat.yMMMMd(Localizations.maybeLocaleOf(context).toString()).add_Hm();

    final rawDateTime = PickerUtils.clampedAndTimeIntervaledDateTime(
      value!,
      minimumDateTime,
      maximumDateTime,
      minuteInterval,
    );
    return effectiveDateFormat.format(rawDateTime);
  }
}
