part of 'sbb_picker.dart';

/// SBB Date Time Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBPicker], variant for custom values.
/// * [SBBDatePicker], variant for date values.
/// * [SBBTimePicker], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDateTimePicker extends StatefulWidget {
  /// Constructs an [SBBDateTimePicker].
  ///
  /// [onDateTimeChanged] is the callback called when the selected date time
  /// changes.
  ///
  /// [initialDateTime] is the initially selected date time of the picker.
  /// Defaults to the present date time. If the initial date time is outside the
  /// range defined by [minimumDateTime] and [maximumDateTime], it will be
  /// automatically adjusted to the closest valid date time within the range.
  ///
  /// [minimumDateTime] is the minimum selectable date time of the picker. If
  /// provided, date times before this minimum date time will be disabled. If
  /// not provided, there will be no restriction on the minimum date time that
  /// can be picked.
  ///
  /// [maximumDateTime] is the maximum selectable date time of the picker. If
  /// provided, date times after this maximum date time will be disabled. If not
  /// provided, there will be no restriction on the maximum date time that can
  /// be picked.
  ///
  /// [minuteInterval] is the granularity of the minute spinner. Must be a
  /// positive integer factor of 60. Defaults to 1.
  ///
  /// [minimumDateTime] must be before [maximumDateTime] if both are set.
  SBBDateTimePicker({
    super.key,
    required this.onDateTimeChanged,
    DateTime? initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
    this.minuteInterval = _defaultMinuteInterval,
  }) : assert(
         minuteInterval > 0 && TimeOfDay.minutesPerHour % minuteInterval == 0,
         'minute interval is not a positive integer factor of 60',
       ),
       initialDateTime = _initialDateTime(
         initialDateTime,
         minimumDateTime,
         maximumDateTime,
         minuteInterval,
       ),
       minimumDateTime = _minimumDateTime(minimumDateTime, minuteInterval),
       maximumDateTime = _maximumDateTime(maximumDateTime, minuteInterval) {
    assert(
      this.minimumDateTime == null ||
          this.maximumDateTime == null ||
          this.minimumDateTime!.isBefore(this.maximumDateTime!),
      'minimum date time (${this.minimumDateTime}) is not before maximum date time (${this.maximumDateTime})',
    );
  }

  final ValueChanged<DateTime>? onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final int minuteInterval;

  /// Shows an [SBBModalSheet] with an [SBBDateTimePicker] to select a
  /// [DateTime].
  /// Use according to documentation.
  ///
  /// See also:
  ///
  /// * [SBBDateTimePicker], which will be displayed.
  /// * [showSBBModalSheet], which is used to display the modal.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
  static void showModal({
    required BuildContext context,
    String? title,
    DateTime? initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
    int minuteInterval = _defaultMinuteInterval,
    ValueChanged<DateTime>? onDateTimeChanged,
  }) {
    final localizations = MaterialLocalizations.of(context);

    final modalTitle = title ?? localizations.dateInputLabel;

    final modalDateTime = _initialDateTime(
      initialDateTime,
      minimumDateTime,
      maximumDateTime,
      minuteInterval,
    );

    final acceptInitialSelection = initialDateTime == null;
    final selectedButtonEnabled = ValueNotifier(acceptInitialSelection);
    final selectedButtonLabel = localizations.datePickerHelpText;

    var selectedDateTime = modalDateTime;

    showSBBModalSheet(
      context: context,
      title: modalTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
            child: SBBGroup(
              child: SBBDateTimePicker(
                initialDateTime: initialDateTime,
                minimumDateTime: minimumDateTime,
                maximumDateTime: maximumDateTime,
                minuteInterval: minuteInterval,
                onDateTimeChanged: (dateTime) {
                  selectedDateTime = dateTime;
                  if (!acceptInitialSelection) {
                    selectedButtonEnabled.value = dateTime != modalDateTime;
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
                final onPressed =
                    selectedButtonEnabled.value
                        ? () {
                          Navigator.of(context).pop();
                          onDateTimeChanged?.call(selectedDateTime);
                        }
                        : null;
                return SBBPrimaryButton(
                  label: selectedButtonLabel,
                  onPressed: onPressed,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<SBBDateTimePicker> createState() {
    return _SBBDateTimePickerState();
  }

  static DateTime _initialDateTime(
    DateTime? initialDateTime,
    DateTime? minimumDateTime,
    DateTime? maximumDateTime,
    int minuteInterval,
  ) {
    final minDateTime = _minimumDateTime(minimumDateTime, minuteInterval);
    final maxDateTime = _maximumDateTime(maximumDateTime, minuteInterval);
    var dateTime = initialDateTime ?? DateTime.now();
    dateTime = dateTime.roundToInterval(minuteInterval);
    dateTime = dateTime.clamp(minDateTime, maxDateTime);
    return dateTime;
  }

  static DateTime? _minimumDateTime(
    DateTime? minimumDateTime,
    int minuteInterval,
  ) {
    return minimumDateTime?.ceilToInterval(minuteInterval);
  }

  static DateTime? _maximumDateTime(
    DateTime? maximumDateTime,
    int minuteInterval,
  ) {
    return maximumDateTime?.floorToInterval(minuteInterval);
  }
}

class _SBBDateTimePickerState extends _TimeBasedPickerState<SBBDateTimePicker> {
  static const _horizontalPaddingCount = 6;

  late DateTime _selectedDateTime;
  late ValueNotifier<DateTime> _selectedDateTimeValueNotifier;

  late ValueNotifier<DateTime> _dateValueNotifier;
  late ValueNotifier<DateTime> _dateHourValueNotifier;

  late SBBPickerScrollController _dateController;
  late SBBPickerScrollController _hourController;
  late SBBPickerScrollController _minuteController;

  late DateFormat _dateFormat;
  late double _timeItemTextWidth;

  double get _hourItemWidth => _itemPadding + _timeItemTextWidth + _itemPadding;

  double get _minuteItemWidth => _hourItemWidth + _widgetHorizontalPadding;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _selectedDateTimeValueNotifier = ValueNotifier(_selectedDateTime);
    final onDateTimeChanged = widget.onDateTimeChanged;
    if (onDateTimeChanged != null) {
      _selectedDateTimeValueNotifier.addListener(() {
        onDateTimeChanged(_selectedDateTimeValueNotifier.value);
      });
    }
    _dateValueNotifier = ValueNotifier(_selectedDateTime.date);
    _dateHourValueNotifier = ValueNotifier(_selectedDateTime);

    _initDateController();
    _initHourController();
    _initMinuteController();
  }

  void _initDateController() {
    _dateController = SBBPickerScrollController(
      initialItem: _dateToIndex(_selectedDateTime),
      onTargetItemSelected: (int index) {
        final closestValidDateTime = _closestValidDateTime(dateIndex: index);
        _dateValueNotifier.value = closestValidDateTime;
        _dateHourValueNotifier.value = closestValidDateTime;
      },
    );
    _dateController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initHourController() {
    _hourController = SBBPickerScrollController(
      initialItem: _hourToIndex(_selectedDateTime.hour),
      onTargetItemSelected: (int index) {
        final closestValidDateTime = _closestValidDateTime(hourIndex: index);
        _dateHourValueNotifier.value = closestValidDateTime;
      },
    );
    _hourController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initMinuteController() {
    _minuteController = SBBPickerScrollController(
      initialItem: _minuteToIndex(_selectedDateTime.minute),
    );
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
              Expanded(child: _buildDatePickerScrollView()),
              SizedBox(
                width: _hourItemWidth,
                child: _buildHourPickerScrollView(),
              ),
              SizedBox(
                width: _minuteItemWidth,
                child: _buildMinutePickerScrollView(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _dateValueNotifier.dispose();
    _dateHourValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildDatePickerScrollView() {
    return SBBPickerScrollView(
      controller: _dateController,
      onSelectedItemChanged: _onSelectedDateItemChanged,
      itemBuilder: (_, index) => _buildDateItem(index),
    );
  }

  Widget _buildHourPickerScrollView() {
    return ValueListenableBuilder(
      valueListenable: _dateValueNotifier,
      builder: (BuildContext context, DateTime selectedDate, _) {
        return SBBPickerScrollView(
          controller: _hourController,
          onSelectedItemChanged: _onSelectedHourItemChanged,
          itemBuilder: (_, index) => _buildHourItem(index, selectedDate),
        );
      },
    );
  }

  Widget _buildMinutePickerScrollView() {
    return ValueListenableBuilder(
      valueListenable: _dateHourValueNotifier,
      builder: (BuildContext context, DateTime selectedDateTime, _) {
        return SBBPickerScrollView(
          controller: _minuteController,
          onSelectedItemChanged: _onSelectedMinuteItemChanged,
          itemBuilder: (_, index) => _buildMinuteItem(index, selectedDateTime),
        );
      },
    );
  }

  void _onSelectedDateItemChanged(int index) {
    _onDateTimeSelected(date: _indexToDate(index));
  }

  void _onSelectedHourItemChanged(int index) {
    _onDateTimeSelected(hour: _indexToHour(index));
  }

  void _onSelectedMinuteItemChanged(int index) {
    _onDateTimeSelected(minute: _indexToMinute(index));
  }

  SBBPickerItem _buildDateItem(int index) {
    final itemDate = _indexToDate(index).date;
    final minDate = widget.minimumDateTime?.date;
    final maxDate = widget.maximumDateTime?.date;
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = _dateFormat.format(itemDate);

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      alignment: Alignment.centerRight,
      isFirstColumn: true,
    );
  }

  SBBPickerItem _buildHourItem(int index, DateTime selectedDate) {
    final itemHour = _indexToHour(index);
    final itemDateTime = selectedDate.copyWith(hour: itemHour, minute: 1);
    final minDateTime = widget.minimumDateTime?.copyWith(minute: 0);
    final maxDateTime = widget.maximumDateTime?.copyWith(minute: 2);
    final isEnabled = itemDateTime.isInRange(minDateTime, maxDateTime);
    final label = _twoDigits(itemHour);

    return _buildPickerItem(isEnabled: isEnabled, label: label);
  }

  SBBPickerItem _buildMinuteItem(int index, DateTime selectedDateTime) {
    final itemMinute = _indexToMinute(index);
    final itemDateTime = selectedDateTime.copyWith(minute: itemMinute);
    final minDateTime = widget.minimumDateTime;
    final maxDateTime = widget.maximumDateTime;
    final isEnabled = itemDateTime.isInRange(minDateTime, maxDateTime);
    final label = _twoDigits(itemMinute);

    return _buildPickerItem(
      isEnabled: isEnabled,
      label: label,
      isLastColumn: true,
    );
  }

  void _onDateTimeSelected({DateTime? date, int? hour, int? minute}) {
    final selectedYear = date?.year ?? _selectedDateTime.year;
    final selectedMonth = date?.month ?? _selectedDateTime.month;
    final selectedDay = date?.day ?? _selectedDateTime.day;
    final selectedHour = hour ?? _selectedDateTime.hour;
    final selectedMinute = minute ?? _selectedDateTime.minute;

    _selectedDateTime = DateTime(
      selectedYear,
      selectedMonth,
      selectedDay,
      selectedHour,
      selectedMinute,
    );

    final validDateTime = _selectedDateTime.clamp(
      widget.minimumDateTime,
      widget.maximumDateTime,
    );
    _selectedDateTimeValueNotifier.value = validDateTime;
  }

  void _onScrollingStateChanged() {
    if (_dateController.isScrolling() ||
        _hourController.isScrolling() ||
        _minuteController.isScrolling()) {
      // do nothing if any controller still scrolling
      return;
    }

    // ensure valid date time
    _ensureValidDateTime();
  }

  void _ensureValidDateTime() {
    final validDateTime = _selectedDateTime.clamp(
      widget.minimumDateTime,
      widget.maximumDateTime,
    );

    if (_selectedDateTime == validDateTime) {
      // no correction needed
      return;
    }

    // optimize scroll positions to prevent scrolling over multiple rounds
    _ensureOptimizedScrollPosition();

    // get index values of valid date time values
    final dateIndex = _dateToIndex(validDateTime);
    final hourIndex = _hourToIndex(validDateTime.hour);
    final minuteIndex = _minuteToIndex(validDateTime.minute);

    // check if any date time values needs to be corrected
    final dateIncorrect = _hourController.selectedItem != dateIndex;
    final hourIncorrect = _hourController.selectedItem != hourIndex;
    final minuteIncorrect = _minuteController.selectedItem != minuteIndex;

    // correct incorrect date time values
    if (dateIncorrect) {
      _dateController.animateToItem(dateIndex);
    }
    if (hourIncorrect) {
      _hourController.animateToItem(hourIndex);
    }
    if (minuteIncorrect) {
      _minuteController.animateToItem(minuteIndex);
    }
  }

  void _ensureOptimizedScrollPosition() {
    final hourIndex = _hourToIndex(_selectedDateTime.hour);
    final minuteIndex = _minuteToIndex(_selectedDateTime.minute);
    _hourController.jumpToItem(hourIndex);
    _minuteController.jumpToItem(minuteIndex);
  }

  DateTime _closestValidDateTime({int? dateIndex, int? hourIndex}) {
    final date = _indexToDate(dateIndex ?? _dateController.selectedItem);
    final hour = _indexToHour(hourIndex ?? _hourController.selectedItem);
    final minute = _indexToMinute(_minuteController.selectedItem);

    final dateTime = date.copyWith(hour: hour, minute: minute);

    final minDateTime = widget.minimumDateTime;
    if (minDateTime != null && minDateTime.isAfter(dateTime)) {
      return minDateTime;
    }

    final maxDateTime = widget.maximumDateTime;
    if (maxDateTime != null && maxDateTime.isBefore(dateTime)) {
      return maxDateTime;
    }

    return dateTime;
  }

  void _adjustItemSizes(double width) {
    // reset sizes to default values
    _itemPadding = _itemDefaultPadding;
    _timeItemTextWidth = max(_timeItemTextDefaultWidth, _timeItemTextMinWidth);

    // validate locale
    final localeObject = Localizations.maybeLocaleOf(context);
    final localeExists = DateFormat.localeExists(localeObject.toString());
    final locale = localeExists ? localeObject.toString() : null;

    // use localized long date format by default
    _dateFormat = DateFormat.MMMEd(locale);

    // adjust pattern for german to conform to design specifications
    if (localeObject?.languageCode == 'de') {
      final pattern = _dateFormat.pattern?.replaceFirst(',', '');
      _dateFormat = DateFormat(pattern, locale);
    }

    // check if enough space to display all texts by calculating width overflow
    final availableDateItemTextWidth = _availableDateItemTextWidth(width);
    final longDateTextMinWidth = _dateItemTextMinWidth(_dateFormat);
    var widthOverflow = longDateTextMinWidth - availableDateItemTextWidth;

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
      widthOverflow -= widthReductions;
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

      // recalculate width overflow
      widthOverflow -= paddingReductions;
    }

    // check if medium date format needs to be used
    if (widthOverflow > 0) {
      // use localized medium date format
      _dateFormat = DateFormat.MMMd(locale);

      // check if short date format needs to be used
      final availableDateItemTextWidth = _availableDateItemTextWidth(width);
      final mediumDateTextWidth = _dateItemTextMinWidth(_dateFormat);
      if (availableDateItemTextWidth < mediumDateTextWidth) {
        // use localized short date format
        _dateFormat = DateFormat.Md(locale);
      }
    }
  }

  double _availableDateItemTextWidth(double widgetWidth) {
    return widgetWidth -
        _widgetHorizontalPadding * 2 -
        _itemPadding * _horizontalPaddingCount -
        _timeItemTextWidth * _timeItemCount;
  }

  double _dateItemTextMinWidth(DateFormat dateFormat) {
    final year = widget.initialDateTime.year;
    var dateTextWidth = 0.0;
    for (var i = 0; i < DateTime.monthsPerYear; i++) {
      final month = i + 1;
      final daysInMonth = DateUtils.getDaysInMonth(year, month);
      for (var j = 0; j < DateTime.daysPerWeek; j++) {
        final day = daysInMonth - j;
        final date = DateTime(year, month, day);
        final itemLabel = dateFormat.format(date);
        final itemTextSize = _textSize(itemLabel);
        final itemTextWidth = itemTextSize.width;
        if (itemTextWidth > dateTextWidth) {
          dateTextWidth = itemTextWidth;
        }
      }
    }
    return dateTextWidth;
  }

  DateTime _indexToDate(int dateIndex) {
    return widget.initialDateTime.date.add(Duration(days: dateIndex));
  }

  int _dateToIndex(DateTime date) {
    return date.date.difference(widget.initialDateTime.date).inDays;
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
