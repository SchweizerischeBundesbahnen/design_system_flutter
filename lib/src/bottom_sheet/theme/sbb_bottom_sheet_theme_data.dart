import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for [SBBBottomSheet].
///
/// Use this to set the [SBBBottomSheetStyle] for all [SBBBottomSheet] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbBottomSheetTheme`.
@immutable
class SBBBottomSheetThemeData extends ThemeExtension<SBBBottomSheetThemeData> with Diagnosticable {
  const SBBBottomSheetThemeData({
    this.style,
  });

  /// Overrides for the bottom sheet's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBBottomSheetStyle? style;

  @override
  SBBBottomSheetThemeData copyWith({
    SBBBottomSheetStyle? style,
  }) {
    return SBBBottomSheetThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBBottomSheetThemeData lerp(SBBBottomSheetThemeData? other, double t) {
    if (other == null) return this;
    return SBBBottomSheetThemeData(
      style: SBBBottomSheetStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBBottomSheetThemeData && other.style == style;
  }
}

extension SBBBottomSheetThemeDataX on SBBBottomSheetThemeData {
  SBBBottomSheetThemeData merge(SBBBottomSheetThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBBottomSheetThemeDataThemeDataX on ThemeData {
  SBBBottomSheetThemeData? get sbbBottomSheetTheme {
    return extension<SBBBottomSheetThemeData>();
  }
}
