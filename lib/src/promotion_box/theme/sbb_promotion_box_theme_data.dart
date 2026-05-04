import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/theme/sbb_promotion_box_badge_style.dart';

/// The ThemeData for the [SBBPromotionBox].
///
/// Use this to set the [SBBPromotionBoxStyle] and [SBBPromotionBoxBadgeStyle] for all
/// [SBBPromotionBox] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPromotionBoxTheme`.
class SBBPromotionBoxThemeData extends ThemeExtension<SBBPromotionBoxThemeData> {
  SBBPromotionBoxThemeData({
    this.badgeStyle,
  });

  /// Overrides for the promotion box badge's default style.
  ///
  /// Non-null properties values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBPromotionBoxBadgeStyle? badgeStyle;

  @override
  SBBPromotionBoxThemeData copyWith({SBBPromotionBoxBadgeStyle? badgeStyle}) {
    return SBBPromotionBoxThemeData(badgeStyle: badgeStyle ?? this.badgeStyle);
  }

  @override
  SBBPromotionBoxThemeData lerp(SBBPromotionBoxThemeData? other, double t) {
    if (other == null) return this;
    return SBBPromotionBoxThemeData(
      badgeStyle: SBBPromotionBoxBadgeStyle.lerp(badgeStyle, other.badgeStyle, t),
    );
  }

  @override
  int get hashCode => badgeStyle.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPromotionBoxThemeData && other.badgeStyle == badgeStyle;
  }
}

extension SBBPromotionBoxThemeDataX on SBBPromotionBoxThemeData {
  SBBPromotionBoxThemeData merge(SBBPromotionBoxThemeData? other) {
    if (other == null) return this;
    return copyWith(badgeStyle: badgeStyle?.merge(other.badgeStyle));
  }
}

extension SBBPromotionBoxThemeDataThemeDataX on ThemeData {
  /// Access the [SBBPromotionBoxThemeData] from the current theme.
  SBBPromotionBoxThemeData get sbbPromotionBoxTheme => extension<SBBPromotionBoxThemeData>()!;
}
