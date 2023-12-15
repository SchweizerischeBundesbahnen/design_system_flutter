import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const sbbDefaultSpacing = 16.0;

enum HostPlatform { web, native }

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    HostPlatform hostPlatform = kIsWeb ? HostPlatform.web : HostPlatform.native,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
  }) =>
      createTheme(
        brightness: Brightness.light,
        boldFont: boldFont,
        hostPlatform: hostPlatform,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
      );

  static ThemeData dark({
    HostPlatform hostPlatform = kIsWeb ? HostPlatform.web : HostPlatform.native,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
  }) =>
      createTheme(
        brightness: Brightness.dark,
        boldFont: boldFont,
        hostPlatform: hostPlatform,
        baseStyle: baseStyle,
        buttonStyles: buttonStyles,
        controlStyles: controlStyles,
      );

  static ThemeData createTheme({
    required Brightness brightness,
    HostPlatform hostPlatform = kIsWeb ? HostPlatform.web : HostPlatform.native,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBButtonStyles? buttonStyles,
    SBBControlStyles? controlStyles,
  }) {
    // SET hard-coded default values HERE
    final defaultBaseStyle = SBBBaseStyle.$default(
      brightness: brightness,
      hostPlatform: hostPlatform,
      boldFont: boldFont,
    );
    final _baseStyle = baseStyle.merge(defaultBaseStyle);

    final defaultButtonStyles = SBBButtonStyles.$default(baseStyle: _baseStyle);
    final _buttonStyles = buttonStyles.merge(defaultButtonStyles);

    final defaultControlStyles =
        SBBControlStyles.$default(baseStyle: _baseStyle);
    final _controlStyles = defaultControlStyles.merge(controlStyles);

    return raw(
      brightness: brightness,
      baseStyle: _baseStyle,
      buttonStyles: _buttonStyles,
      controlStyles: _controlStyles,
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
        elevatedButtonTheme: buttonStyles.elevatedButtonTheme,
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
      if (states.contains(MaterialState.disabled) && disabledValue != null)
        return disabledValue;

      // pressed / focused
      if (states.any({MaterialState.pressed, MaterialState.focused}.contains) &&
          pressedValue != null) {
        return pressedValue;
      }
      // hovered
      if (states.contains(MaterialState.hovered) && hoveredValue != null)
        return hoveredValue;

      // selected
      if (states.contains(MaterialState.selected) && selectedValue != null)
        return selectedValue;
      // default
      return defaultValue;
    });
  }
}
