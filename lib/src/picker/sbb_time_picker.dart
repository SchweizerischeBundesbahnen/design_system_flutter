part of 'sbb_picker.dart';

class SBBTimePicker extends StatefulWidget {
  SBBTimePicker({
    super.key,
    required this.onTimeChanged,
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    this.isLastElement = true,
    this.minuteInterval = 1,
  })  : initialTime = _initialTime(initialTime),
        minimumTime = _minimumTime(minimumTime, minuteInterval),
        maximumTime = _maximumTime(maximumTime, minuteInterval),
        assert(
          minuteInterval > 0 && TimeOfDay.minutesPerHour % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ) {
    assert(
      this.initialTime.minute % minuteInterval == 0,
      'initial time (${this.initialTime.minute}) is not divisible by minute interval ($minuteInterval)',
    );

    if (this.minimumTime != null && this.maximumTime != null) {
      assert(
        this.initialTime.isBetween(this.minimumTime!, this.maximumTime!),
        'initial time (${this.initialTime}) is not between minimum time (${this.minimumTime}) and maximum time (${this.maximumTime})',
      );
    } else {
      assert(
        this.minimumTime == null ||
            !this.initialTime.isBefore(this.minimumTime!),
        'initial time (${this.initialTime}) is before minimum time (${this.minimumTime})',
      );
      assert(
        this.maximumTime == null ||
            !(this.initialTime.isAfter(this.maximumTime!)),
        'initial time (${this.initialTime}) is after maximum time (${this.maximumTime})',
      );
    }
  }

  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimeOfDay initialTime;
  final TimeOfDay? minimumTime;
  final TimeOfDay? maximumTime;
  final int minuteInterval;
  final bool isLastElement;

  @override
  State<SBBTimePicker> createState() {
    return _SBBTimePickerTimeState();
  }

  static TimeOfDay _initialTime(TimeOfDay? time) {
    if (time == null) {
      return TimeOfDay.now();
    }
    return time.replacing(hour: time.hour, minute: time.minute);
  }

  static TimeOfDay? _minimumTime(TimeOfDay? time, int minuteInterval) {
    if (time == null) {
      return null;
    }
    return ceilToInterval(time, minuteInterval);
  }

  static TimeOfDay? _maximumTime(TimeOfDay? time, int minuteInterval) {
    if (time == null) {
      return null;
    }
    return floorToInterval(time, minuteInterval);
  }

  /// Creates copy of [time] with the minute value rounded to the closest minute
  /// value that is divisible by [minuteInterval].
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:08 -> 17:15
  /// 17:07 -> 17:00
  /// 17:52 -> 17:45
  /// 17:53 -> 18:00 (hour value also affected)
  /// ```
  static TimeOfDay roundToInterval(TimeOfDay time, int minuteInterval) {
    var roundedMinute =
        ((time.minute / minuteInterval).round() * minuteInterval);
    final roundedHour =
        (time.hour + roundedMinute ~/ TimeOfDay.minutesPerHour) %
            TimeOfDay.hoursPerDay;
    roundedMinute %= TimeOfDay.minutesPerHour;
    return time.replacing(hour: roundedHour, minute: roundedMinute);
  }

  /// Creates copy of [time] with the minute value rounded to the greatest
  /// minute value that is divisible by [minuteInterval] but no greater than the
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:14 -> 17:00
  /// 17:29 -> 17:15
  /// ```
  static TimeOfDay floorToInterval(TimeOfDay time, int minuteInterval) {
    final roundedHour = time.hour + time.minute ~/ TimeOfDay.minutesPerHour;
    final roundedMinute =
        ((time.minute / minuteInterval).floor() * minuteInterval) %
            TimeOfDay.minutesPerHour;
    return time.replacing(hour: roundedHour, minute: roundedMinute);
  }

