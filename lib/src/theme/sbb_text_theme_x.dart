import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

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
