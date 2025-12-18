import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/button/theme/sbb_button_style_x.dart';
import 'package:sbb_design_system_mobile/src/checkbox/theme/default_sbb_checkbox_theme_data.dart';
import 'package:sbb_design_system_mobile/src/chip/theme/default_sbb_chip_theme_data.dart';
import 'package:sbb_design_system_mobile/src/container/container.dart';
import 'package:sbb_design_system_mobile/src/radio/theme/default_sbb_radio_theme_data.dart';
import 'package:sbb_design_system_mobile/src/switch/theme/default_sbb_switch_theme_data.dart';

import '../button/theme/default_button_themes.dart';
import '../container/theme/default_sbb_content_box_theme_data.dart';
import '../status/theme/default_sbb_status_theme.dart';

const sbbDefaultSpacing = 16.0;

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBControlStyles? controlStyles,
    @Deprecated('Use contentBoxTheme instead') SBBContentBoxStyle? groupStyle,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: Brightness.light,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    radioTheme: radioTheme,
    controlStyles: controlStyles,
    groupStyle: groupStyle,
    headerBoxStyle: headerBoxStyle,
    statusTheme: statusTheme,
    switchTheme: switchTheme,
    textTheme: textTheme,
    toastStyle: toastStyle,
  );

  static ThemeData dark({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    @Deprecated('Use contentBoxTheme instead') SBBContentBoxStyle? groupStyle,
    SBBRadioThemeData? radioTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBStatusThemeData? statusTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: Brightness.dark,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    radioTheme: radioTheme,
    controlStyles: controlStyles,
    headerBoxStyle: headerBoxStyle,
    groupStyle: groupStyle,
    statusTheme: statusTheme,
    switchTheme: switchTheme,
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
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBControlStyles? controlStyles,
    SBBContentBoxThemeData? contentBoxTheme,
    @Deprecated('Use contentBoxTheme instead') SBBGroupStyle? groupStyle,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBToastStyle? toastStyle,
  }) {
    // default values are set here and merged with given styles
    final defaultBaseStyle = SBBBaseStyle.$default(brightness: brightness, boldFont: boldFont);
    final mergedBaseStyle = baseStyle.merge(defaultBaseStyle);

    final defaultPrimaryButtonTheme = DefaultSBBPrimaryButtonTheme(mergedBaseStyle);
    final mergedPrimaryButtonTheme = defaultPrimaryButtonTheme.merge(primaryButtonTheme);

    final defaultSecondaryButtonTheme = DefaultSBBSecondaryButtonTheme(mergedBaseStyle);
    final mergedSecondaryButtonTheme = defaultSecondaryButtonTheme.merge(secondaryButtonTheme);

    final defaultTertiaryButtonTheme = DefaultSBBTertiaryButtonTheme(mergedBaseStyle);
    final mergedTertiaryButtonTheme = defaultTertiaryButtonTheme.merge(tertiaryButtonTheme);

    final defaultCheckboxTheme = DefaultSBBCheckboxThemeData(mergedBaseStyle);
    final mergedCheckboxTheme = defaultCheckboxTheme.merge(checkboxTheme);

    final defaultChipTheme = DefaultSBBChipThemeData(mergedBaseStyle);
    final mergedChipTheme = defaultChipTheme.merge(chipTheme);

    final defaultRadioTheme = DefaultSBBRadioThemeData(mergedBaseStyle);
    final mergedRadioTheme = defaultRadioTheme.merge(radioTheme);

    final defaultControlStyles = SBBControlStyles.$default(baseStyle: mergedBaseStyle);
    final mergedControlStyles = controlStyles.merge(defaultControlStyles);

    final defaultHeaderBoxStyle = SBBHeaderBoxStyle.$default(baseStyle: mergedBaseStyle);
    final mergedHeaderBoxStyle = headerBoxStyle.merge(defaultHeaderBoxStyle);

    final defaultGroupStyle = SBBContentBoxStyle.$default(baseStyle: mergedBaseStyle);
    final mergedGroupStyle = groupStyle.merge(defaultGroupStyle);

    final defaultStatusTheme = DefaultSBBStatusTheme(baseStyle: mergedBaseStyle);
    final mergedStatusTheme = defaultStatusTheme.merge(statusTheme);

    final defaultSwitchTheme = DefaultSBBSwitchThemeData(mergedBaseStyle);
    final mergedSwitchTheme = defaultSwitchTheme.merge(switchTheme);

    final defaultContentBoxTheme = DefaultSBBContentBoxTheme(baseStyle: mergedBaseStyle);
    final mergedContentBoxTheme = defaultContentBoxTheme.merge(contentBoxTheme);

    final defaultTextTheme = SBBTextTheme.$default(baseStyle: mergedBaseStyle);
    final mergedTextTheme = defaultTextTheme.merge(textTheme);

    final defaultToastStyle = SBBToastStyle.$default(baseStyle: mergedBaseStyle);
    final mergedToastStyle = defaultToastStyle.merge(defaultToastStyle);

    return raw(
      brightness: brightness,
      baseStyle: mergedBaseStyle,
      primaryButtonTheme: mergedPrimaryButtonTheme,
      secondaryButtonTheme: mergedSecondaryButtonTheme,
      tertiaryButtonTheme: mergedTertiaryButtonTheme,
      checkboxTheme: mergedCheckboxTheme,
      chipTheme: mergedChipTheme,
      controlStyles: mergedControlStyles,
      contentBoxTheme: mergedContentBoxTheme,
      groupStyle: mergedGroupStyle,
      headerBoxStyle: mergedHeaderBoxStyle,
      radioTheme: mergedRadioTheme,
      statusTheme: mergedStatusTheme,
      switchTheme: mergedSwitchTheme,
      textTheme: mergedTextTheme,
      toastStyle: mergedToastStyle,
    );
  }

  static ThemeData raw({
    required Brightness brightness,
    required SBBBaseStyle baseStyle,
    required SBBPrimaryButtonThemeData primaryButtonTheme,
    required SBBSecondaryButtonThemeData secondaryButtonTheme,
    required SBBTertiaryButtonThemeData tertiaryButtonTheme,
    required SBBCheckboxThemeData checkboxTheme,
    required SBBChipThemeData chipTheme,
    required SBBContentBoxThemeData contentBoxTheme,
    required SBBControlStyles controlStyles,
    @Deprecated('Use contentBoxTheme instead.') required SBBContentBoxStyle groupStyle,
    required SBBHeaderBoxStyle headerBoxStyle,
    required SBBRadioThemeData radioTheme,
    required SBBStatusThemeData statusTheme,
    required SBBSwitchThemeData switchTheme,
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
      filledButtonTheme: FilledButtonThemeData(style: primaryButtonTheme.style?.toButtonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonTheme.style?.toButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: tertiaryButtonTheme.style?.toButtonStyle()),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      textSelectionTheme: controlStyles.textSelectionTheme,
      extensions: [
        baseStyle,
        primaryButtonTheme,
        secondaryButtonTheme,
        tertiaryButtonTheme,
        checkboxTheme,
        contentBoxTheme,
        chipTheme,
        radioTheme,
        controlStyles,
        headerBoxStyle,
        groupStyle,
        statusTheme,
        switchTheme,
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
