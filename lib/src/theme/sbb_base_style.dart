import 'package:flutter/material.dart';

import 'theme.dart';

/// Base style used in [SBBTheme].
///
/// Provides the shared visual defaults (brightness, color scheme, text and
/// icon styles, dividers and text selection) that SBB components use.
///
/// Access the base style by using `Theme.of(context).sbbBaseStyle`.
///
/// See also:
///
/// * [SBBColorScheme], the color values used by this base style.
/// * [SBBTheme], helpers to create full ThemeData from an SBB base style.
class SBBBaseStyle extends ThemeExtension<SBBBaseStyle> {
  SBBBaseStyle({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    this.iconTheme,
    this.dividerTheme,
    this.textSelectionTheme,
  });

  factory SBBBaseStyle.$default({required Brightness brightness, required SBBThemeContext themeContext}) =>
      SBBBaseStyle.fromThemeContext(brightness: brightness, context: themeContext);

  /// Create the base style for the given [brightness] using the SBB theming.
  factory SBBBaseStyle.sbb({required Brightness brightness}) =>
      SBBBaseStyle.fromThemeContext(brightness: brightness, context: .sbb);

  /// Create the base style for the given [brightness] using the off-brand theming.
  factory SBBBaseStyle.offBrand({required Brightness brightness}) =>
      SBBBaseStyle.fromThemeContext(brightness: brightness, context: .offBrand);

  /// Create the base style for the given [brightness] using the safety theming.
  factory SBBBaseStyle.safety({required Brightness brightness}) =>
      SBBBaseStyle.fromThemeContext(brightness: brightness, context: .safety);

  factory SBBBaseStyle.fromThemeContext({required Brightness brightness, required SBBThemeContext context}) =>
      SBBBaseStyle.fromColorScheme(
        brightness: brightness,
        colorScheme: context.colorScheme(brightness: brightness),
      );

  /// Creates the base style from the provided [SBBColorScheme]
  factory SBBBaseStyle.fromColorScheme({required Brightness brightness, required SBBColorScheme colorScheme}) {
    return SBBBaseStyle(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: SBBTextTheme.$default(colorScheme: colorScheme),
      dividerTheme: DividerThemeData(thickness: 1.0, space: 0.0, color: colorScheme.dividerColor),
      iconTheme: IconThemeData(color: colorScheme.iconColor, size: sbbIconSizeSmall),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.selectionColor,
        selectionColor: colorScheme.selectionColor?.withValues(alpha: 0.5),
        selectionHandleColor: colorScheme.selectionColor,
      ),
    );
  }

  /// The brightness (light or dark) of the theme.
  final Brightness brightness;

  /// The color scheme that provides the default colors for the theme and components.
  final SBBColorScheme colorScheme;

  /// The SBB text theme used to derive text styles.
  final SBBTextTheme textTheme;

  /// Icon theme providing default icon color and size. If null, default of [ThemeData] is used.
  final IconThemeData? iconTheme;

  /// Divider theme used for default divider appearance. If null, default of [ThemeData] is used.
  final DividerThemeData? dividerTheme;

  /// Text selection theme (cursor, selection, handles). If null, default of [ThemeData] is used.
  final TextSelectionThemeData? textSelectionTheme;

  static T resolve<T>(bool isLight, T lightThemeValue, T darkThemeValue) => isLight ? lightThemeValue : darkThemeValue;

  T themeValue<T>(T lightThemeValue, T darkThemeValue) =>
      resolve(brightness == .light, lightThemeValue, darkThemeValue);

  TextStyle themedTextStyle({TextStyle? textStyle, Color? color, String? fontFamily}) =>
      (textStyle ?? textTheme.defaultTextStyle)!.copyWith(
        fontFamily: fontFamily ?? textStyle?.fontFamily ?? sbbFont,
        color: color ?? colorScheme.defaultTextColor,
      );

  @override
  ThemeExtension<SBBBaseStyle> copyWith({
    Brightness? brightness,
    SBBColorScheme? colorScheme,
    SBBTextTheme? textTheme,
    IconThemeData? iconTheme,
    DividerThemeData? dividerTheme,
    TextSelectionThemeData? textSelectionTheme,
  }) => SBBBaseStyle(
    brightness: brightness ?? this.brightness,
    colorScheme: colorScheme ?? this.colorScheme,
    textTheme: textTheme ?? this.textTheme,
    iconTheme: iconTheme ?? this.iconTheme,
    dividerTheme: dividerTheme ?? this.dividerTheme,
    textSelectionTheme: textSelectionTheme ?? this.textSelectionTheme,
  );

  @override
  ThemeExtension<SBBBaseStyle> lerp(ThemeExtension<SBBBaseStyle>? other, double t) {
    if (other is! SBBBaseStyle) return this;
    return SBBBaseStyle(
      brightness: other.brightness,
      colorScheme: colorScheme.lerp(other.colorScheme, t),
      textTheme: textTheme.lerp(other.textTheme, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      dividerTheme: DividerThemeData.lerp(dividerTheme, other.dividerTheme, t),
      textSelectionTheme: TextSelectionThemeData.lerp(textSelectionTheme, other.textSelectionTheme, t),
    );
  }

  SBBBaseStyle merge(SBBBaseStyle? other) {
    return copyWith(
          brightness: other?.brightness,
          colorScheme: other?.colorScheme,
          iconTheme: other?.iconTheme,
          dividerTheme: other?.dividerTheme,
          textSelectionTheme: other?.textSelectionTheme,
        )
        as SBBBaseStyle;
  }
}

extension SBBBaseStyleThemeDataX on ThemeData {
  SBBBaseStyle get sbbBaseStyle => extension<SBBBaseStyle>()!;
}

extension SBBThemeContextX on SBBThemeContext {
  SBBColorScheme colorScheme({required Brightness brightness}) => switch (this) {
    .sbb => brightness == .light ? SBBColorScheme.sbb() : SBBColorScheme.sbbDark(),
    .offBrand => brightness == .light ? SBBColorScheme.offBrand() : SBBColorScheme.offBrandDark(),
    .safety => brightness == .light ? SBBColorScheme.safety() : SBBColorScheme.safetyDark(),
  };
}
