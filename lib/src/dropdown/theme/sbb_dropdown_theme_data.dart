import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The theme data for [SBBDropdown] and [SBBMultiDropdown].
///
/// Use this to configure the default styles for all dropdown widgets within the
/// current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbDropdownTheme`.
@immutable
class SBBDropdownThemeData extends ThemeExtension<SBBDropdownThemeData> with Diagnosticable {
  const SBBDropdownThemeData({
    this.triggerDecorationTheme,
    this.triggerStyle,
    this.sheetStyle,
  });

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
  SBBDropdownThemeData copyWith({
    SBBInputDecorationThemeData? triggerDecorationTheme,
    SBBDecoratedTextStyle? triggerStyle,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    return SBBDropdownThemeData(
      triggerDecorationTheme: triggerDecorationTheme ?? this.triggerDecorationTheme,
      triggerStyle: triggerStyle ?? this.triggerStyle,
      sheetStyle: sheetStyle ?? this.sheetStyle,
    );
  }

  @override
  SBBDropdownThemeData lerp(SBBDropdownThemeData? other, double t) {
    if (other == null) return this;
    return SBBDropdownThemeData(
      triggerDecorationTheme: triggerDecorationTheme?.lerp(other.triggerDecorationTheme, t),
      triggerStyle: SBBDecoratedTextStyle.lerp(triggerStyle, other.triggerStyle, t),
      sheetStyle: SBBBottomSheetStyle.lerp(sheetStyle, other.sheetStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(triggerDecorationTheme, triggerStyle, sheetStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDropdownThemeData &&
        other.triggerDecorationTheme == triggerDecorationTheme &&
        other.triggerStyle == triggerStyle &&
        other.sheetStyle == sheetStyle;
  }
}

extension SBBDropdownThemeDataX on SBBDropdownThemeData {
  SBBDropdownThemeData merge(SBBDropdownThemeData? other) {
    if (other == null) return this;
    return copyWith(
      triggerDecorationTheme:
          triggerDecorationTheme?.merge(other.triggerDecorationTheme) ?? other.triggerDecorationTheme,
      triggerStyle: triggerStyle?.merge(other.triggerStyle) ?? other.triggerStyle,
      sheetStyle: sheetStyle?.merge(other.sheetStyle) ?? other.sheetStyle,
    );
  }
}

extension SBBDropdownThemeDataThemeDataX on ThemeData {
  SBBDropdownThemeData? get sbbDropdownTheme {
    return extension<SBBDropdownThemeData>();
  }
}
