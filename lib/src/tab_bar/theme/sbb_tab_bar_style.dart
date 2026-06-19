import 'package:flutter/material.dart';

/// Defines the visual properties of [SBBTabBar].
///
/// Use this class in combination with [SBBTabBarThemeData] to customize
/// the appearance of the tab bar throughout your app or for specific widget
/// subtrees. Pass a [SBBTabBarStyle] directly to [SBBTabBar] to override the
/// theme for a single instance.
///
/// See also:
/// * [SBBTabBar], the widget that uses this style.
/// * [SBBTabBarThemeData], which applies this style theme-wide.
class SBBTabBarStyle {
  const SBBTabBarStyle({
    this.backgroundColor,
    this.iconColor,
    this.itemBackgroundColor,
    this.itemLabelTextStyle,
    this.itemLabelForegroundColor,
    this.warningItemIcon,
    this.warningItemBackgroundColor,
    this.warningItemForegroundColor,
    this.badgeForegroundColor,
    this.badgeBackgroundColor,
    this.badgeTextStyle,
  });

  /// The background color of the tab bar container.
  final Color? backgroundColor;

  /// The color of the tab item icon.
  final WidgetStateProperty<Color?>? iconColor;

  /// The background color of the circular selection indicator behind a tab item.
  final WidgetStateProperty<Color?>? itemBackgroundColor;

  /// The text style for the tab item label shown below the selected icon.
  final TextStyle? itemLabelTextStyle;

  /// The foreground color for the tab item label text.
  final Color? itemLabelForegroundColor;

  /// The icon shown on a tab item when a warning is active and not yet seen.
  final IconData? warningItemIcon;

  /// The background color of the circular badge shown for a warning item.
  final Color? warningItemBackgroundColor;

  /// The icon/text color shown inside the warning badge.
  final Color? warningItemForegroundColor;

  /// The default foreground color (icon or text) for [SBBTabBarBadge] widgets
  /// displayed on tab items.
  ///
  /// This acts as a theme-level default. Individual [SBBTabBarBadgeIcon] or
  /// [SBBTabBarBadgeText] instances can override this by setting their own
  /// [SBBTabBarBadge.labelForegroundColor] property.
  final Color? badgeForegroundColor;

  /// The background color for [SBBTabBarBadge] widgets displayed on
  /// tab items.
  ///
  /// This acts as a theme-level default. Individual [SBBTabBarBadgeIcon] or
  /// [SBBTabBarBadgeText] instances can override this by setting their own
  /// [SBBTabBarBadge.backgroundColor] property.
  final Color? badgeBackgroundColor;

  /// The text style for the [SBBTabBarBadgeText] widget displayed on tab items.
  final TextStyle? badgeTextStyle;

  SBBTabBarStyle copyWith({
    Color? backgroundColor,
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<Color?>? itemBackgroundColor,
    TextStyle? itemLabelTextStyle,
    Color? itemLabelForegroundColor,
    IconData? warningItemIcon,
    Color? warningItemBackgroundColor,
    Color? warningItemForegroundColor,
    Color? badgeForegroundColor,
    Color? badgeBackgroundColor,
    TextStyle? badgeTextStyle,
  }) {
    return SBBTabBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemLabelTextStyle: itemLabelTextStyle ?? this.itemLabelTextStyle,
      itemLabelForegroundColor: itemLabelForegroundColor ?? this.itemLabelForegroundColor,
      warningItemIcon: warningItemIcon ?? this.warningItemIcon,
      warningItemBackgroundColor: warningItemBackgroundColor ?? this.warningItemBackgroundColor,
      warningItemForegroundColor: warningItemForegroundColor ?? this.warningItemForegroundColor,
      badgeForegroundColor: badgeForegroundColor ?? this.badgeForegroundColor,
      badgeBackgroundColor: badgeBackgroundColor ?? this.badgeBackgroundColor,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
    );
  }

  SBBTabBarStyle merge(SBBTabBarStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      iconColor: other.iconColor,
      itemBackgroundColor: other.itemBackgroundColor,
      itemLabelTextStyle: other.itemLabelTextStyle,
      itemLabelForegroundColor: other.itemLabelForegroundColor,
      warningItemIcon: other.warningItemIcon,
      warningItemBackgroundColor: other.warningItemBackgroundColor,
      warningItemForegroundColor: other.warningItemForegroundColor,
      badgeForegroundColor: other.badgeForegroundColor,
      badgeBackgroundColor: other.badgeBackgroundColor,
      badgeTextStyle: other.badgeTextStyle,
    );
  }

  static SBBTabBarStyle? lerp(SBBTabBarStyle? a, SBBTabBarStyle? b, double t) {
    if (identical(a, b)) return a;
    return SBBTabBarStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconColor: WidgetStateProperty.lerp<Color?>(a?.iconColor, b?.iconColor, t, Color.lerp),
      itemBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.itemBackgroundColor,
        b?.itemBackgroundColor,
        t,
        Color.lerp,
      ),
      itemLabelTextStyle: TextStyle.lerp(a?.itemLabelTextStyle, b?.itemLabelTextStyle, t),
      itemLabelForegroundColor: Color.lerp(a?.itemLabelForegroundColor, b?.itemLabelForegroundColor, t),
      warningItemIcon: t < 0.5 ? a?.warningItemIcon : b?.warningItemIcon,
      warningItemBackgroundColor: Color.lerp(a?.warningItemBackgroundColor, b?.warningItemBackgroundColor, t),
      warningItemForegroundColor: Color.lerp(a?.warningItemForegroundColor, b?.warningItemForegroundColor, t),
      badgeForegroundColor: Color.lerp(a?.badgeForegroundColor, b?.badgeForegroundColor, t),
      badgeBackgroundColor: Color.lerp(a?.badgeBackgroundColor, b?.badgeBackgroundColor, t),
      badgeTextStyle: TextStyle.lerp(a?.badgeTextStyle, b?.badgeTextStyle, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBTabBarStyle &&
        other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.itemBackgroundColor == itemBackgroundColor &&
        other.itemLabelTextStyle == itemLabelTextStyle &&
        other.itemLabelForegroundColor == itemLabelForegroundColor &&
        other.warningItemIcon == warningItemIcon &&
        other.warningItemBackgroundColor == warningItemBackgroundColor &&
        other.warningItemForegroundColor == warningItemForegroundColor &&
        other.badgeForegroundColor == badgeForegroundColor &&
        other.badgeBackgroundColor == badgeBackgroundColor &&
        other.badgeTextStyle == badgeTextStyle;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    iconColor,
    itemBackgroundColor,
    itemLabelTextStyle,
    itemLabelForegroundColor,
    warningItemIcon,
    warningItemBackgroundColor,
    warningItemForegroundColor,
    badgeForegroundColor,
    badgeBackgroundColor,
    badgeTextStyle,
  );
}
