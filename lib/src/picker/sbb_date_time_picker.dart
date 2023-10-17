part of 'sbb_picker.dart';

class SBBDateTimePicker extends StatefulWidget {
  SBBDateTimePicker({
    super.key,
    required this.onDateTimeChanged,
    DateTime? initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
    this.isLastElement = true,
    this.minuteInterval = 1,
  })  : initialDateTime = _initialDateTime(initialDateTime, minuteInterval),
        minimumDateTime = _minimumDateTime(minimumDateTime, minuteInterval),
        maximumDateTime = _maximumDateTime(maximumDateTime, minuteInterval),
        assert(
          minuteInterval > 0 && 60 % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ) {
    assert(
      this.initialDateTime.minute % minuteInterval == 0,
      'initial minute (${this.initialDateTime.minute}) is not divisible by minute interval ($minuteInterval)',
    );
    assert(
      this.minimumDateTime == null ||
          !this.initialDateTime.isBefore(this.minimumDateTime!),
      'initial date (${this.initialDateTime}) is before minimum date (${this.minimumDateTime})',
    );
    assert(
      this.maximumDateTime == null ||
          !this.initialDateTime.isAfter(this.maximumDateTime!),
      'initial date (${this.initialDateTime}) is after maximum date (${this.maximumDateTime})',
    );
  }

  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final int minuteInterval;
  final bool isLastElement;

  @override
  State<SBBDateTimePicker> createState() {
    return _SBBDateTimePickerState();
  }

  static DateTime _initialDateTime(
    DateTime? initialDateTime,
    int minuteInterval,
  ) {
    final dateTime = initialDateTime ?? DateTime.now();

    return _cleanDateTime(dateTime);
  }

  static DateTime? _minimumDateTime(
    DateTime? minimumDateTime,
    int minuteInterval,
  ) {
    if (minimumDateTime == null) {
      return null;
    }

    return ceilToInterval(minimumDateTime, minuteInterval);
  }

  static DateTime? _maximumDateTime(
    DateTime? maximumDateTime,
    int minuteInterval,
  ) {
    if (maximumDateTime == null) {
      return null;
    }

    return floorToInterval(maximumDateTime, minuteInterval);
  }

