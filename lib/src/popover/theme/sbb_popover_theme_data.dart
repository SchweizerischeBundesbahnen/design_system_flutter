import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for [SBBPopover].
///
/// Use this to set the [SBBPopoverStyle] for all [SBBPopover] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPopoverTheme`.
@immutable
class SBBPopoverThemeData extends ThemeExtension<SBBPopoverThemeData> with Diagnosticable {
  const SBBPopoverThemeData({
    this.style,
  });

  /// Overrides for the popover's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBPopoverStyle? style;

  @override
  SBBPopoverThemeData copyWith({
    SBBPopoverStyle? style,
  }) {
    return SBBPopoverThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBPopoverThemeData lerp(SBBPopoverThemeData? other, double t) {
    if (other == null) return this;
    return SBBPopoverThemeData(
      style: SBBPopoverStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPopoverThemeData && other.style == style;
  }
}

extension SBBPopoverThemeDataX on SBBPopoverThemeData {
  SBBPopoverThemeData merge(SBBPopoverThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBPopoverThemeDataThemeDataX on ThemeData {
  /// Access the [SBBPopoverThemeData] from the current theme.
  SBBPopoverThemeData get sbbPopoverTheme => extension<SBBPopoverThemeData>()!;
}
