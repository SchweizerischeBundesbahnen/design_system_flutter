import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBListHeader].
///
/// Use this class in combination with [SBBListHeaderThemeData] to customize
/// the appearance of list headers throughout your app or for specific widget subtrees.
class SBBListHeaderStyle {
  const SBBListHeaderStyle({
    this.foregroundColor,
    this.textStyle,
    this.maxLines,
    this.textOverflow,
    this.padding,
  });

  /// The color of the list header text.
  final Color? foregroundColor;

  /// The text style for the list header.
  final TextStyle? textStyle;

  /// The maximum number of lines for the header text.
  final int? maxLines;

  /// How to handle text overflow.
  final TextOverflow? textOverflow;

  /// The padding around the list header.
  final EdgeInsetsGeometry? padding;

  static const EdgeInsetsGeometry defaultPadding = .symmetric(
    vertical: SBBSpacing.xSmall,
    horizontal: SBBSpacing.medium,
  );

  SBBListHeaderStyle copyWith({
    Color? foregroundColor,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? textOverflow,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBListHeaderStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      textStyle: textStyle ?? this.textStyle,
      maxLines: maxLines ?? this.maxLines,
      textOverflow: textOverflow ?? this.textOverflow,
      padding: padding ?? this.padding,
    );
  }

  SBBListHeaderStyle merge(SBBListHeaderStyle? other) {
    if (other == null) return this;
    return copyWith(
      foregroundColor: other.foregroundColor,
      textStyle: other.textStyle,
      maxLines: other.maxLines,
      textOverflow: other.textOverflow,
      padding: other.padding,
    );
  }

  static SBBListHeaderStyle? lerp(SBBListHeaderStyle? a, SBBListHeaderStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBListHeaderStyle(
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      maxLines: a?.maxLines ?? b?.maxLines,
      textOverflow: a?.textOverflow ?? b?.textOverflow,
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBListHeaderStyle &&
        other.foregroundColor == foregroundColor &&
        other.textStyle == textStyle &&
        other.maxLines == maxLines &&
        other.textOverflow == textOverflow &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
    foregroundColor,
    textStyle,
    maxLines,
    textOverflow,
    padding,
  );
}