  static DateTime _cleanDateTime(DateTime dateTime, {int? minute}) {
    return dateTime.copyWith(
      minute: minute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  /// Creates copy of [dateTime] with the minute value rounded to the closest
  /// minute value that is divisible by [minuteInterval].
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:08 -> 17:15
  /// 17:07 -> 17:00
  /// 17:52 -> 17:45
  /// 17:53 -> 18:00 (hour value also affected)
  /// ```
  static DateTime roundToInterval(DateTime dateTime, int minuteInterval) {
    final roundedMinute =
        ((dateTime.minute / minuteInterval).round() * minuteInterval);
    return _cleanDateTime(
      dateTime,
      minute: roundedMinute,
    );
  }

  /// Creates copy of [dateTime] with the minute value rounded to the greatest
  /// minute value that is divisible by [minuteInterval] but no greater than the
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:14 -> 17:00
  /// 17:29 -> 17:15
  /// ```
  static DateTime floorToInterval(DateTime dateTime, int minuteInterval) {
    final roundedMinute =
        ((dateTime.minute / minuteInterval).floor() * minuteInterval);
    return _cleanDateTime(
      dateTime,
      minute: roundedMinute,
    );
  }

  /// Creates copy of [dateTime] with the minute value rounded to the least
  /// minute value that is divisible by [minuteInterval] but is not smaller than
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:16 -> 17:30
  /// 17:01 -> 17:15
  /// 17:46 -> 18:00 (hour value also affected)
  /// ```
  static DateTime ceilToInterval(DateTime dateTime, int minuteInterval) {
    final roundedMinute =
        ((dateTime.minute / minuteInterval).ceil() * minuteInterval);
    return _cleanDateTime(
      dateTime,
      minute: roundedMinute,
    );
  }
}

class _SBBDateTimePickerState extends State<SBBDateTimePicker> {
  late DateTime selectedDateTime;
  late SBBPickerScrollController dateController;
  late SBBPickerScrollController minuteController;
  late SBBPickerScrollController hourController;

  /// This is used to prevent notifying the callback with the same value
  late DateTime lastReportedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
    lastReportedDateTime = selectedDateTime;

    dateController = SBBPickerScrollController(
      initialItem: _dateToIndex(selectedDateTime),
    );
    dateController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    minuteController = SBBPickerScrollController(
      initialItem: _minuteToIndex(selectedDateTime.minute),
    );
    minuteController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    hourController = SBBPickerScrollController(
      initialItem: _hourToIndex(selectedDateTime.hour),
    );
    hourController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SBBPicker.custom(
      isLastElement: widget.isLastElement,
      child: Row(
        children: [
          Expanded(
            child: _buildDatePickerScrollView(context),
          ),
          Container(
            width: 48.0 + 12.0 + 12.0,
            child: _buildHourPickerScrollView(context),
          ),
          Container(
            width: 48.0 + 12.0 + 24.0,
            child: _buildMinutePickerScrollView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerScrollView(BuildContext context) {
    final materialLocalizations = Localizations.of<MaterialLocalizations>(
      context,
      MaterialLocalizations,
    )!;
    final now = DateTime.now();
    return SBBPickerScrollView(
      controller: dateController,
      onSelectedItemChanged: (int index) {
        final selectedDate = _indexToDate(index);
        _onDateTimeSelected(
          year: selectedDate.year,
          month: selectedDate.month,
          day: selectedDate.day,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedDate = _indexToDate(index);

        var dateEnabled = true;
        // check if selected date is before min date
        final minimumDateTime = widget.minimumDateTime;
        if (minimumDateTime != null) {
          if (selectedDate.isBefore(minimumDateTime)) {
            dateEnabled = false;
          }
        }
        // check if selected date is after max date
        final maximumDateTime = widget.maximumDateTime;
        if (maximumDateTime != null) {
          if (selectedDate.isAfter(maximumDateTime)) {
            dateEnabled = false;
          }
        }

        late String listItemLabel;
        final isToday = _sameDay(selectedDate, now);
        if (isToday) {
          // show today label
          listItemLabel = materialLocalizations.currentDateLabel;
        } else {
          // show date label
          listItemLabel = materialLocalizations
              .formatMediumDate(selectedDate)
              .replaceFirst('.,', '.'); // TODO better way?
        }

        return (
          dateEnabled,
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              left: 24.0,
              right: 12.0,
            ),
            child: SizedBox(
              child: Text(
                listItemLabel,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHourPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: hourController,
      onSelectedItemChanged: (int index) {
        final selectedHour = _indexToHour(index);
        _onDateTimeSelected(
          hour: selectedHour,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedHour = _indexToHour(index);

        var hourEnabled = true;

        // check if selected time is before min time
        final minimumDateTime = widget.minimumDateTime;
        if (minimumDateTime != null) {
          final dateTimeToCompare = selectedDateTime.copyWith(
            hour: selectedHour,
            minute: minimumDateTime.minute,
            millisecond: minimumDateTime.millisecond,
            microsecond: minimumDateTime.microsecond,
          );
          if (dateTimeToCompare.isBefore(minimumDateTime)) {
            hourEnabled = false;
          }
        }
        // check if selected time is after max time
        final maximumDateTime = widget.maximumDateTime;
        if (maximumDateTime != null) {
          final dateTimeToCompare = selectedDateTime.copyWith(
            hour: selectedHour,
            minute: maximumDateTime.minute,
            millisecond: maximumDateTime.millisecond,
            microsecond: maximumDateTime.microsecond,
          );
          if (dateTimeToCompare.isAfter(maximumDateTime)) {
            hourEnabled = false;
          }
        }

        final listItemLabel = selectedHour.toString().padLeft(2, '0');
        return (
          hourEnabled,
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: SizedBox(
              width: 48.0,
              child: Text(
                listItemLabel,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMinutePickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: minuteController,
      onSelectedItemChanged: (int index) {
        final selectedMinute = _indexToMinute(index);
        _onDateTimeSelected(
          minute: selectedMinute,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedMinute = _indexToMinute(index);
        final selectedHour = _indexToHour(hourController.selectedItem);

        var minuteEnabled = true;
        // check if selected time is before min time
        final minimumDateTime = widget.minimumDateTime;
        if (minimumDateTime != null) {
          final dateTimeToCompare = selectedDateTime.copyWith(
            minute: selectedMinute,
            millisecond: minimumDateTime.millisecond,
            microsecond: minimumDateTime.microsecond,
          );
          if (dateTimeToCompare.isBefore(minimumDateTime)) {
            minuteEnabled = false;
          }
          // if (minimumDateTime.hour == selectedHour) {
          //   if (minimumDateTime.minute > selectedMinute) {
          //     minuteEnabled = false;
          //   }
          // } else if (minimumDateTime.hour > selectedHour) {
          //   minuteEnabled = false;
          // }
        }
        // check if selected time is after max time
        final maximumDateTime = widget.maximumDateTime;
        if (maximumDateTime != null) {
          if (maximumDateTime.hour == selectedHour) {
            if (maximumDateTime.minute < selectedMinute) {
              minuteEnabled = false;
            }
          } else if (maximumDateTime.hour < selectedHour) {
            minuteEnabled = false;
          }
        }

        final listItemLabel = selectedMinute.toString().padLeft(2, '0');

        return (
          minuteEnabled,
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 12.0,
              right: 24.0,
            ),
            child: SizedBox(
              width: 48.0,
              child: Text(
                listItemLabel,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
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
    int? hour,
    int? minute,
  }) {
    final selectedYear = year ?? selectedDateTime.year;
    final selectedMonth = month ?? selectedDateTime.month;
    final selectedDay = day ?? selectedDateTime.day;
    final selectedHour = hour ?? selectedDateTime.hour;
    final selectedMinute = minute ?? selectedDateTime.minute;

    selectedDateTime = DateTime(
      selectedYear,
      selectedMonth,
      selectedDay,
      selectedHour,
      selectedMinute,
    );
  }

  void _onScrollingStateChanged() {
    if (hourController._scrollingStateNotifier.value ||
        minuteController._scrollingStateNotifier.value) {
      // do nothing if any controller still scrolling
      return;
    }

    // optimize list item positions
    _ensureOptimizedIndexPosition();

    // min time
    final correctedToMinTime = _ensureMinTime();
    if (correctedToMinTime) {
      // early return because of correction to min time
      return;
    }

    // max time
    final correctToMaxTime = _ensureMaxTime();
    if (correctToMaxTime) {
      // early return because of correction to max time
      return;
    }

    if (lastReportedDateTime == selectedDateTime) {
      // don't notify callback if time did not change
      return;
    }

    // notify callback with new selected time
    lastReportedDateTime = selectedDateTime;
    widget.onDateTimeChanged(selectedDateTime);
  }

  bool _ensureMinTime() {
    final minimumDateTime = widget.minimumDateTime;
    if (minimumDateTime == null || minimumDateTime.isBefore(selectedDateTime)) {
      // no correction needed
      return false;
    }

    // get index values of min time values
    final minTimeHourIndex = _hourToIndex(minimumDateTime.hour);
    final minTimeMinuteIndex = _minuteToIndex(minimumDateTime.minute);

    // check if any time values needs to be corrected
    final hourIncorrect = hourController.selectedItem != minTimeHourIndex;
    final minuteIncorrect = minuteController.selectedItem != minTimeMinuteIndex;

    // correct incorrect time values
    if (hourIncorrect) {
      hourController.animateToItem(minTimeHourIndex);
    }
    if (minuteIncorrect) {
      minuteController.animateToItem(minTimeMinuteIndex);
    }

    // return if any values has been corrected
    return hourIncorrect || minuteIncorrect;
  }

  bool _ensureMaxTime() {
    final maximumDateTime = widget.maximumDateTime;
    if (maximumDateTime == null || maximumDateTime.isAfter(selectedDateTime)) {
      // no correction needed
      return false;
    }

    // get index values of max time values
    final maxTimeHourIndex = _hourToIndex(maximumDateTime.hour);
    final maxTimeMinuteIndex = _minuteToIndex(maximumDateTime.minute);

    // check if any time values needs to be corrected
    final hourIncorrect = hourController.selectedItem != maxTimeHourIndex;
    final minuteIncorrect = minuteController.selectedItem != maxTimeMinuteIndex;

    // correct incorrect time values
    if (hourIncorrect) {
      hourController.animateToItem(maxTimeHourIndex);
    }
    if (minuteIncorrect) {
      minuteController.animateToItem(maxTimeMinuteIndex);
    }

    // return if any values has been corrected
    return hourIncorrect || minuteIncorrect;
  }

  void _ensureOptimizedIndexPosition() {
    final hourItemIndex = _hourToIndex(selectedDateTime.hour);
    hourController.jumpToItem(hourItemIndex);
    final minuteItemIndex = _minuteToIndex(selectedDateTime.minute);
    minuteController.jumpToItem(minuteItemIndex);
  }

  DateTime _indexToDate(int selectedItemIndex) {
    return widget.initialDateTime.add(
      Duration(days: selectedItemIndex),
    );
  }

  int _dateToIndex(DateTime selectedValue) {
    return selectedValue.difference(widget.initialDateTime).inDays;
  }

  int _indexToMinute(int selectedItemIndex) {
    return selectedItemIndex * widget.minuteInterval % TimeOfDay.minutesPerHour;
  }

  int _minuteToIndex(int selectedValue) {
    return selectedValue ~/ widget.minuteInterval;
  }

  int _indexToHour(int selectedItemIndex) {
    return selectedItemIndex % TimeOfDay.hoursPerDay;
  }

  int _hourToIndex(int selectedValue) {
    return selectedValue;
  }

  bool _sameDay(DateTime dateTimeA, DateTime dateTimeB) {
    return dateTimeA.year == dateTimeB.year &&
        dateTimeA.month == dateTimeB.month &&
        dateTimeA.day == dateTimeB.day;
  }
}
