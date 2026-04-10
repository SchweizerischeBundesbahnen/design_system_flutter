import 'dart:math';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_picker_constants.dart';
import 'sbb_picker_time_based_mixin.dart';
import 'sbb_picker_utils.dart';

/// SBB Time Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBPicker], variant for custom values.
/// * [SBBDatePicker], variant for date values.
/// * [SBBDateTimePicker], variant for date time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBTimePicker extends StatefulWidget {
  /// Constructs an [SBBTimePicker].
  SBBTimePicker({
    super.key,
    required this.onTimeChanged,
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    this.minuteInterval = pickerDefaultMinuteInterval,
    this.visibleItemCount = pickerDefaultVisibleItemCount,
    this.pickerStyle,
  }) : assert(
         minuteInterval > 0 && TimeOfDay.minutesPerHour % minuteInterval == 0,
         'minute interval is not a positive integer factor of 60',
       ),
       initialTime = PickerUtils.clampedAndIntervaledTime(
         initialTime ?? TimeOfDay.now(),
         minimumTime,
         maximumTime,
         minuteInterval,
       ),
       minimumTime = PickerUtils.minimumTime(minimumTime, minuteInterval),
       maximumTime = PickerUtils.maximumTime(maximumTime, minuteInterval);

  /// Called when the selected time changes.
  final ValueChanged<TimeOfDay>? onTimeChanged;

  /// The initially selected time of the picker.
  ///
  /// Defaults to `TimeOfDay.now()`. Will be rounded to conform [minuteInterval].
  /// If the initial time is outside the range defined by [minimumTime] and
  /// [maximumTime], it will be automatically adjusted to the closest valid time
  /// within the range.
  final TimeOfDay initialTime;

  /// The minimum selectable time of the picker.
  ///
  /// If provided, times before this minimum time will be disabled. If not
  /// provided, there will be no restriction on the minimum time that can be
  /// picked.
  ///
  /// Can be after [maximumTime] to represent a time range over midnight, such
  /// as 22:00-02:00.
  final TimeOfDay? minimumTime;

  /// The maximum selectable time of the picker.
  ///
  /// If provided, times after this maximum time will be disabled. If not
  /// provided, there will be no restriction on the maximum time that can be
  /// picked.
  ///
  /// Can be before [minimumTime] to represent a time range over midnight, such
  /// as 22:00-02:00.
  final TimeOfDay? maximumTime;

  /// The granularity of the minute spinner.
  ///
  /// Must be a positive integer factor of 60.
  ///
  /// Defaults to 1.
  final int minuteInterval;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
  ///
  /// Defaults to 7.
  final int visibleItemCount;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  /// Shows a [SBBBottomSheet] with an [SBBTimePicker] to select a [TimeOfDay].
  ///
  /// See also:
  ///
  /// * [SBBTimePicker], which will be displayed.
  /// * [showSBBBottomSheet], which is used to display the [SBBBottomSheet] with the picker.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  static void showInsideBottomSheet({
    required BuildContext context,
    SBBBottomSheetConfig? sheetConfig,
    String? sheetTitleText,
    String? sheetButtonLabelText,
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
    int minuteInterval = pickerDefaultMinuteInterval,
    ValueChanged<TimeOfDay>? onTimeChanged,
    int visibleItemCount = pickerDefaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
  }) {
    final localizations = MaterialLocalizations.of(context);
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    final effectiveTitleText =
        sheetTitleText ??
        effectiveConfig.titleText ??
        (effectiveConfig.title == null ? localizations.timePickerInputHelpText : null);

    final effectiveInitialTime = PickerUtils.clampedAndIntervaledTime(
      initialTime ?? TimeOfDay.now(),
      minimumTime,
      maximumTime,
      minuteInterval,
    );

    final acceptInitialSelection = initialTime == null;
    final selectedButtonEnabled = ValueNotifier(acceptInitialSelection);
    final selectedButtonLabelText = sheetButtonLabelText ?? localizations.timePickerDialHelpText;

    var selectedTime = effectiveInitialTime;

    showSBBBottomSheet(
      context: context,
      title: effectiveConfig.title,
      titleText: effectiveTitleText,
      leading: effectiveConfig.leading,
      leadingIconData: effectiveConfig.leadingIconData,
      trailing: effectiveConfig.trailing,
      trailingIconData: effectiveConfig.trailingIconData,
      barrierLabel: effectiveConfig.barrierLabel,
      useRootNavigator: effectiveConfig.useRootNavigator,
      isDismissible: effectiveConfig.isDismissible,
      isScrollControlled: true,
      enableDrag: effectiveConfig.enableDrag,
      useSafeArea: effectiveConfig.useSafeArea,
      transitionAnimationController: effectiveConfig.transitionAnimationController,
      sheetAnimationStyle: effectiveConfig.animationStyle,
      showCloseButton: effectiveConfig.showCloseButton,
      body: Column(
        mainAxisSize: .min,
        children: [
          Padding(
            padding: const .symmetric(horizontal: SBBSpacing.medium),
            child: SBBContentBox(
              child: SBBTimePicker(
                initialTime: initialTime,
                minimumTime: minimumTime,
                maximumTime: maximumTime,
                minuteInterval: minuteInterval,
                visibleItemCount: visibleItemCount,
                pickerStyle: pickerStyle,
                onTimeChanged: (time) {
                  selectedTime = time;
                  if (!acceptInitialSelection) {
                    selectedButtonEnabled.value = time != effectiveInitialTime;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const .all(SBBSpacing.medium),
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
  State<SBBTimePicker> createState() => _SBBTimePickerState();
}

class _SBBTimePickerState extends State<SBBTimePicker> with TimeBasedPickerMixin<SBBTimePicker> {
  static const _horizontalPaddingCount = 4;

  late TimeOfDay _selectedTime;
  late ValueNotifier<TimeOfDay> _selectedTimeValueNotifier;

  late ValueNotifier<int> _hourValueNotifier;

  late SBBPickerScrollController _hourController;
  late SBBPickerScrollController _minuteController;

  late double _timeItemTextWidth;

  TimeOfDay get _safeMinTime => widget.minimumTime ?? pickerStartOfDay;

  TimeOfDay get _safeMaxTime => widget.maximumTime ?? pickerEndOfDay;

  double get _timeItemWidth => itemPadding + _timeItemTextWidth + itemPadding + pickerWidgetHorizontalPadding;

  @override
  void initState() {
    super.initState();
    itemPadding = pickerItemDefaultPadding;
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
          visibleItemCount: widget.visibleItemCount,
          pickerStyle: widget.pickerStyle,
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
    _selectedTimeValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildHourPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: _hourController,
      onSelectedItemChanged: _onSelectedHourItemChanged,
      itemBuilder: (_, index) => _buildHourItem(index),
      pickerStyle: widget.pickerStyle,
    );
  }

  Widget _buildMinutePickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _hourValueNotifier,
      builder: (context, selectedHour, _) {
        return SBBPickerScrollView(
          controller: _minuteController,
          onSelectedItemChanged: _onSelectedMinuteItemChanged,
          itemBuilder: (_, index) => _buildMinuteItem(index, selectedHour),
          pickerStyle: widget.pickerStyle,
        );
      },
    );
  }

  void _onSelectedHourItemChanged(int index) {
    _onTimeSelected(hour: _indexToHour(index));
  }

  void _onSelectedMinuteItemChanged(int index) {
    _onTimeSelected(minute: _indexToMinute(index));
  }

  SBBPickerItem _buildHourItem(int index) {
    final itemHour = _indexToHour(index);
    final itemTime = TimeOfDay(hour: itemHour, minute: 0);
    final minTime = _safeMinTime.floor();
    final maxTime = _safeMaxTime.ceil();
    final isEnabled = itemTime.isInRange(minTime, maxTime);
    final label = twoDigits(itemHour);

    return buildPickerItem(
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
    final isEnabled = itemTime.isInRange(_safeMinTime, _safeMaxTime);
    final label = twoDigits(itemMinute);

    return buildPickerItem(
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
    if (_hourController.isScrolling() || _minuteController.isScrolling()) return;
    _ensureValidTime();
  }

  void _ensureValidTime() {
    final minTime = _safeMinTime;
    final maxTime = _safeMaxTime;
    final isTimeInRange = _selectedTime.isInRange(minTime, maxTime);
    if (isTimeInRange) return;

    _ensureOptimizedScrollPosition();

    final correctToMinTime = _hourValueNotifier.value == minTime.hour;
    final correctedTime = correctToMinTime ? minTime : maxTime;

    if (correctToMinTime && _selectedTime.hour > minTime.hour) {
      _ensureOptimizedScrollPosition(offset: -TimeOfDay.hoursPerDay);
    } else if (!correctToMinTime && _selectedTime.hour < maxTime.hour) {
      _ensureOptimizedScrollPosition(offset: TimeOfDay.hoursPerDay);
    }

    final hourIndex = _hourToIndex(correctedTime.hour);
    final minuteIndex = _minuteToIndex(correctedTime.minute);

    if (_hourController.selectedItem != hourIndex) _hourController.animateToItem(hourIndex);
    if (_minuteController.selectedItem != minuteIndex) _minuteController.animateToItem(minuteIndex);
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
    return time.clamp(_safeMinTime, _safeMaxTime);
  }

  void _adjustItemSizes(double width) {
    itemPadding = pickerItemDefaultPadding;
    _timeItemTextWidth = max(pickerTimeItemTextDefaultWidth, timeItemTextMinWidth);

    final timeItemWidths = _timeItemWidth * pickerTimeItemCount;
    var widthOverflow = timeItemWidths - width;

    if (widthOverflow > 0) {
      final minWidths = timeItemTextMinWidth * pickerTimeItemCount;
      const defaultWidths = pickerTimeItemTextDefaultWidth * pickerTimeItemCount;
      final flexibleWidths = defaultWidths - minWidths;
      final widthReductions = min(flexibleWidths, widthOverflow);
      final reducedWidth = (defaultWidths - widthReductions) / pickerTimeItemCount;
      _timeItemTextWidth = reducedWidth;

      final availableTimeItemTextWidths = _availableTimeItemTextWidths(width);
      widthOverflow = minWidths - availableTimeItemTextWidths;
    }

    // check if item paddings need to be reduced
    if (widthOverflow > 0) {
      const minPaddings = pickerItemMinPadding * _horizontalPaddingCount;
      const defaultPaddings = pickerItemDefaultPadding * _horizontalPaddingCount;
      const flexiblePaddings = defaultPaddings - minPaddings;
      final paddingReductions = min(flexiblePaddings, widthOverflow);
      final reducedPadding = (defaultPaddings - paddingReductions) / _horizontalPaddingCount;
      itemPadding = reducedPadding;
    }
  }

  double _availableTimeItemTextWidths(double widgetWidth) {
    return widgetWidth - pickerWidgetHorizontalPadding * 2 - itemPadding * _horizontalPaddingCount;
  }

  int _indexToMinute(int minuteIndex) => minuteIndex * widget.minuteInterval % TimeOfDay.minutesPerHour;

  int _minuteToIndex(int minute) => minute ~/ widget.minuteInterval;

  int _indexToHour(int hourIndex) => hourIndex % TimeOfDay.hoursPerDay;

  int _hourToIndex(int hour) => hour;
}
