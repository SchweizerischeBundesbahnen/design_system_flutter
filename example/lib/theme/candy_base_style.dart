import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class CandyBaseStyle {
  CandyBaseStyle._();

  static SBBBaseStyle light() =>
      SBBBaseStyle.fromColorScheme(brightness: Brightness.light, colorScheme: _lightColorScheme);

  static SBBBaseStyle dark() =>
      SBBBaseStyle.fromColorScheme(brightness: Brightness.dark, colorScheme: _darkColorScheme);

  static final SBBColorScheme _lightColorScheme = SBBColorScheme(
    primary: SBBColors.pink,
    primary85: SBBColors.pinkDark,
    primary125: SBBColors.violet,
    primary150: SBBColors.violetDark,
    brand: SBBColors.turquoise,
    backgroundBase: const Color(0xFFFFF6E8),
    backgroundContent: SBBColors.white,
    error: SBBColors.error,
    iconPrimary: SBBColors.violet,
    iconSecondary: SBBColors.turquoise,
    textPrimary: SBBColors.black,
    textSecondary: SBBColors.turquoise,
    strokePrimary: SBBColors.pink,
    strokeSecondary: SBBColors.orange,
    strokeSeparator: SBBColors.peach,
    selection: SBBColors.lemon,
  );

  static final SBBColorScheme _darkColorScheme = SBBColorScheme(
    primary: SBBColors.pinkDark,
    primary85: SBBColors.violetDark,
    primary125: SBBColors.turquoiseDark,
    primary150: SBBColors.orangeDark,
    brand: SBBColors.lemonDark,
    backgroundBase: const Color(0xFF1A0B2E),
    backgroundContent: const Color(0xFF2B1245),
    error: SBBColors.errorDark,
    iconPrimary: SBBColors.lemonDark,
    iconSecondary: SBBColors.turquoiseDark,
    textPrimary: SBBColors.white,
    textSecondary: SBBColors.peachDark,
    strokePrimary: SBBColors.pinkDark,
    strokeSecondary: SBBColors.violetDark,
    strokeSeparator: SBBColors.orangeDark,
    selection: SBBColors.lemonDark,
  );
}
