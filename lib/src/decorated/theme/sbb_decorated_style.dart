import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBDecorated].
///
/// Use this class to customize how the decorated content appears, including the text
/// style and color inherited by the content, and the interaction feedback color.
///
/// Typically applied theme-wide via [SBBDecoratedThemeData], but can be overridden
/// per-widget using [SBBDecorated.style].
///
/// See also:
/// * [SBBDecorated], the widget that uses this style
/// * [SBBDecoratedThemeData], for applying styles theme-wide
class SBBDecoratedStyle {
  const SBBDecoratedStyle({
    this.contentTextStyle,
    this.contentForegroundColor,
    this.overlayColor,
  });

  /// The base text style inherited by the content widget.
  ///
  ///The text color is typically overridden by [contentForegroundColor]
  ///for state-aware styling.
  final TextStyle? contentTextStyle;

  /// The color inherited by the content widget, resolved based on widget state.
  ///
  /// Applied to both text and icons in the content, so that a disabled or errored
  /// field greys out its content along with its label and affixes.
  final WidgetStateProperty<Color?>? contentForegroundColor;

  /// The overlay color for tap interaction feedback.
  ///
  /// Shown when the user taps the widget, providing visual feedback via the
  /// [InkWell].
  final WidgetStateProperty<Color?>? overlayColor;

  SBBDecoratedStyle copyWith({
    TextStyle? contentTextStyle,
    WidgetStateProperty<Color?>? contentForegroundColor,
    WidgetStateProperty<Color?>? overlayColor,
  }) {
    return SBBDecoratedStyle(
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      contentForegroundColor: contentForegroundColor ?? this.contentForegroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }

  SBBDecoratedStyle merge(SBBDecoratedStyle? other) {
    if (other == null) return this;

    return copyWith(
      contentTextStyle: other.contentTextStyle,
      contentForegroundColor: other.contentForegroundColor,
      overlayColor: other.overlayColor,
    );
  }

  static SBBDecoratedStyle? lerp(SBBDecoratedStyle? a, SBBDecoratedStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBDecoratedStyle(
      contentTextStyle: TextStyle.lerp(a?.contentTextStyle, b?.contentTextStyle, t),
      contentForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.contentForegroundColor,
        b?.contentForegroundColor,
        t,
        Color.lerp,
      ),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBDecoratedStyle &&
        other.contentTextStyle == contentTextStyle &&
        other.contentForegroundColor == contentForegroundColor &&
        other.overlayColor == overlayColor;
  }

  @override
  int get hashCode => Object.hash(contentTextStyle, contentForegroundColor, overlayColor);
}
