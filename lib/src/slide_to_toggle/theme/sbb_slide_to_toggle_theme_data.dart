import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBSlideToToggle].
///
/// Use this to set the [SBBSlideToToggleStyle] for all [SBBSlideToToggle] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbSlideToToggleTheme`.
@immutable
class SBBSlideToToggleThemeData extends ThemeExtension<SBBSlideToToggleThemeData> with Diagnosticable {
  /// Creates an [SBBSlideToToggleThemeData].
  ///
  /// The [style] may be null.
  const SBBSlideToToggleThemeData({this.style});

  /// Overrides for the Slide-To-Toggle's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBSlideToToggleStyle? style;

  @override
  SBBSlideToToggleThemeData copyWith({SBBSlideToToggleStyle? style}) {
    return SBBSlideToToggleThemeData(style: style ?? this.style);
  }

  @override
  SBBSlideToToggleThemeData lerp(SBBSlideToToggleThemeData? other, double t) {
    if (other == null) return this;
    return SBBSlideToToggleThemeData(
      style: SBBSlideToToggleStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBSlideToToggleThemeData && other.style == style;
  }
}

extension SBBSlideToToggleThemeDataX on SBBSlideToToggleThemeData {
  SBBSlideToToggleThemeData merge(SBBSlideToToggleThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBSlideToToggleThemeDataThemeDataX on ThemeData {
  SBBSlideToToggleThemeData? get sbbSlideToToggleTheme => extension<SBBSlideToToggleThemeData>();
}
