import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/button/theme/sbb_button_style_x.dart';

import '../button/theme/default_button_styles.dart';
import '../button/theme/sbb_button_theme_data.dart';
import 'theme.dart';

const sbbDefaultSpacing = 16.0;

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBGroupStyle? groupStyle,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: Brightness.light,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    controlStyles: controlStyles,
    headerBoxStyle: headerBoxStyle,
    groupStyle: groupStyle,
    textTheme: textTheme,
    toastStyle: toastStyle,
  );

  static ThemeData dark({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBGroupStyle? groupStyle,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: Brightness.dark,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    controlStyles: controlStyles,
    headerBoxStyle: headerBoxStyle,
    groupStyle: groupStyle,
    textTheme: textTheme,
    toastStyle: toastStyle,
  );

  static ThemeData createTheme({
    required Brightness brightness,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBGroupStyle? groupStyle,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) {
    // default values are set here and merged with given styles
    final defaultBaseStyle = SBBBaseStyle.$default(brightness: brightness, boldFont: boldFont);
    final mergedBaseStyle = baseStyle.merge(defaultBaseStyle);

    final defaultPrimaryButtonTheme = DefaultSBBPrimaryButtonTheme(mergedBaseStyle);
    final mergedPrimaryButtonTheme = defaultPrimaryButtonTheme.merge(primaryButtonTheme);

    final defaultSecondaryButtonTheme = DefaultSBBSecondaryButtonTheme(mergedBaseStyle);
    final mergedSecondaryButtonStyle = defaultSecondaryButtonTheme.merge(secondaryButtonTheme);

    final defaultTertiaryButtonTheme = DefaultSBBTertiaryButtonTheme(mergedBaseStyle);
    final mergedTertiaryButtonStyle = defaultTertiaryButtonTheme.merge(tertiaryButtonTheme);

    final defaultControlStyles = SBBControlStyles.$default(baseStyle: mergedBaseStyle);
    final mergedControlStyles = controlStyles.merge(defaultControlStyles);

    final defaultHeaderBoxStyle = SBBHeaderBoxStyle.$default(baseStyle: mergedBaseStyle);
    final mergedHeaderBoxStyle = headerBoxStyle.merge(defaultHeaderBoxStyle);

    final defaultGroupStyle = SBBGroupStyle.$default(baseStyle: mergedBaseStyle);
    final mergedGroupStyle = groupStyle.merge(defaultGroupStyle);

    final defaultTextTheme = SBBTextTheme.$default(baseStyle: mergedBaseStyle);
    final mergedTextTheme = defaultTextTheme.merge(textTheme);

    final defaultToastStyle = SBBToastStyle.$default(baseStyle: mergedBaseStyle);
    final mergedToastStyle = defaultToastStyle.merge(defaultToastStyle);

    return raw(
      brightness: brightness,
      baseStyle: mergedBaseStyle,
      primaryButtonStyle: mergedPrimaryButtonTheme.style?.toButtonStyle(),
      secondaryButtonStyle: mergedSecondaryButtonStyle.style?.toButtonStyle(),
      tertiaryButtonStyle: mergedTertiaryButtonStyle.style?.toButtonStyle(),
      controlStyles: mergedControlStyles,
      headerBoxStyle: mergedHeaderBoxStyle,
      groupStyle: mergedGroupStyle,
      textTheme: mergedTextTheme,
      toastStyle: mergedToastStyle,
    );
  }

  static ThemeData raw({
    required Brightness brightness,
    required SBBBaseStyle baseStyle,
    required ButtonStyle? primaryButtonStyle,
    required ButtonStyle? secondaryButtonStyle,
    required ButtonStyle? tertiaryButtonStyle,
    required SBBControlStyles controlStyles,
    required SBBHeaderBoxStyle headerBoxStyle,
    required SBBGroupStyle groupStyle,
    required SBBTextTheme textTheme,
    required SBBToastStyle toastStyle,
  }) {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: baseStyle.primarySwatch!,
        accentColor: baseStyle.primaryColor,
        backgroundColor: baseStyle.backgroundColor,
        errorColor: baseStyle.errorColor,
        brightness: brightness,
      ).copyWith(surfaceTint: SBBColors.transparent),
      scaffoldBackgroundColor: baseStyle.backgroundColor,
      iconTheme: IconThemeData(color: baseStyle.iconColor, size: sbbIconSizeSmall),
      dividerTheme: DividerThemeData(thickness: 1.0, space: 0.0, color: baseStyle.dividerColor),
      fontFamily: baseStyle.defaultFontFamily,
      textTheme: baseStyle.createTextTheme(),
      appBarTheme: controlStyles.appBarTheme,
      filledButtonTheme: FilledButtonThemeData(style: primaryButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
      textButtonTheme: TextButtonThemeData(style: tertiaryButtonStyle),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      textSelectionTheme: controlStyles.textSelectionTheme,
      extensions: [
        baseStyle,
        controlStyles,
        headerBoxStyle,
        groupStyle,
        textTheme,
        toastStyle,
      ],
    );
  }

  /// Convenience method for easier use of [WidgetStateProperty.all].
  static WidgetStateProperty<T> allStates<T>(T value) {
    return WidgetStateProperty.all(value);
  }

  /// Convenience method for easier use of [WidgetStateProperty.resolveWith].
  static WidgetStateProperty<T?> resolveStatesWith<T>({
    required T defaultValue,
    T? pressedValue,
    T? disabledValue,
    T? hoveredValue,
    String? parent,
    T? selectedValue,
  }) {
    return WidgetStateProperty.resolveWith((states) {
      // disabled
      if (states.contains(WidgetState.disabled) && disabledValue != null) {
        return disabledValue;
      }

      // pressed / focused
      if (states.any({WidgetState.pressed, WidgetState.focused}.contains) && pressedValue != null) {
        return pressedValue;
      }
      // hovered
      if (states.contains(WidgetState.hovered) && hoveredValue != null) {
        return hoveredValue;
      }

      // selected
      if (states.contains(WidgetState.selected) && selectedValue != null) {
        return selectedValue;
      }
      // default
      return defaultValue;
    });
  }
}
