part of 'sbb_picker.dart';

enum SBBDateTimePickerMode {
  time,
  date,
  dateAndTime,
}

class SBBDateTimePicker extends StatefulWidget {
  SBBDateTimePicker({
    super.key,
    this.label,
    this.mode = SBBDateTimePickerMode.dateAndTime,
    required this.onDateTimeChanged,
    DateTime? initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
    this.isLastElement = true,
    this.minuteInterval = 1,
  })  : initialDateTime = _initialDateTime(
          initialDateTime,
          minuteInterval,
          mode,
        ),
        minimumDateTime = _minimumDateTime(
          minimumDateTime,
          initialDateTime,
          minuteInterval,
          mode,
        ),
        maximumDateTime = _maximumDateTime(
          maximumDateTime,
          initialDateTime,
          minuteInterval,
          mode,
        ),
        assert(
          minuteInterval > 0 && 60 % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ) {
    // TODO ignore in mode date
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

  final String? label;
  final SBBDateTimePickerMode mode;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final int minuteInterval;
  final bool isLastElement;

  @override
  State<SBBDateTimePicker> createState() {
    if (mode == SBBDateTimePickerMode.date) {
      return _SBBDateTimePickerDateState();
    }
    if (mode == SBBDateTimePickerMode.time) {
      return _SBBDateTimePickerTimeState();
    }
    if (mode == SBBDateTimePickerMode.dateAndTime) {
      return _SBBDateTimePickerDateAndTimeState();
    }
    return _SBBDateTimePickerDateState();
  }

  static DateTime _initialDateTime(
    DateTime? initialDateTime,
    int minuteInterval,
    SBBDateTimePickerMode mode,
  ) {
    final dateTime = initialDateTime ?? DateTime.now();

    if (mode == SBBDateTimePickerMode.date) {
      return _cleanDateTime(dateTime, hour: 0, minute: 0);
    }

    return _cleanDateTime(dateTime);
  }

  static DateTime? _minimumDateTime(
    DateTime? minimumDateTime,
    DateTime? initialDateTime,
    int minuteInterval,
    SBBDateTimePickerMode mode,
  ) {
    if (minimumDateTime == null) {
      return null;
    }

    if (mode == SBBDateTimePickerMode.date) {
      return _cleanDateTime(minimumDateTime, hour: 0, minute: 0);
    }

    if (mode == SBBDateTimePickerMode.dateAndTime) {
      return ceilToInterval(minimumDateTime, minuteInterval);
    }

    if (mode == SBBDateTimePickerMode.time) {
      final initialDate = _initialDateTime(
        initialDateTime,
        minuteInterval,
        mode,
      );
      final dateTime = minimumDateTime.copyWith(
        year: initialDate.year,
        month: initialDate.month,
        day: initialDate.day,
      );
      return ceilToInterval(dateTime, minuteInterval);
    }
    return null;
  }

  static DateTime? _maximumDateTime(
    DateTime? maximumDateTime,
    DateTime? initialDateTime,
    int minuteInterval,
    SBBDateTimePickerMode mode,
  ) {
    if (maximumDateTime == null) {
      return null;
    }

    if (mode == SBBDateTimePickerMode.date) {
      return _cleanDateTime(maximumDateTime, hour: 0, minute: 0);
    }

    if (mode == SBBDateTimePickerMode.dateAndTime) {
      return floorToInterval(maximumDateTime, minuteInterval);
    }
    if (mode == SBBDateTimePickerMode.time) {
      final initialDate = _initialDateTime(
        initialDateTime,
        minuteInterval,
        mode,
      );
      final dateTime = maximumDateTime.copyWith(
        year: initialDate.year,
        month: initialDate.month,
        day: initialDate.day,
      );
      return floorToInterval(dateTime, minuteInterval);
    }
    return null;
  }

  static DateTime _cleanDateTime(DateTime dateTime, {int? hour, int? minute}) {
    return dateTime.copyWith(
      hour: hour,
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

class _SBBDateTimePickerDateAndTimeState extends State<SBBDateTimePicker> {
  late DateTime selectedDateTime;
  late SBBPickerScrollController dateController;
  late SBBPickerScrollController minuteController;
  late SBBPickerScrollController hourController;

  /// This is used to prevent notifying the callback with the same value
  late DateTime lastReportedDateTime;

  @override
  void initState() {
    super.initState();
    // round minute value to closest factor of valid minute interval
    final roundedMinute =
        ((widget.initialDateTime.minute / widget.minuteInterval).round() *
                widget.minuteInterval)
            .toInt();
    selectedDateTime = widget.initialDateTime.copyWith(
      minute: roundedMinute,
      second: 0,
      millisecond: 0,
    );
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
      label: widget.label,
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
    return selectedItemIndex * widget.minuteInterval % 60;
  }

  int _minuteToIndex(int selectedValue) {
    return selectedValue ~/ widget.minuteInterval;
  }

  int _indexToHour(int selectedItemIndex) {
    return selectedItemIndex % 24;
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

class _SBBDateTimePickerTimeState extends State<SBBDateTimePicker> {
  late DateTime selectedDateTime;
  late SBBPickerScrollController minuteController;
  late SBBPickerScrollController hourController;

  /// This is used to prevent notifying the callback with the same value
  late DateTime lastReportedDateTime;

  @override
  void initState() {
    super.initState();
    // round minute value to closest factor of valid minute interval
    final roundedMinute =
        ((widget.initialDateTime.minute / widget.minuteInterval).round() *
                widget.minuteInterval)
            .toInt();
    selectedDateTime = widget.initialDateTime.copyWith(
      year: 0,
      month: 0,
      day: 0,
      minute: roundedMinute,
      second: 0,
      millisecond: 0,
    );
    lastReportedDateTime = selectedDateTime;

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
      label: widget.label,
      isLastElement: widget.isLastElement,
      child: Row(
        children: [
          Expanded(
            child: _buildHourPickerScrollView(context),
          ),
          Expanded(
            child: _buildMinutePickerScrollView(context),
          ),
        ],
      ),
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
          if (minimumDateTime.hour > selectedHour) {
            hourEnabled = false;
          }
        }
        // check if selected time is after max time
        final maximumDateTime = widget.maximumDateTime;
        if (maximumDateTime != null) {
          if (maximumDateTime.hour < selectedHour) {
            hourEnabled = false;
          }
        }

        final listItemLabel = selectedHour.toString().padLeft(2, '0');
        return (
          hourEnabled,
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              right: 12.0,
              // right: sbbDefaultSpacing * 0.75,
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
          if (minimumDateTime.hour == selectedHour) {
            if (minimumDateTime.minute > selectedMinute) {
              minuteEnabled = false;
            }
          } else if (minimumDateTime.hour > selectedHour) {
            minuteEnabled = false;
          }
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
              // right: sbbDefaultSpacing * 0.75,
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
    int? hour,
    int? minute,
  }) {
    final selectedHour = hour ?? selectedDateTime.hour;
    final selectedMinute = minute ?? selectedDateTime.minute;

    selectedDateTime = DateTime(
      widget.initialDateTime.year,
      widget.initialDateTime.month,
      widget.initialDateTime.day,
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
    // check if selected time is before min time
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
    // check if selected time is after max time
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

  int _indexToMinute(int selectedItemIndex) {
    return selectedItemIndex * widget.minuteInterval % 60;
  }

  int _minuteToIndex(int selectedValue) {
    return selectedValue ~/ widget.minuteInterval;
  }

  int _indexToHour(int selectedItemIndex) {
    return selectedItemIndex % 24;
  }

  int _hourToIndex(int selectedValue) {
    return selectedValue;
  }
}

class _SBBDateTimePickerDateState extends State<SBBDateTimePicker> {
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
    selectedDateTime = widget.initialDateTime.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );
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
      label: widget.label,
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
        final minimumDateTime = widget.minimumDateTime;
        if (dayEnabled && minimumDateTime != null) {
          dayEnabled &= !minimumDateTime.isAfter(
            selectedDateTime.copyWith(
              day: selectedDay,
            ),
          );
        }
        // check if date is after maximum date
        final maximumDateTime = widget.maximumDateTime;
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
        final minimumDateTime = widget.minimumDateTime;
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
        final maximumDateTime = widget.maximumDateTime;
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
        final minimumDateTime = widget.minimumDateTime;
        if (minimumDateTime != null) {
          if (minimumDateTime.year > selectedYear) {
            yearEnabled = false;
          }
        }
        // check if selected date is after max date
        final maximumDateTime = widget.maximumDateTime;
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
      selectedDateTime.hour,
      selectedDateTime.minute,
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
    widget.onDateTimeChanged(selectedDateTime);
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
    final minimumDateTime = widget.minimumDateTime;
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
    final maximumDateTime = widget.maximumDateTime;
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
    return selectedItemIndex % 12 + 1;
  }

  int _monthToIndex(int selectedValue) {
    return selectedValue - 1;
  }

  int _indexToYear(int selectedItemIndex) {
    return widget.initialDateTime.year + selectedItemIndex;
  }

  int _yearToIndex(int selectedValue) {
    return selectedValue - widget.initialDateTime.year;
  }

  int _monthDaysCount(int year, int month) {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }
}
