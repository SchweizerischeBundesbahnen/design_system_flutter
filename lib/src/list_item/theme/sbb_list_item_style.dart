import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBListItem].
///
/// Use this class in combination with [SBBListItemThemeData] to customize
/// the appearance of list items throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBListItem(
///   titleText: 'Title',
///   subtitleText: 'Subtitle',
///   onTap: () {},
///   style: SBBListItemStyle(
///     backgroundColor: WidgetStateProperty.all(Colors.white),
///     titleForegroundColor: WidgetStateProperty.all(Colors.black),
///   ),
/// )
/// ```
///
/// See also:
/// * [SBBListItem], the widget that uses this style.
/// * [SBBListItemThemeData], which applies this style theme-wide.
class SBBListItemStyle {
  const SBBListItemStyle({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.titleForegroundColor,
    this.subtitleForegroundColor,
    this.leadingForegroundColor,
    this.trailingForegroundColor,
    this.backgroundColor,
    this.overlayColor,
  });

  /// The minimum vertical height of a list item without [SBBListItem.padding] applied.
  ///
  /// This ensures list items meet accessibility standards for touch targets.
  static double get minInnerHeight => 24.0;

  /// The text style for the list item title.
  ///
  /// Applies to all text descendants of the title of SBBListItem.
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [titleForegroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? titleTextStyle;

  /// The text style for the list item subtitle.
  ///
  /// Applies to all text descendants of the subtitle of SBBListItem.
  ///
  /// The color of the [subtitleTextStyle] is typically not used directly, the
  /// [subtitleForegroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? subtitleTextStyle;

  /// The color of the title text.
  ///
  /// This color is typically used instead of the color of the [titleTextStyle].
  final WidgetStateProperty<Color?>? titleForegroundColor;

  /// The color of the subtitle text.
  ///
  /// This color is typically used instead of the color of the [subtitleTextStyle].
  final WidgetStateProperty<Color?>? subtitleForegroundColor;

  /// The color of the leading widget content.
  ///
  /// This affects the icon or content color of the leading widget.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// The color of the trailing widget content.
  ///
  /// This affects the icon or content color of the trailing widget.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The overlay color shown on interaction.
  ///
  /// This creates the visual feedback when the list item is interacted with.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The background color of the list item.
  ///
  /// This fills the entire list item.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The default padding of the list item.
  static EdgeInsets get defaultPadding => EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0);

  SBBListItemStyle copyWith({
    WidgetStateProperty<TextStyle?>? titleTextStyle,
    WidgetStateProperty<TextStyle?>? subtitleTextStyle,
    WidgetStateProperty<Color?>? titleForegroundColor,
    WidgetStateProperty<Color?>? subtitleForegroundColor,
    WidgetStateProperty<Color?>? leadingForegroundColor,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<Color?>? backgroundColor,
  }) {
    return SBBListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      subtitleForegroundColor: subtitleForegroundColor ?? this.subtitleForegroundColor,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  SBBListItemStyle merge(SBBListItemStyle? other) {
    if (other == null) return this;

    return copyWith(
      titleTextStyle: other.titleTextStyle,
      subtitleTextStyle: other.subtitleTextStyle,
      titleForegroundColor: other.titleForegroundColor,
      subtitleForegroundColor: other.subtitleForegroundColor,
      leadingForegroundColor: other.leadingForegroundColor,
      trailingForegroundColor: other.trailingForegroundColor,
      overlayColor: other.overlayColor,
      backgroundColor: other.backgroundColor,
    );
  }

  static SBBListItemStyle? lerp(SBBListItemStyle? a, SBBListItemStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBListItemStyle(
      titleTextStyle: WidgetStateProperty.lerp<TextStyle?>(a?.titleTextStyle, b?.titleTextStyle, t, TextStyle.lerp),
      subtitleTextStyle: WidgetStateProperty.lerp<TextStyle?>(
        a?.subtitleTextStyle,
        b?.subtitleTextStyle,
        t,
        TextStyle.lerp,
      ),
      titleForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.titleForegroundColor,
        b?.titleForegroundColor,
        t,
        Color.lerp,
      ),
      subtitleForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.subtitleForegroundColor,
        b?.subtitleForegroundColor,
        t,
        Color.lerp,
      ),
      leadingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.leadingForegroundColor,
        b?.leadingForegroundColor,
        t,
        Color.lerp,
      ),
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.trailingForegroundColor,
        b?.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBListItemStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.subtitleTextStyle == subtitleTextStyle &&
        other.titleForegroundColor == titleForegroundColor &&
        other.subtitleForegroundColor == subtitleForegroundColor &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.overlayColor == overlayColor &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode => Object.hash(
    titleTextStyle,
    subtitleTextStyle,
    titleForegroundColor,
    subtitleForegroundColor,
    leadingForegroundColor,
    trailingForegroundColor,
    overlayColor,
    backgroundColor,
  );
}
