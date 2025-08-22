part of 'sbb_picker.dart';

/// SBB Date Time Input Field. Use according to documentation.
///
/// See also:
///
/// * [SBBDateInput], variant for date values.
/// * [SBBTimeInput], variant for time values.
/// * [SBBDateTimePicker], picker for date time values.
/// * [SBBDateTimePicker.showModal], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateTimeInput extends StatefulWidget {
  const SBBDateTimeInput({
    super.key,
    this.value,
    this.minimumDateTime,
    this.maximumDateTime,
    this.minuteInterval = _defaultMinuteInterval,
    this.dateFormat,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    required this.onDateTimeChanged,
    this.maxLines = 1,
    this.isLastElement = false,
  });

  final DateTime? value;
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final int minuteInterval;
  final DateFormat? dateFormat;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final ValueChanged<DateTime>? onDateTimeChanged;
  final int? maxLines;
  final bool isLastElement;

  @override
  State<SBBDateTimeInput> createState() => _SBBDateTimeInputState();
}

class _SBBDateTimeInputState extends State<SBBDateTimeInput> {
  late final DateFormat _dateFormat =
      widget.dateFormat ??
      DateFormat.yMMMMd(Localizations.maybeLocaleOf(context).toString()).add_Hm();

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
    return SBBInputTrigger(
      key: widget.key,
      value: _valueText,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      onSuffixPressed: widget.onSuffixPressed,
      maxLines: widget.maxLines,
      enabled: widget.onDateTimeChanged != null,
      isLastElement: widget.isLastElement,
      onPressed: () {
        SBBDateTimePicker.showModal(
          context: context,
          title: widget.labelText,
          initialDateTime: widget.value,
          minimumDateTime: widget.minimumDateTime,
          maximumDateTime: widget.maximumDateTime,
          minuteInterval: widget.minuteInterval,
          onDateTimeChanged: widget.onDateTimeChanged,
        );
      },
    );
  }
}
