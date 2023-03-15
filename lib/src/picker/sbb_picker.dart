import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';

const _itemHeight = 30.0;
const _highlightedAreaHeight = 34.0;
const _visibleItemCount = 7;
const _scrollAreaHeight = _itemHeight * _visibleItemCount;
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

typedef _SBBStatefulValueWidgetBuilder<T> = Widget Function(
  BuildContext context,
  ValueGetter<T> valueGetter,
  ValueSetter<T> valueSetter,
);

class _SBBStatefulValuePicker<T> extends StatefulWidget {
  const _SBBStatefulValuePicker({
    super.key,
    required this.initialValue,
    required this.builder,
  });

  final T initialValue;
  final _SBBStatefulValueWidgetBuilder<T> builder;

  @override
  State<_SBBStatefulValuePicker<T>> createState() =>
      _SBBStatefulValuePickerState<T>();
}

class SBBPickerScrollController extends ScrollController {
  SBBPickerScrollController({
    int initialItem = 0,
  }) : super(
          initialScrollOffset: _getItemScrollOffset(
            initialItem,
          ),
        );

  int get selectedItem {
    // final visibleItemIndex =
    // ((offset - index * _itemHeight) * -1 / _itemHeight).ceil();
    // final visibleAreaOffset = offset % _itemHeight;
    // var selectedVisibleItemIndex =
    // visibleAreaOffset > _itemHeight * 0.5 ? 4 : 3;
    // final selectedItemIndex =
    //     index + selectedVisibleItemIndex - visibleItemIndex;
    return (offset / _itemHeight).round() + 3;
  }

  Future<void> animateToItem(
    int itemIndex, {
    required Duration duration,
    required Curve curve,
  }) async {
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    animateTo(
      targetItemScrollOffset,
      duration: kThemeAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  void jumpToItem(int itemIndex) {
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    jumpTo(targetItemScrollOffset);
  }

  static double _getItemScrollOffset(int index) {
    final targetItemScrollOffset = (index - 3) * _itemHeight;
    return _PickerScrollPhysics._calculateTargetScrollPosition(
      targetItemScrollOffset,
    );
  }
}

class _SBBStatefulValuePickerState<T>
    extends State<_SBBStatefulValuePicker<T>> {
  late ValueNotifier<T> valueNotifier;
  late ValueGetter<T> valueGetter;
  late ValueSetter<T> valueSetter;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(widget.initialValue);
    valueGetter = () {
      return valueNotifier.value;
    };
    valueSetter = (T value) {
      valueNotifier.value = value;
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, valueGetter, valueSetter);
  }
}

class SBBPicker extends StatefulWidget {
  SBBPicker({
    Key? key,
    String? label,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required IndexedWidgetBuilder itemBuilder,
    bool isLastElement = true,
  }) : this._(
          key: key,
          label: label,
          child: SBBPickerScrollView(
            initialSelectedIndex: initialSelectedIndex,
            onSelectedItemChanged: onSelectedItemChanged,
            itemBuilder: itemBuilder,
          ),
          isLastElement: isLastElement,
        );

