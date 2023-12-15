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
        minimumDateTime = _minimumDateTime(minimumTime, minuteInterval),
        maximumDateTime = _maximumDateTime(maximumTime, minuteInterval),
        assert(
          minuteInterval > 0 && TimeOfDay.minutesPerHour % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ) {
    assert(
      this.initialTime.minute % minuteInterval == 0,
      'initial time (${this.initialTime.minute}) is not divisible by minute interval ($minuteInterval)',
    );
    debugPrint(
      'initial time (${this.initialTime}) is before minimum time (${this.minimumDateTime})',
    );
    assert(
      this.minimumDateTime == null ||
          !(this.initialTime.hour < this.minimumDateTime!.hour ||
              (this.initialTime.hour == this.minimumDateTime!.hour &&
                  this.initialTime.minute < this.minimumDateTime!.minute)),
      'initial time (${this.initialTime}) is before minimum time (${this.minimumDateTime})',
    );
    assert(
      this.maximumDateTime == null ||
          !(this.initialTime.hour > this.maximumDateTime!.hour ||
              (this.initialTime.hour == this.maximumDateTime!.hour &&
                  this.initialTime.minute > this.maximumDateTime!.minute)),
      'initial time (${this.initialTime}) is after maximum time (${this.maximumDateTime})',
    );
  }

  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimeOfDay initialTime;
  final TimeOfDay? minimumDateTime;
  final TimeOfDay? maximumDateTime;
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

  static TimeOfDay? _minimumDateTime(TimeOfDay? time, int minuteInterval) {
    if (time == null) {
      return null;
    }
    return ceilToInterval(time, minuteInterval);
  }

  static TimeOfDay? _maximumDateTime(TimeOfDay? time, int minuteInterval) {
    if (time == null) {
      return null;
    }
    return floorToInterval(time, minuteInterval);
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
  late TimeOfDay selectedDateTime;
  late SBBPickerScrollController minuteController;
  late SBBPickerScrollController hourController;

  /// This is used to prevent notifying the callback with the same value
  late TimeOfDay lastReportedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialTime;
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

    selectedDateTime = TimeOfDay(
      hour: selectedHour,
      minute: selectedMinute,
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
    widget.onTimeChanged(selectedDateTime);
  }

  bool _ensureMinTime() {
    // check if selected time is before min time
    final minimumDateTime = widget.minimumDateTime;
    if (minimumDateTime == null ||
        (minimumDateTime.hour < selectedDateTime.hour ||
            (minimumDateTime.hour == selectedDateTime.hour &&
                minimumDateTime.minute < selectedDateTime.minute))) {
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
    if (maximumDateTime == null ||
        (maximumDateTime.hour > selectedDateTime.hour ||
            (maximumDateTime.hour == selectedDateTime.hour &&
                maximumDateTime.minute > selectedDateTime.minute))) {
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
