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
    bool isLastElement = true,
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
    this.minimumDate,
    this.maximumDate,
    this.isLastElement = true,
    this.minuteInterval = 1,
  })  : initialDateTime = initialDateTime ?? DateTime.now(),
        assert(
          minuteInterval > 0 && 60 % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ) {
    assert(
      mode != SBBDateTimePickerMode.dateAndTime ||
          minimumDate == null ||
          !this.initialDateTime.isBefore(minimumDate!),
      'initial date is before minimum date',
    );
    assert(
      mode != SBBDateTimePickerMode.dateAndTime ||
          maximumDate == null ||
          !this.initialDateTime.isAfter(maximumDate!),
      'initial date is after maximum date',
    );
    // assert(
    //   mode != SBBDateTimePickerMode.date ||
    //       (minimumYear >= 1 && this.initialDateTime.year >= minimumYear),
    //   'initial year is not greater than minimum year, or minimum year is not positive',
    // );
    // assert(
    //   mode != SBBDateTimePickerMode.date ||
    //       maximumYear == null ||
    //       this.initialDateTime.year <= maximumYear!,
    //   'initial year is not smaller than maximum year',
    // );
    // assert(
    //   mode != SBBDateTimePickerMode.date ||
    //       minimumDate == null ||
    //       !minimumDate!.isAfter(this.initialDateTime),
    //   'initial date ${this.initialDateTime} is not greater than or equal to minimumDate $minimumDate',
    // );
    // assert(
    //   mode != SBBDateTimePickerMode.date ||
    //       maximumDate == null ||
    //       !maximumDate!.isBefore(this.initialDateTime),
    //   'initial date ${this.initialDateTime} is not less than or equal to maximumDate $maximumDate',
    // );
    // assert(
    //   this.initialDateTime.minute % minuteInterval == 0,
    //   'initial minute is not divisible by minute interval',
    // );
  }

  final String? label;
  final SBBDateTimePickerMode mode;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
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
    // return _SBBDateTimePickerState();
    return _SBBDateTimePickerDateState();
  }
}

class _SBBDateTimePickerTimeState extends State<SBBDateTimePicker> {
  late DateTime selectedDateTime;
  late SBBPickerScrollController hourController;
  late SBBPickerScrollController minuteController;

