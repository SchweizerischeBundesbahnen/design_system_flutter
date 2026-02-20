import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBMessage].
///
/// Use this to set the [SBBMessageStyle] and spacing for all [SBBMessage] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbMessageTheme`.
@immutable
class SBBMessageThemeData extends ThemeExtension<SBBMessageThemeData> with Diagnosticable {
  /// Creates an [SBBMessageThemeData].
  const SBBMessageThemeData({
    this.style,
    this.padding = const EdgeInsets.all(SBBSpacing.medium),
  });

  /// Overrides for the message's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBMessageStyle? style;

  /// The padding around the entire message content.
  final EdgeInsets padding;

  @override
  SBBMessageThemeData copyWith({
    SBBMessageStyle? style,
    EdgeInsets? padding,
  }) {
    return SBBMessageThemeData(
      style: style ?? this.style,
      padding: padding ?? this.padding,
    );
  }

  @override
  SBBMessageThemeData lerp(SBBMessageThemeData? other, double t) {
    if (other == null) return this;
    return SBBMessageThemeData(
      style: SBBMessageStyle.lerp(style, other.style, t),
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    );
  }

  @override
  int get hashCode => Object.hash(style, padding);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBMessageThemeData && other.style == style && other.padding == padding;
  }
}

extension SBBMessageThemeDataX on SBBMessageThemeData {
  SBBMessageThemeData merge(SBBMessageThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
      padding: other.padding,
    );
  }
}

extension SBBMessageThemeDataThemeDataX on ThemeData {
  SBBMessageThemeData? get sbbMessageTheme {
    return extension<SBBMessageThemeData>();
  }
}
