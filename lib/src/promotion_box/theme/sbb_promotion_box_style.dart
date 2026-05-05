import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// A builder that creates a custom background for [SBBPromotionBox].
///
/// The [context] is the build context of the promotion box and [style] is
/// the fully resolved [SBBPromotionBoxStyle]. The [child] is the inner
/// content (already wrapped in an [InkWell]) and must be included in the
/// returned widget tree.
typedef SBBPromotionBoxBackgroundBuilder =
    Widget Function(BuildContext context, SBBPromotionBoxStyle style, Widget child);

/// Defines the visual properties of [SBBPromotionBox].
///
/// Use this class in combination with [SBBPromotionBoxThemeData] to customize
/// the appearance of promotion boxes throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBPromotionBox], the widget that uses this style.
/// * [SBBPromotionBoxThemeData], which applies this style theme-wide.
class SBBPromotionBoxStyle {
  const SBBPromotionBoxStyle({
    this.titleForegroundColor,
    this.titleTextStyle,
    this.titleTextMaxLines,
    this.subtitleForegroundColor,
    this.subtitleTextStyle,
    this.subtitleTextMaxLines,
    this.trailingForegroundColor,
    this.borderColor,
    this.overlayColor,
    this.backgroundGradientColors,
    this.backgroundTextureOpacity,
    this.backgroundBuilder,
  }) : assert(
         backgroundGradientColors == null || backgroundGradientColors.length == 4,
         'Must provide exactly four colors for the background gradient, given: $backgroundGradientColors',
       );

  /// The color of the title text.
  ///
  /// This affects the text color of [SBBPromotionBox.titleText] or [SBBPromotionBox.title].
  final Color? titleForegroundColor;

  /// The text style for the promotion box title.
  ///
  /// Applies to all text descendants of the title of SBBPromotionBox.
  ///
  /// The color of the [titleTextStyle] is typically not used directly, the
  /// [titleForegroundColor] is used instead.
  final TextStyle? titleTextStyle;

  /// The maximum number of lines for the title text.
  ///
  /// If the title text exceeds this number of lines, it will be truncated with
  /// an ellipsis. If null, the title text can span multiple lines without limit.
  final int? titleTextMaxLines;

  /// The color of the subtitle text.
  ///
  /// This affects the text color of [SBBPromotionBox.subtitleText] or [SBBPromotionBox.subtitle].
  final Color? subtitleForegroundColor;

  /// The text style for the promotion box subtitle.
  ///
  /// Applies to all text descendants of the subtitle of SBBPromotionBox.
  ///
  /// The color of the [subtitleTextStyle] is typically not used directly, the
  /// [subtitleForegroundColor] is used instead.
  final TextStyle? subtitleTextStyle;

  /// The maximum number of lines for the subtitle text.
  ///
  /// If the subtitle text exceeds this number of lines, it will be truncated with
  /// an ellipsis. If null, the subtitle text can span multiple lines without limit.
  final int? subtitleTextMaxLines;

  /// The color of the trailing widget content.
  ///
  /// This affects the icon or text color within the trailing widget of the promotion box.
  final Color? trailingForegroundColor;

  /// The color of the promotion box border.
  ///
  /// This is the outline color of the promotion box container.
  final Color? borderColor;

  /// The overlay color shown on interaction.
  ///
  /// This creates the visual feedback when the promotion box is interacted with.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The gradient colors for the promotion box background.
  ///
  /// This list of colors is used to create a linear gradient background.
  /// The gradient stops are defined by [SBBPromotionBoxStyle.backgroundGradientStops].
  final List<Color>? backgroundGradientColors;

  /// The opacity of the background texture overlay.
  ///
  /// This controls the visibility of the texture pattern applied over the gradient background.
  /// A value of 0.0 means the texture is fully transparent (invisible), while 1.0 means
  /// it is fully opaque.
  final double? backgroundTextureOpacity;

  /// A builder for a fully custom background of the [SBBPromotionBox].
  ///
  /// When provided, this replaces the default noise texture and linear gradient
  /// background. The [child] passed to the builder is the inner content already
  /// wrapped in an [InkWell] and must be included in the returned widget tree.
  ///
  /// The [SBBPromotionBoxStyle.borderColor] is not applied automatically when
  /// using a custom builder — it is the responsibility of the builder to apply
  /// any desired border.
  final SBBPromotionBoxBackgroundBuilder? backgroundBuilder;

  static const backgroundGradientStops = <double>[0.0, 0.406, 0.672, 1.0];

  static const borderRadius = BorderRadius.all(Radius.circular(SBBSpacing.medium));

