import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBChip].
///
/// Use this class in combination with [SBBChipThemeData] to customize
/// the appearance of chips throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBChip(
///   labelText: 'Label',
///   selected: false,
///   onChanged: (value) {},
///   style: SBBChipStyle(
///     borderColor: WidgetStateProperty.all(Colors.grey),
///     backgroundColor: WidgetStateProperty.all(Colors.white),
///   ),
/// )
/// ```
///
/// See also:
/// * [SBBChip], the chip.dart widget that uses this style.
/// * [SBBChipThemeData], which applies this style theme-wide.
class SBBChipStyle {
  const SBBChipStyle({
    this.borderColor,
    this.backgroundColor,
    this.trailingBackgroundColor,
    this.labelForegroundColor,
    this.trailingForegroundColor,
    this.labelTextStyle,
    this.trailingTextStyle,
    this.overlayColor,
  });

  /// The color of the chip.dart border.
  ///
  /// This is the outline color of the chip.dart container.
  /// The border width is defined by [SBBChipStyle.borderWidth].
  final WidgetStateProperty<Color?>? borderColor;

  /// The background color of the chip.dart.
  ///
  /// This fills the entire chip.dart container.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The color of the label text.
  ///
  /// This affects the text color of [SBBChip.labelText] or [SBBChip.label].
  final WidgetStateProperty<Color?>? labelForegroundColor;

  /// The color of the trailing widget content.
  ///
  /// This affects the icon or text color within the trailing badge or custom widget.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The text style for the chip.dart label.
  ///
  /// Applies to all text descendants of the label of SBBChip.
  ///
  /// The color of the [labelTextStyle] is typically not used directly, the
  /// [labelForegroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? labelTextStyle;

  /// The text style for the trailing badge text.
  ///
  /// Applies to all text descendants of trailing of SBBChip.
  ///
  /// The color of the [trailingTextStyle] is typically not used directly, the
  /// [trailingForegroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? trailingTextStyle;

  /// The background color of the trailing badge.
  ///
  /// This fills the circular badge container shown when [SBBChip.selected] is false
  /// and [SBBChip.trailingText] is provided, or when [SBBChip.selected] is true
  /// and no custom [SBBChip.trailing] widget is provided.
  final WidgetStateProperty<Color?>? trailingBackgroundColor;

  /// The overlay color shown on interaction.
  ///
  /// This creates the visual feedback when the chip.dart is interacted with.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The thickness of the chip.dart border.
  ///
  /// This value determines how wide the border line around the chip.dart appears.
  static const double borderWidth = 1.0;

  /// The shape of the chip.dart's border.
  ///
  /// This creates the pill-shaped appearance of the chip.dart.
  static const ShapeBorder borderShape = StadiumBorder();

  /// The size of the trailing badge circle.
  static const Size badgeSize = Size(24.0, 24.0);

  /// The margin between the label and trailing badge.
  static const EdgeInsets badgeMargin = EdgeInsets.only(right: 4.0);

  SBBChipStyle copyWith({
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? labelForegroundColor,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    WidgetStateProperty<TextStyle?>? labelTextStyle,
    WidgetStateProperty<TextStyle?>? trailingTextStyle,
    WidgetStateProperty<Color?>? trailingBackgroundColor,
    WidgetStateProperty<Color?>? overlayColor,
  }) {
    return SBBChipStyle(
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      trailingBackgroundColor: trailingBackgroundColor ?? this.trailingBackgroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }

  SBBChipStyle merge(SBBChipStyle? other) {
    if (other == null) return this;

    return copyWith(
      borderColor: other.borderColor,
      backgroundColor: other.backgroundColor,
      labelForegroundColor: other.labelForegroundColor,
      trailingForegroundColor: other.trailingForegroundColor,
      labelTextStyle: other.labelTextStyle,
      trailingTextStyle: other.trailingTextStyle,
      trailingBackgroundColor: other.trailingBackgroundColor,
      overlayColor: other.overlayColor,
    );
  }

  static SBBChipStyle? lerp(SBBChipStyle? a, SBBChipStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBChipStyle(
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      labelForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.labelForegroundColor,
        b?.labelForegroundColor,
        t,
        Color.lerp,
      ),
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.trailingForegroundColor,
        b?.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      labelTextStyle: WidgetStateProperty.lerp<TextStyle?>(a?.labelTextStyle, b?.labelTextStyle, t, TextStyle.lerp),
      trailingTextStyle: WidgetStateProperty.lerp<TextStyle?>(
        a?.trailingTextStyle,
        b?.trailingTextStyle,
        t,
        TextStyle.lerp,
      ),
      trailingBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.trailingBackgroundColor,
        b?.trailingBackgroundColor,
        t,
        Color.lerp,
      ),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBChipStyle &&
        other.borderColor == borderColor &&
        other.backgroundColor == backgroundColor &&
        other.labelForegroundColor == labelForegroundColor &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.labelTextStyle == labelTextStyle &&
        other.trailingTextStyle == trailingTextStyle &&
        other.trailingBackgroundColor == trailingBackgroundColor &&
        other.overlayColor == overlayColor;
  }

  @override
  int get hashCode => Object.hash(
    borderColor,
    backgroundColor,
    labelForegroundColor,
    trailingForegroundColor,
    labelTextStyle,
    trailingTextStyle,
    trailingBackgroundColor,
    overlayColor,
  );
}