  /// Creates copy of [time] with the minute value rounded to the least minute
  /// value that is divisible by [minuteInterval] but is not smaller than
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:16 -> 17:30
  /// 17:01 -> 17:15
  /// 17:46 -> 18:00 (hour value also affected)
  /// ```
  static TimeOfDay ceilToInterval(TimeOfDay time, int minuteInterval) {
    var roundedMinute =
        ((time.minute / minuteInterval).ceil() * minuteInterval);
    final roundedHour = time.hour + roundedMinute ~/ TimeOfDay.minutesPerHour;
    roundedMinute %= TimeOfDay.minutesPerHour;
    return time.replacing(hour: roundedHour, minute: roundedMinute);
  }
}

class _SBBTimePickerTimeState extends State<SBBTimePicker> {
  late TimeOfDay selectedTime;
  late SBBPickerScrollController minuteController;
  late SBBPickerScrollController hourController;
  late ValueNotifier<int> hourValueNotifier;

  /// This is used to prevent notifying the callback with the same value
  late TimeOfDay lastReportedDateTime;

  TimeOfDay get safeMinTime =>
      widget.minimumTime ?? TimeOfDay(hour: 0, minute: 0);

  TimeOfDay get safeMaxTime =>
      widget.maximumTime ?? TimeOfDay(hour: 23, minute: 59);

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
    lastReportedDateTime = selectedTime;
    hourValueNotifier = ValueNotifier(selectedTime.hour);

    minuteController = SBBPickerScrollController(
      initialItem: _minuteToIndex(selectedTime.minute),
    );
    minuteController._scrollingStateNotifier.addListener(() {
      _onScrollingStateChanged();
    });

