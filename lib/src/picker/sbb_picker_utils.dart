part of 'sbb_picker.dart';

// layout constants
const _itemHeight = 30.0;
const _visibleCenterItemIndex = 3;
const _longListMinItemCount = 4;
const _visibleItemCount = 7;
const _scrollAreaHeight = _itemHeight * _visibleItemCount;
const _itemDefaultPadding = 12.0;
const _itemMinPadding = 4.0;
const _widgetHorizontalPadding = _itemDefaultPadding;
const _timeItemTextDefaultWidth = _itemDefaultPadding * 4;
const _timeItemCount = 2;

// time constants
const _lastMinuteOfHour = TimeOfDay.minutesPerHour - 1;
const _startOfDay = TimeOfDay(hour: 0, minute: 0);
const _endOfDay = TimeOfDay(
  hour: TimeOfDay.hoursPerDay - 1,
  minute: _lastMinuteOfHour,
);

/// Abstract class extended by the State classes of [SBBDatePicker],
/// [SBBDateTimePicker] and [SBBTimePicker] that provides convenience methods.
abstract class _TimeBasedPickerState<T extends StatefulWidget>
    extends State<T> {
  late double _itemPadding;

  double get _timeItemTextMinWidth => _textSize('33').width;

  SBBPickerItem _buildPickerItem({
    required bool isEnabled,
    required String label,
    AlignmentGeometry? alignment,
    double? textWidth,
    bool isFirstColumn = false,
    bool isLastColumn = false,
  }) {
    return SBBPickerItem.custom(
      isEnabled: isEnabled,
      widget: Container(
        alignment: alignment,
        padding: EdgeInsets.only(
          left: _itemPadding + (isFirstColumn ? _widgetHorizontalPadding : 0),
          right: _itemPadding + (isLastColumn ? _widgetHorizontalPadding : 0),
        ),
        child: SizedBox(
          width: textWidth,
          child: Text(
            label,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Size _textSize(String text) {
    final textStyle = SBBControlStyles.of(context).picker!.textStyle;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textDirection = Directionality.of(context);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textDirection: textDirection,
    );
    textPainter.layout();
    final textSize = textPainter.size;
    return textSize;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}

/// Convenience methods on [DateTime].
extension DateTimeExtensions on DateTime {
  /// Creates a new [DateTime] from [this] with all time properties set to 0.
  DateTime get date => clearTime();

  /// Creates a new [DateTime] from [this] one by updating the time properties.
  ///
  /// The [clearTime] method creates a new [DateTime] object with values
  /// for the properties [DateTime.hour], [DateTime.minute], [DateTime.second],
  /// [DateTime.millisecond] and [DateTime.microsecond], provided by
  /// similarly named arguments, or 0 if no argument is provided, or using the
  /// existing value of the property if `null` is provided.
  DateTime clearTime({
    hour = 0,
    minute = 0,
    second = 0,
    millisecond = 0,
    microsecond = 0,
  }) {
    return copyWith(
      hour: hour,
      minute: minute,
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    );
  }

  /// Creates a new [DateTime] from [this] one by updating the time properties.
  ///
  /// The [roundToMinute] method creates a new [DateTime] object with values for
  /// the properties [DateTime.second], [DateTime.millisecond] and
  /// [DateTime.microsecond] set to 0 and [DateTime.minute] set to given value.
  DateTime roundToMinute(int minute) {
    return clearTime(
      hour: hour,
      minute: minute,
    );
  }

  /// Creates copy of [this] with the minute value rounded to the closest
  /// minute value that is divisible by [minuteInterval].
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:08 -> 17:15
  /// 17:07 -> 17:00
  /// 17:52 -> 17:45
  /// 17:53 -> 18:00 (hour value also affected)
  /// ```
  DateTime roundToInterval(int minuteInterval) {
    final roundedMinute = ((minute / minuteInterval).round() * minuteInterval);
    return roundToMinute(roundedMinute);
  }

  /// Creates copy of [this] with the minute value rounded to the greatest
  /// minute value that is divisible by [minuteInterval] but no greater than the
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:14 -> 17:00
  /// 17:29 -> 17:15
  /// ```
  DateTime floorToInterval(int minuteInterval) {
    final roundedMinute = ((minute / minuteInterval).floor() * minuteInterval);
    return roundToMinute(roundedMinute);
  }

  /// Creates copy of [this] with the minute value rounded to the least
  /// minute value that is divisible by [minuteInterval] but is not smaller than
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:16 -> 17:30
  /// 17:01 -> 17:15
  /// 17:46 -> 18:00 (hour value also affected)
  /// ```
  DateTime ceilToInterval(int minuteInterval) {
    final roundedMinute = ((minute / minuteInterval).ceil() * minuteInterval);
    return roundToMinute(roundedMinute);
  }

  /// Returns [this] clamped to be in the range [minimum]-[maximum].
  DateTime clamp(DateTime? minimum, DateTime? maximum) {
    if (minimum != null && isBefore(minimum)) {
      // round to minimum
      return minimum;
    }

    if (maximum != null && isAfter(maximum)) {
      // round to maximum
      return maximum;
    }

    // date time is valid
    return this;
  }

  /// Returns true if [this] occurs in range [start]-[end].
  bool isInRange(DateTime? start, DateTime? end) {
    if (start != null && isBefore(start)) {
      return false;
    }
    if (end != null && isAfter(end)) {
      return false;
    }
    return true;
  }
}

/// Convenience methods on [TimeOfDay].
extension TimeOfDayExtensions on TimeOfDay {
  /// Returns true if [this] occurs before [other].
  bool isBefore(TimeOfDay other) {
    if (this.hour == other.hour) {
      return this.minute < other.minute;
    }
    return this.hour < other.hour;
  }

  /// Returns true if [this] occurs after [other].
  bool isAfter(TimeOfDay other) {
    if (this.hour == other.hour) {
      return this.minute > other.minute;
    }
    return this.hour > other.hour;
  }

  /// Returns true if [this] occurs in range [start]-[end].
  ///
  /// If [start] is after [end], indicating a range over midnight, the function
  /// checks if the current time is between [start] and midnight,
  /// or between midnight and [end].
  bool isInRange(TimeOfDay start, TimeOfDay end) {
    if (start.isBefore(end)) {
      return !isBefore(start) && !isAfter(end);
    }

    // range over midnight
    final isBetweenMinTimeAndMidnight = isInRange(start, _endOfDay);
    final isBetweenMidnightAndMaxTime = isInRange(_startOfDay, end);
    return isBetweenMinTimeAndMidnight || isBetweenMidnightAndMaxTime;
  }

  /// Clamps [this] object to be within the specified time range
  /// [minimum]-[maximum]. If [this] is already within the range, it is returned
  /// unchanged. If [this] is not within the range, the function returns the
  /// closest valid [TimeOfDay] within the range.
  /// The function also supports time ranges that span across midnight.
  ///
  /// Example:
  /// ```
  /// value  minimum maximum result   comment
  /// 12:00   10:15   13:45   12:00   value is valid
  /// 10:00   10:15   13:45   10:15   rounded to minimum
  /// 14:00   10:15   13:45   13:45   rounded to maximum
  /// 00:00   10:15   13:45   13:45   rounded to maximum because time difference to maximum is lower
  /// 23:00   20:00   02:00   23:00   value is valid
  /// 18:00   20:00   02:00   20:00   rounded to minimum
  /// 03:00   20:00   02:00   02:00   rounded to maximum
  /// 12:00   20:00   02:00   20:00   rounded to minimum because time difference to minimum is lower
  /// ```
  TimeOfDay clamp(TimeOfDay? minimum, TimeOfDay? maximum) {
    if (minimum == null && maximum == null) {
      // no min or max time
      return this;
    }

    if (minimum != null && maximum == null) {
      // only min time
      if (isBefore(minimum)) {
        // round to min time
        return minimum;
      }
      // time is valid
      return this;
    }

    if (maximum != null && minimum == null) {
      // only max time
      if (isAfter(maximum)) {
        // round to max time
        return maximum;
      }
      // time is valid
      return this;
    }

    // minimum and maximum are not null
    minimum!;
    maximum!;

    // check if this is in valid range
    if (isInRange(minimum, maximum)) {
      // time is valid
      return this;
    }

    // find closest valid time
    final timeMinutes = toMinutes();
    final minTimeMinutes = minimum.toMinutes();
    final maxTimeMinutes = maximum.toMinutes();

    // day offset is used to check if there is a smaller diff trough midnight
    const dayOffsetMinutes = TimeOfDay.hoursPerDay * TimeOfDay.minutesPerHour;

    final minTimeDiff = (timeMinutes - minTimeMinutes).abs();
    final minTimeOffsetDiff =
        (timeMinutes - dayOffsetMinutes - minTimeMinutes).abs();
    final maxTimeDiff = (timeMinutes - maxTimeMinutes).abs();
    final maxTimeOffsetDiff =
        (timeMinutes + dayOffsetMinutes - maxTimeMinutes).abs();

    final smallerMinTimeDiff = min(minTimeDiff, minTimeOffsetDiff);
    final smallerMaxTimeDiff = min(maxTimeDiff, maxTimeOffsetDiff);

    if (smallerMinTimeDiff < smallerMaxTimeDiff) {
      return minimum;
    } else {
      return maximum;
    }
  }

  /// Converts [this] to minutes.
  ///
  /// Example:
  /// ```
  /// 00:15 ->   15
  /// 01:00 ->   60
  /// 01:15 ->   75
  /// 10:42 ->  642
  /// 23:01 -> 1381
  /// ```
  int toMinutes() => hour * TimeOfDay.minutesPerHour + minute;

  /// Creates a new [TimeOfDay] from [this] by updating [minute] to 0.
  TimeOfDay floor() => replacing(minute: 0);

  /// Creates a new [TimeOfDay] from [this] by updating [minute] to 59.
  TimeOfDay ceil() => replacing(minute: _lastMinuteOfHour);

  /// Creates copy of [this] with the minute value rounded to the closest minute
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
  TimeOfDay roundToInterval(int minuteInterval) {
    var roundedMinute = ((minute / minuteInterval).round() * minuteInterval);
    final roundedHour = (hour + roundedMinute ~/ TimeOfDay.minutesPerHour) %
        TimeOfDay.hoursPerDay;
    roundedMinute %= TimeOfDay.minutesPerHour;
    return replacing(hour: roundedHour, minute: roundedMinute);
  }

  /// Creates copy of [this] with the minute value rounded to the greatest
  /// minute value that is divisible by [minuteInterval] but no greater than the
  /// current minute value.
  ///
  /// ```
  /// Examples with minuteInterval: 15
  /// 17:15 -> 17:15
  /// 17:14 -> 17:00
  /// 17:29 -> 17:15
  /// ```
  TimeOfDay floorToInterval(int minuteInterval) {
    final roundedHour = hour + minute ~/ TimeOfDay.minutesPerHour;
    final roundedMinute = ((minute / minuteInterval).floor() * minuteInterval) %
        TimeOfDay.minutesPerHour;
    return replacing(hour: roundedHour, minute: roundedMinute);
  }

  /// Creates copy of [this] with the minute value rounded to the least minute
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
  TimeOfDay ceilToInterval(int minuteInterval) {
    var roundedMinute = ((minute / minuteInterval).ceil() * minuteInterval);
    final roundedHour = hour + roundedMinute ~/ TimeOfDay.minutesPerHour;
    roundedMinute %= TimeOfDay.minutesPerHour;
    return replacing(hour: roundedHour, minute: roundedMinute);
  }
}
