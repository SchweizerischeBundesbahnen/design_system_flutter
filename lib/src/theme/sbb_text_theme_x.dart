import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

extension SBBTextThemeX on SBBTextTheme {
  TextTheme toTextTheme({Color? labelColor}) {
    return TextTheme(
      bodySmall: smallLight,
      bodyMedium: mediumLight,
      bodyLarge: largeLight,
      labelSmall: smallLight?.copyWith(color: labelColor),
      labelMedium: mediumLight?.copyWith(color: labelColor),
      labelLarge: largeLight?.copyWith(color: labelColor),
      titleSmall: smallBold,
      titleMedium: mediumBold,
      titleLarge: largeBold,
    );
  }
}
