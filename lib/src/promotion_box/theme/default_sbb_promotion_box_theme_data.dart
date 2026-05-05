import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const List<Color> lightGradient = [Color(0xFFD8ECED), Color(0xFFE8F3F7), Color(0xFFE3EFF3), Color(0xFFD6ECED)];
const List<Color> darkGradient = [Color(0xFF2E3847), Color(0xFF3B4557), Color(0xFF3B4557), Color(0xFF202936)];

class DefaultSBBPromotionBoxThemeData extends SBBPromotionBoxThemeData {
  DefaultSBBPromotionBoxThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBPromotionBoxStyle(
          titleForegroundColor: baseStyle.colorScheme.textPrimary,
          titleTextStyle: baseStyle.textTheme.mediumBold,
          titleTextMaxLines: 1,
          subtitleForegroundColor: baseStyle.colorScheme.textPrimary,
          subtitleTextStyle: baseStyle.textTheme.mediumLight,
          subtitleTextMaxLines: 3,
          trailingForegroundColor: baseStyle.colorScheme.iconPrimary,
          borderColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
          overlayColor: WidgetStatePropertyAll<Color?>(baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight)),
          backgroundGradientColors: baseStyle.themeValue(lightGradient, darkGradient),
          backgroundTextureOpacity: baseStyle.themeValue(.1, .5),
        ),
        badgeStyle: SBBPromotionBoxBadgeStyle(
          backgroundColor: baseStyle.colorScheme.primary,
          foregroundColor: SBBColors.white,
          textStyle: baseStyle.textTheme.smallBold,
          haloColor: baseStyle.themeValue(
            baseStyle.colorScheme.primary.withValues(alpha: 0.2),
            baseStyle.colorScheme.primary85?.withValues(alpha: 0.6),
          ),
          borderColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
          padding: .symmetric(horizontal: 8.0, vertical: 1.0),
        ),
      );
}
