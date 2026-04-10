import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

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
    this.triggerDecorationTheme,
    this.triggerStyle,
    this.sheetStyle,
  });

  /// Overrides for the picker's default visual style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [pickerStyle] is null, then this theme doesn't override anything.
  final SBBPickerStyle? pickerStyle;

  /// Overrides for the trigger's decoration default theme.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [triggerDecorationTheme] is null, then this theme doesn't override anything.
  final SBBInputDecorationThemeData? triggerDecorationTheme;

  /// Overrides for the trigger's decorated text default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [triggerStyle] is null, then this theme doesn't override anything.
  final SBBDecoratedTextStyle? triggerStyle;

  /// Overrides for the bottom sheet's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [sheetStyle] is null, then this theme doesn't override anything.
  final SBBBottomSheetStyle? sheetStyle;

  @override
  SBBPickerThemeData copyWith({
    SBBPickerStyle? pickerStyle,
    SBBInputDecorationThemeData? triggerDecorationTheme,
    SBBDecoratedTextStyle? triggerStyle,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    return SBBPickerThemeData(
      pickerStyle: pickerStyle ?? this.pickerStyle,
      triggerDecorationTheme: triggerDecorationTheme ?? this.triggerDecorationTheme,
      triggerStyle: triggerStyle ?? this.triggerStyle,
      sheetStyle: sheetStyle ?? this.sheetStyle,
    );
  }

  @override
  SBBPickerThemeData lerp(SBBPickerThemeData? other, double t) {
    if (other == null) return this;
    return SBBPickerThemeData(
      pickerStyle: pickerStyle?.lerp(other.pickerStyle, t),
      triggerDecorationTheme: triggerDecorationTheme?.lerp(other.triggerDecorationTheme, t),
      triggerStyle: SBBDecoratedTextStyle.lerp(triggerStyle, other.triggerStyle, t),
      sheetStyle: SBBBottomSheetStyle.lerp(sheetStyle, other.sheetStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(pickerStyle, triggerDecorationTheme, triggerStyle, sheetStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPickerThemeData &&
        other.pickerStyle == pickerStyle &&
        other.triggerDecorationTheme == triggerDecorationTheme &&
        other.triggerStyle == triggerStyle &&
        other.sheetStyle == sheetStyle;
  }
}

extension SBBPickerThemeDataX on SBBPickerThemeData {
  SBBPickerThemeData merge(SBBPickerThemeData? other) {
    if (other == null) return this;
    return copyWith(
      pickerStyle: pickerStyle?.merge(other.pickerStyle) ?? other.pickerStyle,
      triggerDecorationTheme:
          triggerDecorationTheme?.merge(other.triggerDecorationTheme) ?? other.triggerDecorationTheme,
      triggerStyle: triggerStyle?.merge(other.triggerStyle) ?? other.triggerStyle,
      sheetStyle: sheetStyle?.merge(other.sheetStyle) ?? other.sheetStyle,
    );
  }
}

extension SBBPickerThemeDataThemeDataX on ThemeData {
  SBBPickerThemeData? get sbbPickerTheme {
    return extension<SBBPickerThemeData>();
  }
}
