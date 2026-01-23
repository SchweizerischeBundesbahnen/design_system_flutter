import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

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
    this.padding,
    this.trailingHorizontalGapWidth,
    this.leadingHorizontalGapWidth,
    this.subtitleVerticalGapHeight,
  });

  /// Overrides for the list item's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override the style.
  final SBBListItemStyle? style;

  /// The padding around the list item's content.
  ///
  /// If null, the default padding is used.
  final EdgeInsetsGeometry? padding;

  /// The horizontal gap width between the trailing widget and the title/subtitle.
  ///
  /// Defaults to 16.0.
  final double? trailingHorizontalGapWidth;

  /// The horizontal gap width between the leading widget and the title/subtitle.
  ///
  /// Defaults to 8.0.
  final double? leadingHorizontalGapWidth;

  /// The vertical gap height between the title and subtitle.
  ///
  /// Defaults to 4.0.
  final double? subtitleVerticalGapHeight;

  @override
  SBBListItemThemeData copyWith({
    SBBListItemStyle? style,
    EdgeInsetsGeometry? padding,
    double? trailingHorizontalGapWidth,
    double? leadingHorizontalGapWidth,
    double? subtitleVerticalGapHeight,
  }) {
    return SBBListItemThemeData(
      style: style ?? this.style,
      padding: padding ?? this.padding,
      trailingHorizontalGapWidth: trailingHorizontalGapWidth ?? this.trailingHorizontalGapWidth,
      leadingHorizontalGapWidth: leadingHorizontalGapWidth ?? this.leadingHorizontalGapWidth,
      subtitleVerticalGapHeight: subtitleVerticalGapHeight ?? this.subtitleVerticalGapHeight,
    );
  }

  @override
  SBBListItemThemeData lerp(SBBListItemThemeData? other, double t) {
    if (other == null) return this;
    return SBBListItemThemeData(
      style: SBBListItemStyle.lerp(style, other.style, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      trailingHorizontalGapWidth: lerpDouble(trailingHorizontalGapWidth, other.trailingHorizontalGapWidth, t),
      leadingHorizontalGapWidth: lerpDouble(leadingHorizontalGapWidth, other.leadingHorizontalGapWidth, t),
      subtitleVerticalGapHeight: lerpDouble(subtitleVerticalGapHeight, other.subtitleVerticalGapHeight, t),
    );
  }

  @override
  int get hashCode => Object.hash(
    style,
    padding,
    trailingHorizontalGapWidth,
    leadingHorizontalGapWidth,
    subtitleVerticalGapHeight,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBListItemThemeData &&
        other.style == style &&
        other.padding == padding &&
        other.trailingHorizontalGapWidth == trailingHorizontalGapWidth &&
        other.leadingHorizontalGapWidth == leadingHorizontalGapWidth &&
        other.subtitleVerticalGapHeight == subtitleVerticalGapHeight;
  }
}

extension SBBListItemThemeDataX on SBBListItemThemeData {
  SBBListItemThemeData merge(SBBListItemThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style),
      padding: other.padding ?? padding,
      trailingHorizontalGapWidth: other.trailingHorizontalGapWidth ?? trailingHorizontalGapWidth,
      leadingHorizontalGapWidth: other.leadingHorizontalGapWidth ?? leadingHorizontalGapWidth,
      subtitleVerticalGapHeight: other.subtitleVerticalGapHeight ?? subtitleVerticalGapHeight,
    );
  }
}

extension SBBListItemThemeDataThemeDataX on ThemeData {
  SBBListItemThemeData? get sbbListItemTheme {
    return extension<SBBListItemThemeData>();
  }
}
