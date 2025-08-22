part of 'sbb_picker.dart';

/// SBB Date Input Field. Use according to documentation.
///
/// See also:
///
/// * [SBBDateTimeInput], variant for date time values.
/// * [SBBTimeInput], variant for time values.
/// * [SBBDatePicker], picker for date values.
/// * [SBBDatePicker.showModal], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateInput extends StatefulWidget {
  const SBBDateInput({
    super.key,
    this.value,
    this.minimumDate,
    this.maximumDate,
    this.dateFormat,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    required this.onDateChanged,
    this.maxLines = 1,
    this.isLastElement = false,
  });

  final DateTime? value;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateFormat? dateFormat;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final ValueChanged<DateTime>? onDateChanged;
  final int? maxLines;
  final bool isLastElement;

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
      enabled: widget.onDateChanged != null,
      isLastElement: widget.isLastElement,
      onPressed: () {
        SBBDatePicker.showModal(
          context: context,
          title: widget.labelText,
          initialDate: widget.value,
          minimumDate: widget.minimumDate,
          maximumDate: widget.maximumDate,
          onDateChanged: widget.onDateChanged,
        );
      },
    );
  }
}
