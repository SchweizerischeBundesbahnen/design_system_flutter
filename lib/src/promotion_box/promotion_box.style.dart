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

  factory PromotionBoxStyle.$default({required SBBBaseStyle baseStyle}) {
    return PromotionBoxStyle(
      borderColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
      badgeShadowColor: baseStyle.themeValue(
        SBBColors.red.withOpacity(0.2),
        SBBColors.redDarkMode.withOpacity(0.6),
      ),
      badgeColor: SBBColors.red,
      badgeTextStyle: SBBTextStyles.smallBold.copyWith(
        color: SBBColors.white,
      ),
      gradientColors: baseStyle.themeValue(
        PromotionBoxStyle.lightGradient,
        PromotionBoxStyle.darkGradient,
      ),
      textureOpacity: baseStyle.themeValue(0.1, 0.5),
    );
  }

  static List<Color> lightGradient = [
    Color(0xFFD8ECED),
    Color(0xFFE8F3F7),
    Color(0xFFE3EFF3),
    Color(0xFFD6ECED),
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
      badgeShadowColor:
          Color.lerp($this?.badgeShadowColor, other?.badgeShadowColor, t),
      badgeColor: Color.lerp($this?.badgeColor, other?.badgeColor, t),
      badgeTextStyle:
          TextStyle.lerp($this?.badgeTextStyle, other?.badgeTextStyle, t),
      gradientColors: other?.gradientColors,
      textureOpacity:
          lerpDouble($this?.textureOpacity, other?.textureOpacity, t),
    );
  }
}
