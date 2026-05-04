import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DefaultSBBPromotionBoxThemeData extends SBBPromotionBoxThemeData {
  DefaultSBBPromotionBoxThemeData(SBBBaseStyle baseStyle)
    : super(
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
