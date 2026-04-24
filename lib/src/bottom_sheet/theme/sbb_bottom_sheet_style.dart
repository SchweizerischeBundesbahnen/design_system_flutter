import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBBottomSheet].
///
/// Use this class in combination with [SBBBottomSheetThemeData] to customize
/// the appearance of bottom sheets throughout your app or for specific widget subtrees.
class SBBBottomSheetStyle {
  const SBBBottomSheetStyle({
    this.titleTextStyle,
    this.titleForegroundColor,
    this.leadingTextStyle,
    this.leadingForegroundColor,
    this.trailingTextStyle,
    this.trailingForegroundColor,
    this.backgroundColor,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    this.titleMinHeight,
    this.titleBodyGap,
    this.padding,
  });

  /// The text style for the title.
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color of the title text.
  ///
  /// This color is typically used instead of the color of the [titleTextStyle].
  final Color? titleForegroundColor;

  /// The text style for the leading widget.
  final TextStyle? leadingTextStyle;

  /// The color of the leading widget.
  final Color? leadingForegroundColor;

  /// The text style for the trailing widget.
  final TextStyle? trailingTextStyle;

  /// The color of the trailing widget.
  final Color? trailingForegroundColor;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// The clip behavior of the bottom sheet.
  final Clip? clipBehavior;

  /// The constraints of the bottom sheet.
  final BoxConstraints? constraints;

  /// The color of the barrier behind the bottom sheet.
  final Color? barrierColor;

  /// The distance in logical pixels between the title row and the body.
  ///
  /// Defaults to [SBBSpacing.small].
  final double? titleBodyGap;

  /// The minimum height of the title row of the bottom sheet if exists.
  ///
  /// The title row exists if:
  /// * one of leading, title or trailing are set OR
  /// * showCloseButton && isDismissible are true
  ///
  /// Defaults to [SBBSpacing.xLarge].
  final double? titleMinHeight;

  /// The padding applied within the bottom sheet.
  ///
  /// Defaults to
  /// `EdgeInsets.symmetric(horizontal: SBBSpacing.medium, vertical: SBBSpacing.small).copyWith(bottom: 0.0)`
  final EdgeInsets? padding;

  /// The default shape for the bottom sheet.
  static const ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(SBBSpacing.medium)),
  );

  SBBBottomSheetStyle copyWith({
    TextStyle? titleTextStyle,
    Color? titleForegroundColor,
    TextStyle? leadingTextStyle,
    Color? leadingForegroundColor,
    TextStyle? trailingTextStyle,
    Color? trailingForegroundColor,
    Color? backgroundColor,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    double? titleBodyGap,
    double? titleMinHeight,
    EdgeInsets? padding,
  }) {
    return SBBBottomSheetStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      constraints: constraints ?? this.constraints,
      barrierColor: barrierColor ?? this.barrierColor,
      titleBodyGap: titleBodyGap ?? this.titleBodyGap,
      titleMinHeight: titleMinHeight ?? this.titleMinHeight,
      padding: padding ?? this.padding,
    );
  }

  SBBBottomSheetStyle merge(SBBBottomSheetStyle? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle: other.titleTextStyle,
      titleForegroundColor: other.titleForegroundColor,
      leadingTextStyle: other.leadingTextStyle,
      leadingForegroundColor: other.leadingForegroundColor,
      trailingTextStyle: other.trailingTextStyle,
      trailingForegroundColor: other.trailingForegroundColor,
      backgroundColor: other.backgroundColor,
      clipBehavior: other.clipBehavior,
      constraints: other.constraints,
      barrierColor: other.barrierColor,
      titleBodyGap: other.titleBodyGap,
      titleMinHeight: other.titleMinHeight,
      padding: other.padding,
    );
  }

  static SBBBottomSheetStyle? lerp(SBBBottomSheetStyle? a, SBBBottomSheetStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBBottomSheetStyle(
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      leadingTextStyle: TextStyle.lerp(a?.leadingTextStyle, b?.leadingTextStyle, t),
      leadingForegroundColor: Color.lerp(a?.leadingForegroundColor, b?.leadingForegroundColor, t),
      trailingTextStyle: TextStyle.lerp(a?.trailingTextStyle, b?.trailingTextStyle, t),
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      clipBehavior: t < 0.5 ? a?.clipBehavior : b?.clipBehavior,
      constraints: BoxConstraints.lerp(a?.constraints, b?.constraints, t),
      barrierColor: Color.lerp(a?.barrierColor, b?.barrierColor, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBBottomSheetStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.titleForegroundColor == titleForegroundColor &&
        other.leadingTextStyle == leadingTextStyle &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.trailingTextStyle == trailingTextStyle &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.backgroundColor == backgroundColor &&
        other.clipBehavior == clipBehavior &&
        other.constraints == constraints &&
        other.barrierColor == barrierColor &&
        other.titleBodyGap == titleBodyGap &&
        other.titleMinHeight == titleMinHeight &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
    titleTextStyle,
    titleForegroundColor,
    leadingTextStyle,
    leadingForegroundColor,
    trailingTextStyle,
    trailingForegroundColor,
    backgroundColor,
    clipBehavior,
    constraints,
    barrierColor,
    titleBodyGap,
    titleMinHeight,
    padding,
  );
}
