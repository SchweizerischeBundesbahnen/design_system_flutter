import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const sbbDefaultSpacing = 16.0;

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
  }) =>
      createTheme(
        brightness: Brightness.light,
        boldFont: boldFont,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
      );

  static ThemeData dark({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
  }) =>
      createTheme(
        brightness: Brightness.dark,
        boldFont: boldFont,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
      );

  static ThemeData createTheme({
    required Brightness brightness,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
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

    return raw(
      brightness: brightness,
      baseStyle: mergedBaseStyle,
      buttonStyles: mergedButtonStyles,
      controlStyles: mergedControlStyles,
    );
  }

  static ThemeData raw({
    required Brightness brightness,
    required SBBBaseStyle baseStyle,
    required SBBButtonStyles buttonStyles,
    required SBBControlStyles controlStyles,
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
        ],
      );

  /// Convenience method for easier use of [MaterialStateProperty.all].
  static MaterialStateProperty<T> allStates<T>(T value) {
    return MaterialStateProperty.all(value);
  }

  /// Convenience method for easier use of [MaterialStateProperty.resolveWith].
  static MaterialStateProperty<T?> resolveStatesWith<T>({
    required T defaultValue,
    T? pressedValue,
    T? disabledValue,
    T? hoveredValue,
    String? parent,
    T? selectedValue,
  }) {
    return MaterialStateProperty.resolveWith((states) {
      // disabled
      if (states.contains(MaterialState.disabled) && disabledValue != null) {
        return disabledValue;
      }

      // pressed / focused
      if (states.any({MaterialState.pressed, MaterialState.focused}.contains) &&
          pressedValue != null) {
        return pressedValue;
      }
      // hovered
      if (states.contains(MaterialState.hovered) && hoveredValue != null) {
        return hoveredValue;
      }

      // selected
      if (states.contains(MaterialState.selected) && selectedValue != null) {
        return selectedValue;
      }
      // default
      return defaultValue;
    });
  }
}
