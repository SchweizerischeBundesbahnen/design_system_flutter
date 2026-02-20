import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/button/theme/sbb_button_style_x.dart';
import 'package:sbb_design_system_mobile/src/checkbox/theme/default_sbb_checkbox_theme_data.dart';
import 'package:sbb_design_system_mobile/src/chip/theme/default_sbb_chip_theme_data.dart';
import 'package:sbb_design_system_mobile/src/container/container.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_input_decoration_theme_data.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_text_input_theme_data.dart';
import 'package:sbb_design_system_mobile/src/paginator/theme/default_sbb_paginator_theme_data.dart';
import 'package:sbb_design_system_mobile/src/radio/theme/default_sbb_radio_theme_data.dart';
import 'package:sbb_design_system_mobile/src/slider/theme/default_sbb_slider_theme_data.dart';
import 'package:sbb_design_system_mobile/src/stepper/theme/default_sbb_stepper_theme_data.dart';
import 'package:sbb_design_system_mobile/src/switch/theme/default_sbb_switch_theme_data.dart';

import '../button/theme/default_button_themes.dart';
import '../container/theme/default_sbb_content_box_theme_data.dart';
import '../list_item/theme/default_sbb_list_item_theme_data.dart';
import '../segmented_button/theme/default_sbb_segmented_button_theme_data.dart';
import '../status/theme/default_sbb_status_theme_data.dart';

