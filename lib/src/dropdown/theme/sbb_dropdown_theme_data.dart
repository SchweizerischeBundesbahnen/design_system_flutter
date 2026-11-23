import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The theme data for [SBBDropdown] and [SBBMultiDropdown].
///
/// Use this to configure the default styles for all dropdown widgets within the
/// current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbDropdownTheme`.
@immutable
class SBBDropdownThemeData extends ThemeExtension<SBBDropdownThemeData> with Diagnosticable {
  const SBBDropdownThemeData({
    this.triggerDecorationStyle,
    this.triggerStyle,
    this.sheetStyle,
  });

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
  SBBDropdownThemeData copyWith({
    SBBDecorationStyle? triggerDecorationStyle,
    SBBDecoratedTextStyle? triggerStyle,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    return SBBDropdownThemeData(
      triggerDecorationStyle: triggerDecorationStyle ?? this.triggerDecorationStyle,
      triggerStyle: triggerStyle ?? this.triggerStyle,
      sheetStyle: sheetStyle ?? this.sheetStyle,
    );
  }

  @override
  SBBDropdownThemeData lerp(SBBDropdownThemeData? other, double t) {
    if (other == null) return this;
    return SBBDropdownThemeData(
      triggerDecorationStyle: SBBDecorationStyle.lerp(triggerDecorationStyle, other.triggerDecorationStyle, t),
      triggerStyle: SBBDecoratedTextStyle.lerp(triggerStyle, other.triggerStyle, t),
      sheetStyle: SBBBottomSheetStyle.lerp(sheetStyle, other.sheetStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(triggerDecorationStyle, triggerStyle, sheetStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDropdownThemeData &&
        other.triggerDecorationStyle == triggerDecorationStyle &&
        other.triggerStyle == triggerStyle &&
        other.sheetStyle == sheetStyle;
  }
}

extension SBBDropdownThemeDataX on SBBDropdownThemeData {
  SBBDropdownThemeData merge(SBBDropdownThemeData? other) {
    if (other == null) return this;
    return copyWith(
      triggerDecorationStyle:
          triggerDecorationStyle?.merge(other.triggerDecorationStyle) ?? other.triggerDecorationStyle,
      triggerStyle: triggerStyle?.merge(other.triggerStyle) ?? other.triggerStyle,
      sheetStyle: sheetStyle?.merge(other.sheetStyle) ?? other.sheetStyle,
    );
  }
}

extension SBBDropdownThemeDataThemeDataX on ThemeData {
  /// Access the [SBBDropdownThemeData] from the current theme.
  SBBDropdownThemeData get sbbDropdownTheme => extension<SBBDropdownThemeData>()!;
}
