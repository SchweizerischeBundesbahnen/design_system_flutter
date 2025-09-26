import 'package:flutter/material.dart';

import '../../theme.dart';

class SBBBaseStyle extends ThemeExtension<SBBBaseStyle> {
  SBBBaseStyle({
    this.primaryColor,
    this.primaryColorDark,
    this.primarySwatch,
    this.backgroundColor,
    this.errorColor,
    this.defaultFontFamily,
    this.defaultTextColor,
    this.defaultTextStyle,
    this.dividerColor,
    this.defaultRootContainerPadding,
    this.iconColor,
    this.brightness,
    this.boldFont = false,
    this.labelColor,
    TextTheme? redTextTheme,
  }) {
    final redColor = resolve(brightness == Brightness.light, SBBColors.red, SBBColors.redDark);
    this.redTextTheme = redTextTheme ?? createTextTheme(colorOverride: redColor);
  }

  factory SBBBaseStyle.$default({required Brightness brightness, bool boldFont = false}) {
    final isLight = brightness == Brightness.light;
    return SBBBaseStyle(
      primaryColor: SBBColors.red,
      primaryColorDark: SBBColors.red125,
      primarySwatch: _sbbPrimarySwatchRed(),
      defaultFontFamily: sbbFont,
      defaultTextColor: resolve(isLight, SBBColors.black, SBBColors.white),
      defaultTextStyle: SBBTextStyles.mediumLight.copyWith(color: resolve(isLight, SBBColors.black, SBBColors.white)),
      backgroundColor: resolve(isLight, SBBColors.milk, SBBColors.black),
      errorColor: resolve(isLight, SBBColors.error, SBBColors.errorDark),
      dividerColor: resolve(isLight, SBBColors.cloud, SBBColors.iron),
      defaultRootContainerPadding: sbbDefaultSpacing,
      iconColor: resolve(isLight, SBBColors.black, SBBColors.white),
      brightness: brightness,
      boldFont: boldFont,
      labelColor: resolve(isLight, SBBColors.granite, SBBColors.graphite),
    );
  }

  static MaterialColor _sbbPrimarySwatchRed() => MaterialColor(SBBColors.red.toARGB32(), const <int, Color>{
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
  });

  static T resolve<T>(bool isLight, T lightThemeValue, T darkThemeValue) => isLight ? lightThemeValue : darkThemeValue;

  static SBBBaseStyle of(BuildContext context) => Theme.of(context).extension<SBBBaseStyle>()!;

  final Color? primaryColor;
  final Color? primaryColorDark;
  final MaterialColor? primarySwatch;
  final Color? backgroundColor;
  final Color? errorColor;
  final String? defaultFontFamily;
  final Color? defaultTextColor;
  final TextStyle? defaultTextStyle;
  final Color? dividerColor;
  final double? defaultRootContainerPadding;
  final Color? iconColor;
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
    Color? errorColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,
    Color? iconColor,
    Brightness? brightness,
    bool? boldFont,
    Color? labelColor,
    TextTheme? redTextTheme,
  }) => SBBBaseStyle(
    primaryColor: primaryColor ?? this.primaryColor,
    primaryColorDark: primaryColorDark ?? this.primaryColorDark,
    primarySwatch: primarySwatch ?? this.primarySwatch,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    errorColor: errorColor ?? this.errorColor,
    defaultFontFamily: fontFamily ?? defaultFontFamily,
    defaultTextColor: defaultTextColor ?? this.defaultTextColor,
    defaultTextStyle: defaultTextStyle ?? this.defaultTextStyle,
    dividerColor: dividerColor ?? this.dividerColor,
    defaultRootContainerPadding: defaultRootContainerPadding ?? this.defaultRootContainerPadding,
    iconColor: iconColor ?? this.iconColor,
    brightness: brightness ?? this.brightness,
    boldFont: boldFont ?? this.boldFont,
    labelColor: labelColor ?? this.labelColor,
    redTextTheme: redTextTheme ?? this.redTextTheme,
  );

  @override
  ThemeExtension<SBBBaseStyle> lerp(ThemeExtension<SBBBaseStyle>? other, double t) {
    if (other is! SBBBaseStyle) return this;
    return SBBBaseStyle(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      primaryColorDark: Color.lerp(primaryColorDark, other.primaryColorDark, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t),
      defaultTextStyle: TextStyle.lerp(defaultTextStyle, other.defaultTextStyle, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      defaultFontFamily: other.defaultFontFamily,
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

  TextStyle themedTextStyle({TextStyle? textStyle, Color? color, String? fontFamily}) =>
      (textStyle ?? defaultTextStyle)!.copyWith(
        fontFamily: fontFamily ?? textStyle?.fontFamily ?? defaultFontFamily,
        color: color ?? defaultTextColor,
      );

  TextTheme createTextTheme({Color? colorOverride}) {
    value(double size, double height, {Color? color, String? fontFamily}) => TextStyle(
      inherit: false,
      fontSize: size,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: fontFamily ?? defaultFontFamily,
      color: colorOverride ?? color ?? defaultTextColor,
      textBaseline: TextBaseline.alphabetic,
    );
    return TextTheme(
      bodySmall: value(SBBTextStyles.smallFontSize, SBBTextStyles.smallFontHeight),
      bodyMedium: value(SBBTextStyles.mediumFontSize, SBBTextStyles.mediumFontHeight),
      bodyLarge: value(SBBTextStyles.largeFontSize, SBBTextStyles.largeFontHeight),
      labelSmall: value(SBBTextStyles.smallFontSize, SBBTextStyles.smallFontHeight, color: labelColor),
      labelMedium: value(SBBTextStyles.mediumFontSize, SBBTextStyles.mediumFontHeight, color: labelColor),
      labelLarge: value(SBBTextStyles.largeFontSize, SBBTextStyles.largeFontHeight, color: labelColor),
      titleSmall: value(
        SBBTextStyles.smallFontSize,
        SBBTextStyles.smallFontHeight,
        fontFamily: SBBFontFamily.sbbFontBold,
      ),
      titleMedium: value(
        SBBTextStyles.mediumFontSize,
        SBBTextStyles.mediumFontHeight,
        fontFamily: SBBFontFamily.sbbFontBold,
      ),
      titleLarge: value(
        SBBTextStyles.largeFontSize,
        SBBTextStyles.largeFontHeight,
        fontFamily: SBBFontFamily.sbbFontBold,
      ),
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
          errorColor: this!.errorColor ?? other?.errorColor,
          fontFamily: this!.defaultFontFamily ?? other?.defaultFontFamily,
          defaultTextColor: this!.defaultTextColor ?? other?.defaultTextColor,
          defaultTextStyle: this!.defaultTextStyle ?? other?.defaultTextStyle,
          dividerColor: this!.dividerColor ?? other?.dividerColor,
          defaultRootContainerPadding: this!.defaultRootContainerPadding ?? other?.defaultRootContainerPadding,
          iconColor: this!.iconColor ?? other?.iconColor,
          brightness: this!.brightness ?? other?.brightness,
          redTextTheme: this?.redTextTheme ?? other?.redTextTheme,
        )
        as SBBBaseStyle;
  }
}
