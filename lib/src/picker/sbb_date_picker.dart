import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/picker/picker_constants.dart';
import 'package:sbb_design_system_mobile/src/picker/picker_utils.dart';
import 'package:sbb_design_system_mobile/src/picker/time_based_picker_mixin.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';

/// SBB Date Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBPicker], variant for custom values.
/// * [SBBDateTimePicker], variant for date time values.
/// * [SBBTimePicker], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBDatePicker extends StatefulWidget {
  /// Constructs an [SBBDatePicker].
  SBBDatePicker({
    super.key,
    required this.onDateChanged,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    this.visibleItemCount = pickerDefaultVisibleItemCount,
    this.pickerStyle,
    this.controller,
  }) : initialDate = PickerUtils.clampedDateOnly(initialDate ?? DateTime.now(), minimumDate, maximumDate),
       minimumDate = minimumDate?.date,
       maximumDate = maximumDate?.date {
    assert(
      this.minimumDate == null || this.maximumDate == null || this.minimumDate!.isBefore(this.maximumDate!),
      'minimum date (${this.minimumDate}) is not before maximum date (${this.maximumDate})',
    );
  }

  /// Called when the selected date changes.
  final ValueChanged<DateTime>? onDateChanged;

  /// The initially selected date of the picker.
  ///
  /// Defaults to `DateTime.now()`. If the initial date is outside the range
  /// defined by [minimumDate] and [maximumDate], it will be automatically
  /// adjusted to the closest valid date within the range.
  final DateTime initialDate;

  /// The minimum selectable date of the picker.
  ///
  /// If provided, dates before this minimum date will be disabled. If not
  /// provided, there will be no restriction on the minimum date that can be
  /// picked.
  ///
  /// Must be before [maximumDate] if both are set.
  final DateTime? minimumDate;

  /// The maximum selectable date of the picker.
  ///
  /// If provided, dates after this maximum date will be disabled. If not
  /// provided, there will be no restriction on the maximum date that can be
  /// picked.
  ///
  /// Must be after [minimumDate] if both are set.
  final DateTime? maximumDate;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
  final int visibleItemCount;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  /// Can be used to programmatically set the selected date, e.g. from
  /// instrumentation tests.
  final SBBDatePickerController? controller;

  /// Shows a [SBBBottomSheet] with an [SBBDatePicker] to select a [DateTime].
  ///
  /// See also:
  ///
  /// * [SBBDatePicker], which will be displayed.
  /// * [showSBBBottomSheet], which is used to display the [SBBBottomSheet] with the picker.
  /// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
  static void showInsideBottomSheet({
    required BuildContext context,
    SBBBottomSheetConfig? sheetConfig,
    String? sheetTitleText,
    String? sheetButtonLabelText,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    ValueChanged<DateTime>? onDateChanged,
    int visibleItemCount = pickerDefaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
  }) {
    assert(debugCheckHasSBBBaseStyle(context));

    final localizations = MaterialLocalizations.of(context);
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    final effectiveTitleText =
        sheetTitleText ??
        effectiveConfig.titleText ??
        (effectiveConfig.title == null ? localizations.dateInputLabel : null);

    final effectiveInitialDate = PickerUtils.clampedDateOnly(initialDate ?? DateTime.now(), minimumDate, maximumDate);

    final acceptInitialSelection = initialDate == null;
    final selectedButtonEnabled = ValueNotifier(acceptInitialSelection);
    final selectedButtonLabelText = sheetButtonLabelText ?? localizations.datePickerHelpText;

    var selectedDate = effectiveInitialDate;

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
      isScrollControlled: true,
      isDismissible: effectiveConfig.isDismissible,
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
              child: SBBDatePicker(
                initialDate: effectiveInitialDate,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                visibleItemCount: visibleItemCount,
                pickerStyle: pickerStyle,
                onDateChanged: (date) {
                  selectedDate = date;
                  if (!acceptInitialSelection) {
                    selectedButtonEnabled.value = date != effectiveInitialDate;
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
                        onDateChanged?.call(selectedDate);
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
  State<SBBDatePicker> createState() => _SBBDatePickerState();
}

/// A controller for [SBBDatePicker] that allows programmatically setting the
/// selected date, e.g. from instrumentation tests.
///
/// Attach it to a picker via [SBBDatePicker.controller]. A controller can only
/// be attached to one picker at a time.
///
/// See also:
///
/// * `example/integration_test/widget_tester_extensions.dart`, which wraps
///   [setDate] in a `WidgetTester.selectSBBDate` helper that takes care of the
///   pumping needed in widget and integration tests.
class SBBDatePickerController {
  _SBBDatePickerState? _state;

  /// Whether this controller is currently attached to an [SBBDatePicker].
  bool get isAttached => _state != null;

  /// Sets the selected date of the attached [SBBDatePicker].
  ///
  /// [date] is clamped to [SBBDatePicker.minimumDate] and
  /// [SBBDatePicker.maximumDate]; its time components are ignored.
  /// [SBBDatePicker.onDateChanged] is called for every selection change caused
  /// by the resulting scroll, ending with the target date.
  ///
  /// If [animate] is true, the picker columns scroll to the target date,
  /// otherwise they jump there without animation. The returned future
  /// completes when the scroll animations are done.
  ///
  /// Note for widget tests (fake async): animations only advance while frames
  /// are pumped, so either pass `animate: false` or pump before awaiting the
  /// returned future:
  ///
  /// ```dart
  /// final done = controller.setDate(DateTime(2026, 3, 31));
  /// await tester.pumpAndSettle();
  /// await done;
  /// ```
  ///
  /// Must only be called while attached to a picker that has been laid out:
  /// calling while not attached asserts in debug mode and does nothing in
  /// release mode.
  Future<void> setDate(DateTime date, {bool animate = true}) {
    final state = _state;
    assert(state != null, 'SBBDatePickerController.setDate called while not attached to an SBBDatePicker.');
    if (state == null) return Future<void>.value();
    return state.setDate(date, animate: animate);
  }

  void _attach(_SBBDatePickerState state) {
    assert(_state == null, 'SBBDatePickerController is already attached to an SBBDatePicker.');
    _state = state;
  }

  void _detach(_SBBDatePickerState state) {
    if (_state == state) _state = null;
  }
}

class _SBBDatePickerState extends State<SBBDatePicker> with TimeBasedPickerMixin<SBBDatePicker> {
  static const _dayItemTextDefaultWidth = 40.0;
  static const _yearItemTextDefaultWidth = 64.0;

  static const _dayItemCount = 31;
  static const _horizontalPaddingCount = 6;

  late DateTime _selectedDate;
  late ValueNotifier<DateTime> _selectedDateValueNotifier;

  late ValueNotifier<DateTime> _monthYearValueNotifier;
  late ValueNotifier<int> _yearValueNotifier;

  late SBBPickerScrollController _dayController;
  late SBBPickerScrollController _monthController;
  late SBBPickerScrollController _yearController;

  late DateFormat _dateFormat;
  late double _dayItemTextWidth;
  late double _yearItemTextWidth;

  double get _dayItemWidth => pickerWidgetHorizontalPadding + itemPadding + _dayItemTextWidth + itemPadding;

  double get _yearItemWidth => itemPadding + _yearItemTextWidth + itemPadding + pickerWidgetHorizontalPadding;

  double get _dayItemTextMinWidth => measureText('33.').width;

  double get _yearItemTextMinWidth => measureText('9999').width;

  @override
  void initState() {
    super.initState();
    itemPadding = pickerItemDefaultPadding;
    _selectedDate = widget.initialDate;
    _selectedDateValueNotifier = ValueNotifier(_selectedDate);
    final onDateChanged = widget.onDateChanged;
    if (onDateChanged != null) {
      _selectedDateValueNotifier.addListener(() {
        onDateChanged(_selectedDateValueNotifier.value);
      });
    }
    _monthYearValueNotifier = ValueNotifier(_selectedDate);
    _yearValueNotifier = ValueNotifier(_selectedDate.year);

    _initDayController();
    _initMonthController();
    _initYearController();

    widget.controller?._attach(this);
  }

  @override
  void didUpdateWidget(SBBDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
  }

  void _initDayController() {
    _dayController = SBBPickerScrollController(initialItem: _dayToIndex(_selectedDate.day));
    _dayController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initMonthController() {
    _monthController = SBBPickerScrollController(
      initialItem: _monthToIndex(_selectedDate.month),
      onTargetItemSelected: (int index) {
        final closestValidDate = _closestValidDate(monthIndex: index);
        _monthYearValueNotifier.value = closestValidDate;
      },
    );
    _monthController.addScrollingStateListener(_onScrollingStateChanged);
  }

  void _initYearController() {
    _yearController = SBBPickerScrollController(
      initialItem: _yearToIndex(_selectedDate.year),
      onTargetItemSelected: (int index) {
        final closestValidDate = _closestValidDate(yearIndex: index);
        _monthYearValueNotifier.value = closestValidDate;
        _yearValueNotifier.value = closestValidDate.year;
      },
    );
    _yearController.addScrollingStateListener(_onScrollingStateChanged);
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
              SizedBox(width: _dayItemWidth, child: _buildDayPickerScrollView(context)),
              Expanded(child: _buildMonthPickerScrollView(context)),
              SizedBox(width: _yearItemWidth, child: _buildYearPickerScrollView(context)),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller?._detach(this);
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _selectedDateValueNotifier.dispose();
    _monthYearValueNotifier.dispose();
    _yearValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildDayPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _monthYearValueNotifier,
      builder: (context, selectedMonthYear, _) {
        return SBBPickerScrollView(
          controller: _dayController,
          onSelectedItemChanged: _onSelectedDayItemChanged,
          itemBuilder: (_, index) => _buildDayItem(index, selectedMonthYear),
          pickerStyle: widget.pickerStyle,
        );
      },
    );
  }

  Widget _buildMonthPickerScrollView(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _yearValueNotifier,
      builder: (context, selectedYear, _) {
        return SBBPickerScrollView(
          controller: _monthController,
          onSelectedItemChanged: _onSelectedMonthItemChanged,
          itemBuilder: (_, index) => _buildMonthItem(index, selectedYear),
          pickerStyle: widget.pickerStyle,
        );
      },
    );
  }

  Widget _buildYearPickerScrollView(BuildContext context) {
    return SBBPickerScrollView(
      controller: _yearController,
      looping: false,
      onSelectedItemChanged: _onSelectedYearItemChanged,
      itemBuilder: (_, index) => _buildYearItem(index),
      pickerStyle: widget.pickerStyle,
    );
  }

  Future<void> setDate(DateTime date, {bool animate = true}) async {
    assert(
      _dayController.hasClients && _monthController.hasClients && _yearController.hasClients,
      'Cannot set the date of an SBBDatePicker that has not been laid out yet.',
    );

    final targetDate = PickerUtils.clampedDateOnly(date, widget.minimumDate, widget.maximumDate);

    _ensureOptimizedScrollPosition();

    final dayIndex = _dayToIndex(targetDate.day);
    final monthIndex = _monthToIndex(targetDate.month);
    final yearIndex = _yearToIndex(targetDate.year);

    _monthYearValueNotifier.value = targetDate;
    _yearValueNotifier.value = targetDate.year;

    if (animate) {
      await Future.wait([
        if (_dayController.selectedItem != dayIndex) _dayController.animateToItem(dayIndex),
        if (_monthController.selectedItem != monthIndex) _monthController.animateToItem(monthIndex),
        if (_yearController.selectedItem != yearIndex) _yearController.animateToItem(yearIndex),
      ]);
    } else {
      _dayController.jumpToItem(dayIndex);
      _monthController.jumpToItem(monthIndex);
      _yearController.jumpToItem(yearIndex);
    }

    _onDateSelected(
      year: _indexToYear(_yearController.selectedItem),
      month: _indexToMonth(_monthController.selectedItem),
      day: _indexToDay(_dayController.selectedItem),
    );
  }

  void _onSelectedDayItemChanged(int index) {
    _onDateSelected(day: _indexToDay(index));
  }

  void _onSelectedMonthItemChanged(int index) {
    _onDateSelected(month: _indexToMonth(index));
  }

  void _onSelectedYearItemChanged(int index) {
    _onDateSelected(year: _indexToYear(index));
  }

  SBBPickerItem _buildDayItem(int index, DateTime selectedMonthYear) {
    final itemDay = _indexToDay(index);
    final daysInMonth = DateUtils.getDaysInMonth(selectedMonthYear.year, selectedMonthYear.month);
    final dayOverflow = itemDay > daysInMonth;

    final itemDate = selectedMonthYear.copyWith(day: itemDay);
    final minDate = widget.minimumDate;
    final maxDate = dayOverflow ? selectedMonthYear.copyWith(day: daysInMonth) : widget.maximumDate;
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = '$itemDay.';

    return buildPickerItem(isEnabled: isEnabled, label: label, alignment: Alignment.centerRight, isFirstColumn: true);
  }

  SBBPickerItem _buildMonthItem(int index, int selectedYear) {
    final itemMonth = _indexToMonth(index);
    final itemDate = DateTime(selectedYear, itemMonth);
    final minDate = widget.minimumDate?.copyWith(day: 1);
    final maxDate = widget.maximumDate?.copyWith(day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = _dateFormat.format(itemDate);

    return buildPickerItem(isEnabled: isEnabled, label: label, alignment: Alignment.centerLeft);
  }

  SBBPickerItem _buildYearItem(int index) {
    final itemYear = _indexToYear(index);
    final itemDate = DateTime(itemYear);
    final minDate = widget.minimumDate?.copyWith(month: 1, day: 1);
    final maxDate = widget.maximumDate?.copyWith(month: 1, day: 1);
    final isEnabled = itemDate.isInRange(minDate, maxDate);
    final label = itemYear.toString();

    return buildPickerItem(isEnabled: isEnabled, label: label, isLastColumn: true);
  }

  void _onDateSelected({int? year, int? month, int? day}) {
    final selectedYear = year ?? _selectedDate.year;
    final selectedMonth = month ?? _selectedDate.month;
    var selectedDay = day ?? _selectedDate.day;

    final daysInMonth = DateUtils.getDaysInMonth(selectedYear, selectedMonth);
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
    }

    _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    _selectedDateValueNotifier.value = _selectedDate.clamp(widget.minimumDate, widget.maximumDate);
  }

  void _onScrollingStateChanged() {
    if (_yearController.isScrolling() || _monthController.isScrolling() || _dayController.isScrolling()) {
      return;
    }
    _ensureValidDate();
  }

  void _ensureValidDate() {
    _ensureOptimizedScrollPosition();

    final validDate = _selectedDate.clamp(widget.minimumDate, widget.maximumDate);

    if (_selectedDate == validDate) {
      final selectedDay = _indexToDay(_dayController.selectedItem);
      final daysInMonth = DateUtils.getDaysInMonth(validDate.year, validDate.month);
      final dayOverflow = selectedDay > daysInMonth;
      if (dayOverflow) {
        _dayController.animateToItem(_dayToIndex(daysInMonth));
        return;
      }
      return;
    }

    final dayIndex = _dayToIndex(validDate.day);
    final monthIndex = _monthToIndex(validDate.month);
    final yearIndex = _yearToIndex(validDate.year);

    if (_dayController.selectedItem != dayIndex) _dayController.animateToItem(dayIndex);
    if (_monthController.selectedItem != monthIndex) _monthController.animateToItem(monthIndex);
    if (_yearController.selectedItem != yearIndex) _yearController.animateToItem(yearIndex);
  }

  void _ensureOptimizedScrollPosition() {
    final monthIndex = _monthController.selectedItem % DateTime.monthsPerYear;
    final dayIndex = _dayController.selectedItem % _dayItemCount;
    _monthController.jumpToItem(monthIndex);
    _dayController.jumpToItem(dayIndex);
  }

  DateTime _closestValidDate({int? yearIndex, int? monthIndex}) {
    final year = _indexToYear(yearIndex ?? _yearController.selectedItem);
    final month = _indexToMonth(monthIndex ?? _monthController.selectedItem);
    var day = _indexToDay(_dayController.selectedItem);

    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    if (day > daysInMonth) day = daysInMonth;

    var date = DateTime(year, month, day);
    date = date.clamp(widget.minimumDate, widget.maximumDate);
    return date;
  }

  void _adjustItemSizes(double width) {
    itemPadding = pickerItemDefaultPadding;
    _dayItemTextWidth = max(_dayItemTextDefaultWidth, _dayItemTextMinWidth);
    _yearItemTextWidth = max(_yearItemTextDefaultWidth, _yearItemTextMinWidth);

    final localeObject = Localizations.maybeLocaleOf(context);
    final localeExists = DateFormat.localeExists(localeObject.toString());
    final locale = localeExists ? localeObject.toString() : null;

    _dateFormat = DateFormat.MMMM(locale);

    final availableMonthItemTextWidth = _availableMonthItemTextWidth(width);
    final longMonthTextMinWidth = _monthItemTextMinWidth(_dateFormat);
    var widthOverflow = longMonthTextMinWidth - availableMonthItemTextWidth;

    if (widthOverflow > 0) {
      _dateFormat = DateFormat.MMM(locale);
      final shortMonthTextMinWidth = _monthItemTextMinWidth(_dateFormat);
      final widthReduction = longMonthTextMinWidth - shortMonthTextMinWidth;
      widthOverflow -= widthReduction;
    }

    if (widthOverflow > 0) {
      final dayItemFlexibleWidth = _dayItemTextDefaultWidth - _dayItemTextMinWidth;
      final yearItemFlexibleWidth = _yearItemTextDefaultWidth - _yearItemTextMinWidth;
      final flexibleWidths = dayItemFlexibleWidth + yearItemFlexibleWidth;
      final widthReductions = min(flexibleWidths, widthOverflow);
      final widthReductionRatio = widthReductions / flexibleWidths;
      _dayItemTextWidth = _dayItemTextDefaultWidth - dayItemFlexibleWidth * widthReductionRatio;
      _yearItemTextWidth = _yearItemTextDefaultWidth - yearItemFlexibleWidth * widthReductionRatio;
      widthOverflow -= widthReductions;
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

  double _availableMonthItemTextWidth(double widgetWidth) {
    return widgetWidth -
        pickerWidgetHorizontalPadding * 2 -
        itemPadding * _horizontalPaddingCount -
        _dayItemTextWidth -
        _yearItemTextWidth;
  }

  double _monthItemTextMinWidth(DateFormat dateFormat) {
    final year = widget.initialDate.year;
    var dateTextWidth = 0.0;
    for (var i = 0; i < DateTime.monthsPerYear; i++) {
      final month = i + 1;
      final date = DateTime(year, month);
      final itemLabel = dateFormat.format(date);
      final itemTextWidth = measureText(itemLabel).width;
      if (itemTextWidth > dateTextWidth) dateTextWidth = itemTextWidth;
    }
    return dateTextWidth;
  }

  int _indexToDay(int dayIndex) => dayIndex % _dayItemCount + 1;

  int _dayToIndex(int day) => day - 1;

  int _indexToMonth(int monthIndex) => monthIndex % DateTime.monthsPerYear + 1;

  int _monthToIndex(int month) => month - 1;

  int _indexToYear(int yearIndex) => widget.initialDate.year + yearIndex;

  int _yearToIndex(int year) => year - widget.initialDate.year;
}