  factory SBBPicker.time({
    Key? key,
    String? label,
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? initialDateTime,
    int minuteInterval = 1,
    bool isLastElement = true,
  }) {
    assert(
      minuteInterval > 0 && 60 % minuteInterval == 0,
      'minute interval is not a positive integer factor of 60',
    );

    minuteByIndex(minuteIndex) {
      return minuteIndex * minuteInterval % 60;
    }

    var initialValue = initialDateTime ?? DateTime.now();
    final initialHourIndex = initialValue.hour;
    final initialMinuteIndex = (initialValue.minute / minuteInterval).ceil();
    initialValue = initialValue.copyWith(
      minute: minuteByIndex(initialMinuteIndex),
    );
    return SBBPicker._(
      key: key,
      label: label,
      isLastElement: isLastElement,
      child: _SBBStatefulValuePicker<DateTime>(
        key: key,
        initialValue: initialValue,
        builder: (
          BuildContext context,
          ValueGetter<DateTime> valueGetter,
          ValueSetter<DateTime> valueSetter,
        ) {
          return Row(
            children: [
              Expanded(
                child: SBBPickerScrollView(
                  initialSelectedIndex: initialHourIndex,
                  onSelectedItemChanged: (int index) {
                    final selectedHour = index % 24;
                    final previousDateTime = valueGetter();
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      previousDateTime.day,
                      selectedHour,
                      previousDateTime.minute,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
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
                    );
                  },
                ),
              ),
              Expanded(
                child: SBBPickerScrollView(
                  initialSelectedIndex: initialMinuteIndex,
                  onSelectedItemChanged: (int index) {
                    final selectedMinute = minuteByIndex(index);
                    final previousDateTime = valueGetter();
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      previousDateTime.day,
                      previousDateTime.hour,
                      selectedMinute,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          width: 48.0,
                          alignment: Alignment.center,
                          child: Text(
                            minuteByIndex(index).toString().padLeft(2, '0'),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // TODO WIP
  factory SBBPicker._date({
    Key? key,
    String? label,
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? initialDateTime,
    bool isLastElement = true,
  }) {
    final startDate = DateTime.now();
    final initialValue = initialDateTime ?? startDate;
    final initialDayIndex = initialValue.day - 1;
    final initialMonthIndex = initialValue.month - 1;
    final initialYearIndex = initialValue.year - startDate.year;
    final dateTimeValueNotifier = ValueNotifier(initialValue);

    final dayScrollController = SBBPickerScrollController(
      initialItem: initialDayIndex,
    );

    numberOfDaysInMonth(int year, int month) {
      return DateTime(
        year,
        month + 1,
        0,
      ).day;
    }

    animateToDay(int day) {
      dayScrollController.animateToItem(
        day - 1,
        duration: kThemeAnimationDuration,
        curve: Curves.fastOutSlowIn,
      );
    }

    return SBBPicker._(
      key: key,
      label: label,
      isLastElement: isLastElement,
      child: _SBBStatefulValuePicker<DateTime>(
        key: key,
        initialValue: initialValue,
        builder: (
          BuildContext context,
          ValueGetter<DateTime> valueGetter,
          ValueSetter<DateTime> valueSetter,
        ) {
          onSelectedItemChanged(
            int selectedYear,
            int selectedMonth,
            int selectedDay,
          ) {
            final numberOfDays = numberOfDaysInMonth(
              selectedYear,
              selectedMonth,
            );
            final dayValueOverflow = selectedDay > numberOfDays;
            final correctedSelectedDay =
                dayValueOverflow ? numberOfDays : selectedDay;
            final selectedDateTime = DateTime(
              selectedYear,
              selectedMonth,
              correctedSelectedDay,
            );

            valueSetter(selectedDateTime);
            Future.delayed(Duration.zero, () {
              dateTimeValueNotifier.value = selectedDateTime;
              animateToDay(correctedSelectedDay);
            });
            if (dayValueOverflow) {
              onDateTimeChanged(selectedDateTime);
            }
          }

          return Row(
            children: [
              Container(
                width: 40.0 + 24.0 + 12.0,
                child: SBBPickerScrollView(
                  controller: dayScrollController,
                  onSelectedItemChanged: (int index) {
                    final previousDateTime = valueGetter();
                    final numberOfDays = numberOfDaysInMonth(
                      previousDateTime.year,
                      previousDateTime.month,
                    );
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      index % numberOfDays + 1,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ValueListenableBuilder<DateTime>(
                        valueListenable: dateTimeValueNotifier,
                        builder: (context, value, _) {
                          final numberOfDays = numberOfDaysInMonth(
                            value.year,
                            value.month,
                          );
                          return Container(
                            margin: EdgeInsets.only(
                              left: 24.0,
                              right: 12.0,
                            ),
                            child: Text(
                              '${index % numberOfDays + 1}.',
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          );
                        });
                  },
                ),
              ),
              Expanded(
                child: SBBPickerScrollView(
                  initialSelectedIndex: initialMonthIndex,
                  onSelectedItemChanged: (int index) {
                    final previousDateTime = valueGetter();
                    final selectedYear = previousDateTime.year;
                    final selectedMonth = index % 12 + 1;
                    final selectedDay = previousDateTime.day;
                    onSelectedItemChanged(
                      selectedYear,
                      selectedMonth,
                      selectedDay,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final cupertinoLocalizations = Localizations.of(
                      context,
                      CupertinoLocalizations,
                    );
                    return Container(
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
                    );
                  },
                ),
              ),
              Container(
                width: 64.0 + 12.0 + 24.0,
                child: SBBPickerScrollView(
                  initialSelectedIndex: initialYearIndex,
                  onSelectedItemChanged: (int index) {
                    final previousDateTime = valueGetter();
                    final selectedYear = startDate.year + index;
                    final selectedMonth = previousDateTime.month;
                    final selectedDay = previousDateTime.day;
                    onSelectedItemChanged(
                      selectedYear,
                      selectedMonth,
                      selectedDay,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: 12.0,
                        right: 24.0,
                      ),
                      child: Text(
                        (startDate.year + index).toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // TODO WIP
  factory SBBPicker._dateAndTime({
    Key? key,
    String? label,
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? initialDateTime,
    int minuteInterval = 1,
    bool isLastElement = true,
  }) {
    assert(
      minuteInterval > 0 && 60 % minuteInterval == 0,
      'minute interval is not a positive integer factor of 60',
    );
    final startValue = DateTime.now();
    final initialValue = initialDateTime ?? startValue;
    final initialHourIndex = initialValue.hour;
    final initialMinuteIndex = (initialValue.minute / minuteInterval).ceil();
    return SBBPicker._(
      key: key,
      label: label,
      isLastElement: isLastElement,
      child: _SBBStatefulValuePicker<DateTime>(
        key: key,
        initialValue: initialValue,
        builder: (
          BuildContext context,
          ValueGetter<DateTime> valueGetter,
          ValueSetter<DateTime> valueSetter,
        ) {
          final cupertinoLocalizations = Localizations.of(
            context,
            CupertinoLocalizations,
          );
          return Row(
            children: [
              Expanded(
                child: SBBPickerScrollView(
                  onSelectedItemChanged: (int index) {
                    final selectedHour = index % 24;
                    final previousDateTime = valueGetter();
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      previousDateTime.day,
                      previousDateTime.hour,
                      previousDateTime.minute,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final dateTime = startValue.add(Duration(days: index));
                    var label = '';
                    if (dateTime.year == startValue.year &&
                        dateTime.month == startValue.month &&
                        dateTime.day == startValue.day) {
                      label = cupertinoLocalizations.todayLabel;
                    } else {
                      label = cupertinoLocalizations.datePickerMediumDate(
                        dateTime,
                      );
                    }
                    return Container(
                      padding: EdgeInsets.only(
                        left: 24.0,
                        right: 12.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
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
                    final previousDateTime = valueGetter();
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      previousDateTime.day,
                      selectedHour,
                      previousDateTime.minute,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
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
                    );
                  },
                ),
              ),
              Container(
                width: 48.0 + 12.0 + 24.0,
                child: SBBPickerScrollView(
                  initialSelectedIndex: initialMinuteIndex,
                  onSelectedItemChanged: (int index) {
                    final selectedMinute = index * minuteInterval % 60;
                    final previousDateTime = valueGetter();
                    final selectedDateTime = DateTime(
                      previousDateTime.year,
                      previousDateTime.month,
                      previousDateTime.day,
                      previousDateTime.hour,
                      selectedMinute,
                    );
                    valueSetter(selectedDateTime);
                    onDateTimeChanged(selectedDateTime);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(
                        left: 12.0,
                        right: 24.0,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ((index * minuteInterval) % 60)
                            .toString()
                            .padLeft(2, '0'),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  const SBBPicker._({
    super.key,
    this.label,
    required this.child,
    this.isLastElement = true,
  });

  final String? label;
  final Widget child;
  final bool isLastElement;

  @override
  State<SBBPicker> createState() => _SBBPickerState();
}

class _SBBPickerState extends State<SBBPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label!,
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
                    child: widget.child,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.label != null && !widget.isLastElement)
          SizedBox(
            height: sbbDefaultSpacing * 0.5,
          ),
        if (!widget.isLastElement) Divider(),
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

class SBBPickerScrollView extends StatefulWidget {
  const SBBPickerScrollView({
    super.key,
    this.initialSelectedIndex = 0,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.controller,
  });

  final int initialSelectedIndex;
  final ValueChanged<int>? onSelectedItemChanged;
  final IndexedWidgetBuilder itemBuilder;
  final SBBPickerScrollController? controller;

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
        initialItem: widget.initialSelectedIndex,
      );
    }
    _scrollOffsetValueNotifier = ValueNotifier(
      _controller.initialScrollOffset,
    );
    _selectedItemIndexValueNotifier = ValueNotifier(
      widget.initialSelectedIndex,
    );
    _selectedItemIndexValueNotifier.addListener(() {
      widget.onSelectedItemChanged?.call(_selectedItemIndexValueNotifier.value);
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // adjust index so it goes negative from -1 instead of positive from 0
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

  Widget _buildListItem(int index) {
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
              final maxCorrectedOffset = (-1 - i) * _itemHeight;
              offset = offsetPercentage * maxCorrectedOffset;
              break;
            }
          }
        }

        // includes items that are partly visible when scrolling
        final visibleItemIndex =
            ((offset - index * _itemHeight) * -1 / _itemHeight).ceil();

        if (visibleItemIndex < 0 || visibleItemIndex > _visibleItemCount) {
          return const SizedBox(
            height: _itemHeight,
          );
        }

        // check selected item
        final visibleAreaOffset = offset % _itemHeight;
        var selectedVisibleItemIndex =
            visibleAreaOffset > _itemHeight * 0.5 ? 4 : 3;
        final selectedItemIndex =
            index + selectedVisibleItemIndex - visibleItemIndex;
        _selectedItemIndexValueNotifier.value = selectedItemIndex;

        final indexA = visibleItemIndex - 1;
        final indexB = visibleItemIndex;
        final weightA = (offset % _itemHeight) / _itemHeight;
        final weightB = 1 - weightA;
        final heightA = _getItemHeight(indexA);
        final heightB = _getItemHeight(indexB);
        final textColorA = _getItemTextColor(indexA);
        final textColorB = _getItemTextColor(indexB);

        final itemHeight = weightA * heightA + weightB * heightB;
        final textColor = Color.lerp(
          textColorA,
          textColorB,
          weightB,
        );

        return GestureDetector(
          onTap: () {
            // _animateToItem(index);
            _controller.animateToItem(
              index,
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
            );
          },
          child: Container(
            height: itemHeight,
            width: double.infinity,
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: SBBTextStyles.mediumLight.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
                height: 26.0 / 24.0,
                color: textColor,
              ),
              child: widget.itemBuilder(
                context,
                index,
              ),
            ),
          ),
        );
      },
    );
  }

  double _getItemHeight(int index) {
    if (index < 0 || index > _visibleItemCount - 1) {
      return _itemHeight;
    }
    return _visibleItemHeights[index];
  }

  Color _getItemTextColor(int index) {
    if (index < 0) {
      return _visibleItemTextColors.first;
    }
    if (index > _visibleItemCount - 1) {
      return _visibleItemTextColors.last;
    }
    return _visibleItemTextColors[index];
  }

  SBBPickerScrollController get _controller {
    return widget.controller ?? _fallbackController!;
  }
}

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
    // // If we're out of range and not headed back in range, defer to the parent
    // // ballistics, which should put us back in range at a page boundary.
    // if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
    //     (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
    //   return super.createBallisticSimulation(position, velocity);
    // }

    if (velocity == 0.0) {
      final scrollPosition = position.pixels;
      final target = _calculateTargetScrollPosition(scrollPosition);
      if (target != scrollPosition) {
        return ScrollSpringSimulation(
          spring,
          scrollPosition,
          target,
          velocity,
          tolerance: tolerance,
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

    return (scrollPosition / _itemHeight).round() * _itemHeight;
  }

  @override
  bool get allowImplicitScrolling => false;
}
