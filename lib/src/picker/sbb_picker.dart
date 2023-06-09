import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';

typedef SBBPickerScrollViewItemBuilder = (bool isEnabled, Widget? widget)
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
  }) : this._(
          key: key,
          label: label,
          child: SBBPickerScrollView(
            initialSelectedIndex: initialSelectedIndex,
            onSelectedItemChanged: onSelectedItemChanged,
            itemBuilder: itemBuilder,
            looping: looping,
          ),
          looping: looping,
          isLastElement: isLastElement,
        );

  const SBBPicker._({
    super.key,
    this.label,
    required this.child,
    this.looping = true,
    this.isLastElement = true,
  });

  final String? label;
  final Widget child;
  final bool looping;
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
  const SBBDateTimePicker({
    super.key,
    this.label,
    this.mode = SBBDateTimePickerMode.dateAndTime,
    required this.onDateTimeChanged,
    this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.isLastElement = true,
    this.minuteInterval = 1,
  });

  final String? label;
  final SBBDateTimePickerMode mode;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final int minuteInterval;
  final bool isLastElement;

  @override
  State<SBBDateTimePicker> createState() {
    if (mode == SBBDateTimePickerMode.date) {
      return _SBBDateTimePickerDateState();
    }
    return _SBBDateTimePickerState();
  }
}

class _SBBDateTimePickerDateState extends State<SBBDateTimePicker> {
  final maxDaysInMonth = 31;

  final startDateTime = DateTime.now();
  late DateTime selectedDateTime = widget.initialDateTime ?? startDateTime;
  late int initialHourIndex = selectedDateTime.hour;
  late int initialMinuteIndex =
      (selectedDateTime.minute / widget.minuteInterval).ceil();

  late int initialDayIndex = selectedDateTime.day - 1;
  late int initialMonthIndex = selectedDateTime.month - 1;
  late int initialYearIndex = selectedDateTime.year - startDateTime.year;

  late SBBPickerScrollController dayController = SBBPickerScrollController(
    initialItem: initialDayIndex,
  );
  late SBBPickerScrollController monthController = SBBPickerScrollController(
    initialItem: initialMonthIndex,
  );
  late SBBPickerScrollController yearController = SBBPickerScrollController(
    initialItem: initialYearIndex,
  );

  var dayScrollingNotifierListenerRegistered = false;
  var monthScrollingNotifierListenerRegistered = false;
  var yearScrollingNotifierListenerRegistered = false;

