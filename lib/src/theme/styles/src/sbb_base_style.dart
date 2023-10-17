import 'package:flutter/material.dart';

import '../sbb_styles.dart';

class SBBBaseStyle extends ThemeExtension<SBBBaseStyle> {
  SBBBaseStyle({
    this.primaryColor,
    this.primaryColorDark,
    this.primarySwatch,
    this.backgroundColor,
    this.defaultFontFamily,
    this.defaultTextColor,
    this.defaultTextStyle,
    this.dividerColor,
    this.defaultRootContainerPadding,
    this.iconColor,
    this.hostPlatform,
    this.brightness,
    this.boldFont = false,
    this.labelColor,
    TextTheme? redTextTheme,
  }) {
    final redColor = $resolve(SBBColors.red, SBBColors.redDarkMode);
    this.redTextTheme =
        redTextTheme ?? createTextTheme(colorOverride: redColor);
  }

  factory SBBBaseStyle.$default({
    required Brightness brightness,
    HostPlatform? hostPlatform,
    bool boldFont = false,
  }) {
    final isLight = brightness == Brightness.light;
    return SBBBaseStyle(
      primaryColor: SBBColors.red,
      primaryColorDark: SBBColors.red125,
      primarySwatch: MaterialColor(
        SBBColors.red.value,
        <int, Color>{
          50: SBBColors.red,
          100: SBBColors.red,
          200: SBBColors.red,
          300: SBBColors.red,
          400: SBBColors.red,
          500: SBBColors.red,
          600: SBBColors.red,
          700: SBBColors.red,
          800: SBBColors.red,
          900: SBBColors.red,
        },
      ),
      defaultFontFamily: SBBWebFont,
      defaultTextColor: resolve(isLight, SBBColors.black, SBBColors.white),
      defaultTextStyle: SBBTextStyles.mediumLight.copyWith(
        color: resolve(isLight, SBBColors.black, SBBColors.white),
      ),
      backgroundColor: resolve(isLight, SBBColors.milk, SBBColors.black),
      dividerColor: resolve(isLight, SBBColors.cloud, SBBColors.iron),
      defaultRootContainerPadding: sbbDefaultSpacing,
      iconColor: resolve(isLight, SBBColors.black, SBBColors.white),
      hostPlatform: hostPlatform ?? HostPlatform.native,
      brightness: brightness,
      boldFont: boldFont,
      labelColor: resolve(isLight, SBBColors.granite, SBBColors.graphite),
    );
  }

  T $resolve<T>(T lightThemeValue, T darkThemeValue) {
    final isLight = brightness == Brightness.light;
    return SBBBaseStyle.resolve(isLight, lightThemeValue, darkThemeValue);
  }

  static T resolve<T>(bool isLight, T lightThemeValue, T darkThemeValue) =>
      isLight ? lightThemeValue : darkThemeValue;

  static SBBBaseStyle of(BuildContext context) =>
      Theme.of(context).extension<SBBBaseStyle>()!;

  final Color? primaryColor;
  final Color? primaryColorDark;
  final MaterialColor? primarySwatch;
  final Color? backgroundColor;
  final String? defaultFontFamily;
  final Color? defaultTextColor;
  final TextStyle? defaultTextStyle;
  final Color? dividerColor;
  final double? defaultRootContainerPadding;
  final Color? iconColor;
  final HostPlatform? hostPlatform;
  final Brightness? brightness;
  final bool boldFont;
  final Color? labelColor;
  late final TextTheme redTextTheme;

  @override
  ThemeExtension<SBBBaseStyle> copyWith({
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,
    Color? iconColor,
    HostPlatform? hostPlatform,
    Brightness? brightness,
    bool? boldFont,
    Color? labelColor,
    TextTheme? redTextTheme,
  }) =>
      SBBBaseStyle(
        primaryColor: primaryColor ?? this.primaryColor,
        primaryColorDark: primaryColorDark ?? this.primaryColorDark,
        primarySwatch: primarySwatch ?? this.primarySwatch,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        defaultFontFamily: fontFamily ?? this.defaultFontFamily,
        defaultTextColor: defaultTextColor ?? this.defaultTextColor,
        defaultTextStyle: defaultTextStyle ?? this.defaultTextStyle,
        dividerColor: dividerColor ?? this.dividerColor,
        defaultRootContainerPadding:
            defaultRootContainerPadding ?? this.defaultRootContainerPadding,
        iconColor: iconColor ?? this.iconColor,
        hostPlatform: hostPlatform ?? this.hostPlatform,
        brightness: brightness ?? this.brightness,
        boldFont: boldFont ?? this.boldFont,
        labelColor: labelColor ?? this.labelColor,
        redTextTheme: redTextTheme ?? this.redTextTheme,
      );