  @override
  void initState() {
    super.initState();
    hourController = SBBPickerScrollController(
      initialItem: 0,
    );
    minuteController = SBBPickerScrollController(
      initialItem: 0,
    );
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
      // controller: minuteController,
      onSelectedItemChanged: (int index) {
        // final selectedMonth = _selectedMonth(index);
        // _onDateTimeSelected(
        //   month: selectedMonth,
        // );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedMinute =
            widget.minuteInterval * index % 60; //_selectedMonth(index);
        final selectedHour =
            index % 24; //_selectedYear(yearController.selectedItem);

        var hourEnabled = true;
        // check if selected time is before min time
        final minTime = _minTime;
        if (minTime != null) {
          if (minTime.hour > selectedHour) {
            hourEnabled = false;
          }
        }
        // check if selected time is after max time
        final maxTime = _maxTime;
        if (maxTime != null) {
          if (maxTime.hour < selectedHour) {
            hourEnabled = false;
          }
        }

        final listItemLabel = selectedHour.toString().padLeft(2, '0');

        return (
          hourEnabled,
          Container(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            alignment: Alignment.centerRight,
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

  Widget _buildMinutePickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      // controller: minuteController,
      onSelectedItemChanged: (int index) {
        // final selectedMonth = _selectedMonth(index);
        // _onDateTimeSelected(
        //   month: selectedMonth,
        // );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedMinute = _selectedMinute(index);
        final selectedHour = _selectedHour(hourController.selectedItem);

        var minuteEnabled = true;
        // check if selected date is before min date
        final minTime = _minTime;
        if (minTime != null) {
          if (minTime.hour == selectedHour) {
            if (minTime.minute > selectedMinute) {
              minuteEnabled = false;
            }
          } else if (minTime.hour > selectedHour) {
            minuteEnabled = false;
          }
        }
        // // check if selected date is after max date
        // final maxDate = _maxDate;
        // if (maxDate != null) {
        //   if (maxDate.year == selectedHour) {
        //     if (maxDate.month < selectedMinute) {
        //       minuteEnabled = false;
        //     }
        //   } else if (maxDate.year < selectedHour) {
        //     minuteEnabled = false;
        //   }
        // }

        final listItemLabel = selectedMinute.toString().padLeft(2, '0');

        return (
          minuteEnabled,
          Container(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
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

  int _selectedHour(int selectedItemIndex) {
    return selectedItemIndex % 24;
  }

  int _selectedMinute(int selectedItemIndex) {
    return selectedItemIndex * widget.minuteInterval % 60;
  }

  DateTime? get _minTime {
    return widget.minimumDate?.copyWith(
      year: widget.initialDateTime.year,
      month: widget.initialDateTime.month,
      day: widget.initialDateTime.day,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  DateTime? get _maxTime {
    return widget.maximumDate?.copyWith(
      year: widget.initialDateTime.year,
      month: widget.initialDateTime.month,
      day: widget.initialDateTime.day,
      second: 59,
      millisecond: 999,
      microsecond: 999,
    );
  }
}

class _SBBDateTimePickerDateState extends State<SBBDateTimePicker> {
  late int _startYear;
  late DateTime selectedDateTime;
  late SBBPickerScrollController dayController;
  late SBBPickerScrollController monthController;
  late SBBPickerScrollController yearController;

  @override
  void initState() {
    super.initState();
    final startDate = DateTime.now();
    _startYear = startDate.year;
    selectedDateTime = (widget.initialDateTime ?? startDate).copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    final initialDayIndex = selectedDateTime.day - 1;
    dayController = SBBPickerScrollController(
      initialItem: initialDayIndex,
    );
    dayController._scrollingStateNotifier.addListener(() {
      _onControllerIdle(dayController);
    });

    final initialMonthIndex = selectedDateTime.month - 1;
    monthController = SBBPickerScrollController(
      initialItem: initialMonthIndex,
    );
    monthController._scrollingStateNotifier.addListener(() {
      _onControllerIdle(monthController);
    });

    final initialYearIndex = selectedDateTime.year - _startYear;
    yearController = SBBPickerScrollController(
      initialItem: initialYearIndex,
    );
    yearController._scrollingStateNotifier.addListener(() {
      _onControllerIdle(yearController);
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
            // TODO check bigger fonts
            // TODO evaluate more generic approach than hardcoded numbers
            width: 40.0 + 24.0 + 12.0,
            child: _buildDayPickerScrollView(context),
          ),
          Expanded(
            child: _buildMonthPickerScrollView(context),
          ),
          Container(
            width: 64.0 + 12.0 + 24.0,
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
        final selectedDay = _selectedDay(index);
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
        final monthDay = _selectedDay(index);
        final monthDayIndex = monthDay - 1;
        var dayEnabled = monthDayIndex < monthDaysCount;

        // check if date is before minimum date
        final minDate = _minDate;
        if (dayEnabled && minDate != null) {
          dayEnabled &= !minDate.isAfter(
            selectedDateTime.copyWith(
              day: monthDay,
            ),
          );
        }
        // check if date is after maximum date
        final maxDate = _maxDate;
        if (dayEnabled && maxDate != null) {
          dayEnabled &= !maxDate.isBefore(
            selectedDateTime.copyWith(
              day: monthDay,
            ),
          );
        }
        final listItemLabel = '$monthDay.';
        return (
          dayEnabled,
          Container(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 12.0,
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
    return SBBPickerScrollView(
      controller: monthController,
      onSelectedItemChanged: (int index) {
        final selectedMonth = _selectedMonth(index);
        _onDateTimeSelected(
          month: selectedMonth,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final cupertinoLocalizations = Localizations.of(
          context,
          CupertinoLocalizations,
        );
        final selectedMonth = _selectedMonth(index);
        final selectedYear = _selectedYear(yearController.selectedItem);

        var monthEnabled = true;
        // check if selected date is before min date
        final minDate = _minDate;
        if (minDate != null) {
          if (minDate.year == selectedYear) {
            if (minDate.month > selectedMonth) {
              monthEnabled = false;
            }
          } else if (minDate.year > selectedYear) {
            monthEnabled = false;
          }
        }
        // check if selected date is after max date
        final maxDate = _maxDate;
        if (maxDate != null) {
          if (maxDate.year == selectedYear) {
            if (maxDate.month < selectedMonth) {
              monthEnabled = false;
            }
          } else if (maxDate.year < selectedYear) {
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
              left: 12.0,
              right: 12.0,
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
      onSelectedItemChanged: (int index) {
        final selectedYear = _selectedYear(index);
        _onDateTimeSelected(
          year: selectedYear,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final selectedYear = _selectedYear(index);

        var yearEnabled = true;
        // check if selected date is before min date
        final minDate = _minDate;
        if (minDate != null) {
          if (minDate.year > selectedYear) {
            yearEnabled = false;
          }
        }
        // check if selected date is after max date
        final maxDate = _maxDate;
        if (maxDate != null) {
          if (maxDate.year < selectedYear) {
            yearEnabled = false;
          }
        }

        final listItemLabel = _selectedYear(index).toString();
        return (
          yearEnabled,
          Container(
            margin: EdgeInsets.only(
              left: 12.0,
              right: 24.0,
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

  void _onControllerIdle(SBBPickerScrollController controller) {
    if (controller._scrollingStateNotifier.value) {
      // do nothing if controller still scrolling
      return;
    }

    // check if selected date is before min date
    final minDate = _minDate;
    if (minDate != null && minDate.isAfter(selectedDateTime)) {
      // change selected date to min date
      final correctedYearIndex = minDate.year - _startYear;
      final correctedMonthIndex = minDate.month - 1;
      final correctedDayIndex = minDate.day - 1;
      yearController.animateToItem(correctedYearIndex);
      monthController.animateToItem(correctedMonthIndex);
      dayController.animateToItem(correctedDayIndex);
      debugPrint(
          'correct to min date: $correctedDayIndex $correctedMonthIndex $correctedYearIndex');
      return;
    }

    // check if selected date is after max date
    final maxDate = _maxDate;
    if (maxDate != null && maxDate.isBefore(selectedDateTime)) {
      // change selected date to max date
      final correctedYearIndex = maxDate.year - _startYear;
      final correctedMonthIndex = maxDate.month - 1;
      final correctedDayIndex = maxDate.day - 1;
      yearController.animateToItem(correctedYearIndex);
      monthController.animateToItem(correctedMonthIndex);
      dayController.animateToItem(correctedDayIndex);
      return;
    }

    // check if selected day value is higher than valid for current month
    final selectedDay = _selectedDay(dayController.selectedItem);
    final selectedMonthDaysCount = _monthDaysCount(
      selectedDateTime.year,
      selectedDateTime.month,
    );
    final monthDayIndex = selectedDay - 1;
    if (monthDayIndex >= selectedMonthDaysCount) {
      // correction to max day value in current month
      final difference = selectedDay - selectedMonthDaysCount;
      final correctedDayIndex = dayController.selectedItem - difference;
      dayController.animateToItem(correctedDayIndex);
      debugPrint(
          'correct to valid date: $correctedDayIndex ${selectedDateTime.toIso8601String()}');
      return;
    }
  }

  int _selectedDay(int selectedItemIndex) {
    return selectedItemIndex % 31 + 1;
  }

  int _selectedMonth(int selectedItemIndex) {
    return selectedItemIndex % 12 + 1;
  }

  int _selectedYear(int selectedItemIndex) {
    return _startYear + selectedItemIndex;
  }

  DateTime? get _minDate {
    return widget.minimumDate?.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  DateTime? get _maxDate {
    return widget.maximumDate?.copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
      microsecond: 999,
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
    var selectedDay = day ?? selectedDateTime.day;
    final selectedHour = hour ?? selectedDateTime.hour;
    final selectedMinute = minute ?? selectedDateTime.minute;
    var notifyCallback = true;

    if (widget.mode == SBBDateTimePickerMode.date) {
      // final isDayChanging = day != null;
      final isMonthChanging = month != null;
      final isYearChanging = year != null;

      final currentMonthDays = _monthDaysCount(
        isYearChanging ? selectedYear : selectedDateTime.year,
        isMonthChanging ? selectedMonth : selectedDateTime.month,
      );
      if (selectedDay > currentMonthDays) {
        notifyCallback = false;
        selectedDay = currentMonthDays;
      }

      // final isMonthOrYearChanging = day == null;
      // if (isMonthOrYearChanging) {
      //   final isDayControllerIdle =
      //       !dayController.position.isScrollingNotifier.value;
      //   final isMonthControllerIdle =
      //       !monthController.position.isScrollingNotifier.value;
      //   final isYearControllerIdle =
      //       !yearController.position.isScrollingNotifier.value;
      //   if (isDayControllerIdle &&
      //       isMonthControllerIdle &&
      //       isYearControllerIdle) {
      //     final prevMonthDays = _monthDaysCount(
      //       selectedDateTime.year,
      //       selectedDateTime.month,
      //     );
      //     if (dayController.selectedItem < 0) {
      //       notifyCallback = false;
      //     } else if (dayController.selectedItem > prevMonthDays - 1) {
      //       notifyCallback = false;
      //     }
      //
      //     final monthDays = _monthDaysCount(
      //       selectedYear,
      //       selectedMonth,
      //     );
      //     final dayValueOverflow = selectedDay > monthDays;
      //
      //     if (dayValueOverflow) {
      //       selectedDay = monthDays;
      //       notifyCallback = false;
      //     }
      //   }
      // }
    }

    _onDateTimeChanged(
      selectedYear,
      selectedMonth,
      selectedDay,
      selectedHour,
      selectedMinute,
      notifyCallback,
    );
  }

  void _onDateTimeChanged(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    bool notifyCallback,
  ) {
    setState(() {
      selectedDateTime = DateTime(
        year,
        month,
        day,
        hour,
        minute,
      );
    });
    if (notifyCallback) {
      widget.onDateTimeChanged(selectedDateTime);
    }
  }

  int _monthDaysCount(int year, int month) {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }
}

// class _SBBDateTimePickerState extends State<SBBDateTimePicker> {
//   final pickerItemTextColorDisabledLight = SBBColors.storm;
//   final pickerItemTextColorDisabledDark = SBBColors.metal;
//   final maxDaysInMonth = 31;
//
//   final startDateTime = DateTime.now();
//   late DateTime selectedDateTime = widget.initialDateTime ?? startDateTime;
//   late int initialHourIndex = selectedDateTime.hour;
//   late int initialMinuteIndex =
//       (selectedDateTime.minute / widget.minuteInterval).ceil();
//
//   late int initialDayIndex = selectedDateTime.day - 1;
//   late int initialMonthIndex = selectedDateTime.month - 1;
//   late int initialYearIndex = selectedDateTime.year - startDateTime.year;
//
//   late SBBPickerScrollController dayController = SBBPickerScrollController(
//     initialItem: initialDayIndex,
//   );
//   late SBBPickerScrollController monthController = SBBPickerScrollController(
//     initialItem: initialMonthIndex,
//   );
//   late SBBPickerScrollController yearController = SBBPickerScrollController(
//     initialItem: initialYearIndex,
//   );
//
//   var dayScrollingNotifierListenerRegistered = false;
//   var monthScrollingNotifierListenerRegistered = false;
//   var yearScrollingNotifierListenerRegistered = false;
//
//   @override
//   void initState() {
//     selectedDateTime = selectedDateTime.copyWith(
//       minute: _minuteByIndex(initialMinuteIndex),
//     );
//
//     if (widget.mode == SBBDateTimePickerMode.date) {
//       dayController.addListener(() {
//         if (!dayScrollingNotifierListenerRegistered) {
//           dayScrollingNotifierListenerRegistered = true;
//           dayController.position.isScrollingNotifier.addListener(
//             () {
//               final controllerIdle =
//                   !dayController.position.isScrollingNotifier.value;
//               if (controllerIdle) {
//                 final currentMonthDays = _monthDaysCount(
//                   selectedDateTime.year,
//                   selectedDateTime.month,
//                 );
//                 final selectedDay =
//                     dayController.selectedItem % maxDaysInMonth + 1;
//                 final overflowedDaysCount = selectedDay - currentMonthDays;
//                 if (selectedDay > currentMonthDays) {
//                   dayController.animateToItem(
//                     dayController.selectedItem - overflowedDaysCount,
//                   );
//                   debugPrint(
//                       'IDLE ${dayController.selectedItem} $overflowedDaysCount');
//                 }
//               }
//             },
//           );
//         }
//       });
//       monthController.addListener(() {
//         if (!monthScrollingNotifierListenerRegistered) {
//           monthScrollingNotifierListenerRegistered = true;
//           monthController.position.isScrollingNotifier.addListener(
//             () {
//               final controllerIdle =
//                   !monthController.position.isScrollingNotifier.value;
//               if (controllerIdle) {
//                 final selectedMonth = monthController.selectedItem + 1;
//                 final currentMonthDays = _monthDaysCount(
//                   selectedDateTime.year,
//                   selectedMonth,
//                 );
//
//                 final selectedDay =
//                     dayController.selectedItem % maxDaysInMonth + 1;
//                 final overflowedDaysCount = selectedDay - currentMonthDays;
//                 if (selectedDay > currentMonthDays) {
//                   debugPrint('DEBUG month scrolling: ${currentMonthDays}');
//                   dayController.animateToItem(
//                     dayController.selectedItem - overflowedDaysCount,
//                   );
//                   debugPrint(
//                       'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
//                 }
//               }
//             },
//           );
//         }
//       });
//       yearController.addListener(() {
//         if (!yearScrollingNotifierListenerRegistered) {
//           yearScrollingNotifierListenerRegistered = true;
//           yearController.position.isScrollingNotifier.addListener(
//             () {
//               final controllerIdle =
//                   !yearController.position.isScrollingNotifier.value;
//               if (controllerIdle) {
//                 final selectedYear =
//                     yearController.selectedItem + startDateTime.year;
//                 final currentMonthDays = _monthDaysCount(
//                   selectedYear,
//                   selectedDateTime.month,
//                 );
//
//                 final selectedDay =
//                     dayController.selectedItem % maxDaysInMonth + 1;
//                 final overflowedDaysCount = selectedDay - currentMonthDays;
//                 if (selectedDay > currentMonthDays) {
//                   debugPrint('DEBUG month scrolling: ${currentMonthDays}');
//                   dayController.animateToItem(
//                     dayController.selectedItem - overflowedDaysCount,
//                   );
//                   debugPrint(
//                       'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
//                 }
//               }
//             },
//           );
//         }
//       });
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     assert(
//       widget.minuteInterval > 0 && 60 % widget.minuteInterval == 0,
//       'minute interval is not a positive integer factor of 60',
//     );
//
//     return SBBPicker.custom(
//       label: widget.label,
//       isLastElement: widget.isLastElement,
//       child: widget.mode == SBBDateTimePickerMode.time
//           ? _timeBody(context)
//           : widget.mode == SBBDateTimePickerMode.date
//               ? _dateBody(context)
//               : _dateAndTimeBody(context),
//     );
//   }
//
//   Widget _timeBody(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: SBBPickerScrollView(
//             initialSelectedIndex: initialHourIndex,
//             onSelectedItemChanged: (int index) {
//               final selectedHour = index % 24;
//               _onDateTimeSelected(
//                 hour: selectedHour,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return (
//                 true,
//                 Row(
//                   children: [
//                     const Spacer(),
//                     Container(
//                       width: 48.0,
//                       alignment: Alignment.center,
//                       child: Text(
//                         (index % 24).toString().padLeft(2, '0'),
//                         textAlign: TextAlign.right,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: false,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 12.0,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: SBBPickerScrollView(
//             initialSelectedIndex: initialMinuteIndex,
//             onSelectedItemChanged: (int index) {
//               final selectedMinute = _minuteByIndex(index);
//               _onDateTimeSelected(
//                 minute: selectedMinute,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return (
//                 true,
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 12.0,
//                     ),
//                     Container(
//                       width: 48.0,
//                       alignment: Alignment.center,
//                       child: Text(
//                         _minuteByIndex(index).toString().padLeft(2, '0'),
//                         textAlign: TextAlign.left,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: false,
//                       ),
//                     ),
//                     const Spacer(),
//                   ],
//                 )
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   bool _isDateValid(int year, int month, int day) {
//     final monthDaysCount = _monthDaysCount(
//       selectedDateTime.year,
//       selectedDateTime.month,
//     );
//     final dayInMonthIndex = (day - 1) % maxDaysInMonth;
//     final monthDay = dayInMonthIndex + 1;
//     if (dayInMonthIndex >= monthDaysCount) {
//       // day out of month days bounds
//       return false;
//     }
//     // check if date is before minimum date
//     final dateToValidate = DateTime(year, month, day);
//     final minDate = widget.minimumDate?.copyWith(
//         hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
//     if (minDate != null) {
//       if (dateToValidate.isBefore(minDate)) {
//         // date before min date
//         return false;
//       }
//     }
//     final maxDate = widget.maximumDate?.copyWith(
//         hour: 23, minute: 59, second: 59, millisecond: 999, microsecond: 999);
//     if (minDate != null) {
//       if (dateToValidate.isBefore(minDate)) {
//         // date before min date
//         return false;
//       }
//     }
//     return true;
//   }
//
//   Widget _dateBody(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 40.0 + 24.0 + 12.0,
//           child: SBBPickerScrollView(
//             controller: dayController,
//             onSelectedItemChanged: (int index) {
//               final selectedDay = index % maxDaysInMonth + 1;
//               _onDateTimeSelected(
//                 day: selectedDay,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               // check if day is within month days constraints
//               final monthDaysCount = _monthDaysCount(
//                 selectedDateTime.year,
//                 selectedDateTime.month,
//               );
//               final dayInMonthIndex = index % maxDaysInMonth;
//               final monthDay = dayInMonthIndex + 1;
//               var dayEnabled = dayInMonthIndex < monthDaysCount;
//               // check if date is before minimum date
//               final minDate = widget.minimumDate;
//               if (dayEnabled && minDate != null) {
//                 dayEnabled &=
//                     minDate.isBefore(selectedDateTime.copyWith(day: monthDay));
//               }
//               return (
//                 dayEnabled,
//                 Container(
//                   margin: EdgeInsets.only(
//                     left: 24.0,
//                     right: 12.0,
//                   ),
//                   child: Text(
//                     '$monthDay.',
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: SBBPickerScrollView(
//             controller: monthController,
//             onSelectedItemChanged: (int index) {
//               final selectedMonth = index % 12 + 1;
//               _onDateTimeSelected(
//                 month: selectedMonth,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final cupertinoLocalizations = Localizations.of(
//                 context,
//                 CupertinoLocalizations,
//               );
//               return (
//                 true,
//                 Container(
//                   padding: EdgeInsets.only(
//                     left: 12.0,
//                     right: 12.0,
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     cupertinoLocalizations.datePickerMonth(index % 12 + 1),
//                     textAlign: TextAlign.left,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           width: 64.0 + 12.0 + 24.0,
//           child: SBBPickerScrollView(
//             controller: yearController,
//             onSelectedItemChanged: (int index) {
//               final selectedYear = startDateTime.year + index;
//               _onDateTimeSelected(
//                 year: selectedYear,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return (
//                 true,
//                 Container(
//                   margin: EdgeInsets.only(
//                     left: 12.0,
//                     right: 24.0,
//                   ),
//                   child: Text(
//                     (startDateTime.year + index).toString(),
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _dateAndTimeBody(BuildContext context) {
//     final cupertinoLocalizations = Localizations.of(
//       context,
//       CupertinoLocalizations,
//     );
//     return Row(
//       children: [
//         Expanded(
//           child: SBBPickerScrollView(
//             onSelectedItemChanged: (int index) {
//               final selectedDate = startDateTime.add(
//                 Duration(days: index),
//               );
//               _onDateTimeSelected(
//                 year: selectedDate.year,
//                 month: selectedDate.month,
//                 day: selectedDate.day,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final dateTime = startDateTime.add(
//                 Duration(days: index),
//               );
//               final isToday = dateTime.year == startDateTime.year &&
//                   dateTime.month == startDateTime.month &&
//                   dateTime.day == startDateTime.day;
//               return (
//                 true,
//                 Container(
//                   padding: EdgeInsets.only(
//                     left: 24.0,
//                     right: 12.0,
//                   ),
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     isToday
//                         ? cupertinoLocalizations.todayLabel
//                         : cupertinoLocalizations.datePickerMediumDate(
//                             dateTime,
//                           ),
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           width: 48.0 + 12.0 + 12.0,
//           child: SBBPickerScrollView(
//             initialSelectedIndex: initialHourIndex,
//             onSelectedItemChanged: (int index) {
//               final selectedHour = index % 24;
//               _onDateTimeSelected(
//                 hour: selectedHour,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return (
//                 true,
//                 Container(
//                   padding: EdgeInsets.only(
//                     left: 12.0,
//                     right: 12.0,
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     (index % 24).toString().padLeft(2, '0'),
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           width: 48.0 + 12.0 + 24.0,
//           child: SBBPickerScrollView(
//             initialSelectedIndex: initialMinuteIndex,
//             onSelectedItemChanged: (int index) {
//               final selectedMinute = _minuteByIndex(index);
//               _onDateTimeSelected(
//                 minute: selectedMinute,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return (
//                 true,
//                 Container(
//                   padding: EdgeInsets.only(
//                     left: 12.0,
//                     right: 24.0,
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     _minuteByIndex(index).toString().padLeft(2, '0'),
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _onDateTimeSelected({
//     int? year,
//     int? month,
//     int? day,
//     int? hour,
//     int? minute,
//   }) {
//     final selectedYear = year ?? selectedDateTime.year;
//     final selectedMonth = month ?? selectedDateTime.month;
//     var selectedDay = day ?? selectedDateTime.day;
//     final selectedHour = hour ?? selectedDateTime.hour;
//     final selectedMinute = minute ?? selectedDateTime.minute;
//     var notifyCallback = true;
//
//     if (widget.mode == SBBDateTimePickerMode.date) {
//       final isDayChanging = day != null;
//       final isMonthChanging = month != null;
//       final isYearChanging = year != null;
//
//       final currentMonthDays = _monthDaysCount(
//         isYearChanging ? selectedYear : selectedDateTime.year,
//         isMonthChanging ? selectedMonth : selectedDateTime.month,
//       );
//       if (selectedDay > currentMonthDays) {
//         notifyCallback = false;
//         selectedDay = currentMonthDays;
//       }
//       // if (isDayChanging) {
//       //   // dayController.position.isScrollingNotifier.addListener(() {
//       //   //   debugPrint(
//       //   //       'addPostFrameCallback:\n${dayController}\n${dayController.position}\n${dayController.position.isScrollingNotifier}');
//       //   // });
//       //   final currentMonthDays = _monthDaysCount(
//       //     selectedDateTime.year,
//       //     selectedDateTime.month,
//       //   );
//       //   if (selectedDay > currentMonthDays) {
//       //     notifyCallback = false;
//       //     selectedDay = currentMonthDays;
//       //     // _computeWhenTrue(
//       //     //   () => !dayController.position.isScrollingNotifier.value,
//       //     //   () => dayController.animateToItem(
//       //     //     selectedDay - 1,
//       //     //     duration: kThemeAnimationDuration,
//       //     //     curve: Curves.fastOutSlowIn,
//       //     //   ),
//       //     // );
//       //     // dayController.animateToItem(
//       //     //   selectedDay - 1,
//       //     //   duration: kThemeAnimationDuration,
//       //     //   curve: Curves.fastOutSlowIn,
//       //     // );
//       //   }
//       // }
//
//       final isMonthOrYearChanging = day == null;
//       if (isMonthOrYearChanging) {
//         final isDayControllerIdle =
//             !dayController.position.isScrollingNotifier.value;
//         final isMonthControllerIdle =
//             !monthController.position.isScrollingNotifier.value;
//         final isYearControllerIdle =
//             !yearController.position.isScrollingNotifier.value;
//         debugPrint(
//             '$selectedDay.$selectedMonth.$selectedYear : ${dayController.position.isScrollingNotifier.value}');
//         if (isDayControllerIdle &&
//             isMonthControllerIdle &&
//             isYearControllerIdle) {
//           final prevMonthDays = _monthDaysCount(
//             selectedDateTime.year,
//             selectedDateTime.month,
//           );
//           if (dayController.selectedItem < 0) {
//             notifyCallback = false;
//             while (dayController.selectedItem < 0) {
//               // dayController.jumpToItem(
//               //   dayController.selectedItem + prevMonthDays,
//               // );
//             }
//           } else if (dayController.selectedItem > prevMonthDays - 1) {
//             notifyCallback = false;
//             while (dayController.selectedItem > prevMonthDays - 1) {
//               // dayController.jumpToItem(
//               //   dayController.selectedItem - prevMonthDays,
//               // );
//             }
//           }
//
//           final monthDays = _monthDaysCount(
//             selectedYear,
//             selectedMonth,
//           );
//           final dayValueOverflow = selectedDay > monthDays;
//
//           if (dayValueOverflow) {
//             // TODO add scrollcontroller for motnh and year and check those => check with cupertino
//             debugPrint(
//                 'OVERFLOW $selectedDay.$selectedMonth.$selectedYear : ${dayController.positions.length} ${dayController.position.isScrollingNotifier.value}');
//
//             selectedDay = monthDays;
//             notifyCallback = false;
//             // TODO prevent jumpToItem while animating
//             // dayController.animateToItem(
//             //   selectedDay - 1,
//             //   duration: kThemeAnimationDuration,
//             //   curve: Curves.fastOutSlowIn,
//             // );
//           }
//         }
//       }
//     }
//
//     _onDateTimeChanged(
//       selectedYear,
//       selectedMonth,
//       selectedDay,
//       selectedHour,
//       selectedMinute,
//       notifyCallback,
//     );
//   }
//
//   void _onDateTimeChanged(
//     int year,
//     int month,
//     int day,
//     int hour,
//     int minute,
//     bool notifyCallback,
//   ) {
//     setState(() {
//       selectedDateTime = DateTime(
//         year,
//         month,
//         day,
//         hour,
//         minute,
//       );
//     });
//     if (notifyCallback) {
//       widget.onDateTimeChanged(selectedDateTime);
//     }
//   }
//
//   int _minuteByIndex(int minuteIndex) {
//     return minuteIndex * widget.minuteInterval % 60;
//   }
//
//   int _monthDaysCount(int year, int month) {
//     return DateTime(
//       year,
//       month + 1,
//       0,
//     ).day;
//   }
// }

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
  // final _listCenterKey = UniqueKey();
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
    // _controller._scrollingStateNotifier.addListener(() {
    //   if (_controller._scrollingStateNotifier.value) {
    //     // do nothing because controller is not idle
    //     return;
    //   }
    //   Future.microtask(() {
    //     // check for idle scroll controller with Future.microtask to prevent
    //     // this getting triggered by a new drag action while the view was
    //     // already in an scroll animation
    //     if (!_controller._scrollingStateNotifier.value) {
    //       // ensure scroll position snaps to the nearest item after controller
    //       // is done scrolling
    //       final currentScrollPosition = _controller.position.pixels;
    //       final targetScrollPosition =
    //           SBBPickerScrollController._calculateTargetScrollPosition(
    //         currentScrollPosition,
    //       );
    //
    //       // Due to the workaround in the target scroll position calculation, the
    //       // calculated position may be slightly inaccurate. As a result, if the
    //       // difference between the current and calculated positions is minor, the
    //       // snap to item scroll will be skipped.
    //       final difference =
    //           (currentScrollPosition - targetScrollPosition).abs();
    //       if (difference > 0.01) {
    //         _controller.animateToScrollOffset(
    //           targetScrollPosition,
    //           curve: Curves.easeInOut,
    //         );
    //       }
    //     }
    //   });
    // });
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

/// Scroll physics used by a [SBBPickerScrollView].
///
/// These physics cause the SBB picker scroll view to snap to items.
class _SBBPickerScrollPhysics extends ScrollPhysics {
  const _SBBPickerScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  _SBBPickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SBBPickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (velocity == 0.0) {
      final scrollPosition = position.pixels;
      final target = _calculateTargetScrollPosition(scrollPosition);
      if (target != scrollPosition) {
        debugPrint('DEBUG2 ===== ScrollSpringSimulation');
        return ScrollSpringSimulation(
          spring,
          scrollPosition,
          target,
          velocity,
          tolerance: toleranceFor(position),
        );
      }
    }

    debugPrint('DEBUG2 ===== createBallisticSimulation');
    return parent!.createBallisticSimulation(position, velocity);
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

  @override
  bool get allowImplicitScrolling => false;
}
