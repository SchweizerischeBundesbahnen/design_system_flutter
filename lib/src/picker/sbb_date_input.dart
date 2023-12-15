part of 'sbb_picker.dart';

class SBBDateInput extends StatefulWidget {
  const SBBDateInput({
    super.key,
    this.value,
    this.labelText,
    this.hintText,
    this.errorText,
    this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.onDateChanged,
    this.maxLines,
    this.enabled = true,
    this.isLastElement = true,
  });

  final String? value;
  final String? labelText;
  final String? hintText;
  final String? errorText;

  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  final ValueChanged<DateTime>? onDateChanged;

  final int? maxLines;

  final bool enabled;
  final bool isLastElement;

  @override
  State<SBBDateInput> createState() => _SBBDateInputState();
}

class _SBBDateInputState extends State<SBBDateInput> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SBBInputTrigger(
      value: widget.value,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      prefixIcon: SBBIcons.calendar_small,
      onPressed: () {
        showSBBModalSheet(
          context: context,
          title: _labelText,
          child: _DateInputModalContent(
            initialDate: selectedDate ?? widget.initialDate,
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            onDateChanged: widget.onDateChanged,
          ),
        );
      },
      enabled: widget.enabled,
      isLastElement: widget.isLastElement,
    );
  }

  String get _labelText => widget.labelText ?? '';
}

class _DateInputModalContent extends StatefulWidget {
  _DateInputModalContent({
    DateTime? initialDate,
    this.minimumDate,
    this.maximumDate,
    this.onDateChanged,
  }) : initialDate = SBBDatePicker._initialDate(initialDate);

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  final ValueChanged<DateTime>? onDateChanged;

  @override
  State<_DateInputModalContent> createState() => _DateInputModalContentState();
}

class _DateInputModalContentState extends State<_DateInputModalContent> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: SBBDatePicker(
            initialDate: widget.initialDate,
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            onDateChanged: (DateTime date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBPrimaryButton(
            label: MaterialLocalizations.of(context).okButtonLabel,
            onPressed: selectedDate != widget.initialDate
                ? () {
                    Navigator.of(context).pop();
                    widget.onDateChanged?.call(selectedDate);
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
