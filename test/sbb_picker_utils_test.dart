import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/src/picker/sbb_picker_utils.dart';

void main() {
  group('DateTimeExtensions.ceilToInterval', () {
    test('ceilToInterval_whenAlreadyOnInterval_thenReturnsSameMinuteWithClearedSeconds', () {
      // ARRANGE
      final value = DateTime(2026, 4, 10, 17, 30, 42, 9, 8);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, DateTime(2026, 4, 10, 17, 30));
    });

    test('ceilToInterval_whenMinuteNeedsRounding_thenRoundsUpWithinSameHour', () {
      // ARRANGE
      final value = DateTime(2026, 4, 10, 17, 16);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, DateTime(2026, 4, 10, 17, 30));
    });

    test('ceilToInterval_whenMinuteOverflowsHour_thenCarriesToNextHour', () {
      // ARRANGE
      final value = DateTime(2026, 4, 10, 17, 46);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, DateTime(2026, 4, 10, 18, 0));
    });

    test('ceilToInterval_whenAtEndOfDay_thenCarriesToNextDay', () {
      // ARRANGE
      final value = DateTime(2026, 4, 10, 23, 59);

      // ACT
      final result = value.ceilToInterval(30);

      // EXPECT
      expect(result, DateTime(2026, 4, 11, 0, 0));
    });

    test('ceilToInterval_whenAtEndOfYear_thenCarriesToNextYear', () {
      // ARRANGE
      final value = DateTime(2026, 12, 31, 23, 59);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, DateTime(2027, 1, 1, 0, 0));
    });
  });

  group('TimeOfDayExtensions.ceilToInterval', () {
    test('ceilToInterval_whenAlreadyOnInterval_thenReturnsUnchangedTime', () {
      // ARRANGE
      const value = TimeOfDay(hour: 8, minute: 45);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 8, minute: 45));
    });

    test('ceilToInterval_whenMinuteNeedsRounding_thenRoundsUpWithinSameHour', () {
      // ARRANGE
      const value = TimeOfDay(hour: 8, minute: 1);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 8, minute: 15));
    });

    test('ceilToInterval_whenMinuteOverflowsHour_thenCarriesToNextHour', () {
      // ARRANGE
      const value = TimeOfDay(hour: 8, minute: 46);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 9, minute: 0));
    });

    test('ceilToInterval_whenAtEndOfDay_thenWrapsToStartOfDay', () {
      // ARRANGE
      const value = TimeOfDay(hour: 23, minute: 59);

      // ACT
      final result = value.ceilToInterval(15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 0, minute: 0));
    });

    test('ceilToInterval_whenHourCarryExceeds24_thenWrapsUsingModulo24', () {
      // ARRANGE
      const value = TimeOfDay(hour: 23, minute: 31);

      // ACT
      final result = value.ceilToInterval(30);

      // EXPECT
      expect(result, const TimeOfDay(hour: 0, minute: 0));
    });
  });

  group('PickerUtils minimum/maximum helpers', () {
    test('minimumTime_whenRoundingOverflowsDay_thenReturnsWrappedStartOfDay', () {
      // ARRANGE
      const minimum = TimeOfDay(hour: 23, minute: 59);

      // ACT
      final result = PickerUtils.minimumTime(minimum, 15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 0, minute: 0));
    });

    test('maximumTime_whenRoundingDown_thenKeepsSameDayAndFloorsMinutes', () {
      // ARRANGE
      const maximum = TimeOfDay(hour: 23, minute: 59);

      // ACT
      final result = PickerUtils.maximumTime(maximum, 15);

      // EXPECT
      expect(result, const TimeOfDay(hour: 23, minute: 45));
    });

    test('minimumDateTime_whenRoundingOverflowsDay_thenReturnsNextDayAtMidnight', () {
      // ARRANGE
      final minimum = DateTime(2026, 4, 10, 23, 59);

      // ACT
      final result = PickerUtils.minimumDateTime(minimum, 15);

      // EXPECT
      expect(result, DateTime(2026, 4, 11, 0, 0));
    });

    test('maximumDateTime_whenRoundingDown_thenReturnsSameDayFlooredMinute', () {
      // ARRANGE
      final maximum = DateTime(2026, 4, 10, 23, 59);

      // ACT
      final result = PickerUtils.maximumDateTime(maximum, 15);

      // EXPECT
      expect(result, DateTime(2026, 4, 10, 23, 45));
    });
  });
}
