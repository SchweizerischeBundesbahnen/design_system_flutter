part of 'promotion_box.dart';

class PromotionBoxStyle {
  const PromotionBoxStyle({
    required this.borderColor,
    required this.badgeShadowColor,
    required this.badgeColor,
    required this.badgeTextStyle,
    required this.gradientColors,
    required this.textureOpacity,
  });

  static List<Color> lightGradient = [
    Color(0xFFD8ECED),
    Color(0xFFE8F3F7),
    Color(0xFFE3EFF3),
    Color(0xFFD8ECED),
  ];

  static List<Color> darkGradient = [
    Color(0xFF2E3847),
    Color(0xFF3B4557),
    Color(0xFF3B4557),
    Color(0xFF202936),
  ];

  final Color? borderColor;
  final Color? badgeShadowColor;
  final Color? badgeColor;
  final TextStyle? badgeTextStyle;
  final List<Color>? gradientColors;
  final double? textureOpacity;

  static PromotionBoxStyle lerp(
    PromotionBoxStyle? $this,
    PromotionBoxStyle? other,
    double t,
  ) {
    return PromotionBoxStyle(
      borderColor: Color.lerp($this?.borderColor, other?.borderColor, t),
      badgeShadowColor: Color.lerp($this?.badgeShadowColor, other?.badgeShadowColor, t),
      badgeColor: Color.lerp($this?.badgeColor, other?.badgeColor, t),
      badgeTextStyle: TextStyle.lerp($this?.badgeTextStyle, other?.badgeTextStyle, t),
      gradientColors: other?.gradientColors,
      textureOpacity: lerpDouble($this?.textureOpacity, other?.textureOpacity, t),
    );
  }
}
