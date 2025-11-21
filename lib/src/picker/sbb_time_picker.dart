part of 'sbb_picker.dart';

/// SBB Time Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBPicker], variant for custom values.
/// * [SBBDatePicker], variant for date values.
/// * [SBBDateTimePicker], variant for date time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBTimePicker extends StatefulWidget {
  /// Constructs an [SBBDateTimePicker].
  ///
  /// [onTimeChanged] is the callback called when the selected time changes.
  ///
  /// [initialTime] is the initially selected time of the picker. Defaults to
  /// the present time. Will be rounded to conform [minuteInterval]. If the
  /// initial time is outside the range defined by [minimumTime] and
  /// [maximumTime], it will be automatically adjusted to the closest valid time
  /// within the range.
  ///
  /// [minimumTime] is the minimum selectable time of the picker. If provided,
  /// times before this minimum time will be disabled. If not provided, there
  /// will be no restriction on the minimum time that can be picked.
  ///
  /// [maximumTime] is the maximum selectable time of the picker. If provided,
  /// times after this maximum time will be disabled. If not provided, there
  /// will be no restriction on the maximum time that can be picked.
  ///
  /// [minuteInterval] is the granularity of the minute spinner. Must be a
  /// positive integer factor of 60. Defaults to 1.
  ///
  /// [maximumTime] can be before [minimumTime] to represent a time range over
  /// midnight, such as 22:00-02:00.
  SBBTimePicker({
    super.key,
    required this.onTimeChanged,
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    this.minuteInterval = _defaultMinuteInterval,
  }) : assert(
         minuteInterval > 0 && TimeOfDay.minutesPerHour % minuteInterval == 0,
         'minute interval is not a positive integer factor of 60',
       ),
       initialTime = _initialTime(initialTime, minimumTime, maximumTime, minuteInterval),
       minimumTime = _minimumTime(minimumTime, minuteInterval),
       maximumTime = _maximumTime(maximumTime, minuteInterval);

  final ValueChanged<TimeOfDay>? onTimeChanged;
  final TimeOfDay initialTime;
  final TimeOfDay? minimumTime;
  final TimeOfDay? maximumTime;
  final int minuteInterval;

  /// Shows an [SBBModalSheet] with an [SBBTimePicker] to select a [TimeOfDay].
  /// Use according to documentation.
  ///
  /// See also:
  ///
  /// * [SBBTimePicker], which will be displayed.
  /// * [showSBBModalSheet], which is used to display the modal.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
  static void showModal({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    int minuteInterval = _defaultMinuteInterval,
    ValueChanged<TimeOfDay>? onTimeChanged,
  }) {
    final localizations = MaterialLocalizations.of(context);

    final modalTitle = title ?? localizations.timePickerInputHelpText;

    final modalTime = _initialTime(initialTime, minimumTime, maximumTime, minuteInterval);

    final acceptInitialSelection = initialTime == null;
    final selectedButtonEnabled = ValueNotifier(acceptInitialSelection);
    final selectedButtonLabelText = localizations.timePickerDialHelpText;

    var selectedTime = modalTime;

    showSBBModalSheet(
      context: context,
      title: modalTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
            child: SBBGroup(
              child: SBBTimePicker(
                initialTime: initialTime,
                minimumTime: minimumTime,
                maximumTime: maximumTime,
                minuteInterval: minuteInterval,
                onTimeChanged: (time) {
                  selectedTime = time;
                  if (!acceptInitialSelection) {
                    selectedButtonEnabled.value = time != modalTime;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: ListenableBuilder(
              listenable: selectedButtonEnabled,
              builder: (context, _) {
                final onPressed = selectedButtonEnabled.value
                    ? () {
                        Navigator.of(context).pop();
                        onTimeChanged?.call(selectedTime);
                      }
                    : null;
                return SBBPrimaryButton(labelText: selectedButtonLabelText, onPressed: onPressed);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<SBBTimePicker> createState() {
    return _SBBTimePickerTimeState();
  }

  static TimeOfDay _initialTime(
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    int minuteInterval,
  ) {
    final minTime = _minimumTime(minimumTime, minuteInterval);
    final maxTime = _maximumTime(maximumTime, minuteInterval);
    var time = initialTime ?? TimeOfDay.now();
    time = time.roundToInterval(minuteInterval);
    time = time.clamp(minTime, maxTime);
    return time;
  }

  static TimeOfDay? _minimumTime(TimeOfDay? minimumTime, int minuteInterval) {
    return minimumTime?.ceilToInterval(minuteInterval);
  }

  static TimeOfDay? _maximumTime(TimeOfDay? maximumTime, int minuteInterval) {
    return maximumTime?.floorToInterval(minuteInterval);
  }
}

class _SBBTimePickerTimeState extends _TimeBasedPickerState<SBBTimePicker> {
  static const _horizontalPaddingCount = 4;

  late TimeOfDay _selectedTime;
  late ValueNotifier<TimeOfDay> _selectedTimeValueNotifier;

  late ValueNotifier<int> _hourValueNotifier;

  late SBBPickerScrollController _hourController;
  late SBBPickerScrollController _minuteController;

  late double _timeItemTextWidth;

  TimeOfDay get _safeMinTime => widget.minimumTime ?? _startOfDay;

  TimeOfDay get _safeMaxTime => widget.maximumTime ?? _endOfDay;

  double get _timeItemWidth => _itemPadding + _timeItemTextWidth + _itemPadding + _widgetHorizontalPadding;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _selectedTimeValueNotifier = ValueNotifier(_selectedTime);
    final onTimeChanged = widget.onTimeChanged;
    if (onTimeChanged != null) {
      _selectedTimeValueNotifier.addListener(() {
        onTimeChanged(_selectedTimeValueNotifier.value);
      });
    }
    _hourValueNotifier = ValueNotifier(_selectedTime.hour);

    _initHourController();
    _initMinuteController();
  }

  void _initHourController() {
    _hourController = SBBPickerScrollController(
      initialItem: _hourToIndex(_selectedTime.hour),
      onTargetItemSelected: (int index) {
        final closestValidHour = _getClosestValidTime(hourIndex: index);
        _hourValueNotifier.value = closestValidHour.hour;
      },
    );
    _hourController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initMinuteController() {
    _minuteController = SBBPickerScrollController(initialItem: _minuteToIndex(_selectedTime.minute));
    _minuteController.addScrollingStateListener(_onScrollingStateChanged);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        _adjustItemSizes(constraints.maxWidth);

        return SBBPicker.custom(
          child: Row(
            children: [
              Expanded(child: _buildHourPickerScrollView(context)),
              Expanded(child: _buildMinutePickerScrollView(context)),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _hourValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildHourPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: _hourController,
      onSelectedItemChanged: _onSelectedHourItemChanged,
      itemBuilder: (_, index) => _buildHourItem(index),
    );
  }

  Widget _buildMinutePickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _hourValueNotifier,
      builder: (BuildContext context, int selectedHour, _) {
        return SBBPickerScrollView(
          controller: _minuteController,
          onSelectedItemChanged: _onSelectedMinuteItemChanged,
          itemBuilder: (_, index) => _buildMinuteItem(index, selectedHour),
        );
      },
    );
  }

  void _onSelectedHourItemChanged(int index) {
    final selectedHour = _indexToHour(index);
    _onTimeSelected(hour: selectedHour);
  }

  void _onSelectedMinuteItemChanged(int index) {
    final selectedMinute = _indexToMinute(index);
    _onTimeSelected(minute: selectedMinute);
  }

  SBBPickerItem _buildHourItem(int index) {
    final itemHour = _indexToHour(index);
    final itemTime = TimeOfDay(hour: itemHour, minute: 0);
    final minTime = _safeMinTime.floor();
    final maxTime = _safeMaxTime.ceil();
    final isEnabled = itemTime.isInRange(minTime, maxTime);
    final label = _twoDigits(itemHour);

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      alignment: Alignment.centerRight,
      textWidth: _timeItemTextWidth,
      isFirstColumn: true,
    );
  }

  SBBPickerItem _buildMinuteItem(int index, int selectedHour) {
    final itemMinute = _indexToMinute(index);
    final itemTime = TimeOfDay(hour: selectedHour, minute: itemMinute);
    final minTime = _safeMinTime;
    final maxTime = _safeMaxTime;
    final isEnabled = itemTime.isInRange(minTime, maxTime);
    final label = _twoDigits(itemMinute);

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      alignment: Alignment.centerLeft,
      textWidth: _timeItemTextWidth,
      isLastColumn: true,
    );
  }

  void _onTimeSelected({int? hour, int? minute}) {
    final selectedHour = hour ?? _selectedTime.hour;
    final selectedMinute = minute ?? _selectedTime.minute;

    _selectedTime = TimeOfDay(hour: selectedHour, minute: selectedMinute);

    _selectedTimeValueNotifier.value = _getClosestValidTime(hourIndex: selectedHour);
  }

  void _onScrollingStateChanged() {
    if (_hourController.isScrolling() || _minuteController.isScrolling()) {
      // do nothing if any controller still scrolling
      return;
    }

    // ensure valid time
    _ensureValidTime();
  }

  void _ensureValidTime() {
    final minTime = _safeMinTime;
    final maxTime = _safeMaxTime;
    final isTimeInRange = _selectedTime.isInRange(minTime, maxTime);
    if (isTimeInRange) {
      // no correction needed
      return;
    }

    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    final correctToMinTime = _hourValueNotifier.value == minTime.hour;
    final correctedTime = correctToMinTime ? minTime : maxTime;

    // check if scroll position needs to be optimized for scroll over midnight
    if (correctToMinTime && _selectedTime.hour > minTime.hour) {
      // set index dayOffset to scroll over midnight
      _ensureOptimizedScrollPosition(offset: -TimeOfDay.hoursPerDay);
    } else if (!correctToMinTime && _selectedTime.hour < maxTime.hour) {
      // set index dayOffset to scroll over midnight
      _ensureOptimizedScrollPosition(offset: TimeOfDay.hoursPerDay);
    }

    // get index values of time values
    final hourIndex = _hourToIndex(correctedTime.hour);
    final minuteIndex = _minuteToIndex(correctedTime.minute);

    // check if any time values needs to be corrected
    final hourIncorrect = _hourController.selectedItem != hourIndex;
    final minuteIncorrect = _minuteController.selectedItem != minuteIndex;

    // correct incorrect time values
    if (hourIncorrect) {
      _hourController.animateToItem(hourIndex);
    }
    if (minuteIncorrect) {
      _minuteController.animateToItem(minuteIndex);
    }
  }

  void _ensureOptimizedScrollPosition({int offset = 0}) {
    final hourIndex = _hourToIndex(_selectedTime.hour) + offset;
    final minuteIndex = _minuteToIndex(_selectedTime.minute);
    _hourController.jumpToItem(hourIndex);
    _minuteController.jumpToItem(minuteIndex);
  }

  TimeOfDay _getClosestValidTime({required int hourIndex}) {
    final hour = _indexToHour(hourIndex);
    final time = _selectedTime.replacing(hour: hour);
    final closestValidTime = time.clamp(_safeMinTime, _safeMaxTime);
    return closestValidTime;
  }

  void _adjustItemSizes(double width) {
    // reset sizes to default values
    _itemPadding = _itemDefaultPadding;
    _timeItemTextWidth = max(_timeItemTextDefaultWidth, _timeItemTextMinWidth);

    // check if enough space to display all texts by calculating width overflow
    final timeItemWidths = _timeItemWidth * _timeItemCount;
    var widthOverflow = timeItemWidths - width;

    // check if time items text width needs to be reduced
    if (widthOverflow > 0) {
      // calculate time items text widths based on width overflow
      final minWidths = _timeItemTextMinWidth * _timeItemCount;
      const defaultWidths = _timeItemTextDefaultWidth * _timeItemCount;
      final flexibleWidths = defaultWidths - minWidths;
      final widthReductions = min(flexibleWidths, widthOverflow);
      final reducedWidths = defaultWidths - widthReductions;
      final reducedWidth = reducedWidths / _timeItemCount;

      // set reduced time item text widths
      _timeItemTextWidth = reducedWidth;

      // recalculate width overflow
      final availableTimeItemTextWidths = _availableTimeItemTextWidths(width);
      widthOverflow = minWidths - availableTimeItemTextWidths;
    }

    // check if item paddings need to be reduced
    if (widthOverflow > 0) {
      // calculate item paddings based on width overflow
      const minPaddings = _itemMinPadding * _horizontalPaddingCount;
      const defaultPaddings = _itemDefaultPadding * _horizontalPaddingCount;
      const flexiblePaddings = defaultPaddings - minPaddings;
      final paddingReductions = min(flexiblePaddings, widthOverflow);
      final reducedPaddings = defaultPaddings - paddingReductions;
      final reducedPadding = reducedPaddings / _horizontalPaddingCount;

      // set reduced paddings
      _itemPadding = reducedPadding;
    }
  }

  double _availableTimeItemTextWidths(double widgetWidth) {
    return widgetWidth - _widgetHorizontalPadding * 2 - _itemPadding * _horizontalPaddingCount;
  }

  int _indexToMinute(int minuteIndex) {
    return minuteIndex * widget.minuteInterval % TimeOfDay.minutesPerHour;
  }

  int _minuteToIndex(int minute) {
    return minute ~/ widget.minuteInterval;
  }

  int _indexToHour(int hourIndex) {
    return hourIndex % TimeOfDay.hoursPerDay;
  }

  int _hourToIndex(int hour) {
    return hour;
  }
}
