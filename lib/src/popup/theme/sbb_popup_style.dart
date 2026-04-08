import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBPopup].
///
/// Use this class in combination with [SBBPopupThemeData] to customize
/// the appearance of popups throughout your app or for specific widget subtrees.
class SBBPopupStyle {
  const SBBPopupStyle({
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
    this.titleBodyGap,
    this.padding,
    this.margin,
    this.alignment,
  });

  /// The text style for the title.
  ///
  /// The color of the [titleTextStyle] is typically not used directly; the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color of the title text and close button.
  final Color? titleForegroundColor;

  /// The text style for the leading widget.
  ///
  /// The color of the [leadingTextStyle] is typically not used directly; the
  /// [leadingForegroundColor] is used instead.
  final TextStyle? leadingTextStyle;

  /// The color of the leading widget.
  final Color? leadingForegroundColor;

  /// The text style for the trailing widget.
  ///
  /// The color of the [trailingTextStyle] is typically not used directly; the
  /// [trailingForegroundColor] is used instead.
  final TextStyle? trailingTextStyle;

  /// The color of the trailing widget.
  final Color? trailingForegroundColor;

  /// The background color of the popup dialog.
  final Color? backgroundColor;

  /// The clip behavior of the popup dialog.
  final Clip? clipBehavior;

  /// The constraints of the popup dialog.
  ///
  /// Controls how large the popup can be. When null, Flutter's default dialog
  /// constraints apply.
  final BoxConstraints? constraints;

  /// The color of the barrier behind the popup.
  final Color? barrierColor;

  /// The distance in logical pixels between the title row and the body.
  ///
  /// Defaults to [SBBSpacing.small].
  final double? titleBodyGap;

  /// The padding applied within the popup.
  ///
  /// Defaults to `EdgeInsets.all(SBBSpacing.medium).copyWith(bottom: SBBSpacing.medium)`.
  final EdgeInsets? padding;

  /// How to align the dialog on the screen.
  ///
  /// Defaults to [Alignment.center].
  final AlignmentGeometry? alignment;

  /// Margin around the dialog to keep it away from the screen edges.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
  final EdgeInsets? margin;

  /// The default shape for the popup.
  static ShapeBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(SBBSpacing.medium));

  SBBPopupStyle copyWith({
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
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
    EdgeInsets? margin,
  }) {
    return SBBPopupStyle(
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
      padding: padding ?? this.padding,
      alignment: alignment ?? this.alignment,
      margin: margin ?? this.margin,
    );
  }

  SBBPopupStyle merge(SBBPopupStyle? other) {
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
      padding: other.padding,
      alignment: other.alignment,
      margin: other.margin,
    );
  }

  static SBBPopupStyle? lerp(SBBPopupStyle? a, SBBPopupStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBPopupStyle(
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
      titleBodyGap: t < 0.5 ? a?.titleBodyGap : b?.titleBodyGap,
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      alignment: t < 0.5 ? a?.alignment : b?.alignment,
      margin: EdgeInsets.lerp(a?.margin, b?.margin, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPopupStyle &&
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
        other.padding == padding &&
        other.alignment == alignment &&
        other.margin == margin;
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
    padding,
    alignment,
    margin,
  );
}
