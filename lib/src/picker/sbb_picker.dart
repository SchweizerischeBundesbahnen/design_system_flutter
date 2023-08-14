import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';

typedef SBBPickerScrollViewItemBuilder = (bool isEnabled, Widget widget)?
    Function(BuildContext context, int index);

const _defaultItemHeight = 30.0;
const _highlightedAreaHeight = 34.0;
const _visibleItemCount = 7;
const _firstIndexPreItemsCount = 3;
const _scrollAreaHeight = _defaultItemHeight * _visibleItemCount;
const _visibleItemHeights = [
  28.0,
  28.0,
  30.0,
  38.0,
  30.0,
  28.0,
  28.0,
];
const _visibleItemTextColors = [
  SBBColors.silver,
  SBBColors.cement,
  SBBColors.storm,
  SBBColors.storm,
  SBBColors.storm,
  SBBColors.cement,
  SBBColors.silver,
];

enum SBBDateTimePickerMode {
  time,
  date,
  dateAndTime,
}

class SBBPicker extends StatelessWidget {
  SBBPicker({
    Key? key,
    String? label,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required SBBPickerScrollViewItemBuilder itemBuilder,
    bool looping = true,
    bool isLastElement = false,
  }) : this.custom(
          key: key,
          label: label,
          child: SBBPickerScrollView(
            controller: SBBPickerScrollController(
              initialItem: initialSelectedIndex,
            ),
            onSelectedItemChanged: onSelectedItemChanged,
            itemBuilder: itemBuilder,
            looping: looping,
          ),
          isLastElement: isLastElement,
        );

  const SBBPicker.custom({
    super.key,
    this.label,
    required this.child,
    this.isLastElement = true,
  });

