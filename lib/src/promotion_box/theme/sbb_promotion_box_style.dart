import 'dart:ui';

class SBBPromotionBoxStyle {
  const SBBPromotionBoxStyle({
    this.titleForegroundColor,
    this.titleTextStyle,
    this.subtitleForegroundColor,
    this.subtitleTextStyle,
    this.trailingForegroundColor,
    this.backgroundGradientColors,
    this.backgroundTextureOpacity,
  });

  static List<Color> lightGradient = [
    const Color(0xFFD8ECED),
    const Color(0xFFE8F3F7),
    const Color(0xFFE3EFF3),
    const Color(0xFFD6ECED),
  ];

  static List<Color> darkGradient = [
    const Color(0xFF2E3847),
    const Color(0xFF3B4557),
    const Color(0xFF3B4557),
    const Color(0xFF202936),
  ];

  final List<Color>? backgroundGradientColors;
  final double? backgroundTextureOpacity;

  SBBPromotionBoxStyle copyWith({
    List<Color>? backgroundGradientColors,
    double? backgroundTextureOpacity,
  }) {
    return SBBPromotionBoxStyle(
      backgroundGradientColors: backgroundGradientColors ?? this.backgroundGradientColors,
      backgroundTextureOpacity: backgroundTextureOpacity ?? this.backgroundTextureOpacity,
    );
  }

  static SBBPromotionBoxStyle lerp(SBBPromotionBoxStyle? $this, SBBPromotionBoxStyle? other, double t) {
    return SBBPromotionBoxStyle(
      backgroundGradientColors: other?.backgroundGradientColors,
      backgroundTextureOpacity: lerpDouble($this?.backgroundTextureOpacity, other?.backgroundTextureOpacity, t),
    );
  }

  /// The given [other] null properties its null properties
  /// are replaced with the non-null properties of this text style.
  /// Another way to think of it is that the "missing" properties of the [other] style
  /// are _filled_ by the properties of this style.
  SBBPromotionBoxStyle merge(SBBPromotionBoxStyle? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      backgroundGradientColors: other.backgroundGradientColors,
      backgroundTextureOpacity: other.backgroundTextureOpacity,
    );
  }
}
