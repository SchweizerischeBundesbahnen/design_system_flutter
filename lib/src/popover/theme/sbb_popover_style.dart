import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBPopover].
///
/// Use this class in combination with [SBBPopoverThemeData] to customize
/// the appearance of popovers throughout your app or for specific widget
/// subtrees.
class SBBPopoverStyle {
  const SBBPopoverStyle({
    this.titleTextStyle,
    this.titleForegroundColor,
    this.leadingTextStyle,
    this.leadingForegroundColor,
    this.trailingTextStyle,
    this.trailingForegroundColor,
    this.backgroundColor,
    this.barrierColor,
    this.constraints,
    this.padding,
  });

  /// The text style for the title.
  ///
  /// The color of the [titleTextStyle] is typically not used directly; the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color of the title text.
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

  /// The fill color of the popover surface (body and notch).
  final Color? backgroundColor;

  /// The color of the modal barrier behind the popover.
  final Color? barrierColor;

  /// The constraints of the popover box.
  ///
  /// Controls how large the popover can grow before its content wraps or
  /// scrolls; the space the viewport actually offers around the target
  /// always applies on top of these.
  final BoxConstraints? constraints;

  /// The padding applied around the popover's content.
  final EdgeInsets? padding;

  SBBPopoverStyle copyWith({
    TextStyle? titleTextStyle,
    Color? titleForegroundColor,
    TextStyle? leadingTextStyle,
    Color? leadingForegroundColor,
    TextStyle? trailingTextStyle,
    Color? trailingForegroundColor,
    Color? backgroundColor,
    Color? barrierColor,
    BoxConstraints? constraints,
    EdgeInsets? padding,
  }) {
    return SBBPopoverStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      leadingTextStyle: leadingTextStyle ?? this.leadingTextStyle,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
      constraints: constraints ?? this.constraints,
      padding: padding ?? this.padding,
    );
  }

  SBBPopoverStyle merge(SBBPopoverStyle? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle: other.titleTextStyle,
      titleForegroundColor: other.titleForegroundColor,
      leadingTextStyle: other.leadingTextStyle,
      leadingForegroundColor: other.leadingForegroundColor,
      trailingTextStyle: other.trailingTextStyle,
      trailingForegroundColor: other.trailingForegroundColor,
      backgroundColor: other.backgroundColor,
      barrierColor: other.barrierColor,
      constraints: other.constraints,
      padding: other.padding,
    );
  }

  static SBBPopoverStyle? lerp(SBBPopoverStyle? a, SBBPopoverStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBPopoverStyle(
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      leadingTextStyle: TextStyle.lerp(a?.leadingTextStyle, b?.leadingTextStyle, t),
      leadingForegroundColor: Color.lerp(a?.leadingForegroundColor, b?.leadingForegroundColor, t),
      trailingTextStyle: TextStyle.lerp(a?.trailingTextStyle, b?.trailingTextStyle, t),
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      barrierColor: Color.lerp(a?.barrierColor, b?.barrierColor, t),
      constraints: BoxConstraints.lerp(a?.constraints, b?.constraints, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPopoverStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.titleForegroundColor == titleForegroundColor &&
        other.leadingTextStyle == leadingTextStyle &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.trailingTextStyle == trailingTextStyle &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.backgroundColor == backgroundColor &&
        other.barrierColor == barrierColor &&
        other.constraints == constraints &&
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
    barrierColor,
    constraints,
    padding,
  );
}
