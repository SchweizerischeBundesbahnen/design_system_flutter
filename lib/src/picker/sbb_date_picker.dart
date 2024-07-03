part of 'sbb_picker.dart';

/// SBB Date Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBPicker], variant for custom values.
/// * [SBBDateTimePicker], variant for date time values.
/// * [SBBTimePicker], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDatePicker extends StatefulWidget {
  /// Constructs an [SBBDatePicker].
  ///
  /// [onDateChanged] is the callback called when the selected date changes.
  ///
  /// [initialDate] is the initially selected date of the picker. Defaults to
  /// the present date. If the initial date is outside the range defined by
  /// [minimumDate] and [maximumDate], it will be automatically adjusted to the
  /// closest valid date within the range.
  ///
  /// [minimumDate] is the minimum selectable date of the picker. If provided,
  /// dates before this minimum date will be disabled. If not provided, there
  /// will be no restriction on the minimum date that can be picked.
  ///
  /// [maximumDate] is the maximum selectable date of the picker. If provided,
  /// dates after this maximum date will be disabled. If not provided, there
  /// will be no restriction on the maximum date that can be picked.
  ///
  /// [minimumDate] must be before [maximumDate] if both are set.
  SBBDatePicker({
    super.key,
    required this.onDateChanged,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  })  : initialDate = _initialDate(initialDate, minimumDate, maximumDate),
        minimumDate = _minimumDate(minimumDate),
        maximumDate = _maximumDate(maximumDate) {
    assert(
      this.minimumDate == null ||
          this.maximumDate == null ||
          this.minimumDate!.isBefore(this.maximumDate!),
      'minimum date (${this.minimumDate}) is not before maximum date (${this.maximumDate})',
    );
  }

  final ValueChanged<DateTime>? onDateChanged;
  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  /// Shows an [SBBModalSheet] with an [SBBDatePicker] to select a [DateTime].
  /// Use according to documentation.
  ///
  /// See also:
  ///
  /// * [SBBDatePicker], which will be displayed.
  /// * [showSBBModalSheet], which is used to display the modal.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
  static void showModal({
    required BuildContext context,
    String? title,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    ValueChanged<DateTime>? onDateChanged,
  }) {
    final localizations = MaterialLocalizations.of(context);
    title ??= localizations.dateInputLabel;
    final selectedButtonLabel = localizations.datePickerHelpText;
    DateTime selectedDate = initialDate ?? DateTime.now();

    showSBBModalSheet(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: sbbDefaultSpacing,
            ),
            child: SBBGroup(
              child: SBBDatePicker(
                initialDate: initialDate,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                onDateChanged: (DateTime date) {
                  selectedDate = date;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: SBBPrimaryButton(
                label: selectedButtonLabel,
                onPressed: () {
                  Navigator.of(context).pop();
                  onDateChanged?.call(selectedDate);
                }),
          ),
        ],
      ),
    );
  }

  @override
  State<SBBDatePicker> createState() {
    return _SBBDatePickerState();
  }

  static DateTime _initialDate(
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  ) {
    var date = initialDate ?? DateTime.now();
    date = date.clamp(minimumDate, maximumDate);
    return date.date;
  }

  static DateTime? _minimumDate(DateTime? minimumDate) {
    return minimumDate?.date;
  }

  static DateTime? _maximumDate(DateTime? maximumDate) {
    return maximumDate?.date;
  }
}

class _SBBDatePickerState extends _TimeBasedPickerState<SBBDatePicker> {
  static const _dayItemTextDefaultWidth = 40.0;
  static const _yearItemTextDefaultWidth = 64.0;

  static const _dayItemCount = 31;
  static const _horizontalPaddingCount = 6;

  late DateTime _selectedDate;
  late ValueNotifier<DateTime> _selectedDateValueNotifier;

  late ValueNotifier<DateTime> _monthYearValueNotifier;
  late ValueNotifier<int> _yearValueNotifier;

  late SBBPickerScrollController _dayController;
  late SBBPickerScrollController _monthController;
  late SBBPickerScrollController _yearController;

  late DateFormat _dateFormat;
  late double _dayItemTextWidth;
  late double _yearItemTextWidth;

  double get _dayItemWidth =>
      _widgetHorizontalPadding +
      _itemPadding +
      _dayItemTextWidth +
      _itemPadding;

