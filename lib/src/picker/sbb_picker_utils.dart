import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/picker/sbb_picker_constants.dart';

/// Convenience methods on [DateTime].
extension DateTimeX on DateTime {
  /// Creates a new [DateTime] from [this] with all time properties set to 0.
  DateTime get date => clearTime();

  /// Creates a new [DateTime] from [this] one by updating the time properties.
  ///
  /// The [clearTime] method creates a new [DateTime] object with values
  /// for the properties [DateTime.hour], [DateTime.minute], [DateTime.second],
  /// [DateTime.millisecond] and [DateTime.microsecond], provided by
  /// similarly named arguments, or 0 if no argument is provided, or using the
  /// existing value of the property if `null` is provided.
  DateTime clearTime({int? hour = 0, int? minute = 0, int? second = 0, int? millisecond = 0, int? microsecond = 0}) {
    return copyWith(hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond);
  }

  /// Creates a new [DateTime] from [this] one by updating the time properties.
  ///
  /// The [roundToMinute] method creates a new [DateTime] object with values for
  /// the properties [DateTime.second], [DateTime.millisecond] and
  /// [DateTime.microsecond] set to 0 and [DateTime.minute] set to given value.
  DateTime roundToMinute(int minute) {
    return clearTime(hour: hour, minute: minute);
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
    if (minimum != null && isBefore(minimum)) return minimum;
    if (maximum != null && isAfter(maximum)) return maximum;

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
extension TimeOfDayX on TimeOfDay {
  /// Returns true if [this] occurs before [other].
  bool isBefore(TimeOfDay other) {
    if (hour == other.hour) {
      return minute < other.minute;
    }
    return hour < other.hour;
  }

  /// Returns true if [this] occurs after [other].
  bool isAfter(TimeOfDay other) {
    if (hour == other.hour) {
      return minute > other.minute;
    }
    return hour > other.hour;
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
    final isBetweenMinTimeAndMidnight = isInRange(start, pickerEndOfDay);
    final isBetweenMidnightAndMaxTime = isInRange(pickerStartOfDay, end);
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
      return this;
    }

    if (minimum != null && maximum == null) {
      if (isBefore(minimum)) {
        return minimum;
      }
      return this;
    }

    if (maximum != null && minimum == null) {
      if (isAfter(maximum)) {
        return maximum;
      }
      return this;
    }

    minimum!;
    maximum!;

    if (isInRange(minimum, maximum)) {
      return this;
    }

    final timeMinutes = toMinutes();
    final minTimeMinutes = minimum.toMinutes();
    final maxTimeMinutes = maximum.toMinutes();

    const dayOffsetMinutes = TimeOfDay.hoursPerDay * TimeOfDay.minutesPerHour;

    final minTimeDiff = (timeMinutes - minTimeMinutes).abs();
    final minTimeOffsetDiff = (timeMinutes - dayOffsetMinutes - minTimeMinutes).abs();
    final maxTimeDiff = (timeMinutes - maxTimeMinutes).abs();
    final maxTimeOffsetDiff = (timeMinutes + dayOffsetMinutes - maxTimeMinutes).abs();

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
  TimeOfDay ceil() => replacing(minute: pickerLastMinuteOfHour);

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
    final roundedHour = (hour + roundedMinute ~/ TimeOfDay.minutesPerHour) % TimeOfDay.hoursPerDay;
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
    final roundedMinute = ((minute / minuteInterval).floor() * minuteInterval) % TimeOfDay.minutesPerHour;
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
  /// 23:59 -> 00:00 (wraps to the next day)
  /// ```
  TimeOfDay ceilToInterval(int minuteInterval) {
    var roundedMinute = ((minute / minuteInterval).ceil() * minuteInterval);
    final roundedHour = (hour + roundedMinute ~/ TimeOfDay.minutesPerHour) % TimeOfDay.hoursPerDay;
    roundedMinute %= TimeOfDay.minutesPerHour;
    return replacing(hour: roundedHour, minute: roundedMinute);
  }
}

/// Utility functions for picker formatting and value clamping.
class PickerUtils {
  /// Clamps and applies minute interval to a [TimeOfDay] value.
  ///
  /// Rounds the value to the closest minute interval and clamps it to be
  /// within the [minTime] and [maxTime] range.
  static TimeOfDay clampedAndIntervaledTime(
    TimeOfDay value,
    TimeOfDay? minTime,
    TimeOfDay? maxTime,
    int minuteInterval,
  ) {
    TimeOfDay result = value.roundToInterval(minuteInterval);
    result = result.clamp(minimumTime(minTime, minuteInterval), maximumTime(maxTime, minuteInterval));
    return result;
  }

  /// Clamps a [DateTime] to date only (strips time components).
  ///
  /// Clamps the date portion of the value to be within the [minimumDate]
  /// and [maximumDate] range.
  static DateTime clampedDateOnly(DateTime value, DateTime? minimumDate, DateTime? maximumDate) =>
      value.clamp(minimumDate, maximumDate).date;

  /// Clamps and applies minute interval to a [DateTime] value.
  ///
  /// Rounds the value to the closest minute interval and clamps it to be
  /// within the [minDateTime] and [maxDateTime] range.
  static DateTime clampedAndTimeIntervaledDateTime(
    DateTime value,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    int minuteInterval,
  ) {
    DateTime result = value.roundToInterval(minuteInterval);
    result = result.clamp(
      minimumDateTime(minDateTime, minuteInterval),
      maximumDateTime(maxDateTime, minuteInterval),
    );
    return result;
  }

  static TimeOfDay? minimumTime(TimeOfDay? minimumTime, int minuteInterval) {
    return minimumTime?.ceilToInterval(minuteInterval);
  }

  static TimeOfDay? maximumTime(TimeOfDay? maximumTime, int minuteInterval) {
    return maximumTime?.floorToInterval(minuteInterval);
  }

  static DateTime? minimumDateTime(DateTime? minimumDateTime, int minuteInterval) =>
      minimumDateTime?.ceilToInterval(minuteInterval);

  static DateTime? maximumDateTime(DateTime? maximumDateTime, int minuteInterval) =>
      maximumDateTime?.floorToInterval(minuteInterval);
}