  final String? label;
  final Widget child;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label!,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: SBBTextStyles.helpersLabel,
                  ),
                ),
              ],
            ),
          ),
        Container(
          height: 224,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: _buildHighlightedArea(),
              ),
              Center(
                child: ShaderMask(
                  shaderCallback: _shaderCallback,
                  child: Container(
                    height: _scrollAreaHeight,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (label != null && !isLastElement)
          SizedBox(
            height: sbbDefaultSpacing * 0.5,
          ),
        if (!isLastElement) Divider(),
      ],
    );
  }

  Widget _buildHighlightedArea() {
    return Container(
      height: _highlightedAreaHeight,
      margin: EdgeInsets.symmetric(
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      decoration: BoxDecoration(
        color: SBBColors.cloud,
        borderRadius: BorderRadius.all(
          Radius.circular(
            sbbDefaultSpacing * 0.5,
          ),
        ),
      ),
    );
  }

  Shader _shaderCallback(bounds) {
    const topFadeOutStartStop = 3.0 / _scrollAreaHeight;
    final topFadeOutEndStop = _visibleItemHeights[0] / _scrollAreaHeight;
    const highlightedAreaStartStop =
        (_scrollAreaHeight - _highlightedAreaHeight) * 0.5 / _scrollAreaHeight;
    const highlightedAreaEndStop = 1.0 - highlightedAreaStartStop;
    final bottomFadeOutStartStop = 1.0 - topFadeOutEndStop;
    const bottomFadeOutEndStop = 1.0 - topFadeOutStartStop;

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        topFadeOutStartStop,
        topFadeOutEndStop,
        highlightedAreaStartStop,
        highlightedAreaStartStop,
        highlightedAreaEndStop,
        highlightedAreaEndStop,
        bottomFadeOutStartStop,
        bottomFadeOutEndStop,
      ],
      colors: [
        SBBColors.white.withOpacity(0.0),
        SBBColors.white,
        SBBColors.white,
        SBBColors.black,
        SBBColors.black,
        SBBColors.white,
        SBBColors.white,
        SBBColors.white.withOpacity(0.0),
      ],
    ).createShader(
      bounds,
    );
  }
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

    final roundedMinute =
        ((minimumDateTime.minute / minuteInterval).ceil() * minuteInterval)
            .toInt();
    final roundedHour = minimumDateTime.minute > 30 && roundedMinute == 0
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
        ((maximumDateTime.minute / minuteInterval).floor() * minuteInterval)
            .toInt();
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
    final roundedMinute = _roundMinuteToInterval(
      dateTime.minute,
      minuteInterval,
    );

    return dateTime.copyWith(
      hour: roundedHour,
      minute: roundedMinute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  static int _roundMinuteToInterval(int minute, int minuteInterval) {
    return ((minute / minuteInterval).round() * minuteInterval).toInt();
  }

  static int _floorMinuteToInterval(int minute, int minuteInterval) {
    return ((minute / minuteInterval).floor() * minuteInterval).toInt();
  }

  static int _ceilMinuteToInterval(int minute, int minuteInterval) {
    return ((minute / minuteInterval).ceil() * minuteInterval).toInt();
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

class SBBPickerScrollView extends StatefulWidget {
  const SBBPickerScrollView({
    super.key,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.controller,
    this.looping = true,
  });

  final ValueChanged<int>? onSelectedItemChanged;
  final SBBPickerScrollViewItemBuilder itemBuilder;
  final SBBPickerScrollController? controller;
  final bool looping;

  @override
  State<SBBPickerScrollView> createState() => _SBBPickerScrollViewState();
}

class _SBBPickerScrollViewState extends State<SBBPickerScrollView> {
  late ValueNotifier<double> _scrollOffsetValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;
  SBBPickerScrollController? _fallbackController;

  void _initController() {
    if (widget.controller == null) {
      _fallbackController = SBBPickerScrollController();
    }
    _controller.addListener(() {
      _scrollOffsetValueNotifier.value = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _scrollOffsetValueNotifier = ValueNotifier(
      _controller.initialScrollOffset,
    );
    _selectedItemIndexValueNotifier = ValueNotifier(_controller.selectedItem);

    _selectedItemIndexValueNotifier.addListener(() {
      final onSelectedItemChanged = widget.onSelectedItemChanged;
      if (onSelectedItemChanged != null) {
        // callback needs to be notified with Future.microtask to prevent
        // notifying callback during build phase which result in an exception
        Future.microtask(() {
          onSelectedItemChanged(_selectedItemIndexValueNotifier.value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant SBBPickerScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != _controller) {
      _initController();
    }
  }

  @override
  void dispose() {
    _scrollOffsetValueNotifier.dispose();
    _selectedItemIndexValueNotifier.dispose();
    _fallbackController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _listCenterKey = UniqueKey();
    return Container(
      height: _scrollAreaHeight,
      child: Scrollable(
        controller: _controller,
        viewportBuilder: (
          BuildContext context,
          ViewportOffset offset,
        ) {
          return Viewport(
            offset: offset,
            center: _listCenterKey,
            slivers: [
              // negative list (index < 0)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // adjust index so it goes negative from -1 instead of
                    // positive from 0
                    final adjustedIndex = -1 * index - 1;
                    return _buildListItem(adjustedIndex);
                  },
                ),
              ),
              // positive list (index >= 0)
              SliverList(
                key: _listCenterKey,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildListItem(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget? _buildListItem(int index) {
    int? scrollTarget = index;
    (bool, Widget)? listItem = widget.itemBuilder(
      context,
      index,
    );
    var listItemEnabled = listItem?.$1 ?? false;
    var listItemWidget = listItem?.$2;

    if (!widget.looping && listItem == null) {
      // checking for spacer list items in non looping scroll views
      if (index < 0 && index >= -_firstIndexPreItemsCount) {
        // scroll to first item for tapping top spacer items
        scrollTarget = 0;
        listItemWidget = SizedBox.shrink();
      } else if (widget.itemBuilder(
            context,
            index - _firstIndexPreItemsCount,
          ) !=
          null) {
        // scroll to last item for tapping bottom spacer items
        scrollTarget = null;
        listItemWidget = SizedBox.shrink();
      } else {
        return null;
      }
    }

    // item style values are calculated based on the current scroll offset
    return ValueListenableBuilder(
      valueListenable: _scrollOffsetValueNotifier,
      builder: (
        BuildContext context,
        double offset,
        Widget? _,
      ) {
        final itemsOfBothListsVisible =
            offset < 0 && offset > -_scrollAreaHeight;
        if (itemsOfBothListsVisible) {
          // Because of the target scroll position calculation workaround used
          // in SBBPickerScrollController, it's necessary to adjust the offset
          // to ensure that item heights are accurately calculated.
          var threshold = 0.0;
          for (var i = 0; i < _visibleItemCount; i++) {
            threshold -= _visibleItemHeights[i];
            if (threshold <= offset) {
              final offsetPercentage = offset / threshold;
              final maxCorrectedOffset = (-1 - i) * _defaultItemHeight;
              offset = offsetPercentage * maxCorrectedOffset;
              break;
            }
          }
        }

        // calculate the current item index of the visible items, this also
        // includes items that are only partly visible when scrolling
        final visibleItemIndex =
            ((offset - index * _defaultItemHeight) * -1 / _defaultItemHeight)
                .ceil();

        if (visibleItemIndex < 0 || visibleItemIndex > _visibleItemCount) {
          // return sized boxes with default height for out of sight items
          return Container(
            color: SBBColors.violet,
            height: _defaultItemHeight,
            child: Text('$visibleItemIndex'),
          );
        }

        // notify selected item changed
        final visibleAreaOffset = offset % _defaultItemHeight;
        var selectedVisibleItemIndex =
            visibleAreaOffset > _defaultItemHeight * 0.5
                ? _firstIndexPreItemsCount + 1
                : _firstIndexPreItemsCount;
        final selectedItemIndex =
            index + selectedVisibleItemIndex - visibleItemIndex;
        _selectedItemIndexValueNotifier.value = selectedItemIndex;

        // index values needed for following calculation of the item values
        final indexA = visibleItemIndex - 1;
        final indexB = visibleItemIndex;

        // calculate weight values based on scroll position
        final weightA = (offset % _defaultItemHeight) / _defaultItemHeight;
        final weightB = 1 - weightA;

        // calculate item height based on weight values
        final heightA = _itemHeight(indexA);
        final heightB = _itemHeight(indexB);
        final itemHeight = weightA * heightA + weightB * heightB;

        // calculate text color based on weight values
        final textColorA = _itemTextColor(indexA, listItemEnabled);
        final textColorB = _itemTextColor(indexB, listItemEnabled);
        final textColor = Color.lerp(
          textColorA,
          textColorB,
          weightB,
        );

        return GestureDetector(
          onTap: () {
            if (scrollTarget != null) {
              _controller.animateToItem(scrollTarget);
            } else {
              // scroll to bottom
              _controller.animateToScrollOffset(
                _controller.position.maxScrollExtent,
              );
            }
          },
          // TODO to the theme
          child: Container(
            height: itemHeight,
            color: SBBColors.transparent,
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: SBBTextStyles.mediumLight.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
                height: 26.0 / 24.0,
                color: textColor,
              ),
              child: listItemWidget!,
            ),
          ),
        );
      },
    );
  }

  double _itemHeight(int index) {
    if (index < 0 || index > _visibleItemCount - 1) {
      return _defaultItemHeight;
    }
    return _visibleItemHeights[index];
  }

  Color _itemTextColor(int index, bool enabled) {
    if (index < 0) {
      return _visibleItemTextColors.first.withOpacity(enabled ? 1.0 : 0.35);
    }
    if (index > _visibleItemCount - 1) {
      return _visibleItemTextColors.last.withOpacity(enabled ? 1.0 : 0.35);
    }
    return _visibleItemTextColors[index].withOpacity(enabled ? 1.0 : 0.35);
  }

  final testController = SBBPickerScrollController(initialItem: 1);

  SBBPickerScrollController get _controller {
    // return testController;
    // return widget.controller!;
    return widget.controller ?? _fallbackController!;
  }
}

/// A controller for [SBBPickerScrollView].
///
/// A SBB picker scroll view controller lets you manipulate which item is
/// selected in a [SBBPickerScrollView].
///
/// See also:
///
///  * [SBBPickerScrollView], which is the widget this object controls.
class SBBPickerScrollController extends ScrollController {
  SBBPickerScrollController({
    int initialItem = 0,
  }) : super(
          initialScrollOffset: _getItemScrollOffset(
            initialItem,
          ),
        );

  ValueNotifier<bool> _scrollingStateNotifier = ValueNotifier(false);

  int get selectedItem {
    final currentOffset = positions.isEmpty ? initialScrollOffset : offset;
    return (currentOffset / _defaultItemHeight).round() +
        _firstIndexPreItemsCount;
  }

  /// Animates the controlled [SBBPickerScrollView] from the current item to
  /// the item at the given index.
  ///
  /// The animation lasts for the given duration and follows the given curve or
  /// uses default values.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The duration must not be zero. To jump to a particular value without an
  /// animation, use [jumpToItem].
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> animateToItem(
    int itemIndex, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    await animateToScrollOffset(
      targetItemScrollOffset,
      duration: duration,
      curve: curve,
    );
  }

  /// Animates the position from its current offset to the given offset.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  ///
  /// The returned [Future] will complete when the animation ends, whether it
  /// completed successfully or whether it was interrupted prematurely.
  ///
  /// An animation will be interrupted whenever the user attempts to scroll
  /// manually, or whenever another activity is started, or whenever the
  /// animation reaches the edge of the viewport and attempts to overscroll in a
  /// non looping [SBBPickerScrollView]. (If the [SBBPickerScrollView] is
  /// looping, then going around the loop will not interrupt the animation.)
  ///
  /// The animation is indifferent to changes to the viewport or content
  /// dimensions.
  ///
  /// Once the animation has completed, the scroll position will attempt to
  /// begin a ballistic activity to snap to the nearest item.
  ///
  /// The duration must not be zero. To jump to a particular value without an
  /// animation, use [jumpTo].
  Future<void> animateToScrollOffset(
    double scrollOffset, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateTo(
      scrollOffset,
      duration: duration,
      curve: curve,
    );
  }

  /// Jumps the scroll position from the current item to the item at the given
  /// index, without animation.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  void jumpToItem(int itemIndex) {
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    jumpTo(targetItemScrollOffset);
  }

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    position.isScrollingNotifier.addListener(() {
      final scrollingValue = position.isScrollingNotifier.value;
      if (scrollingValue) {
        // only update scrolling value because controller is not idle
        _scrollingStateNotifier.value = scrollingValue;
        return;
      }

      // check for idle scroll controller with Future.microtask to prevent
      // this getting triggered by a new drag action while the view was
      // already in an scroll animation
      Future.microtask(() {
        final scrollingValue = position.isScrollingNotifier.value;
        if (scrollingValue) {
          // only update scrolling value because controller is not idle
          _scrollingStateNotifier.value = scrollingValue;
          return;
        }

        // ensure scroll position snaps to the nearest item after controller
        // is done scrolling
        final currentScrollPosition = position.pixels;
        final targetScrollPosition =
            SBBPickerScrollController._calculateTargetScrollPosition(
          currentScrollPosition,
        );

        // Due to the workaround in the target scroll position calculation, the
        // calculated position may be slightly inaccurate. As a result, if the
        // difference between the current and calculated positions is minor, the
        // snap to item scroll will be skipped.
        final difference = (currentScrollPosition - targetScrollPosition).abs();
        if (difference > 0.01) {
          animateToScrollOffset(
            targetScrollPosition,
            curve: Curves.easeInOut,
          ).whenComplete(() {
            // update scrolling value after animation is complete
            _scrollingStateNotifier.value = position.isScrollingNotifier.value;
          });
        } else {
          _scrollingStateNotifier.value = scrollingValue;
        }
      });
    });
  }

  static double _getItemScrollOffset(int index) {
    final targetItemScrollOffset =
        (index - _firstIndexPreItemsCount) * _defaultItemHeight;
    return _calculateTargetScrollPosition(
      targetItemScrollOffset,
    );
  }

  static double _calculateTargetScrollPosition(double scrollPosition) {
    final itemsOfBothListsVisible =
        scrollPosition < 0 && scrollPosition > -_scrollAreaHeight;
    if (itemsOfBothListsVisible) {
      // Because the heights of list items vary depending on their positions,
      // it's necessary to handle the area where items from both the positive
      // and negative lists are visible differently. This is because the
      // calculation for the target scroll position isn't accurate when both
      // lists are scrolling simultaneously. Therefore, the calculation for the
      // target scroll position must be adjusted.
      for (var i = 0; i < _visibleItemCount; i++) {
        var threshold = 0.0;
        for (var j = 0; j < i; j++) {
          threshold -= _visibleItemHeights[j];
        }
        threshold -= _visibleItemHeights[i] * 0.5;
        if (scrollPosition > threshold) {
          return threshold + _visibleItemHeights[i] * 0.5;
        }
      }
    }

    return (scrollPosition / _defaultItemHeight).round() * _defaultItemHeight;
  }
}