  double get _yearItemWidth =>
      _itemPadding +
      _yearItemTextWidth +
      _itemPadding +
      _widgetHorizontalPadding;

  double get _dayItemTextMinWidth => _textSize('33.').width;

  double get _yearItemTextMinWidth => _textSize('9999').width;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedDateValueNotifier = ValueNotifier(_selectedDate);
    final onDateChanged = widget.onDateChanged;
    if (onDateChanged != null) {
      _selectedDateValueNotifier.addListener(() {
        onDateChanged(_selectedDateValueNotifier.value);
      });
    }
    _monthYearValueNotifier = ValueNotifier(_selectedDate);
    _yearValueNotifier = ValueNotifier(_selectedDate.year);

    _initDayController();
    _initMonthController();
    _initYearController();
  }

  void _initDayController() {
    _dayController = SBBPickerScrollController(
      initialItem: _dayToIndex(_selectedDate.day),
    );
    _dayController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initMonthController() {
    _monthController = SBBPickerScrollController(
      initialItem: _monthToIndex(_selectedDate.month),
      onTargetItemSelected: (int index) {
        final closestValidDate = _closestValidDate(monthIndex: index);
        _monthYearValueNotifier.value = closestValidDate;
      },
    );
    _monthController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initYearController() {
    _yearController = SBBPickerScrollController(
      initialItem: _yearToIndex(_selectedDate.year),
      onTargetItemSelected: (int index) {
        final closestValidDate = _closestValidDate(yearIndex: index);
        _monthYearValueNotifier.value = closestValidDate;
        _yearValueNotifier.value = closestValidDate.year;
      },
    );
    _yearController.addScrollingStateListener(_onScrollingStateChanged);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        _adjustItemSizes(constraints.maxWidth);

        return SBBPicker.custom(
          child: Row(
            children: [
              SizedBox(
                width: _dayItemWidth,
                child: _buildDayPickerScrollView(context),
              ),
              Expanded(
                child: _buildMonthPickerScrollView(context),
              ),
              SizedBox(
                width: _yearItemWidth,
                child: _buildYearPickerScrollView(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _monthYearValueNotifier.dispose();
    _yearValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildDayPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _monthYearValueNotifier,
      builder: (BuildContext context, DateTime selectedMonthYear, _) {
        return SBBPickerScrollView(
          controller: _dayController,
          onSelectedItemChanged: _onSelectedDayItemChanged,
          itemBuilder: (_, index) => _buildDayItem(index, selectedMonthYear),
        );
      },
    );
  }

  Widget _buildMonthPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _yearValueNotifier,
      builder: (BuildContext context, int selectedYear, _) {
        return SBBPickerScrollView(
          controller: _monthController,
          onSelectedItemChanged: _onSelectedMonthItemChanged,
          itemBuilder: (_, index) => _buildMonthItem(index, selectedYear),
        );
      },
    );
  }

  Widget _buildYearPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: _yearController,
      looping: false,
      onSelectedItemChanged: _onSelectedYearItemChanged,
      itemBuilder: (_, index) => _buildYearItem(index),
    );
  }

  void _onSelectedDayItemChanged(int index) {
    _onDateSelected(
      day: _indexToDay(index),
    );
  }

  void _onSelectedMonthItemChanged(int index) {
    _onDateSelected(
      month: _indexToMonth(index),
    );
  }

  void _onSelectedYearItemChanged(int index) {
    _onDateSelected(
      year: _indexToYear(index),
    );
  }

  SBBPickerItem _buildDayItem(int index, DateTime selectedMonthYear) {
    final itemDay = _indexToDay(index);
    final daysInMonth = DateUtils.getDaysInMonth(
      selectedMonthYear.year,
      selectedMonthYear.month,
    );
    final dayOverflow = itemDay > daysInMonth;

    final itemDate = selectedMonthYear.copyWith(day: itemDay);
    final minDate = widget.minimumDate;
    // set max date to last valid day in month if current day value too high
    final maxDate = dayOverflow
        ? selectedMonthYear.copyWith(day: daysInMonth)
        : widget.maximumDate;
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = '$itemDay.';

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      alignment: Alignment.centerRight,
      isFirstColumn: true,
    );
  }

  SBBPickerItem _buildMonthItem(int index, int selectedYear) {
    final itemMonth = _indexToMonth(index);
    final itemDate = DateTime(selectedYear, itemMonth);
    final minDate = widget.minimumDate?.copyWith(day: 1);
    final maxDate = widget.maximumDate?.copyWith(day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = _dateFormat.format(itemDate);

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      alignment: Alignment.centerLeft,
    );
  }

  SBBPickerItem _buildYearItem(int index) {
    final itemYear = _indexToYear(index);
    final itemDate = DateTime(itemYear);
    final minDate = widget.minimumDate?.copyWith(month: 1, day: 1);
    final maxDate = widget.maximumDate?.copyWith(month: 1, day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = itemYear.toString();

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      isLastColumn: true,
    );
  }

  void _onDateSelected({
    int? year,
    int? month,
    int? day,
  }) {
    final selectedYear = year ?? _selectedDate.year;
    final selectedMonth = month ?? _selectedDate.month;
    var selectedDay = day ?? _selectedDate.day;

    // correct day value to max month day value if necessary
    final daysInMonth = DateUtils.getDaysInMonth(
      selectedYear,
      selectedMonth,
    );
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
    }

    _selectedDate = DateTime(
      selectedYear,
      selectedMonth,
      selectedDay,
    );

    _selectedDateValueNotifier.value = _selectedDate.clamp(
      widget.minimumDate,
      widget.maximumDate,
    );
  }

  void _onScrollingStateChanged() {
    if (_yearController.isScrolling() ||
        _monthController.isScrolling() ||
        _dayController.isScrolling()) {
      // do nothing if any controller still scrolling
      return;
    }

    // ensure valid date
    _ensureValidDate();
  }

  void _ensureValidDate() {
    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    final validDate = _selectedDate.clamp(
      widget.minimumDate,
      widget.maximumDate,
    );

    if (_selectedDate == validDate) {
      // check if selected day value is higher than valid for current month
      final selectedDay = _indexToDay(_dayController.selectedItem);

      // get max day value for currently selected month
      final daysInMonth = DateUtils.getDaysInMonth(
        validDate.year,
        validDate.month,
      );

      // check if day value needs to be corrected
      final dayOverflow = selectedDay > daysInMonth;
      if (dayOverflow) {
        final correctedDayIndex = _dayToIndex(daysInMonth);

        // correct incorrect date value
        _dayController.animateToItem(correctedDayIndex);
        return;
      }

      // no correction needed
      return;
    }

    // get index values of valid date values
    final dayIndex = _dayToIndex(validDate.day);
    final monthIndex = _monthToIndex(validDate.month);
    final yearIndex = _yearToIndex(validDate.year);

    // check if any date values needs to be corrected
    final dayIncorrect = _dayController.selectedItem != dayIndex;
    final monthIncorrect = _monthController.selectedItem != monthIndex;
    final yearIncorrect = _yearController.selectedItem != yearIndex;

    // correct incorrect date values
    if (dayIncorrect) {
      _dayController.animateToItem(dayIndex);
    }
    if (monthIncorrect) {
      _monthController.animateToItem(monthIndex);
    }
    if (yearIncorrect) {
      _yearController.animateToItem(yearIndex);
    }
  }

  void _ensureOptimizedScrollPosition() {
    final monthIndex = _monthController.selectedItem % DateTime.monthsPerYear;
    final dayIndex = _dayController.selectedItem % _dayItemCount;
    _monthController.jumpToItem(monthIndex);
    _dayController.jumpToItem(dayIndex);
  }

  DateTime _closestValidDate({int? yearIndex, int? monthIndex}) {
    final year = _indexToYear(yearIndex ?? _yearController.selectedItem);
    final month = _indexToMonth(monthIndex ?? _monthController.selectedItem);
    var day = _indexToDay(_dayController.selectedItem);

    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    if (day > daysInMonth) {
      day = daysInMonth;
    }

    var date = DateTime(year, month, day);
    date = date.clamp(widget.minimumDate, widget.maximumDate);
    return date;
  }

  void _adjustItemSizes(double width) {
    // reset sizes to default
    _itemPadding = _itemDefaultPadding;
    _dayItemTextWidth = max(_dayItemTextDefaultWidth, _dayItemTextMinWidth);
    _yearItemTextWidth = max(_yearItemTextDefaultWidth, _yearItemTextMinWidth);

    // validate locale
    final localeObject = Localizations.maybeLocaleOf(context);
    final localeExists = DateFormat.localeExists(localeObject.toString());
    final locale = localeExists ? localeObject.toString() : null;

    // use localized long month format by default
    _dateFormat = DateFormat.MMMM(locale);

    // check if enough space to display all texts by calculating width overflow
    final availableMonthItemTextWidth = _availableMonthItemTextWidth(width);
    final longMonthTextMinWidth = _monthItemTextMinWidth(_dateFormat);
    var widthOverflow = longMonthTextMinWidth - availableMonthItemTextWidth;

    // check if medium month format needs to be used
    if (widthOverflow > 0) {
      // use localized medium month format
      _dateFormat = DateFormat.MMM(locale);

      // recalculate width overflow
      final shortMonthTextMinWidth = _monthItemTextMinWidth(_dateFormat);
      final widthReduction = longMonthTextMinWidth - shortMonthTextMinWidth;
      widthOverflow -= widthReduction;
    }

    // check if items text width needs to be reduced
    if (widthOverflow > 0) {
      // calculate items text widths based on width overflow
      final dayItemFlexibleWidth =
          _dayItemTextDefaultWidth - _dayItemTextMinWidth;
      final yearItemFlexibleWidth =
          _yearItemTextDefaultWidth - _yearItemTextMinWidth;
      final flexibleWidths = dayItemFlexibleWidth + yearItemFlexibleWidth;
      final widthReductions = min(flexibleWidths, widthOverflow);
      final widthReductionRatio = widthReductions / flexibleWidths;
      final dayItemReducedWidth =
          _dayItemTextDefaultWidth - dayItemFlexibleWidth * widthReductionRatio;
      final yearItemReducedWidth = _yearItemTextDefaultWidth -
          yearItemFlexibleWidth * widthReductionRatio;

      // set reduced item text widths
      _dayItemTextWidth = dayItemReducedWidth;
      _yearItemTextWidth = yearItemReducedWidth;

      // recalculate width overflow
      widthOverflow -= widthReductions;
    }

    // check if item paddings need to be reduced
    if (widthOverflow > 0) {
      // calculate item paddings based on width overflow
      const minPaddings = _itemMinPadding * _horizontalPaddingCount;
      const defaultPaddings = _itemDefaultPadding * _horizontalPaddingCount;
      const flexiblePaddings = defaultPaddings - minPaddings;
      final paddingReductions = min(flexiblePaddings, widthOverflow);
      final reducedPaddings = defaultPaddings - paddingReductions;
      final reducedPadding = reducedPaddings / _horizontalPaddingCount;

      // set reduced paddings
      _itemPadding = reducedPadding;

      // recalculate width overflow
      widthOverflow -= paddingReductions;
    }
  }

  double _availableMonthItemTextWidth(double widgetWidth) {
    return widgetWidth -
        _widgetHorizontalPadding * 2 -
        _itemPadding * _horizontalPaddingCount -
        _dayItemTextWidth -
        _yearItemTextWidth;
  }

  double _monthItemTextMinWidth(DateFormat dateFormat) {
    final year = widget.initialDate.year;
    var dateTextWidth = 0.0;
    for (var i = 0; i < DateTime.monthsPerYear; i++) {
      final month = i + 1;
      final date = DateTime(year, month);
      final itemLabel = dateFormat.format(date);
      final itemTextSize = _textSize(itemLabel);
      final itemTextWidth = itemTextSize.width;
      if (itemTextWidth > dateTextWidth) {
        dateTextWidth = itemTextWidth;
      }
    }
    return dateTextWidth;
  }

  int _indexToDay(int dayIndex) {
    return dayIndex % _dayItemCount + 1;
  }

  int _dayToIndex(int day) {
    return day - 1;
  }

  int _indexToMonth(int monthIndex) {
    return monthIndex % DateTime.monthsPerYear + 1;
  }

  int _monthToIndex(int month) {
    return month - 1;
  }

  int _indexToYear(int yearIndex) {
    return widget.initialDate.year + yearIndex;
  }

  int _yearToIndex(int year) {
    return year - widget.initialDate.year;
  }
}
