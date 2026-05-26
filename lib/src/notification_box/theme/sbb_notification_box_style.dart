import 'package:flutter/material.dart';

/// Defines the visual properties of [SBBNotificationBox].
///
/// Use this class in combination with [SBBNotificationBoxThemeData] to customize
/// the appearance of notification boxes throughout your app or for specific widget subtrees.
///
/// Non-null properties override the corresponding properties in the theme and default styles.
///
/// See also:
///
/// * [SBBNotificationBox], the notification box widget that uses this style.
/// * [SBBNotificationBoxThemeData], which applies this style theme-wide.
class SBBNotificationBoxStyle {
  const SBBNotificationBoxStyle({
    this.contentTextStyle,
    this.contentMaxLines,
    this.titleTextStyle,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.leadingIconData,
    this.dismissButtonForegroundColor,
    this.overlayColor,
    this.padding,
  });

  /// The text style for the notification content text.
  ///
  /// The color of the [contentTextStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final TextStyle? contentTextStyle;

  /// The max lines of [SBBNotificationBox.contentText].
  final int? contentMaxLines;

  /// The text style for the notification title.
  ///
  /// Used when [SBBNotificationBox.titleText] is provided.
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The color for notification [Text] and [Icon] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle].
  final Color? foregroundColor;

  /// The background color of the notification box.
  final Color? backgroundColor;

  /// The color of the leading icon.
  ///
  /// If null, defaults to [foregroundColor].
  final Color? iconColor;

  /// The color of the border around the notification box.
  ///
  /// If null, defaults to [backgroundColor].
  final Color? borderColor;

  /// The default leading icon for this notification box type.
  ///
  /// Used when neither [SBBNotificationBox.leading] nor
  /// [SBBNotificationBox.leadingIconData] are provided.
  final IconData? leadingIconData;

  /// The color of the dismiss button.
  final Color? dismissButtonForegroundColor;

  /// The overlay color shown on interaction.
  ///
  /// This creates the visual feedback when the notification box is interacted with.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The inner padding inside the notification box.
  final EdgeInsetsGeometry? padding;

  /// The outer border radius of the notification box.
  static const BorderRadius outerBorderRadius = BorderRadius.all(Radius.circular(16.0));

  /// The inner border radius of the notification box content area.
  static const BorderRadius innerBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomLeft: Radius.circular(8.0),
    topRight: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  );

  /// The width of the left accent border.
  static const double leftBorderWidth = 8.0;

  SBBNotificationBoxStyle copyWith({
    TextStyle? contentTextStyle,
    int? contentMaxLines,
    TextStyle? titleTextStyle,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? iconColor,
    Color? borderColor,
    Color? dismissButtonForegroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? alphaValue,
    IconData? leadingIconData,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBNotificationBoxStyle(
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      contentMaxLines: contentMaxLines ?? this.contentMaxLines,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      dismissButtonForegroundColor: dismissButtonForegroundColor ?? this.dismissButtonForegroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      leadingIconData: leadingIconData ?? this.leadingIconData,
      padding: padding ?? this.padding,
    );
  }

  SBBNotificationBoxStyle merge(SBBNotificationBoxStyle? other) {
    if (other == null) return this;

    return copyWith(
      contentTextStyle: other.contentTextStyle,
      contentMaxLines: other.contentMaxLines,
      titleTextStyle: other.titleTextStyle,
      foregroundColor: other.foregroundColor,
      backgroundColor: other.backgroundColor,
      iconColor: other.iconColor,
      borderColor: other.borderColor,
      dismissButtonForegroundColor: other.dismissButtonForegroundColor,
      overlayColor: other.overlayColor,
      leadingIconData: other.leadingIconData,
      padding: other.padding,
    );
  }

  static SBBNotificationBoxStyle? lerp(
    SBBNotificationBoxStyle? a,
    SBBNotificationBoxStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;

    return SBBNotificationBoxStyle(
      contentTextStyle: TextStyle.lerp(a?.contentTextStyle, b?.contentTextStyle, t),
      contentMaxLines: t < 0.5 ? a?.contentMaxLines : b?.contentMaxLines,
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      dismissButtonForegroundColor: Color.lerp(a?.dismissButtonForegroundColor, b?.dismissButtonForegroundColor, t),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
      leadingIconData: t < 0.5 ? a?.leadingIconData : b?.leadingIconData,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBNotificationBoxStyle &&
          runtimeType == other.runtimeType &&
          contentTextStyle == other.contentTextStyle &&
          contentMaxLines == other.contentMaxLines &&
          titleTextStyle == other.titleTextStyle &&
          foregroundColor == other.foregroundColor &&
          backgroundColor == other.backgroundColor &&
          iconColor == other.iconColor &&
          borderColor == other.borderColor &&
          leadingIconData == other.leadingIconData &&
          dismissButtonForegroundColor == other.dismissButtonForegroundColor &&
          overlayColor == other.overlayColor &&
          padding == other.padding;

  @override
  int get hashCode => Object.hash(
    contentTextStyle,
    contentMaxLines,
    titleTextStyle,
    foregroundColor,
    backgroundColor,
    iconColor,
    borderColor,
    leadingIconData,
    dismissButtonForegroundColor,
    overlayColor,
    padding,
  );
}
