part of 'sbb_picker.dart';

class SBBTimeRangePicker extends StatefulWidget {
  SBBTimeRangePicker({
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
    assert(
      mode != SBBDateTimePickerMode.dateAndTime ||
          minimumDateTime == null ||
          !this.initialDateTime.isBefore(minimumDateTime),
      'initial date is before minimum date',
    );
    assert(
      mode != SBBDateTimePickerMode.dateAndTime ||
          maximumDateTime == null ||
          !this.initialDateTime.isAfter(maximumDateTime),
      'initial date is after maximum date',
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
  State<SBBTimeRangePicker> createState() {
    return _SBBTimeRangePickerState();
  }

  static DateTime _initialDateTime(
    DateTime? initialDateTime,
    int minuteInterval,
    SBBDateTimePickerMode mode,
  ) {
    final dateTime = initialDateTime ?? DateTime.now();

    if (mode == SBBDateTimePickerMode.date) {
      return dateTime.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
    }

    return _roundDateTimeToMinuteInterval(
      dateTime.copyWith(
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ),
      minuteInterval,
    );
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
      return minimumDateTime.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
    }

    final roundingHourMinuteThreshold =
        Duration.minutesPerHour - minuteInterval * 0.5;
    final roundedMinute =
        ((minimumDateTime.minute / minuteInterval).ceil() * minuteInterval);
    final roundedHour = minimumDateTime.minute > roundingHourMinuteThreshold &&
            roundedMinute == 0
        ? minimumDateTime.hour + 1
        : minimumDateTime.hour;

    if (mode == SBBDateTimePickerMode.dateAndTime) {
      return minimumDateTime.copyWith(
        hour: roundedHour,
        minute: roundedMinute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
    }
    if (mode == SBBDateTimePickerMode.time) {
      final initialDate = initialDateTime ?? DateTime.now();
      return minimumDateTime.copyWith(
        year: initialDate.year,
        month: initialDate.month,
        day: initialDate.day,
        hour: roundedHour,
        minute: roundedMinute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
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
      return maximumDateTime.copyWith(
        hour: Duration.hoursPerDay - 1,
        minute: Duration.minutesPerHour - 1,
        second: Duration.secondsPerMinute - 1,
        millisecond: Duration.millisecondsPerSecond - 1,
        microsecond: Duration.microsecondsPerMillisecond - 1,
      );
    }

    final roundedMinute =
        ((maximumDateTime.minute / minuteInterval).floor() * minuteInterval);
    if (mode == SBBDateTimePickerMode.dateAndTime) {
      return maximumDateTime.copyWith(
        minute: roundedMinute,
        second: Duration.secondsPerMinute - 1,
        millisecond: Duration.millisecondsPerSecond - 1,
        microsecond: Duration.microsecondsPerMillisecond - 1,
      );
    }
    if (mode == SBBDateTimePickerMode.time) {
      final initialDate = initialDateTime ?? DateTime.now();
      return maximumDateTime.copyWith(
        year: initialDate.year,
        month: initialDate.month,
        day: initialDate.day,
        minute: roundedMinute,
        second: Duration.secondsPerMinute - 1,
        millisecond: Duration.millisecondsPerSecond - 1,
        microsecond: Duration.microsecondsPerMillisecond - 1,
      );
    }
    return null;
  }

  static DateTime _roundDateTimeToMinuteInterval(
    DateTime dateTime,
    int minuteInterval,
  ) {
    final roundingHourMinuteThreshold =
        Duration.minutesPerHour - minuteInterval * 0.5;
    final roundedHour = dateTime.minute < roundingHourMinuteThreshold
        ? dateTime.hour
        : dateTime.hour + 1;
    final roundedMinute =
        ((dateTime.minute / minuteInterval).round() * minuteInterval);

    return dateTime.copyWith(
      hour: roundedHour,
      minute: roundedMinute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }
}

class _SBBTimeRangePickerState extends State<SBBTimeRangePicker> {
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