  @override
  ThemeExtension<SBBBaseStyle> lerp(
      ThemeExtension<SBBBaseStyle>? other, double t) {
    if (other is! SBBBaseStyle) return this;
    return SBBBaseStyle(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      primaryColorDark: Color.lerp(primaryColorDark, other.primaryColorDark, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t),
      defaultTextStyle:
          TextStyle.lerp(defaultTextStyle, other.defaultTextStyle, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      defaultFontFamily: other.defaultFontFamily,
      hostPlatform: other.hostPlatform,
      brightness: other.brightness,
      primarySwatch: other.primarySwatch,
      defaultRootContainerPadding: other.defaultRootContainerPadding,
      boldFont: other.boldFont,
      labelColor: Color.lerp(labelColor, other.labelColor, t),
      redTextTheme: TextTheme.lerp(redTextTheme, other.redTextTheme, t),
    );
  }

  T themeValue<T>(T lightThemeValue, T darkThemeValue) =>
      resolve(brightness == Brightness.light, lightThemeValue, darkThemeValue);

  TextStyle themedTextStyle(
          {TextStyle? textStyle, Color? color, bool boldFont = false}) =>
      (textStyle ?? defaultTextStyle)!.copyWith(
        fontFamily: defaultFontFamily,
        color: color ?? defaultTextColor,
        fontWeight: this.boldFont || boldFont ? FontWeight.bold : null,
      );

  TextTheme createTextTheme({Color? colorOverride}) {
    value(double size, double height, FontWeight weight, {Color? color}) =>
        TextStyle(
          inherit: false,
          fontSize: size,
          height: height,
          fontStyle: FontStyle.normal,
          fontWeight: boldFont ? FontWeight.bold : weight,
          fontFamily: defaultFontFamily,
          color: colorOverride ?? color ?? defaultTextColor,
          textBaseline: TextBaseline.alphabetic,
        );
    return TextTheme(
      bodySmall: value(SBBTextStyles.smallFontSize,
          SBBTextStyles.smallFontHeight, FontWeight.w300),
      bodyMedium: value(SBBTextStyles.mediumFontSize,
          SBBTextStyles.mediumFontHeight, FontWeight.w300),
      bodyLarge: value(SBBTextStyles.largeFontSize,
          SBBTextStyles.largeFontHeight, FontWeight.w300),
      labelSmall: value(SBBTextStyles.smallFontSize,
          SBBTextStyles.smallFontHeight, FontWeight.w300,
          color: labelColor),
      labelMedium: value(SBBTextStyles.mediumFontSize,
          SBBTextStyles.mediumFontHeight, FontWeight.w300,
          color: labelColor),
      labelLarge: value(SBBTextStyles.largeFontSize,
          SBBTextStyles.largeFontHeight, FontWeight.w300,
          color: labelColor),
      titleSmall: value(SBBTextStyles.smallFontSize,
          SBBTextStyles.smallFontHeight, FontWeight.w700),
      titleMedium: value(SBBTextStyles.mediumFontSize,
          SBBTextStyles.mediumFontHeight, FontWeight.w700),
      titleLarge: value(SBBTextStyles.largeFontSize,
          SBBTextStyles.largeFontHeight, FontWeight.w700),
    );
  }
}

extension StyleExtension on SBBBaseStyle? {
  SBBBaseStyle merge(SBBBaseStyle? other) {
    if (this == null) return other ?? SBBBaseStyle();
    return this!.copyWith(
      primaryColor: this!.primaryColor ?? other?.primaryColor,
      primaryColorDark: this!.primaryColorDark ?? other?.primaryColorDark,
      primarySwatch: this!.primarySwatch ?? other?.primarySwatch,
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      fontFamily: this!.defaultFontFamily ?? other?.defaultFontFamily,
      defaultTextColor: this!.defaultTextColor ?? other?.defaultTextColor,
      defaultTextStyle: this!.defaultTextStyle ?? other?.defaultTextStyle,
      dividerColor: this!.dividerColor ?? other?.dividerColor,
      defaultRootContainerPadding: this!.defaultRootContainerPadding ??
          other?.defaultRootContainerPadding,
      iconColor: this!.iconColor ?? other?.iconColor,
      hostPlatform: this!.hostPlatform ?? other?.hostPlatform,
      brightness: this!.brightness ?? other?.brightness,
      redTextTheme: this!.redTextTheme ?? other?.redTextTheme,
    ) as SBBBaseStyle;
  }
}