class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBStepperThemeData? stepperTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListItemThemeData? listItemTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: .light,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    accentButtonTheme: accentButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    radioTheme: radioTheme,
    stepperTheme: stepperTheme,
    controlStyles: controlStyles,
    headerBoxStyle: headerBoxStyle,
    inputDecorationTheme: inputDecorationTheme,
    listItemTheme: listItemTheme,
    paginatorTheme: paginatorTheme,
    statusTheme: statusTheme,
    segmentedButtonTheme: segmentedButtonTheme,
    sliderTheme: sliderTheme,
    switchTheme: switchTheme,
    textTheme: textTheme,
    textInputTheme: textInputTheme,
    toastStyle: toastStyle,
  );

  static ThemeData dark({
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBRadioThemeData? radioTheme,
    SBBStepperThemeData? stepperTheme,
    SBBControlStyles? controlStyles,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListItemThemeData? listItemTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBStatusThemeData? statusTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastStyle? toastStyle,
  }) => createTheme(
    brightness: .dark,
    boldFont: boldFont,
    baseStyle: baseStyle,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    accentButtonTheme: accentButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    radioTheme: radioTheme,
    stepperTheme: stepperTheme,
    controlStyles: controlStyles,
    headerBoxStyle: headerBoxStyle,
    inputDecorationTheme: inputDecorationTheme,
    listItemTheme: listItemTheme,
    paginatorTheme: paginatorTheme,
    statusTheme: statusTheme,
    segmentedButtonTheme: segmentedButtonTheme,
    sliderTheme: sliderTheme,
    switchTheme: switchTheme,
    textTheme: textTheme,
    textInputTheme: textInputTheme,
    toastStyle: toastStyle,
  );

  static ThemeData createTheme({
    required Brightness brightness,
    bool boldFont = false,
    SBBBaseStyle? baseStyle,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBStepperThemeData? stepperTheme,
    SBBControlStyles? controlStyles,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListItemThemeData? listItemTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTextTheme? textTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastStyle? toastStyle,
  }) {
    // default values are set here and merged with given styles
    final defaultBaseStyle = SBBBaseStyle.$default(brightness: brightness, boldFont: boldFont);
    final mergedBaseStyle = baseStyle.merge(defaultBaseStyle);

    final defaultPrimaryButtonTheme = DefaultSBBPrimaryButtonThemeData(mergedBaseStyle);
    final mergedPrimaryButtonTheme = defaultPrimaryButtonTheme.merge(primaryButtonTheme);

    final defaultSecondaryButtonTheme = DefaultSBBSecondaryButtonThemeData(mergedBaseStyle);
    final mergedSecondaryButtonTheme = defaultSecondaryButtonTheme.merge(secondaryButtonTheme);

    final defaultTertiaryButtonTheme = DefaultSBBTertiaryButtonThemeData(mergedBaseStyle);
    final mergedTertiaryButtonTheme = defaultTertiaryButtonTheme.merge(tertiaryButtonTheme);

    final defaultAccentButtonTheme = DefaultSBBAccentButtonThemeData(mergedBaseStyle);
    final mergedAccentButtonTheme = defaultAccentButtonTheme.merge(accentButtonTheme);

    final defaultCheckboxTheme = DefaultSBBCheckboxThemeData(mergedBaseStyle);
    final mergedCheckboxTheme = defaultCheckboxTheme.merge(checkboxTheme);

    final defaultChipTheme = DefaultSBBChipThemeData(mergedBaseStyle);
    final mergedChipTheme = defaultChipTheme.merge(chipTheme);

    final defaultStepperTheme = DefaultSBBStepperThemeData(mergedBaseStyle);
    final mergedStepperTheme = defaultStepperTheme.merge(stepperTheme);

    final defaultControlStyles = SBBControlStyles.$default(baseStyle: mergedBaseStyle);
    final mergedControlStyles = controlStyles.merge(defaultControlStyles);

    final defaultContentBoxTheme = DefaultSBBContentBoxThemeData(baseStyle: mergedBaseStyle);
    final mergedContentBoxTheme = defaultContentBoxTheme.merge(contentBoxTheme);

    final defaultHeaderBoxStyle = SBBHeaderBoxStyle.$default(baseStyle: mergedBaseStyle);
    final mergedHeaderBoxStyle = headerBoxStyle.merge(defaultHeaderBoxStyle);

    final defaultListItemTheme = DefaultSBBListItemThemeData(baseStyle: mergedBaseStyle);
    final mergedListItemTheme = defaultListItemTheme.merge(listItemTheme);

    final defaultPaginatorTheme = DefaultSBBPaginatorThemeData(mergedBaseStyle);
    final mergedPaginatorTheme = defaultPaginatorTheme.merge(paginatorTheme);

    final defaultRadioTheme = DefaultSBBRadioThemeData(mergedBaseStyle);
    final mergedRadioTheme = defaultRadioTheme.merge(radioTheme);

    final defaultStatusTheme = DefaultSBBStatusThemeData(baseStyle: mergedBaseStyle);
    final mergedStatusTheme = defaultStatusTheme.merge(statusTheme);

    final defaultSegmentedButtonTheme = DefaultSBBSegmentedButtonThemeData(mergedBaseStyle);
    final mergedSegmentedButtonTheme = defaultSegmentedButtonTheme.merge(segmentedButtonTheme);

    final defaultSliderTheme = DefaultSBBSliderThemeData(mergedBaseStyle);
    final mergedSliderTheme = defaultSliderTheme.merge(sliderTheme);

    final defaultSwitchTheme = DefaultSBBSwitchThemeData(mergedBaseStyle);
    final mergedSwitchTheme = defaultSwitchTheme.merge(switchTheme);

    final defaultTextTheme = SBBTextTheme.$default(baseStyle: mergedBaseStyle);
    final mergedTextTheme = defaultTextTheme.merge(textTheme);

    final defaultTextInputTheme = DefaultSBBTextInputThemeData(mergedBaseStyle);
    final mergedTextInputTheme = defaultTextInputTheme.merge(textInputTheme);

    final defaultToastStyle = SBBToastStyle.$default(baseStyle: mergedBaseStyle);
    final mergedToastStyle = defaultToastStyle.merge(defaultToastStyle);

    final defaultInputDecorationTheme = DefaultSBBInputDecorationThemeData(mergedBaseStyle);
    final mergedInputDecorationTheme = defaultInputDecorationTheme.merge(inputDecorationTheme);

    return raw(
      brightness: brightness,
      baseStyle: mergedBaseStyle,
      primaryButtonTheme: mergedPrimaryButtonTheme,
      secondaryButtonTheme: mergedSecondaryButtonTheme,
      tertiaryButtonTheme: mergedTertiaryButtonTheme,
      accentButtonTheme: mergedAccentButtonTheme,
      checkboxTheme: mergedCheckboxTheme,
      chipTheme: mergedChipTheme,
      stepperTheme: mergedStepperTheme,
      controlStyles: mergedControlStyles,
      contentBoxTheme: mergedContentBoxTheme,
      headerBoxStyle: mergedHeaderBoxStyle,
      listItemTheme: mergedListItemTheme,
      paginatorTheme: mergedPaginatorTheme,
      radioTheme: mergedRadioTheme,
      statusTheme: mergedStatusTheme,
      segmentedButtonTheme: mergedSegmentedButtonTheme,
      sliderTheme: mergedSliderTheme,
      switchTheme: mergedSwitchTheme,
      textTheme: mergedTextTheme,
      textInputTheme: mergedTextInputTheme,
      toastStyle: mergedToastStyle,
      inputDecorationTheme: mergedInputDecorationTheme,
    );
  }

  static ThemeData raw({
    required Brightness brightness,
    required SBBBaseStyle baseStyle,
    required SBBPrimaryButtonThemeData primaryButtonTheme,
    required SBBSecondaryButtonThemeData secondaryButtonTheme,
    required SBBTertiaryButtonThemeData tertiaryButtonTheme,
    required SBBAccentButtonThemeData accentButtonTheme,
    required SBBCheckboxThemeData checkboxTheme,
    required SBBChipThemeData chipTheme,
    required SBBContentBoxThemeData contentBoxTheme,
    required SBBStepperThemeData stepperTheme,
    required SBBControlStyles controlStyles,
    required SBBHeaderBoxStyle headerBoxStyle,
    required SBBInputDecorationThemeData inputDecorationTheme,
    required SBBListItemThemeData listItemTheme,
    required SBBPaginatorThemeData paginatorTheme,
    required SBBRadioThemeData radioTheme,
    required SBBStatusThemeData statusTheme,
    required SBBSegmentedButtonThemeData segmentedButtonTheme,
    required SBBSliderThemeData sliderTheme,
    required SBBSwitchThemeData switchTheme,
    required SBBTextTheme textTheme,
    required SBBTextInputThemeData textInputTheme,
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
        accentButtonTheme,
        checkboxTheme,
        contentBoxTheme,
        chipTheme,
        controlStyles,
        headerBoxStyle,
        inputDecorationTheme,
        listItemTheme,
        paginatorTheme,
        radioTheme,
        statusTheme,
        segmentedButtonTheme,
        sliderTheme,
        stepperTheme,
        switchTheme,
        textTheme,
        textInputTheme,
        toastStyle,
      ],
    );
  }
}
