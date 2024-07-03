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
  @override
  Widget build(BuildContext context) {
    return SBBInputTrigger(
      key: widget.key,
      value: widget.value?.format(context),
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
          onTimeChanged: widget.onTimeChanged,
        );
      },
    );
  }
}
