import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme.dart';

class PromotionBoxStyle {
  const PromotionBoxStyle({
    required this.borderColor,
    required this.badgeShadowColor,
    required this.badgeColor,
    required this.badgeBorderColor,
    required this.badgeTextStyle,
    required this.gradientColors,
    required this.textureOpacity,
  });

  factory PromotionBoxStyle.$default({required SBBBaseStyle baseStyle}) {
    return PromotionBoxStyle(
      borderColor: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
      badgeShadowColor: baseStyle.themeValue(
        SBBColors.red.withValues(alpha: 0.2),
        SBBColors.redDarkMode.withValues(alpha: 0.6),
      ),
      badgeColor: SBBColors.red,
      badgeBorderColor: baseStyle.themeValue(
        SBBColors.white,
        SBBColors.charcoal,
      ),
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

  final Color? borderColor;
  final Color? badgeShadowColor;
  final Color? badgeColor;
  final Color? badgeBorderColor;
  final TextStyle? badgeTextStyle;
  final List<Color>? gradientColors;
  final double? textureOpacity;

  PromotionBoxStyle copyWith({
    Color? borderColor,
    Color? badgeShadowColor,
    Color? badgeColor,
    Color? badgeBorderColor,
    TextStyle? badgeTextStyle,
    List<Color>? gradientColors,
    double? textureOpacity,
  }) {
    return PromotionBoxStyle(
      borderColor: borderColor ?? this.borderColor,
      badgeShadowColor: badgeShadowColor ?? this.badgeShadowColor,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeBorderColor: badgeBorderColor ?? this.badgeBorderColor,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
      gradientColors: gradientColors ?? this.gradientColors,
      textureOpacity: textureOpacity ?? this.textureOpacity,
    );
  }

  static PromotionBoxStyle lerp(
    PromotionBoxStyle? $this,
    PromotionBoxStyle? other,
    double t,
  ) {
    return PromotionBoxStyle(
      borderColor: Color.lerp($this?.borderColor, other?.borderColor, t),
      badgeShadowColor: Color.lerp(
        $this?.badgeShadowColor,
        other?.badgeShadowColor,
        t,
      ),
      badgeColor: Color.lerp($this?.badgeColor, other?.badgeColor, t),
      badgeBorderColor: Color.lerp(
        $this?.badgeBorderColor,
        other?.badgeBorderColor,
        t,
      ),
      badgeTextStyle: TextStyle.lerp(
        $this?.badgeTextStyle,
        other?.badgeTextStyle,
        t,
      ),
      gradientColors: other?.gradientColors,
      textureOpacity: lerpDouble(
        $this?.textureOpacity,
        other?.textureOpacity,
        t,
      ),
    );
  }

  /// The given [other] null properties its null properties
  /// are replaced with the non-null properties of this text style.
  /// Another way to think of it is that the "missing" properties of the [other] style
  /// are _filled_ by the properties of this style.
  PromotionBoxStyle merge(PromotionBoxStyle? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      borderColor: other.borderColor,
      badgeShadowColor: other.badgeShadowColor,
      badgeColor: other.badgeColor,
      badgeBorderColor: other.badgeBorderColor,
      badgeTextStyle: other.badgeTextStyle,
      gradientColors: other.gradientColors,
      textureOpacity: other.textureOpacity,
    );
  }
}
