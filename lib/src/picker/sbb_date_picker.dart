part of 'sbb_picker.dart';

class SBBDatePicker extends StatefulWidget {
  SBBDatePicker({
    super.key,
    required this.onDateChanged,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    this.isLastElement = true,
  })  : initialDate = _initialDate(initialDate),
        minimumDate = _minimumDate(minimumDate, initialDate),
        maximumDate = _maximumDate(maximumDate, initialDate) {
    assert(
      this.minimumDate == null || !this.initialDate.isBefore(this.minimumDate!),
      'initial date (${this.initialDate}) is before minimum date (${this.minimumDate})',
    );
    assert(
      this.maximumDate == null || !this.initialDate.isAfter(this.maximumDate!),
      'initial date (${this.initialDate}) is after maximum date (${this.maximumDate})',
    );
  }

  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool isLastElement;

  @override
  State<SBBDatePicker> createState() {
    return _SBBDatePickerState();
  }

  static DateTime _initialDate(
    DateTime? initialDate,
  ) {
    final dateTime = initialDate ?? DateTime.now();

    return _cleanDateTime(dateTime);
  }

  static DateTime? _minimumDate(
    DateTime? minimumDateTime,
    DateTime? initialDateTime,
  ) {
    if (minimumDateTime == null) {
      return null;
    }

    return _cleanDateTime(minimumDateTime);
  }

  static DateTime? _maximumDate(
    DateTime? maximumDateTime,
    DateTime? initialDateTime,
  ) {
    if (maximumDateTime == null) {
      return null;
    }

    return _cleanDateTime(maximumDateTime);
  }

  static DateTime _cleanDateTime(DateTime dateTime) {
    return dateTime.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }
}

class _SBBDatePickerState extends State<SBBDatePicker> {
  late DateTime selectedDate;
  late SBBPickerScrollController dayController;
  late SBBPickerScrollController monthController;
  late SBBPickerScrollController yearController;

  late ValueNotifier<DateTime> monthYearValueNotifier;
  late ValueNotifier<int> yearValueNotifier;

  /// This is used to prevent notifying the callback with the same value
  late DateTime lastReportedDate;

  static const outerPadding = 24.0;
  static const innerPadding = outerPadding * 0.5;

  static const dayItemLeftPadding = outerPadding;
  static const dayItemRightPadding = innerPadding;
  static const dayLabelWidth = 40.0;
  static const dayItemWidth =
      dayItemLeftPadding + dayLabelWidth + dayItemRightPadding;

  static const monthItemLeftPadding = innerPadding;
  static const monthItemRightPadding = innerPadding;

  static const yearItemLeftPadding = innerPadding;
  static const yearItemRightPadding = outerPadding;
  static const yearLabelWidth = 64.0;
  static const yearItemWidth =
      yearItemLeftPadding + yearLabelWidth + yearItemRightPadding;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    lastReportedDate = selectedDate;
    monthYearValueNotifier = ValueNotifier(selectedDate);
    yearValueNotifier = ValueNotifier(selectedDate.year);

