import 'package:flutter/material.dart';

import 'theme.dart';

const sbbDefaultSpacing = 16.0;

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
  }) =>
      createTheme(
        brightness: Brightness.light,
        boldFont: boldFont,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
        headerBoxStyle: headerBoxStyle,
      );

  static ThemeData dark({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
  }) =>
      createTheme(
        brightness: Brightness.dark,
        boldFont: boldFont,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
        headerBoxStyle: headerBoxStyle,
      );

  static ThemeData createTheme({
    required Brightness brightness,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
  }) {
    // SET hard-coded default values HERE
    final defaultBaseStyle = SBBBaseStyle.$default(
      brightness: brightness,
      boldFont: boldFont,
    );
    final mergedBaseStyle = baseStyle.merge(defaultBaseStyle);

    final defaultButtonStyles = SBBButtonStyles.$default(
      baseStyle: mergedBaseStyle,
    );
    final mergedButtonStyles = buttonStyles.merge(defaultButtonStyles);

    final defaultControlStyles = SBBControlStyles.$default(
      baseStyle: mergedBaseStyle,
    );
    final mergedControlStyles = controlStyles.merge(defaultControlStyles);

    final defaultHeaderBoxStyle = SBBHeaderBoxStyle.$default(
      baseStyle: mergedBaseStyle,
    );
    final mergedHeaderBoxStyle = headerBoxStyle.merge(defaultHeaderBoxStyle);

    return raw(
      brightness: brightness,
      baseStyle: mergedBaseStyle,
      buttonStyles: mergedButtonStyles,
      controlStyles: mergedControlStyles,
      headerBoxStyle: mergedHeaderBoxStyle,
    );
  }

  static ThemeData raw({
    required Brightness brightness,
    required SBBBaseStyle baseStyle,
    required SBBButtonStyles buttonStyles,
    required SBBControlStyles controlStyles,
    required SBBHeaderBoxStyle headerBoxStyle,
  }) =>
      ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: baseStyle.primarySwatch!,
          accentColor: baseStyle.primaryColor,
          cardColor: controlStyles.groupBackgroundColor,
          backgroundColor: baseStyle.backgroundColor,
          errorColor: controlStyles.textField?.dividerColorError,
          brightness: brightness,
        ).copyWith(
          surfaceTint: SBBColors.transparent,
        ),
        scaffoldBackgroundColor: baseStyle.backgroundColor,
        iconTheme: IconThemeData(
          color: baseStyle.iconColor,
          size: sbbIconSizeSmall,
        ),
        dividerTheme: DividerThemeData(
          thickness: 1.0,
          space: 0.0,
          color: baseStyle.dividerColor,
        ),
        fontFamily: baseStyle.defaultFontFamily,
        textTheme: baseStyle.createTextTheme(),
        appBarTheme: controlStyles.appBarTheme,
        filledButtonTheme: buttonStyles.filledButtonTheme,
        outlinedButtonTheme: buttonStyles.outlinedButtonTheme,
        textButtonTheme: buttonStyles.textButtonTheme,
        cardTheme: controlStyles.cardTheme,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        textSelectionTheme: controlStyles.textSelectionTheme,
        tooltipTheme: controlStyles.tooltipTheme,
        extensions: [
          baseStyle,
          buttonStyles,
          controlStyles,
          headerBoxStyle,
        ],
      );

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
