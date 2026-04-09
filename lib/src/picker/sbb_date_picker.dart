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
  SBBDatePicker({
    super.key,
    required this.onDateChanged,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    this.visibleItemCount = _defaultVisibleItemCount,
    this.pickerStyle,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       ),
       initialDate = _clampedDateOnly(initialDate ?? DateTime.now(), minimumDate, maximumDate),
       minimumDate = _minimumDate(minimumDate),
       maximumDate = _maximumDate(maximumDate) {
    assert(
      this.minimumDate == null || this.maximumDate == null || this.minimumDate!.isBefore(this.maximumDate!),
      'minimum date (${this.minimumDate}) is not before maximum date (${this.maximumDate})',
    );
  }

  /// Called when the selected date changes.
  final ValueChanged<DateTime>? onDateChanged;

  /// The initially selected date of the picker.
  ///
  /// Defaults to `DateTime.now()`. If the initial date is outside the range
  /// defined by [minimumDate] and [maximumDate], it will be automatically
  /// adjusted to the closest valid date within the range.
  final DateTime initialDate;

  /// The minimum selectable date of the picker.
  ///
  /// If provided, dates before this minimum date will be disabled. If not
  /// provided, there will be no restriction on the minimum date that can be
  /// picked.
  ///
  /// Must be before [maximumDate] if both are set.
  final DateTime? minimumDate;

  /// The maximum selectable date of the picker.
  ///
  /// If provided, dates after this maximum date will be disabled. If not
  /// provided, there will be no restriction on the maximum date that can be
  /// picked.
  ///
  /// Must be after [minimumDate] if both are set.
  final DateTime? maximumDate;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
  ///
  /// Defaults to 7.
  final int visibleItemCount;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  /// Shows a [SBBBottomSheet] with an [SBBDatePicker] to select a [DateTime].
  ///
  /// See also:
  ///
  /// * [SBBDatePicker], which will be displayed.
  /// * [showSBBBottomSheet], which is used to display the [SBBBottomSheet] with the picker.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  static void showInsideBottomSheet({
    required BuildContext context,
    SBBBottomSheetConfig? sheetConfig,
    String? sheetTitleText,
    String? sheetButtonLabelText,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    ValueChanged<DateTime>? onDateChanged,
    int visibleItemCount = _defaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
  }) {
    final localizations = MaterialLocalizations.of(context);
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    final effectiveTitleText =
        sheetTitleText ??
        effectiveConfig.titleText ??
        (effectiveConfig.title == null ? localizations.dateInputLabel : null);

    final effectiveInitialDate = _clampedDateOnly(initialDate ?? DateTime.now(), minimumDate, maximumDate);

    final acceptInitialSelection = initialDate == null;
    final selectedButtonEnabled = ValueNotifier(acceptInitialSelection);
    final selectedButtonLabelText = sheetButtonLabelText ?? localizations.datePickerHelpText;

    var selectedDate = effectiveInitialDate;

    showSBBBottomSheet(
      context: context,
      title: effectiveConfig.title,
      titleText: effectiveTitleText,
      leading: effectiveConfig.leading,
      leadingIconData: effectiveConfig.leadingIconData,
      trailing: effectiveConfig.trailing,
      trailingIconData: effectiveConfig.trailingIconData,
      barrierLabel: effectiveConfig.barrierLabel,
      useRootNavigator: effectiveConfig.useRootNavigator,
      isScrollControlled: true,
      isDismissible: effectiveConfig.isDismissible,
      enableDrag: effectiveConfig.enableDrag,
      useSafeArea: effectiveConfig.useSafeArea,
      transitionAnimationController: effectiveConfig.transitionAnimationController,
      sheetAnimationStyle: effectiveConfig.animationStyle,
      showCloseButton: effectiveConfig.showCloseButton,
      body: Column(
        mainAxisSize: .min,
        children: [
           Padding(
             padding: const .symmetric(horizontal: SBBSpacing.medium),
             child: SBBContentBox(
               child: SBBDatePicker(
                 initialDate: effectiveInitialDate,
                 minimumDate: minimumDate,
                 maximumDate: maximumDate,
                 visibleItemCount: visibleItemCount,
                 pickerStyle: pickerStyle,
                 onDateChanged: (date) {
                   selectedDate = date;
                   if (!acceptInitialSelection) {
                     selectedButtonEnabled.value = date != effectiveInitialDate;
                   }
                 },
               ),
             ),
           ),
          Padding(
            padding: const .all(SBBSpacing.medium),
            child: ListenableBuilder(
              listenable: selectedButtonEnabled,
              builder: (context, _) {
                final onPressed = selectedButtonEnabled.value
                    ? () {
                        Navigator.of(context).pop();
                        onDateChanged?.call(selectedDate);
                      }
                    : null;
                return SBBPrimaryButton(labelText: selectedButtonLabelText, onPressed: onPressed);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<SBBDatePicker> createState() => _SBBDatePickerState();

  static DateTime _clampedDateOnly(DateTime value, DateTime? minimumDate, DateTime? maximumDate) =>
      value.clamp(minimumDate, maximumDate).date;

  static DateTime? _minimumDate(DateTime? minimumDate) => minimumDate?.date;

  static DateTime? _maximumDate(DateTime? maximumDate) => maximumDate?.date;
}

class _SBBDatePickerState extends _TimeBasedPickerState<SBBDatePicker> {
  @override
  int get _visibleItemCount => widget.visibleItemCount;

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

  double get _dayItemWidth => _widgetHorizontalPadding + _itemPadding + _dayItemTextWidth + _itemPadding;

  double get _yearItemWidth => _itemPadding + _yearItemTextWidth + _itemPadding + _widgetHorizontalPadding;

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
    _dayController = SBBPickerScrollController(initialItem: _dayToIndex(_selectedDate.day));
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
          visibleItemCount: widget.visibleItemCount,
          pickerStyle: widget.pickerStyle,
          child: Row(
            children: [
              SizedBox(width: _dayItemWidth, child: _buildDayPickerScrollView(context)),
              Expanded(child: _buildMonthPickerScrollView(context)),
              SizedBox(width: _yearItemWidth, child: _buildYearPickerScrollView(context)),
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

   @override
   SBBPickerStyle? _getEffectivePickerStyle(BuildContext context) {
     final themePickerStyle = Theme.of(context).sbbPickerTheme?.pickerStyle;
     return themePickerStyle?.merge(widget.pickerStyle) ?? widget.pickerStyle;
   }

  Widget _buildDayPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _monthYearValueNotifier,
      builder: (context, selectedMonthYear, _) {
        return SBBPickerScrollView(
          controller: _dayController,
          onSelectedItemChanged: _onSelectedDayItemChanged,
          itemBuilder: (_, index) => _buildDayItem(index, selectedMonthYear),
          visibleItemCount: widget.visibleItemCount,
          pickerStyle: widget.pickerStyle,
        );
      },
    );
  }

  Widget _buildMonthPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _yearValueNotifier,
      builder: (context, selectedYear, _) {
        return SBBPickerScrollView(
          controller: _monthController,
          onSelectedItemChanged: _onSelectedMonthItemChanged,
          itemBuilder: (_, index) => _buildMonthItem(index, selectedYear),
          visibleItemCount: widget.visibleItemCount,
          pickerStyle: widget.pickerStyle,
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
      visibleItemCount: widget.visibleItemCount,
      pickerStyle: widget.pickerStyle,
    );
  }

  void _onSelectedDayItemChanged(int index) {
    _onDateSelected(day: _indexToDay(index));
  }

  void _onSelectedMonthItemChanged(int index) {
    _onDateSelected(month: _indexToMonth(index));
  }

  void _onSelectedYearItemChanged(int index) {
    _onDateSelected(year: _indexToYear(index));
  }

  SBBPickerItem _buildDayItem(int index, DateTime selectedMonthYear) {
    final itemDay = _indexToDay(index);
    final daysInMonth = DateUtils.getDaysInMonth(selectedMonthYear.year, selectedMonthYear.month);
    final dayOverflow = itemDay > daysInMonth;

    final itemDate = selectedMonthYear.copyWith(day: itemDay);
    final minDate = widget.minimumDate;
    // set max date to last valid day in month if current day value too high
    final maxDate = dayOverflow ? selectedMonthYear.copyWith(day: daysInMonth) : widget.maximumDate;
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = '$itemDay.';

    return _buildPickerItem(isEnabled: isEnabled, label: label, alignment: .centerRight, isFirstColumn: true);
  }

  SBBPickerItem _buildMonthItem(int index, int selectedYear) {
    final itemMonth = _indexToMonth(index);
    final itemDate = DateTime(selectedYear, itemMonth);
    final minDate = widget.minimumDate?.copyWith(day: 1);
    final maxDate = widget.maximumDate?.copyWith(day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = _dateFormat.format(itemDate);

    return _buildPickerItem(isEnabled: isEnabled, label: label, alignment: .centerLeft);
  }

  SBBPickerItem _buildYearItem(int index) {
    final itemYear = _indexToYear(index);
    final itemDate = DateTime(itemYear);
    final minDate = widget.minimumDate?.copyWith(month: 1, day: 1);
    final maxDate = widget.maximumDate?.copyWith(month: 1, day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = itemYear.toString();

    return _buildPickerItem(isEnabled: isEnabled, label: label, isLastColumn: true);
  }

  void _onDateSelected({int? year, int? month, int? day}) {
    final selectedYear = year ?? _selectedDate.year;
    final selectedMonth = month ?? _selectedDate.month;
    var selectedDay = day ?? _selectedDate.day;

    // correct day value to max month day value if necessary
    final daysInMonth = DateUtils.getDaysInMonth(selectedYear, selectedMonth);
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
    }

    _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);

    _selectedDateValueNotifier.value = _selectedDate.clamp(widget.minimumDate, widget.maximumDate);
  }

  void _onScrollingStateChanged() {
    if (_yearController.isScrolling() || _monthController.isScrolling() || _dayController.isScrolling()) {
      // do nothing if any controller still scrolling
      return;
    }

    // ensure valid date
    _ensureValidDate();
  }

  void _ensureValidDate() {
    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    final validDate = _selectedDate.clamp(widget.minimumDate, widget.maximumDate);

    if (_selectedDate == validDate) {
      // check if selected day value is higher than valid for current month
      final selectedDay = _indexToDay(_dayController.selectedItem);

      // get max day value for currently selected month
      final daysInMonth = DateUtils.getDaysInMonth(validDate.year, validDate.month);

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
      final dayItemFlexibleWidth = _dayItemTextDefaultWidth - _dayItemTextMinWidth;
      final yearItemFlexibleWidth = _yearItemTextDefaultWidth - _yearItemTextMinWidth;
      final flexibleWidths = dayItemFlexibleWidth + yearItemFlexibleWidth;
      final widthReductions = min(flexibleWidths, widthOverflow);
      final widthReductionRatio = widthReductions / flexibleWidths;
      final dayItemReducedWidth = _dayItemTextDefaultWidth - dayItemFlexibleWidth * widthReductionRatio;
      final yearItemReducedWidth = _yearItemTextDefaultWidth - yearItemFlexibleWidth * widthReductionRatio;

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