    dayController = SBBPickerScrollController(
      initialItem: _dayToIndex(selectedDate.day),
    );
    dayController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    monthController = SBBPickerScrollController(
      initialItem: _monthToIndex(selectedDate.month),
      onTargetItemSelected: (int index) {
        final closestValidDate = _getClosestValidDate(
          yearController.selectedItem,
          index,
          dayController.selectedItem,
        );
        monthYearValueNotifier.value = closestValidDate;
      },
    );
    monthController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    yearController = SBBPickerScrollController(
      initialItem: _yearToIndex(selectedDate.year),
      onTargetItemSelected: (int index) {
        final closestValidDate = _getClosestValidDate(
          index,
          monthController.selectedItem,
          dayController.selectedItem,
        );
        monthYearValueNotifier.value = closestValidDate;
        yearValueNotifier.value = closestValidDate.year;
      },
    );
    yearController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SBBPicker.custom(
      isLastElement: widget.isLastElement,
      child: Row(
        children: [
          Container(
            width: dayItemWidth,
            child: _buildDayPickerScrollView(context),
          ),
          Expanded(
            child: _buildMonthPickerScrollView(context),
          ),
          Container(
            width: yearItemWidth,
            child: _buildYearPickerScrollView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDayPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: monthYearValueNotifier,
      builder: (BuildContext context, DateTime selectedMonthYear, _) {
        return SBBPickerScrollView(
          controller: dayController,
          onSelectedItemChanged: (int index) {
            final selectedDay = _indexToDay(index);
            _onDateSelected(day: selectedDay);
          },
          itemBuilder: (BuildContext context, int index) {
            // check if day is within max month days constraints
            final monthDaysCount = _monthDaysCount(
              selectedMonthYear.year,
              selectedMonthYear.month,
            );
            final itemDay = _indexToDay(index);
            final itemDayIndex = _dayToIndex(itemDay);
            var itemEnabled = itemDayIndex < monthDaysCount;

            // check if date is before minimum date
            final minDate = widget.minimumDate;
            if (itemEnabled && minDate != null) {
              itemEnabled &= !minDate.isAfter(
                selectedMonthYear.copyWith(
                  day: itemDay,
                ),
              );
            }
            // check if date is after maximum date
            final maxDate = widget.maximumDate;
            if (itemEnabled && maxDate != null) {
              itemEnabled &= !maxDate.isBefore(
                selectedMonthYear.copyWith(
                  day: itemDay,
                ),
              );
            }
            final listItemLabel = '$itemDay.';
            return (
              itemEnabled,
              Container(
                padding: EdgeInsets.only(
                  left: dayItemLeftPadding,
                  right: dayItemRightPadding,
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  listItemLabel,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMonthPickerScrollView(BuildContext context) {
    final cupertinoLocalizations = Localizations.of<CupertinoLocalizations>(
      context,
      CupertinoLocalizations,
    )!;
    return ValueListenableBuilder(
      valueListenable: yearValueNotifier,
      builder: (BuildContext context, int selectedYear, _) {
        return SBBPickerScrollView(
          controller: monthController,
          onSelectedItemChanged: (int index) {
            final selectedMonth = _indexToMonth(index);
            _onDateSelected(month: selectedMonth);
          },
          itemBuilder: (BuildContext context, int index) {
            final itemMonth = _indexToMonth(index);
            var itemEnabled = true;

            // check if selected date is before min date
            final minDate = widget.minimumDate;
            if (minDate != null) {
              if (minDate.year == selectedYear) {
                if (minDate.month > itemMonth) {
                  itemEnabled = false;
                }
              } else if (minDate.year > selectedYear) {
                itemEnabled = false;
              }
            }
            // check if selected date is after max date
            final maxDate = widget.maximumDate;
            if (maxDate != null) {
              if (maxDate.year == selectedYear) {
                if (maxDate.month < itemMonth) {
                  itemEnabled = false;
                }
              } else if (maxDate.year < selectedYear) {
                itemEnabled = false;
              }
            }

            final listItemLabel = cupertinoLocalizations.datePickerMonth(
              itemMonth,
            );

            return (
              itemEnabled,
              Container(
                padding: EdgeInsets.only(
                  left: monthItemLeftPadding,
                  right: monthItemRightPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  listItemLabel,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildYearPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: yearController,
      looping: false,
      onSelectedItemChanged: (int index) {
        final selectedYear = _indexToYear(index);
        _onDateSelected(
          year: selectedYear,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final itemYear = _indexToYear(index);
        var itemEnabled = true;

        // check if selected date is before min date
        final minDate = widget.minimumDate;
        if (minDate != null) {
          if (minDate.year > itemYear) {
            itemEnabled = false;
          }
        }
        // check if selected date is after max date
        final maxDate = widget.maximumDate;
        if (maxDate != null) {
          if (maxDate.year < itemYear) {
            itemEnabled = false;
          }
        }

        final listItemLabel = itemYear.toString();
        return (
          itemEnabled,
          Container(
            margin: EdgeInsets.only(
              left: yearItemLeftPadding,
              right: yearItemRightPadding,
            ),
            child: Text(
              listItemLabel,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        );
      },
    );
  }

  void _onDateSelected({
    int? year,
    int? month,
    int? day,
  }) {
    final selectedYear = year ?? selectedDate.year;
    final selectedMonth = month ?? selectedDate.month;
    var selectedDay = day ?? selectedDate.day;

    // correct day value to max month day value if necessary
    final monthDaysCount = _monthDaysCount(
      selectedYear,
      selectedMonth,
    );
    if (selectedDay > monthDaysCount) {
      selectedDay = monthDaysCount;
    }

    selectedDate = DateTime(
      selectedYear,
      selectedMonth,
      selectedDay,
    );
  }

  void _onScrollingStateChanged() {
    if (yearController._scrollingStateNotifier.value ||
        monthController._scrollingStateNotifier.value ||
        dayController._scrollingStateNotifier.value) {
      // do nothing if any controller still scrolling
      return;
    }

    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    // min date
    final correctedToMinDate = _ensureMinDate();
    if (correctedToMinDate) {
      // early return because of correction to min date
      return;
    }

    // max date
    final correctToMaxDate = _ensureMaxDate();
    if (correctToMaxDate) {
      // early return because of correction to max date
      return;
    }

    // valid month day
    final correctedToValidMonthDay = _ensureValidMonthDay();
    if (correctedToValidMonthDay) {
      // early return because of correction to valid month date
      return;
    }

    if (lastReportedDate == selectedDate) {
      // don't notify callback if date did not change
      return;
    }

    // notify callback with new selected date
    lastReportedDate = selectedDate;
    widget.onDateChanged(selectedDate);
  }

  bool _ensureMinDate() {
    // check if selected date is before min date
    final minDate = widget.minimumDate;
    if (minDate == null || minDate.isBefore(selectedDate)) {
      // no correction needed
      return false;
    }

    // get index values of min date values
    final minDateYearIndex = _yearToIndex(minDate.year);
    final minDateMonthIndex = _monthToIndex(minDate.month);
    final minDateDayIndex = _dayToIndex(minDate.day);

    // check if any date values needs to be corrected
    final yearIncorrect = yearController.selectedItem != minDateYearIndex;
    final monthIncorrect = monthController.selectedItem != minDateMonthIndex;
    final dayIncorrect = dayController.selectedItem != minDateDayIndex;

    // correct incorrect date values
    if (yearIncorrect) {
      yearController.animateToItem(minDateYearIndex);
    }
    if (monthIncorrect) {
      monthController.animateToItem(minDateMonthIndex);
    }
    if (dayIncorrect) {
      dayController.animateToItem(minDateDayIndex);
    }

    // return if any values has been corrected
    return yearIncorrect || monthIncorrect || dayIncorrect;
  }

  bool _ensureMaxDate() {
    // check if selected date is after max date
    final maxDate = widget.maximumDate;
    if (maxDate == null || maxDate.isAfter(selectedDate)) {
      // no correction needed
      return false;
    }

    // get index values of max date values
    final maxDateYearIndex = _yearToIndex(maxDate.year);
    final maxDateMonthIndex = _monthToIndex(maxDate.month);
    final maxDateDayIndex = _dayToIndex(maxDate.day);

    // check if any date values needs to be corrected
    final yearIncorrect = yearController.selectedItem != maxDateYearIndex;
    final monthIncorrect = monthController.selectedItem != maxDateMonthIndex;
    final dayIncorrect = dayController.selectedItem != maxDateDayIndex;

    // correct incorrect date values
    if (yearIncorrect) {
      yearController.animateToItem(maxDateYearIndex);
    }
    if (monthIncorrect) {
      monthController.animateToItem(maxDateMonthIndex);
    }
    if (dayIncorrect) {
      dayController.animateToItem(maxDateDayIndex);
    }

    // return if any values has been corrected
    return yearIncorrect || monthIncorrect || dayIncorrect;
  }

  bool _ensureValidMonthDay() {
    // check if selected day value is higher than valid for current month
    final selectedDay = _indexToDay(dayController.selectedItem);
    final monthDayIndex = _dayToIndex(selectedDay);

    // get max day value for currently selected month
    final monthDaysCount = _monthDaysCount(
      selectedDate.year,
      selectedDate.month,
    );

    // check if day value needs to be corrected
    final dayIncorrect = monthDayIndex >= monthDaysCount;
    if (!dayIncorrect) {
      // day value is valid
      return false;
    }

    // calculate difference in days from selected day to max month day to only
    // scroll to nearest correct list item in the looping list view
    final difference = selectedDay - monthDaysCount;
    final correctedDayIndex = dayController.selectedItem - difference;

    // correct incorrect date values
    dayController.animateToItem(correctedDayIndex);
    return true;
  }

  void _ensureOptimizedScrollPosition() {
    final monthItemIndex =
        monthController.selectedItem % DateTime.monthsPerYear;
    final optimizedDayItemIndex = dayController.selectedItem % 31;
    monthController.jumpToItem(monthItemIndex);
    dayController.jumpToItem(optimizedDayItemIndex);
  }

  DateTime _getClosestValidDate(
    int yearIndex,
    int monthIndex,
    int dayIndex,
  ) {
    final day = _indexToDay(dayIndex);
    final month = _indexToMonth(monthIndex);
    final year = _indexToYear(yearIndex);

    var validDay = day;
    final monthDaysCount = _monthDaysCount(
      year,
      month,
    );
    if (day > monthDaysCount) {
      validDay = monthDaysCount;
    }

    var validDate = DateTime(year, month, validDay);
    final minDate = widget.minimumDate;
    if (minDate != null && minDate.isAfter(validDate)) {
      return minDate;
    }

    final maxDate = widget.maximumDate;
    if (maxDate != null && maxDate.isBefore(validDate)) {
      return maxDate;
    }

    return validDate;
  }

  int _indexToDay(int selectedItemIndex) {
    return selectedItemIndex % 31 + 1;
  }

  int _dayToIndex(int selectedValue) {
    return selectedValue - 1;
  }

  int _indexToMonth(int selectedItemIndex) {
    return selectedItemIndex % DateTime.monthsPerYear + 1;
  }

  int _monthToIndex(int selectedValue) {
    return selectedValue - 1;
  }

  int _indexToYear(int selectedItemIndex) {
    return widget.initialDate.year + selectedItemIndex;
  }

  int _yearToIndex(int selectedValue) {
    return selectedValue - widget.initialDate.year;
  }

  int _monthDaysCount(int year, int month) {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }
}
