part of 'sbb_picker.dart';

/// SBB Time Input Field. Use according to documentation.
///
/// See also:
///
/// * [SBBDateTimeInput], variant for date time values.
/// * [SBBDateInput], variant for date values.
/// * [SBBTimePicker], picker for time values.
/// * [SBBTimePicker.showModal], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBTimeInput extends StatefulWidget {
  const SBBTimeInput({
    super.key,
    this.value,
    this.minimumTime,
    this.maximumTime,
    this.minuteInterval = _defaultMinuteInterval,
    this.dateFormat,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    required this.onTimeChanged,
    this.maxLines,
    this.enabled = true,
    this.isLastElement = false,
  });

  final TimeOfDay? value;
  final TimeOfDay? minimumTime;
  final TimeOfDay? maximumTime;
  final int minuteInterval;
  final DateFormat? dateFormat;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixPressed;

  final ValueChanged<TimeOfDay>? onTimeChanged;

  final int? maxLines;

  final bool enabled;
  final bool isLastElement;

  @override
  State<SBBTimeInput> createState() => _SBBTimeInputState();
}

class _SBBTimeInputState extends State<SBBTimeInput> {
  String get _valueText {
    var value = widget.value;
    if (value == null) {
      return '';
    }
    value = SBBTimePicker._initialTime(
      widget.value,
      widget.minimumTime,
      widget.maximumTime,
      widget.minuteInterval,
    );
    return value.format(context);
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
      enabled: widget.onTimeChanged != null,
      isLastElement: widget.isLastElement,
      onPressed: () {
        SBBTimePicker.showModal(
          context: context,
          title: widget.labelText,
          initialTime: widget.value,
          minimumTime: widget.minimumTime,
          maximumTime: widget.maximumTime,
          minuteInterval: widget.minuteInterval,
          onTimeChanged: widget.onTimeChanged,
        );
      },
    );
  }
}
