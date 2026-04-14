import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBColorScheme {
  SBBColorScheme({
    required this.primaryColor,
    this.primary85Color,
    this.primary125Color,
    this.primary150Color,
    this.brandColor,
    this.backgroundColor,
    this.errorColor,
    this.iconColor,
    this.defaultTextColor,
    this.dividerColor,
    this.selectionColor,
    this.labelColor,
  });

  factory SBBColorScheme.$default({required Brightness brightness}) =>
      brightness == .light ? SBBColorScheme.sbb() : SBBColorScheme.sbbDark();

  factory SBBColorScheme.sbb() => SBBColorScheme(
    primaryColor: SBBColors.red,
    primary85Color: SBBColors.red85,
    primary125Color: SBBColors.red125,
    primary150Color: SBBColors.red150,
    brandColor: SBBColors.red,
    backgroundColor: SBBColors.milk,
    errorColor: SBBColors.error,
    iconColor: SBBColors.black,
    defaultTextColor: SBBColors.black,
    dividerColor: SBBColors.cloud,
    selectionColor: SBBColors.sky,
    labelColor: SBBColors.granite,
  );

  factory SBBColorScheme.sbbDark() => SBBColorScheme.sbb().copyWith(
    backgroundColor: SBBColors.black,
    errorColor: SBBColors.errorDark,
    iconColor: SBBColors.white,
    defaultTextColor: SBBColors.white,
    dividerColor: SBBColors.iron,
    selectionColor: SBBColors.skyDark,
    labelColor: SBBColors.graphite,
  );

  final Color primaryColor;
  final Color? primary85Color;
  final Color? primary125Color;
  final Color? primary150Color;
  final Color? brandColor;
  final Color? backgroundColor;
  final Color? errorColor;
  final Color? iconColor;
  final Color? defaultTextColor;
  final Color? dividerColor;
  final Color? selectionColor;
  final Color? labelColor;

  MaterialColor get primarySwatch => MaterialColor(primaryColor.toARGB32(), <int, Color>{
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  });

  SBBColorScheme copyWith({
    Color? primaryColor,
    Color? primary85Color,
    Color? primary125Color,
    Color? primary150Color,
    Color? brandColor,
    Color? backgroundColor,
    Color? errorColor,
    Color? iconColor,
    Color? defaultTextColor,
    Color? dividerColor,
    Color? selectionColor,
    Color? labelColor,
  }) => SBBColorScheme(
    primaryColor: primaryColor ?? this.primaryColor,
    primary85Color: primary85Color ?? this.primary85Color,
    primary125Color: primary125Color ?? this.primary125Color,
    primary150Color: primary150Color ?? this.primary150Color,
    brandColor: brandColor ?? this.brandColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    errorColor: errorColor ?? this.errorColor,
    iconColor: iconColor ?? this.iconColor,
    defaultTextColor: defaultTextColor ?? this.defaultTextColor,
    dividerColor: dividerColor ?? this.dividerColor,
    selectionColor: selectionColor ?? this.selectionColor,
    labelColor: labelColor ?? this.labelColor,
  );

  SBBColorScheme lerp(SBBColorScheme? other, double t) {
    if (other is! SBBColorScheme) return this;
    return SBBColorScheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      primary85Color: Color.lerp(primary85Color, other.primary85Color, t),
      primary125Color: Color.lerp(primary125Color, other.primary125Color, t),
      primary150Color: Color.lerp(primary150Color, other.primary150Color, t),
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t),
      labelColor: Color.lerp(labelColor, other.labelColor, t),
    );
  }
}
