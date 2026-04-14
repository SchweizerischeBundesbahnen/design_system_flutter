import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/theme/styles/src/sbb_color_scheme.dart';

import '../../theme.dart';

class SBBBaseStyle extends ThemeExtension<SBBBaseStyle> {
  SBBBaseStyle({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    this.iconTheme,
    this.dividerTheme,
    this.textSelectionTheme,
  });

  factory SBBBaseStyle.$default({required Brightness brightness}) => SBBBaseStyle.sbb(brightness: brightness);

  factory SBBBaseStyle.sbb({required Brightness brightness}) => SBBBaseStyle.fromColorScheme(
    brightness: brightness,
    colorScheme: brightness == .light ? SBBColorScheme.sbb() : SBBColorScheme.sbbDark(),
  );

  factory SBBBaseStyle.fromColorScheme({required Brightness brightness, required SBBColorScheme colorScheme}) {
    final defaultTextTheme = SBBTextTheme.$default(colorScheme: colorScheme);
    return SBBBaseStyle(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: defaultTextTheme,
      dividerTheme: DividerThemeData(thickness: 1.0, space: 0.0, color: colorScheme.dividerColor),
      iconTheme: IconThemeData(color: colorScheme.iconColor, size: sbbIconSizeSmall),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.selectionColor,
        selectionColor: colorScheme.selectionColor?.withValues(alpha: 0.5),
        selectionHandleColor: colorScheme.selectionColor,
      ),
    );
  }

  final Brightness brightness;
  final SBBColorScheme colorScheme;
  final SBBTextTheme textTheme;
  final IconThemeData? iconTheme;
  final DividerThemeData? dividerTheme;
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
