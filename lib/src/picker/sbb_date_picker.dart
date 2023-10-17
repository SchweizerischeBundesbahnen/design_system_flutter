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
  late DateTime selectedDateTime;
  late SBBPickerScrollController dayController;
  late SBBPickerScrollController monthController;
  late SBBPickerScrollController yearController;

  /// This is used to prevent notifying the callback with the same value
  late DateTime lastReportedDateTime;

  /// This is used as a workaround to prevent unintentional changes in the day
  /// value, which may occur when scrolling between months. For instance, when
  /// scrolling from 31.05.2023 to 31.07.2023 via month scrolling, the month
  /// scrollview will scroll over June where there is no 31st day of. Therefore,
  /// the day value will automatically be corrected downwards to 30, resulting
  /// in 30.07.2023 instead of the intended 31.07.2023.
  int? targetSelectedDay;

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
    selectedDateTime = widget.initialDate;
    lastReportedDateTime = selectedDateTime;

    dayController = SBBPickerScrollController(
      initialItem: _dayToIndex(selectedDateTime.day),
    );
    dayController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    monthController = SBBPickerScrollController(
      initialItem: _monthToIndex(selectedDateTime.month),
    );
    monthController._scrollingStateNotifier.addListener(() {
      if (targetSelectedDay == null) {
        targetSelectedDay = _indexToDay(dayController.selectedItem);
      }
      _onScrollingStateChanged();
    });

    yearController = SBBPickerScrollController(
      initialItem: _yearToIndex(selectedDateTime.year),
    );
    yearController._scrollingStateNotifier.addListener(() {
      if (targetSelectedDay == null) {
        targetSelectedDay = _indexToDay(dayController.selectedItem);
      }
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
    return SBBPickerScrollView(
      controller: dayController,
      onSelectedItemChanged: (int index) {
        final selectedDay = _indexToDay(index);
        _onDateTimeSelected(
          day: selectedDay,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        // check if day is within max month days constraints
        final monthDaysCount = _monthDaysCount(
          selectedDateTime.year,
          selectedDateTime.month,
        );
        final selectedDay = _indexToDay(index);
        final selectedDayIndex = _dayToIndex(selectedDay);
        var dayEnabled = selectedDayIndex < monthDaysCount;

        // check if date is before minimum date
        final minimumDateTime = widget.minimumDate;
        if (dayEnabled && minimumDateTime != null) {
          dayEnabled &= !minimumDateTime.isAfter(
            selectedDateTime.copyWith(
              day: selectedDay,
            ),
          );
        }
        // check if date is after maximum date
        final maximumDateTime = widget.maximumDate;
        if (dayEnabled && maximumDateTime != null) {
          dayEnabled &= !maximumDateTime.isBefore(
            selectedDateTime.copyWith(
              day: selectedDay,
            ),
          );
        }
        final listItemLabel = '$selectedDay.';
        return (
          dayEnabled,
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
  }

  Widget _buildMonthPickerScrollView(BuildContext context) {
    final cupertinoLocalizations = Localizations.of<CupertinoLocalizations>(
      context,
      CupertinoLocalizations,
    )!;
    return SBBPickerScrollView(
      controller: monthController,
      onSelectedItemChanged: (int index) {
        final selectedMonth = _indexToMonth(index);
        _onDateTimeSelected(
          month: selectedMonth,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedMonth = _indexToMonth(index);
        final selectedYear = _indexToYear(yearController.selectedItem);

        var monthEnabled = true;
        // check if selected date is before min date
        final minimumDateTime = widget.minimumDate;
        if (minimumDateTime != null) {
          if (minimumDateTime.year == selectedYear) {
            if (minimumDateTime.month > selectedMonth) {
              monthEnabled = false;
            }
          } else if (minimumDateTime.year > selectedYear) {
            monthEnabled = false;
          }
        }
        // check if selected date is after max date
        final maximumDateTime = widget.maximumDate;
        if (maximumDateTime != null) {
          if (maximumDateTime.year == selectedYear) {
            if (maximumDateTime.month < selectedMonth) {
              monthEnabled = false;
            }
          } else if (maximumDateTime.year < selectedYear) {
            monthEnabled = false;
          }
        }

        final listItemLabel = cupertinoLocalizations.datePickerMonth(
          selectedMonth,
        );

        return (
          monthEnabled,
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
  }

  Widget _buildYearPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: yearController,
      looping: false,
      onSelectedItemChanged: (int index) {
        final selectedYear = _indexToYear(index);
        _onDateTimeSelected(
          year: selectedYear,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedYear = _indexToYear(index);

        var yearEnabled = true;
        // check if selected date is before min date
        final minimumDateTime = widget.minimumDate;
        if (minimumDateTime != null) {
          if (minimumDateTime.year > selectedYear) {
            yearEnabled = false;
          }
        }
        // check if selected date is after max date
        final maximumDateTime = widget.maximumDate;
        if (maximumDateTime != null) {
          if (maximumDateTime.year < selectedYear) {
            yearEnabled = false;
          }
        }

        final listItemLabel = selectedYear.toString();
        return (
          yearEnabled,
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

  void _onDateTimeSelected({
    int? year,
    int? month,
    int? day,
  }) {
    final selectedYear = year ?? selectedDateTime.year;
    final selectedMonth = month ?? selectedDateTime.month;
    var selectedDay = day ?? selectedDateTime.day;

    // correct day value to max month day value if necessary
    final monthDaysCount = _monthDaysCount(
      selectedYear,
      selectedMonth,
    );
    if (selectedDay > monthDaysCount) {
      selectedDay = monthDaysCount;
    }

    selectedDateTime = DateTime(
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

    // check if selected day value needs to be changed to target day value
    _ensureTargetDay();

    // optimize list item positions
    _ensureOptimizedIndexPosition();

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

    if (lastReportedDateTime == selectedDateTime) {
      // don't notify callback if date did not change
      return;
    }

    // notify callback with new selected date
    lastReportedDateTime = selectedDateTime;
    widget.onDateChanged(selectedDateTime);
  }

  void _ensureTargetDay() {
    if (targetSelectedDay == null) {
      return;
    }

    var selectedDay = selectedDateTime.day;
    if (selectedDay != targetSelectedDay) {
      final monthDaysCount = _monthDaysCount(
        selectedDateTime.year,
        selectedDateTime.month,
      );
      if (targetSelectedDay! > monthDaysCount) {
        // set selected day value to max day value of current month since
        // target day value is too high
        selectedDay = monthDaysCount;
      } else {
        // set selected day value to target day value
        selectedDay = targetSelectedDay!;
      }
    }

    // correct selected date time value
    selectedDateTime = selectedDateTime.copyWith(day: selectedDay);
    targetSelectedDay = null;
  }

  bool _ensureMinDate() {
    // check if selected date is before min date
    final minimumDateTime = widget.minimumDate;
    if (minimumDateTime == null || minimumDateTime.isBefore(selectedDateTime)) {
      // no correction needed
      return false;
    }

    // get index values of min date values
    final minDateYearIndex = _yearToIndex(minimumDateTime.year);
    final minDateMonthIndex = _monthToIndex(minimumDateTime.month);
    final minDateDayIndex = _dayToIndex(minimumDateTime.day);

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
      targetSelectedDay = _indexToDay(minDateDayIndex);
      dayController.animateToItem(minDateDayIndex);
    }

    // return if any values has been corrected
    return yearIncorrect || monthIncorrect || dayIncorrect;
  }

  bool _ensureMaxDate() {
    // check if selected date is after max date
    final maximumDateTime = widget.maximumDate;
    if (maximumDateTime == null || maximumDateTime.isAfter(selectedDateTime)) {
      // no correction needed
      return false;
    }

    // get index values of max date values
    final maxDateYearIndex = _yearToIndex(maximumDateTime.year);
    final maxDateMonthIndex = _monthToIndex(maximumDateTime.month);
    final maxDateDayIndex = _dayToIndex(maximumDateTime.day);

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
      targetSelectedDay = _indexToDay(maxDateDayIndex);
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
      selectedDateTime.year,
      selectedDateTime.month,
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
    targetSelectedDay = _indexToDay(correctedDayIndex);
    dayController.animateToItem(correctedDayIndex);
    return true;
  }

  void _ensureOptimizedIndexPosition() {
    final monthItemIndex = _monthToIndex(selectedDateTime.month);
    monthController.jumpToItem(monthItemIndex);
    final dayItemIndex = _dayToIndex(selectedDateTime.day);
    dayController.jumpToItem(dayItemIndex);
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
