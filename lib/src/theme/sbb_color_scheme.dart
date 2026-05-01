import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile_v5/src/theme/theme.dart';

/// Defines the base color scheme used by the SBB design system.
/// Used by components to set their default color values.
///
/// Access the color scheme by using `Theme.of(context).sbbBaseStyle.colorScheme`.
///
/// See also:
///
/// * [SBBBaseStyle], base style containing the color scheme.
/// * [SBBColors], defined SBB colors
/// * [SBBTheme], the SBB base theme
class SBBColorScheme {
  SBBColorScheme({
    required this.primary,
    this.primary85,
    this.primary125,
    this.primary150,
    this.backgroundBase,
    this.backgroundContent,
    this.error,
    this.iconPrimary,
    this.iconSecondary,
    this.textPrimary,
    this.textSecondary,
    this.strokePrimary,
    this.strokeSecondary,
    this.strokeSeparator,
    this.selection,
    this.brand,
  });

  factory SBBColorScheme.$default({required Brightness brightness}) =>
      brightness == .light ? SBBColorScheme.sbb() : SBBColorScheme.sbbDark();

  /// Create a light ColorScheme based on the SBB theme context colors.
  factory SBBColorScheme.sbb() => SBBColorScheme(
    primary: SBBColors.red,
    primary85: SBBColors.red85,
    primary125: SBBColors.red125,
    primary150: SBBColors.red150,
    brand: SBBColors.red,
    backgroundBase: SBBColors.milk,
    backgroundContent: SBBColors.white,
    error: SBBColors.error,
    iconPrimary: SBBColors.black,
    iconSecondary: SBBColors.granite,
    textPrimary: SBBColors.black,
    textSecondary: SBBColors.granite,
    strokePrimary: SBBColors.black,
    strokeSecondary: SBBColors.granite,
    strokeSeparator: SBBColors.cloud,
    selection: SBBColors.sky,
  );

  /// Create a dark ColorScheme based on the SBB theme context colors.
  factory SBBColorScheme.sbbDark() => SBBColorScheme.sbb().copyWith(
    backgroundBase: SBBColors.black,
    backgroundContent: SBBColors.charcoal,
    error: SBBColors.errorDark,
    iconPrimary: SBBColors.white,
    iconSecondary: SBBColors.graphite,
    textPrimary: SBBColors.white,
    textSecondary: SBBColors.graphite,
    strokePrimary: SBBColors.white,
    strokeSecondary: SBBColors.graphite,
    strokeSeparator: SBBColors.iron,
    selection: SBBColors.skyDark,
  );

  /// Create a light ColorScheme based on the off-brand theme context colors.
  factory SBBColorScheme.offBrand() => SBBColorScheme.$default(brightness: .light).copyWith(
    primary: SBBColors.royal,
    primary85: SBBColors.royal85,
    primary125: SBBColors.royal125,
    primary150: SBBColors.royal150,
  );

  /// Create a dark ColorScheme based on the off-brand theme context colors.
  factory SBBColorScheme.offBrandDark() => SBBColorScheme.$default(brightness: .dark).copyWith(
    primary: SBBColors.royalDark,
    primary85: SBBColors.royal85Dark,
    primary125: SBBColors.royal125Dark,
    primary150: SBBColors.royal150Dark,
  );

  /// Create a light ColorScheme based on the safety theme context colors.
  factory SBBColorScheme.safety() => SBBColorScheme.$default(brightness: .light).copyWith(
    primary: SBBColors.royal,
    primary85: SBBColors.royal85,
    primary125: SBBColors.royal125,
    primary150: SBBColors.royal150,
    brand: SBBColors.metal,
  );

  /// Create a dark ColorScheme based on the safety theme context colors.
  factory SBBColorScheme.safetyDark() => SBBColorScheme.$default(brightness: .dark).copyWith(
    primary: SBBColors.royalDark,
    primary85: SBBColors.royal85Dark,
    primary125: SBBColors.royal125Dark,
    primary150: SBBColors.royal150Dark,
    brand: SBBColors.metal,
  );

  /// Required primary color.
  final Color primary;

  /// A lighter/soft variant of the primary color (85%).
  final Color? primary85;

  /// A stronger variant of the primary color (125%).
  final Color? primary125;

  /// A stronger variant of the primary color (150%).
  final Color? primary150;

  /// The brand color.
  final Color? brand;

  /// Background color used for app surfaces.
  final Color? backgroundBase;

  /// Background color used for content, e.g. the background color of a SBBContentBox.
  final Color? backgroundContent;

  /// Color used for error states.
  final Color? error;

  /// Primary color for icons.
  final Color? iconPrimary;

  /// Secondary color for icons.
  final Color? iconSecondary;

  /// Primary text color.
  final Color? textPrimary;

  /// Secondary text color used for label styles in [TextTheme] and some components.
  final Color? textSecondary;

  /// Primary stroke color used for borders.
  final Color? strokePrimary;

  /// Secondary stroke color used for borders.
  final Color? strokeSecondary;

  /// Separator color used in [DividerThemeData].
  final Color? strokeSeparator;

  /// Color used for text selection and cursor in [TextSelectionThemeData].
  final Color? selection;

  /// Returns a MaterialColor based on [primary] for use as a swatch.
  MaterialColor get primarySwatch => MaterialColor(primary.toARGB32(), <int, Color>{
    50: primary,
    100: primary,
    200: primary,
    300: primary,
    400: primary,
    500: primary,
    600: primary,
    700: primary,
    800: primary,
    900: primary,
  });

  SBBColorScheme copyWith({
    Color? primary,
    Color? primary85,
    Color? primary125,
    Color? primary150,
    Color? backgroundBase,
    Color? backgroundContent,
    Color? error,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? strokePrimary,
    Color? strokeSecondary,
    Color? strokeSeparator,
    Color? selection,
    Color? brand,
  }) => SBBColorScheme(
    primary: primary ?? this.primary,
    primary85: primary85 ?? this.primary85,
    primary125: primary125 ?? this.primary125,
    primary150: primary150 ?? this.primary150,
    backgroundBase: backgroundBase ?? this.backgroundBase,
    backgroundContent: backgroundContent ?? this.backgroundContent,
    error: error ?? this.error,
    iconPrimary: iconPrimary ?? this.iconPrimary,
    iconSecondary: iconSecondary ?? this.iconSecondary,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    strokePrimary: strokePrimary ?? this.strokePrimary,
    strokeSecondary: strokeSecondary ?? this.strokeSecondary,
    strokeSeparator: strokeSeparator ?? this.strokeSeparator,
    selection: selection ?? this.selection,
    brand: brand ?? this.brand,
  );

  SBBColorScheme lerp(SBBColorScheme? other, double t) {
    if (other is! SBBColorScheme) return this;
    return SBBColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primary85: Color.lerp(primary85, other.primary85, t),
      primary125: Color.lerp(primary125, other.primary125, t),
      primary150: Color.lerp(primary150, other.primary150, t),
      backgroundBase: Color.lerp(backgroundBase, other.backgroundBase, t),
      backgroundContent: Color.lerp(backgroundContent, other.backgroundContent, t),
      error: Color.lerp(error, other.error, t),
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t),
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t),
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t),
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
      strokePrimary: Color.lerp(strokePrimary, other.strokePrimary, t),
      strokeSecondary: Color.lerp(strokeSecondary, other.strokeSecondary, t),
      strokeSeparator: Color.lerp(strokeSeparator, other.strokeSeparator, t),
      selection: Color.lerp(selection, other.selection, t),
      brand: Color.lerp(brand, other.brand, t),
    );
  }
}
