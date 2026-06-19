import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBListItem].
///
/// Use this to set the [SBBListItemStyle] and layout properties for all [SBBListItem]
/// within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbListItemTheme`.
@immutable
class SBBListItemThemeData extends ThemeExtension<SBBListItemThemeData> with Diagnosticable {
  /// Creates an [SBBListItemThemeData].
  ///
  /// The [style], [padding], [trailingHorizontalGapWidth], [leadingHorizontalGapWidth],
  /// and [subtitleVerticalGapHeight] may be null.
  const SBBListItemThemeData({
    this.style,
  });

  /// Overrides for the list item's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override the style.
  final SBBListItemStyle? style;

  @override
  SBBListItemThemeData copyWith({
    SBBListItemStyle? style,
  }) {
    return SBBListItemThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBListItemThemeData lerp(SBBListItemThemeData? other, double t) {
    if (other == null) return this;
    return SBBListItemThemeData(
      style: SBBListItemStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBListItemThemeData && other.style == style;
  }
}

extension SBBListItemThemeDataX on SBBListItemThemeData {
  SBBListItemThemeData merge(SBBListItemThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
    );
  }
}

extension SBBListItemThemeDataThemeDataX on ThemeData {
  /// Access the [SBBListItemThemeData] from the current theme.
  SBBListItemThemeData get sbbListItemTheme => extension<SBBListItemThemeData>()!;
}