  @override
  void initState() {
    selectedDateTime = selectedDateTime.copyWith(
      minute: _minuteByIndex(initialMinuteIndex),
    );

    if (widget.mode == SBBDateTimePickerMode.date) {
      dayController.addListener(() {
        if (!dayScrollingNotifierListenerRegistered) {
          dayScrollingNotifierListenerRegistered = true;
          dayController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !dayController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final currentMonthDays = _monthDaysCount(
                  selectedDateTime.year,
                  selectedDateTime.month,
                );
                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                }
              }
            },
          );
        }
      });
      monthController.addListener(() {
        if (!monthScrollingNotifierListenerRegistered) {
          monthScrollingNotifierListenerRegistered = true;
          monthController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !monthController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final selectedMonth = monthController.selectedItem + 1;
                final currentMonthDays = _monthDaysCount(
                  selectedDateTime.year,
                  selectedMonth,
                );

                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  debugPrint('DEBUG month scrolling: ${currentMonthDays}');
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                  debugPrint(
                      'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
                }
              }
            },
          );
        }
      });
      yearController.addListener(() {
        if (!yearScrollingNotifierListenerRegistered) {
          yearScrollingNotifierListenerRegistered = true;
          yearController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !yearController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final selectedYear =
                    yearController.selectedItem + startDateTime.year;
                final currentMonthDays = _monthDaysCount(
                  selectedYear,
                  selectedDateTime.month,
                );

                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  debugPrint('DEBUG month scrolling: ${currentMonthDays}');
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                  debugPrint(
                      'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
                }
              }
            },
          );
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.minuteInterval > 0 && 60 % widget.minuteInterval == 0,
      'minute interval is not a positive integer factor of 60',
    );

    return SBBPicker._(
      label: widget.label,
      isLastElement: widget.isLastElement,
      child: _dateBody(context),
    );
  }

  bool _isDateValid(int year, int month, int day) {
    final monthDaysCount = _monthDaysCount(
      selectedDateTime.year,
      selectedDateTime.month,
    );
    final dayInMonthIndex = (day - 1) % maxDaysInMonth;
    final monthDay = dayInMonthIndex + 1;
    if (dayInMonthIndex >= monthDaysCount) {
      // day out of month days bounds
      return false;
    }
    // check if date is before minimum date
    final dateToValidate = DateTime(year, month, day);
    final minDate = widget.minimumDate?.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    if (minDate != null) {
      if (dateToValidate.isBefore(minDate)) {
        // date before min date
        return false;
      }
    }
    final maxDate = widget.maximumDate?.copyWith(
        hour: 23, minute: 59, second: 59, millisecond: 999, microsecond: 999);
    if (minDate != null) {
      if (dateToValidate.isBefore(minDate)) {
        // date before min date
        return false;
      }
    }
    return true;
  }

  // bool get _isCurrentDateValid {
  //   // The current date selection represents a range [minSelectedData, maxSelectDate].
  //   final DateTime minSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
  //   final DateTime maxSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay + 1);
  //
  //   final bool minCheck = widget.minimumDate?.isBefore(maxSelectedDate) ?? true;
  //   final bool maxCheck = widget.maximumDate?.isBefore(minSelectedDate) ?? false;
  //
  //   return minCheck && !maxCheck && minSelectedDate.day == selectedDay;
  // }

  Widget _dateBody(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.0 + 24.0 + 12.0,
          child: SBBPickerScrollView(
            controller: dayController,
            onSelectedItemChanged: (int index) {
              final selectedDay = index % maxDaysInMonth + 1;
              _onDateTimeSelected(
                day: selectedDay,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              // check if day is within month days constraints
              final monthDaysCount = _monthDaysCount(
                selectedDateTime.year,
                selectedDateTime.month,
              );
              final dayInMonthIndex = index % maxDaysInMonth;
              final monthDay = dayInMonthIndex + 1;
              var dayEnabled = dayInMonthIndex < monthDaysCount;
              // check if date is before minimum date
              final minDate = widget.minimumDate;
              if (dayEnabled && minDate != null) {
                dayEnabled &=
                    minDate.isBefore(selectedDateTime.copyWith(day: monthDay));
              }
              return (
                dayEnabled,
                Container(
                  margin: EdgeInsets.only(
                    left: 24.0,
                    right: 12.0,
                  ),
                  child: Text(
                    '$monthDay.',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: SBBPickerScrollView(
            controller: monthController,
            onSelectedItemChanged: (int index) {
              final selectedMonth = index % 12 + 1;
              _onDateTimeSelected(
                month: selectedMonth,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final cupertinoLocalizations = Localizations.of(
                context,
                CupertinoLocalizations,
              );
              return (
                true,
                Container(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cupertinoLocalizations.datePickerMonth(index % 12 + 1),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 64.0 + 12.0 + 24.0,
          child: SBBPickerScrollView(
            controller: yearController,
            onSelectedItemChanged: (int index) {
              final selectedYear = startDateTime.year + index;
              _onDateTimeSelected(
                year: selectedYear,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Container(
                  margin: EdgeInsets.only(
                    left: 12.0,
                    right: 24.0,
                  ),
                  child: Text(
                    (startDateTime.year + index).toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      final isDayChanging = day != null;
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
      // if (isDayChanging) {
      //   // dayController.position.isScrollingNotifier.addListener(() {
      //   //   debugPrint(
      //   //       'addPostFrameCallback:\n${dayController}\n${dayController.position}\n${dayController.position.isScrollingNotifier}');
      //   // });
      //   final currentMonthDays = _monthDaysCount(
      //     selectedDateTime.year,
      //     selectedDateTime.month,
      //   );
      //   if (selectedDay > currentMonthDays) {
      //     notifyCallback = false;
      //     selectedDay = currentMonthDays;
      //     // _computeWhenTrue(
      //     //   () => !dayController.position.isScrollingNotifier.value,
      //     //   () => dayController.animateToItem(
      //     //     selectedDay - 1,
      //     //     duration: kThemeAnimationDuration,
      //     //     curve: Curves.fastOutSlowIn,
      //     //   ),
      //     // );
      //     // dayController.animateToItem(
      //     //   selectedDay - 1,
      //     //   duration: kThemeAnimationDuration,
      //     //   curve: Curves.fastOutSlowIn,
      //     // );
      //   }
      // }

      final isMonthOrYearChanging = day == null;
      if (isMonthOrYearChanging) {
        final isDayControllerIdle =
            !dayController.position.isScrollingNotifier.value;
        final isMonthControllerIdle =
            !monthController.position.isScrollingNotifier.value;
        final isYearControllerIdle =
            !yearController.position.isScrollingNotifier.value;
        debugPrint(
            '$selectedDay.$selectedMonth.$selectedYear : ${dayController.position.isScrollingNotifier.value}');
        if (isDayControllerIdle &&
            isMonthControllerIdle &&
            isYearControllerIdle) {
          final prevMonthDays = _monthDaysCount(
            selectedDateTime.year,
            selectedDateTime.month,
          );
          if (dayController.selectedItem < 0) {
            notifyCallback = false;
            while (dayController.selectedItem < 0) {
              // dayController.jumpToItem(
              //   dayController.selectedItem + prevMonthDays,
              // );
            }
          } else if (dayController.selectedItem > prevMonthDays - 1) {
            notifyCallback = false;
            while (dayController.selectedItem > prevMonthDays - 1) {
              // dayController.jumpToItem(
              //   dayController.selectedItem - prevMonthDays,
              // );
            }
          }

          final monthDays = _monthDaysCount(
            selectedYear,
            selectedMonth,
          );
          final dayValueOverflow = selectedDay > monthDays;

          if (dayValueOverflow) {
            // TODO add scrollcontroller for motnh and year and check those => check with cupertino
            debugPrint(
                'OVERFLOW $selectedDay.$selectedMonth.$selectedYear : ${dayController.positions.length} ${dayController.position.isScrollingNotifier.value}');

            selectedDay = monthDays;
            notifyCallback = false;
            // TODO prevent jumpToItem while animating
            // dayController.animateToItem(
            //   selectedDay - 1,
            //   duration: kThemeAnimationDuration,
            //   curve: Curves.fastOutSlowIn,
            // );
          }
        }
      }
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

  int _minuteByIndex(int minuteIndex) {
    return minuteIndex * widget.minuteInterval % 60;
  }

  int _monthDaysCount(int year, int month) {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }
}

class _SBBDateTimePickerState extends State<SBBDateTimePicker> {
  final pickerItemTextColorDisabledLight = SBBColors.storm;
  final pickerItemTextColorDisabledDark = SBBColors.metal;
  final maxDaysInMonth = 31;

  final startDateTime = DateTime.now();
  late DateTime selectedDateTime = widget.initialDateTime ?? startDateTime;
  late int initialHourIndex = selectedDateTime.hour;
  late int initialMinuteIndex =
      (selectedDateTime.minute / widget.minuteInterval).ceil();

  late int initialDayIndex = selectedDateTime.day - 1;
  late int initialMonthIndex = selectedDateTime.month - 1;
  late int initialYearIndex = selectedDateTime.year - startDateTime.year;

  late SBBPickerScrollController dayController = SBBPickerScrollController(
    initialItem: initialDayIndex,
  );
  late SBBPickerScrollController monthController = SBBPickerScrollController(
    initialItem: initialMonthIndex,
  );
  late SBBPickerScrollController yearController = SBBPickerScrollController(
    initialItem: initialYearIndex,
  );

  var dayScrollingNotifierListenerRegistered = false;
  var monthScrollingNotifierListenerRegistered = false;
  var yearScrollingNotifierListenerRegistered = false;

  @override
  void initState() {
    selectedDateTime = selectedDateTime.copyWith(
      minute: _minuteByIndex(initialMinuteIndex),
    );

    if (widget.mode == SBBDateTimePickerMode.date) {
      dayController.addListener(() {
        if (!dayScrollingNotifierListenerRegistered) {
          dayScrollingNotifierListenerRegistered = true;
          dayController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !dayController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final currentMonthDays = _monthDaysCount(
                  selectedDateTime.year,
                  selectedDateTime.month,
                );
                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                  debugPrint(
                      'IDLE ${dayController.selectedItem} $overflowedDaysCount');
                }
              }
            },
          );
        }
      });
      monthController.addListener(() {
        if (!monthScrollingNotifierListenerRegistered) {
          monthScrollingNotifierListenerRegistered = true;
          monthController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !monthController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final selectedMonth = monthController.selectedItem + 1;
                final currentMonthDays = _monthDaysCount(
                  selectedDateTime.year,
                  selectedMonth,
                );

                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  debugPrint('DEBUG month scrolling: ${currentMonthDays}');
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                  debugPrint(
                      'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
                }
              }
            },
          );
        }
      });
      yearController.addListener(() {
        if (!yearScrollingNotifierListenerRegistered) {
          yearScrollingNotifierListenerRegistered = true;
          yearController.position.isScrollingNotifier.addListener(
            () {
              final controllerIdle =
                  !yearController.position.isScrollingNotifier.value;
              if (controllerIdle) {
                final selectedYear =
                    yearController.selectedItem + startDateTime.year;
                final currentMonthDays = _monthDaysCount(
                  selectedYear,
                  selectedDateTime.month,
                );

                final selectedDay =
                    dayController.selectedItem % maxDaysInMonth + 1;
                final overflowedDaysCount = selectedDay - currentMonthDays;
                if (selectedDay > currentMonthDays) {
                  debugPrint('DEBUG month scrolling: ${currentMonthDays}');
                  dayController.animateToItem(
                    dayController.selectedItem - overflowedDaysCount,
                  );
                  debugPrint(
                      'IDLE2 ${dayController.selectedItem} $overflowedDaysCount');
                }
              }
            },
          );
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.minuteInterval > 0 && 60 % widget.minuteInterval == 0,
      'minute interval is not a positive integer factor of 60',
    );

    return SBBPicker._(
      label: widget.label,
      isLastElement: widget.isLastElement,
      child: widget.mode == SBBDateTimePickerMode.time
          ? _timeBody(context)
          : widget.mode == SBBDateTimePickerMode.date
              ? _dateBody(context)
              : _dateAndTimeBody(context),
    );
  }

  Widget _timeBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SBBPickerScrollView(
            initialSelectedIndex: initialHourIndex,
            onSelectedItemChanged: (int index) {
              final selectedHour = index % 24;
              _onDateTimeSelected(
                hour: selectedHour,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 48.0,
                      alignment: Alignment.center,
                      child: Text(
                        (index % 24).toString().padLeft(2, '0'),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Expanded(
          child: SBBPickerScrollView(
            initialSelectedIndex: initialMinuteIndex,
            onSelectedItemChanged: (int index) {
              final selectedMinute = _minuteByIndex(index);
              _onDateTimeSelected(
                minute: selectedMinute,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Row(
                  children: [
                    const SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      width: 48.0,
                      alignment: Alignment.center,
                      child: Text(
                        _minuteByIndex(index).toString().padLeft(2, '0'),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isDateValid(int year, int month, int day) {
    final monthDaysCount = _monthDaysCount(
      selectedDateTime.year,
      selectedDateTime.month,
    );
    final dayInMonthIndex = (day - 1) % maxDaysInMonth;
    final monthDay = dayInMonthIndex + 1;
    if (dayInMonthIndex >= monthDaysCount) {
      // day out of month days bounds
      return false;
    }
    // check if date is before minimum date
    final dateToValidate = DateTime(year, month, day);
    final minDate = widget.minimumDate?.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    if (minDate != null) {
      if (dateToValidate.isBefore(minDate)) {
        // date before min date
        return false;
      }
    }
    final maxDate = widget.maximumDate?.copyWith(
        hour: 23, minute: 59, second: 59, millisecond: 999, microsecond: 999);
    if (minDate != null) {
      if (dateToValidate.isBefore(minDate)) {
        // date before min date
        return false;
      }
    }
    return true;
  }

  Widget _dateBody(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.0 + 24.0 + 12.0,
          child: SBBPickerScrollView(
            controller: dayController,
            onSelectedItemChanged: (int index) {
              final selectedDay = index % maxDaysInMonth + 1;
              _onDateTimeSelected(
                day: selectedDay,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              // check if day is within month days constraints
              final monthDaysCount = _monthDaysCount(
                selectedDateTime.year,
                selectedDateTime.month,
              );
              final dayInMonthIndex = index % maxDaysInMonth;
              final monthDay = dayInMonthIndex + 1;
              var dayEnabled = dayInMonthIndex < monthDaysCount;
              // check if date is before minimum date
              final minDate = widget.minimumDate;
              if (dayEnabled && minDate != null) {
                dayEnabled &=
                    minDate.isBefore(selectedDateTime.copyWith(day: monthDay));
              }
              return (
                dayEnabled,
                Container(
                  margin: EdgeInsets.only(
                    left: 24.0,
                    right: 12.0,
                  ),
                  child: Text(
                    '$monthDay.',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: SBBPickerScrollView(
            controller: monthController,
            onSelectedItemChanged: (int index) {
              final selectedMonth = index % 12 + 1;
              _onDateTimeSelected(
                month: selectedMonth,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final cupertinoLocalizations = Localizations.of(
                context,
                CupertinoLocalizations,
              );
              return (
                true,
                Container(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cupertinoLocalizations.datePickerMonth(index % 12 + 1),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 64.0 + 12.0 + 24.0,
          child: SBBPickerScrollView(
            controller: yearController,
            onSelectedItemChanged: (int index) {
              final selectedYear = startDateTime.year + index;
              _onDateTimeSelected(
                year: selectedYear,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Container(
                  margin: EdgeInsets.only(
                    left: 12.0,
                    right: 24.0,
                  ),
                  child: Text(
                    (startDateTime.year + index).toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _dateAndTimeBody(BuildContext context) {
    final cupertinoLocalizations = Localizations.of(
      context,
      CupertinoLocalizations,
    );
    return Row(
      children: [
        Expanded(
          child: SBBPickerScrollView(
            onSelectedItemChanged: (int index) {
              final selectedDate = startDateTime.add(
                Duration(days: index),
              );
              _onDateTimeSelected(
                year: selectedDate.year,
                month: selectedDate.month,
                day: selectedDate.day,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final dateTime = startDateTime.add(
                Duration(days: index),
              );
              final isToday = dateTime.year == startDateTime.year &&
                  dateTime.month == startDateTime.month &&
                  dateTime.day == startDateTime.day;
              return (
                true,
                Container(
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 12.0,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    isToday
                        ? cupertinoLocalizations.todayLabel
                        : cupertinoLocalizations.datePickerMediumDate(
                            dateTime,
                          ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 48.0 + 12.0 + 12.0,
          child: SBBPickerScrollView(
            initialSelectedIndex: initialHourIndex,
            onSelectedItemChanged: (int index) {
              final selectedHour = index % 24;
              _onDateTimeSelected(
                hour: selectedHour,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Container(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (index % 24).toString().padLeft(2, '0'),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 48.0 + 12.0 + 24.0,
          child: SBBPickerScrollView(
            initialSelectedIndex: initialMinuteIndex,
            onSelectedItemChanged: (int index) {
              final selectedMinute = _minuteByIndex(index);
              _onDateTimeSelected(
                minute: selectedMinute,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return (
                true,
                Container(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 24.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _minuteByIndex(index).toString().padLeft(2, '0'),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      final isDayChanging = day != null;
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
      // if (isDayChanging) {
      //   // dayController.position.isScrollingNotifier.addListener(() {
      //   //   debugPrint(
      //   //       'addPostFrameCallback:\n${dayController}\n${dayController.position}\n${dayController.position.isScrollingNotifier}');
      //   // });
      //   final currentMonthDays = _monthDaysCount(
      //     selectedDateTime.year,
      //     selectedDateTime.month,
      //   );
      //   if (selectedDay > currentMonthDays) {
      //     notifyCallback = false;
      //     selectedDay = currentMonthDays;
      //     // _computeWhenTrue(
      //     //   () => !dayController.position.isScrollingNotifier.value,
      //     //   () => dayController.animateToItem(
      //     //     selectedDay - 1,
      //     //     duration: kThemeAnimationDuration,
      //     //     curve: Curves.fastOutSlowIn,
      //     //   ),
      //     // );
      //     // dayController.animateToItem(
      //     //   selectedDay - 1,
      //     //   duration: kThemeAnimationDuration,
      //     //   curve: Curves.fastOutSlowIn,
      //     // );
      //   }
      // }

      final isMonthOrYearChanging = day == null;
      if (isMonthOrYearChanging) {
        final isDayControllerIdle =
            !dayController.position.isScrollingNotifier.value;
        final isMonthControllerIdle =
            !monthController.position.isScrollingNotifier.value;
        final isYearControllerIdle =
            !yearController.position.isScrollingNotifier.value;
        debugPrint(
            '$selectedDay.$selectedMonth.$selectedYear : ${dayController.position.isScrollingNotifier.value}');
        if (isDayControllerIdle &&
            isMonthControllerIdle &&
            isYearControllerIdle) {
          final prevMonthDays = _monthDaysCount(
            selectedDateTime.year,
            selectedDateTime.month,
          );
          if (dayController.selectedItem < 0) {
            notifyCallback = false;
            while (dayController.selectedItem < 0) {
              // dayController.jumpToItem(
              //   dayController.selectedItem + prevMonthDays,
              // );
            }
          } else if (dayController.selectedItem > prevMonthDays - 1) {
            notifyCallback = false;
            while (dayController.selectedItem > prevMonthDays - 1) {
              // dayController.jumpToItem(
              //   dayController.selectedItem - prevMonthDays,
              // );
            }
          }

          final monthDays = _monthDaysCount(
            selectedYear,
            selectedMonth,
          );
          final dayValueOverflow = selectedDay > monthDays;

          if (dayValueOverflow) {
            // TODO add scrollcontroller for motnh and year and check those => check with cupertino
            debugPrint(
                'OVERFLOW $selectedDay.$selectedMonth.$selectedYear : ${dayController.positions.length} ${dayController.position.isScrollingNotifier.value}');

            selectedDay = monthDays;
            notifyCallback = false;
            // TODO prevent jumpToItem while animating
            // dayController.animateToItem(
            //   selectedDay - 1,
            //   duration: kThemeAnimationDuration,
            //   curve: Curves.fastOutSlowIn,
            // );
          }
        }
      }
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

  int _minuteByIndex(int minuteIndex) {
    return minuteIndex * widget.minuteInterval % 60;
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
    this.initialSelectedIndex = 0,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.controller,
    this.looping = true,
  });

  final int initialSelectedIndex;
  final ValueChanged<int>? onSelectedItemChanged;
  final SBBPickerScrollViewItemBuilder itemBuilder;
  final SBBPickerScrollController? controller;
  final bool looping;

  @override
  State<SBBPickerScrollView> createState() => _SBBPickerScrollViewState();
}

class _SBBPickerScrollViewState extends State<SBBPickerScrollView> {
  final _listCenterKey = UniqueKey();
  late ValueNotifier<double> _scrollOffsetValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;
  SBBPickerScrollController? _fallbackController;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _fallbackController = SBBPickerScrollController(
        initialItem: widget.initialSelectedIndex + _loopingListIndexAdjustment,
      );
    }
    _scrollOffsetValueNotifier = ValueNotifier(
      _controller.initialScrollOffset,
    );
    _selectedItemIndexValueNotifier = ValueNotifier(
      widget.initialSelectedIndex,
    );
    _selectedItemIndexValueNotifier.addListener(() {
      final onSelectedItemChanged = widget.onSelectedItemChanged;
      if (onSelectedItemChanged != null) {
        // callback needs to be notified with Future.delayed to prevent
        Future.delayed(Duration.zero, () {
          onSelectedItemChanged(_selectedItemIndexValueNotifier.value);
        });
      }
    });
    _controller.addListener(() {
      _scrollOffsetValueNotifier.value = _controller.offset;
    });
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
    return Container(
      height: _scrollAreaHeight,
      child: Scrollable(
        controller: _controller,
        physics: _PickerScrollPhysics(),
        viewportBuilder: (
          BuildContext context,
          ViewportOffset offset,
        ) {
          return Viewport(
            offset: offset,
            center: _listCenterKey,
            slivers: [
              // negative list (index < 0)
              if (widget.looping)
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
                    final adjustedIndex = index - _loopingListIndexAdjustment;
                    return _buildListItem(adjustedIndex);
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
    int? scrollTarget = index + _loopingListIndexAdjustment;
    bool listItemEnabled;
    Widget? listItemWidget;
    final listItem = widget.itemBuilder(
      context,
      index,
    );
    listItemEnabled = listItem.$1;
    listItemWidget = listItem.$2;

    if (!widget.looping && listItemWidget == null) {
      // checking for spacer list items in non looping scroll views
      if (index < 0 && index >= -_firstIndexPreItemsCount) {
        // scroll to first item for tapping top spacer items
        scrollTarget = _firstIndexPreItemsCount;
        listItemWidget = SizedBox.shrink();
      } else if (widget
              .itemBuilder(
                context,
                index - _firstIndexPreItemsCount,
              )
              .$2 !=
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
          // Because of the workaround used in _PickerScrollPhysics, it's
          // necessary to adjust the offset to ensure that item heights are
          // accurately calculated.
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
                    .ceil() +
                _loopingListIndexAdjustment;

        if (visibleItemIndex < 0 || visibleItemIndex > _visibleItemCount) {
          // return sized boxes with default height for out of sight items
          return const SizedBox(
            height: _defaultItemHeight,
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

  int get _loopingListIndexAdjustment {
    return widget.looping ? 0 : _firstIndexPreItemsCount;
  }

  SBBPickerScrollController get _controller {
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

  int get selectedItem {
    return (offset / _defaultItemHeight).round() + _firstIndexPreItemsCount;
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

  static double _getItemScrollOffset(int index) {
    final targetItemScrollOffset =
        (index - _firstIndexPreItemsCount) * _defaultItemHeight;
    return _PickerScrollPhysics._calculateTargetScrollPosition(
      targetItemScrollOffset,
    );
  }
}

/// Scroll physics used by a [SBBPickerScrollView].
///
/// These physics cause the SBB picker scroll view to snap to items.
class _PickerScrollPhysics extends ScrollPhysics {
  const _PickerScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  _PickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _PickerScrollPhysics(parent: buildParent(ancestor));
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
        return ScrollSpringSimulation(
          spring,
          scrollPosition,
          target,
          velocity,
          tolerance: toleranceFor(position),
        );
      }
    }

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