  SBBPromotionBoxStyle copyWith({
    Color? titleForegroundColor,
    TextStyle? titleTextStyle,
    int? titleTextMaxLines,
    Color? subtitleForegroundColor,
    TextStyle? subtitleTextStyle,
    int? subtitleTextMaxLines,
    Color? trailingForegroundColor,
    Color? borderColor,
    WidgetStateProperty<Color?>? overlayColor,
    List<Color>? backgroundGradientColors,
    double? backgroundTextureOpacity,
    SBBPromotionBoxBackgroundBuilder? backgroundBuilder,
  }) {
    return SBBPromotionBoxStyle(
      titleForegroundColor: titleForegroundColor ?? this.titleForegroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleTextMaxLines: titleTextMaxLines ?? this.titleTextMaxLines,
      subtitleForegroundColor: subtitleForegroundColor ?? this.subtitleForegroundColor,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      subtitleTextMaxLines: subtitleTextMaxLines ?? this.subtitleTextMaxLines,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      borderColor: borderColor ?? this.borderColor,
      overlayColor: overlayColor ?? this.overlayColor,
      backgroundGradientColors: backgroundGradientColors ?? this.backgroundGradientColors,
      backgroundTextureOpacity: backgroundTextureOpacity ?? this.backgroundTextureOpacity,
      backgroundBuilder: backgroundBuilder ?? this.backgroundBuilder,
    );
  }

  static SBBPromotionBoxStyle lerp(SBBPromotionBoxStyle? a, SBBPromotionBoxStyle? b, double t) {
    if (identical(a, b)) return a ?? b!;

    return SBBPromotionBoxStyle(
      titleForegroundColor: Color.lerp(a?.titleForegroundColor, b?.titleForegroundColor, t),
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      titleTextMaxLines: a?.titleTextMaxLines ?? b?.titleTextMaxLines,
      subtitleForegroundColor: Color.lerp(a?.subtitleForegroundColor, b?.subtitleForegroundColor, t),
      subtitleTextStyle: TextStyle.lerp(a?.subtitleTextStyle, b?.subtitleTextStyle, t),
      subtitleTextMaxLines: a?.subtitleTextMaxLines ?? b?.subtitleTextMaxLines,
      trailingForegroundColor: Color.lerp(a?.trailingForegroundColor, b?.trailingForegroundColor, t),
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      backgroundGradientColors: b?.backgroundGradientColors,
      backgroundTextureOpacity: lerpDouble(a?.backgroundTextureOpacity, b?.backgroundTextureOpacity, t),
      backgroundBuilder: t < 0.5 ? a?.backgroundBuilder : b?.backgroundBuilder,
    );
  }

  SBBPromotionBoxStyle merge(SBBPromotionBoxStyle? other) {
    if (other == null) return this;

    return copyWith(
      titleForegroundColor: other.titleForegroundColor,
      titleTextStyle: other.titleTextStyle,
      titleTextMaxLines: other.titleTextMaxLines,
      subtitleForegroundColor: other.subtitleForegroundColor,
      subtitleTextStyle: other.subtitleTextStyle,
      subtitleTextMaxLines: other.subtitleTextMaxLines,
      trailingForegroundColor: other.trailingForegroundColor,
      borderColor: other.borderColor,
      overlayColor: other.overlayColor,
      backgroundGradientColors: other.backgroundGradientColors,
      backgroundTextureOpacity: other.backgroundTextureOpacity,
      backgroundBuilder: other.backgroundBuilder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBPromotionBoxStyle &&
        other.titleForegroundColor == titleForegroundColor &&
        other.titleTextStyle == titleTextStyle &&
        other.titleTextMaxLines == titleTextMaxLines &&
        other.subtitleForegroundColor == subtitleForegroundColor &&
        other.subtitleTextStyle == subtitleTextStyle &&
        other.subtitleTextMaxLines == subtitleTextMaxLines &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.borderColor == borderColor &&
        other.overlayColor == overlayColor &&
        other.backgroundGradientColors == backgroundGradientColors &&
        other.backgroundTextureOpacity == backgroundTextureOpacity &&
        other.backgroundBuilder == backgroundBuilder;
  }

  @override
  int get hashCode => Object.hash(
    titleForegroundColor,
    titleTextStyle,
    titleTextMaxLines,
    subtitleForegroundColor,
    subtitleTextStyle,
    subtitleTextMaxLines,
    trailingForegroundColor,
    borderColor,
    overlayColor,
    backgroundGradientColors,
    backgroundTextureOpacity,
    backgroundBuilder,
  );
}