    hourController = SBBPickerScrollController(
      initialItem: _hourToIndex(selectedTime.hour),
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
        _onDateTimeSelected(hour: selectedHour);
      },
      itemBuilder: (BuildContext context, int index) {
        final itemHour = _indexToHour(index);
        final itemHourTime = TimeOfDay(hour: itemHour, minute: 0);
        final itemEnabled = itemHourTime.isBetween(
          safeMinTime.floor(),
          safeMaxTime.ceil(),
        );

        final listItemLabel = itemHour.toString().padLeft(2, '0');
        return (
          itemEnabled,
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
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
    return ValueListenableBuilder(
      valueListenable: hourValueNotifier,
      builder: (
        BuildContext context,
        int selectedHour,
        Widget? child,
      ) {
        return SBBPickerScrollView(
          controller: minuteController,
          onSelectedItemChanged: (int index) {
            final selectedMinute = _indexToMinute(index);
            _onDateTimeSelected(minute: selectedMinute);
          },
          itemBuilder: (BuildContext context, int index) {
            final itemMinute = _indexToMinute(index);
            final itemTime = TimeOfDay(
              hour: selectedHour,
              minute: itemMinute,
            );

            final itemEnabled = itemTime.isBetween(
              safeMinTime,
              safeMaxTime,
            );

            final listItemLabel = itemMinute.toString().padLeft(2, '0');
            return (
              itemEnabled,
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 12.0,
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
      },
    );
  }

  void _onDateTimeSelected({int? hour, int? minute}) {
    final selectedHour = hour ?? selectedTime.hour;
    final selectedMinute = minute ?? selectedTime.minute;

    selectedTime = TimeOfDay(
      hour: selectedHour,
      minute: selectedMinute,
    );

    // update hour ValueNotifier to trigger rebuilding minute scrollview
    // if the selected time is outside the valid time range, the hour value of
    // the closest valid time should be used to prevent showing all minute items
    // disabled while scrolling back to valid time
    hourValueNotifier.value = _getClosestValidHour();
  }

  int _getClosestValidHour() {
    final selectedHour = selectedTime.hour;

    // just return selected hour if selected time is already in valid range
    final isTimeInRange = selectedTime.isBetween(safeMinTime, safeMaxTime);
    if (isTimeInRange) {
      return selectedHour;
    }

    final minHour = safeMinTime.hour;
    final maxHour = safeMaxTime.hour;

    // day offset is used to check if there is a smaller diff trough midnight
    const dayOffset = TimeOfDay.hoursPerDay;

    final minTimeDiff = (selectedHour - minHour).abs();
    final minTimeOffsetDiff = (selectedHour - dayOffset - minHour).abs();
    final maxTimeDiff = (selectedHour - maxHour).abs();
    final maxTimeOffsetDiff = (selectedHour + dayOffset - maxHour).abs();

    final smallerMinTimeDiff = min(minTimeDiff, minTimeOffsetDiff);
    final smallerMaxTimeDiff = min(maxTimeDiff, maxTimeOffsetDiff);

    if (smallerMinTimeDiff < smallerMaxTimeDiff) {
      return minHour;
    } else {
      return maxHour;
    }
  }

  void _onScrollingStateChanged() {
    if (hourController._scrollingStateNotifier.value ||
        minuteController._scrollingStateNotifier.value) {
      // do nothing if any controller still scrolling
      return;
    }

    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    // check if selected time in valid range
    final isTimeInRange = selectedTime.isBetween(safeMinTime, safeMaxTime);
    if (!isTimeInRange) {
      // correct to closest valid time value
      _animateToClosestValidTime();

      // early return because of time correction
      return;
    }

    // don't notify callback if time did not change
    if (lastReportedDateTime == selectedTime) {
      return;
    }

    // notify callback with new selected time
    lastReportedDateTime = selectedTime;
    widget.onTimeChanged(selectedTime);
  }

  void _animateToClosestValidTime() {
    final animateToMinTime = hourValueNotifier.value == safeMinTime.hour;
    if (animateToMinTime) {
      if (selectedTime.hour > safeMinTime.hour) {
        // set index dayOffset to scroll over midnight
        _ensureOptimizedScrollPosition(offset: -TimeOfDay.hoursPerDay);
      }
      _animateToMinTime();
    } else {
      if (selectedTime.hour < safeMaxTime.hour) {
        // set index dayOffset to scroll over midnight
        _ensureOptimizedScrollPosition(offset: TimeOfDay.hoursPerDay);
      }
      _animateToMaxTime();
    }
  }

  void _animateToMinTime() => _animateToTime(safeMinTime);

  void _animateToMaxTime() => _animateToTime(safeMaxTime);

  void _animateToTime(TimeOfDay time) {
    // get index values of time values
    final hourIndex = _hourToIndex(time.hour);
    final minuteIndex = _minuteToIndex(time.minute);

    // check if any time values needs to be corrected
    final hourIncorrect = hourController.selectedItem != hourIndex;
    final minuteIncorrect = minuteController.selectedItem != minuteIndex;

    // correct incorrect time values
    if (hourIncorrect) {
      hourController.animateToItem(hourIndex);
    }
    if (minuteIncorrect) {
      minuteController.animateToItem(minuteIndex);
    }
  }

  void _ensureOptimizedScrollPosition({int offset = 0}) {
    final hourItemIndex = _hourToIndex(selectedTime.hour) + offset;
    final minuteItemIndex = _minuteToIndex(selectedTime.minute);
    hourController.jumpToItem(hourItemIndex);
    minuteController.jumpToItem(minuteItemIndex);
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
}

extension TimeOfDayX on TimeOfDay {
  bool isBefore(TimeOfDay timeOfDay) {
    if (this.hour == timeOfDay.hour) {
      return this.minute < timeOfDay.minute;
    }
    return this.hour < timeOfDay.hour;
  }

  bool isAfter(TimeOfDay timeOfDay) {
    if (this.hour == timeOfDay.hour) {
      return this.minute > timeOfDay.minute;
    }
    return this.hour > timeOfDay.hour;
  }

  bool isBetween(TimeOfDay minTime, TimeOfDay maxTime) {
    final startOfDay = TimeOfDay(hour: 0, minute: 0);
    final endOfDay = TimeOfDay(hour: 23, minute: 59);

    if (minTime.isBefore(maxTime)) {
      return !this.isBefore(minTime) && !this.isAfter(maxTime);
    }

    // range over midnight
    final isBetweenMinTimeAndMidnight = this.isBetween(minTime, endOfDay);
    final isBetweenMidnightAndMaxTime = this.isBetween(startOfDay, maxTime);
    return isBetweenMinTimeAndMidnight || isBetweenMidnightAndMaxTime;
  }

  TimeOfDay floor() => this.replacing(minute: 0);

  TimeOfDay ceil() => this.replacing(minute: 59);
}
