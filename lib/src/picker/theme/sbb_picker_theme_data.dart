import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The theme data for [SBBPicker], [SBBDatePicker], [SBBTimePicker],
/// [SBBDateTimePicker], [SBBDateInput], [SBBTimeInput] and [SBBDateTimeInput].
///
/// Use this to configure the default styles for all picker widgets within the
/// current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPickerTheme`.
@immutable
class SBBPickerThemeData extends ThemeExtension<SBBPickerThemeData> with Diagnosticable {
  const SBBPickerThemeData({
    this.pickerStyle,
    this.triggerDecorationStyle,
    this.triggerStyle,
    this.sheetStyle,
  });

  /// Overrides for the picker's default visual style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [pickerStyle] is null, then this theme doesn't override anything.
  final SBBPickerStyle? pickerStyle;

  /// Overrides for the trigger's decoration style.
  ///
  /// Non-null properties override the values of [SBBDecoratedTextThemeData.decorationStyle]
  /// and [SBBDecorationThemeData.style].
  ///
  /// If [triggerDecorationStyle] is null, then this theme doesn't override anything.
  final SBBDecorationStyle? triggerDecorationStyle;

  /// Overrides for the trigger's decorated text style.
  ///
  /// Non-null properties override the values of [SBBDecoratedTextThemeData.style].
  ///
  /// If [triggerStyle] is null, then this theme doesn't override anything.
  final SBBDecoratedTextStyle? triggerStyle;

  /// Overrides for the bottom sheet's style.
  ///
  /// Non-null properties override the values of [SBBBottomSheetThemeData.style].
  ///
  /// If [sheetStyle] is null, then this theme doesn't override anything.
  final SBBBottomSheetStyle? sheetStyle;

  @override
  SBBPickerThemeData copyWith({
    SBBPickerStyle? pickerStyle,
    SBBDecorationStyle? triggerDecorationStyle,
    SBBDecoratedTextStyle? triggerStyle,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    return SBBPickerThemeData(
      pickerStyle: pickerStyle ?? this.pickerStyle,
      triggerDecorationStyle: triggerDecorationStyle ?? this.triggerDecorationStyle,
      triggerStyle: triggerStyle ?? this.triggerStyle,
      sheetStyle: sheetStyle ?? this.sheetStyle,
    );
  }

  @override
  SBBPickerThemeData lerp(SBBPickerThemeData? other, double t) {
    if (other == null) return this;
    return SBBPickerThemeData(
      pickerStyle: pickerStyle?.lerp(other.pickerStyle, t),
      triggerDecorationStyle: SBBDecorationStyle.lerp(triggerDecorationStyle, other.triggerDecorationStyle, t),
      triggerStyle: SBBDecoratedTextStyle.lerp(triggerStyle, other.triggerStyle, t),
      sheetStyle: SBBBottomSheetStyle.lerp(sheetStyle, other.sheetStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(pickerStyle, triggerDecorationStyle, triggerStyle, sheetStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPickerThemeData &&
        other.pickerStyle == pickerStyle &&
        other.triggerDecorationStyle == triggerDecorationStyle &&
        other.triggerStyle == triggerStyle &&
        other.sheetStyle == sheetStyle;
  }
}

extension SBBPickerThemeDataX on SBBPickerThemeData {
  SBBPickerThemeData merge(SBBPickerThemeData? other) {
    if (other == null) return this;
    return copyWith(
      pickerStyle: pickerStyle?.merge(other.pickerStyle) ?? other.pickerStyle,
      triggerDecorationStyle:
          triggerDecorationStyle?.merge(other.triggerDecorationStyle) ?? other.triggerDecorationStyle,
      triggerStyle: triggerStyle?.merge(other.triggerStyle) ?? other.triggerStyle,
      sheetStyle: sheetStyle?.merge(other.sheetStyle) ?? other.sheetStyle,
    );
  }
}

extension SBBPickerThemeDataThemeDataX on ThemeData {
  /// Access the [SBBPickerThemeData] from the current theme.
  SBBPickerThemeData get sbbPickerTheme => extension<SBBPickerThemeData>()!;
}
