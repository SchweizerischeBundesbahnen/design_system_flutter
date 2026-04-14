import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/bottom_sheet/theme/default_sbb_bottom_sheet_theme_data.dart';
import 'package:sbb_design_system_mobile/src/button/theme/sbb_button_style_x.dart';
import 'package:sbb_design_system_mobile/src/checkbox/theme/default_sbb_checkbox_theme_data.dart';
import 'package:sbb_design_system_mobile/src/chip/theme/default_sbb_chip_theme_data.dart';
import 'package:sbb_design_system_mobile/src/decorated_text/theme/default_sbb_decorated_text_theme_data.dart';
import 'package:sbb_design_system_mobile/src/header/theme/default_sbb_header_theme_data.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_input_decoration_theme_data.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_text_input_theme_data.dart';
import 'package:sbb_design_system_mobile/src/list_header/theme/default_sbb_list_header_theme_data.dart';
import 'package:sbb_design_system_mobile/src/message/theme/default_sbb_message_theme_data.dart';
import 'package:sbb_design_system_mobile/src/paginator/theme/default_sbb_paginator_theme_data.dart';
import 'package:sbb_design_system_mobile/src/popup/theme/default_sbb_popup_theme_data.dart';
import 'package:sbb_design_system_mobile/src/radio/theme/default_sbb_radio_theme_data.dart';
import 'package:sbb_design_system_mobile/src/slider/theme/default_sbb_slider_theme_data.dart';
import 'package:sbb_design_system_mobile/src/stepper/theme/default_sbb_stepper_theme_data.dart';
import 'package:sbb_design_system_mobile/src/switch/theme/default_sbb_switch_theme_data.dart';
import 'package:sbb_design_system_mobile/src/toast/theme/default_sbb_toast_theme_data.dart';

import '../button/theme/default_button_themes.dart';
import '../container/theme/default_sbb_content_box_theme_data.dart';
import '../list_item/theme/default_sbb_list_item_theme_data.dart';
import '../segmented_button/theme/default_sbb_segmented_button_theme_data.dart';
import '../status/theme/default_sbb_status_theme_data.dart';
import '../tab_bar/theme/default_sbb_tab_bar_theme_data.dart';

/// Base SBB theme builder.
///
/// Provides factory helpers to build full [ThemeData] for light and dark
/// based on the theming of the SBB design system.
///
/// ```dart
/// MaterialApp(
///     theme: SBBTheme.light(),
///     darkTheme: SBBTheme.dark(),
///     ...
/// );
/// ```
///
/// Access created [ThemeData] by using `Theme.of(context)` and the theme
/// extensions f.ex. with `Theme.of(context).extension<SBBBaseStyle>()` or
/// the provided helper methods `Theme.of(context).sbbBaseStyle`.
///
/// See also:
///
/// * [ThemeData], theme for a [MaterialApp]
class SBBTheme {
  SBBTheme._();

  static ThemeData light({
    SBBBaseStyle? baseStyle,
    SBBBottomSheetThemeData? bottomSheetTheme,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBControlStyles? controlStyles,
    SBBDecoratedTextThemeData? decoratedTextTheme,
    SBBDropdownThemeData? dropdownTheme,
    SBBHeaderThemeData? headerTheme,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListHeaderThemeData? listHeaderTheme,
    SBBListItemThemeData? listItemTheme,
    SBBMessageThemeData? messageTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBPopupThemeData? popupTheme,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBStepperThemeData? stepperTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTabBarThemeData? tabBarTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastThemeData? toastTheme,
  }) => createTheme(
    brightness: .light,
    baseStyle: baseStyle,
    bottomSheetTheme: bottomSheetTheme,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    accentButtonTheme: accentButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    controlStyles: controlStyles,
    decoratedTextTheme: decoratedTextTheme,
    dropdownTheme: dropdownTheme,
    headerTheme: headerTheme,
    headerBoxStyle: headerBoxStyle,
    inputDecorationTheme: inputDecorationTheme,
    listHeaderTheme: listHeaderTheme,
    listItemTheme: listItemTheme,
    messageTheme: messageTheme,
    paginatorTheme: paginatorTheme,
    radioTheme: radioTheme,
    popupTheme: popupTheme,
    statusTheme: statusTheme,
    segmentedButtonTheme: segmentedButtonTheme,
    sliderTheme: sliderTheme,
    stepperTheme: stepperTheme,
    switchTheme: switchTheme,
    tabBarTheme: tabBarTheme,
    textInputTheme: textInputTheme,
    toastTheme: toastTheme,
  );

  static ThemeData dark({
    SBBBaseStyle? baseStyle,
    SBBBottomSheetThemeData? bottomSheetTheme,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBControlStyles? controlStyles,
    SBBDecoratedTextThemeData? decoratedTextTheme,
    SBBDropdownThemeData? dropdownTheme,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListHeaderThemeData? listHeaderTheme,
    SBBListItemThemeData? listItemTheme,
    SBBMessageThemeData? messageTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBPopupThemeData? popupTheme,
    SBBRadioThemeData? radioTheme,
    SBBStatusThemeData? statusTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBStepperThemeData? stepperTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTabBarThemeData? tabBarTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastThemeData? toastTheme,
  }) => createTheme(
    brightness: .dark,
    baseStyle: baseStyle,
    bottomSheetTheme: bottomSheetTheme,
    primaryButtonTheme: primaryButtonTheme,
    secondaryButtonTheme: secondaryButtonTheme,
    tertiaryButtonTheme: tertiaryButtonTheme,
    accentButtonTheme: accentButtonTheme,
    checkboxTheme: checkboxTheme,
    chipTheme: chipTheme,
    contentBoxTheme: contentBoxTheme,
    controlStyles: controlStyles,
    decoratedTextTheme: decoratedTextTheme,
    dropdownTheme: dropdownTheme,
    headerBoxStyle: headerBoxStyle,
    inputDecorationTheme: inputDecorationTheme,
    listHeaderTheme: listHeaderTheme,
    listItemTheme: listItemTheme,
    messageTheme: messageTheme,
    paginatorTheme: paginatorTheme,
    popupTheme: popupTheme,
    radioTheme: radioTheme,
    statusTheme: statusTheme,
    stepperTheme: stepperTheme,
    segmentedButtonTheme: segmentedButtonTheme,
    sliderTheme: sliderTheme,
    switchTheme: switchTheme,
    tabBarTheme: tabBarTheme,
    textInputTheme: textInputTheme,
    toastTheme: toastTheme,
  );

  static ThemeData createTheme({
    required Brightness brightness,
    SBBBaseStyle? baseStyle,
    SBBBottomSheetThemeData? bottomSheetTheme,
    SBBPrimaryButtonThemeData? primaryButtonTheme,
    SBBSecondaryButtonThemeData? secondaryButtonTheme,
    SBBTertiaryButtonThemeData? tertiaryButtonTheme,
    SBBAccentButtonThemeData? accentButtonTheme,
    SBBCheckboxThemeData? checkboxTheme,
    SBBChipThemeData? chipTheme,
    SBBStepperThemeData? stepperTheme,
    SBBControlStyles? controlStyles,
    SBBContentBoxThemeData? contentBoxTheme,
    SBBDecoratedTextThemeData? decoratedTextTheme,
    SBBDropdownThemeData? dropdownTheme,
    SBBHeaderThemeData? headerTheme,
    SBBHeaderBoxStyle? headerBoxStyle,
    SBBInputDecorationThemeData? inputDecorationTheme,
    SBBListHeaderThemeData? listHeaderTheme,
    SBBListItemThemeData? listItemTheme,
    SBBMessageThemeData? messageTheme,
    SBBPaginatorThemeData? paginatorTheme,
    SBBPopupThemeData? popupTheme,
    SBBRadioThemeData? radioTheme,
    SBBSegmentedButtonThemeData? segmentedButtonTheme,
    SBBSliderThemeData? sliderTheme,
    SBBStatusThemeData? statusTheme,
    SBBSwitchThemeData? switchTheme,
    SBBTabBarThemeData? tabBarTheme,
    SBBTextInputThemeData? textInputTheme,
    SBBToastThemeData? toastTheme,
  }) {
    // default values are set here and merged with given styles
    final defaultBaseStyle = SBBBaseStyle.$default(brightness: brightness);
    final mergedBaseStyle = defaultBaseStyle.merge(baseStyle);

    final defaultBottomSheetTheme = DefaultSBBBottomSheetThemeData(mergedBaseStyle);
    final mergedBottomSheetTheme = defaultBottomSheetTheme.merge(bottomSheetTheme);

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

    final defaultControlStyles = SBBControlStyles.$default(baseStyle: mergedBaseStyle);
    final mergedControlStyles = controlStyles.merge(defaultControlStyles);

    final defaultDecoratedTextTheme = DefaultSBBDecoratedTextThemeData(mergedBaseStyle);
    final mergedDecoratedTextTheme = defaultDecoratedTextTheme.merge(decoratedTextTheme);

    final defaultContentBoxTheme = DefaultSBBContentBoxThemeData(baseStyle: mergedBaseStyle);
    final mergedContentBoxTheme = defaultContentBoxTheme.merge(contentBoxTheme);

    final defaultHeaderTheme = DefaultSBBHeaderThemeData(baseStyle: mergedBaseStyle);
    final mergedHeaderTheme = defaultHeaderTheme.merge(headerTheme);

    final defaultHeaderBoxStyle = SBBHeaderBoxStyle.$default(baseStyle: mergedBaseStyle);
    final mergedHeaderBoxStyle = headerBoxStyle.merge(defaultHeaderBoxStyle);

    final defaultListHeaderTheme = DefaultSBBListHeaderThemeData(mergedBaseStyle);
    final mergedListHeaderTheme = defaultListHeaderTheme.merge(listHeaderTheme);

    final defaultListItemTheme = DefaultSBBListItemThemeData(baseStyle: mergedBaseStyle);
    final mergedListItemTheme = defaultListItemTheme.merge(listItemTheme);

    final defaultMessageTheme = DefaultSBBMessageThemeData(mergedBaseStyle);
    final mergedMessageTheme = defaultMessageTheme.merge(messageTheme);

    final defaultPaginatorTheme = DefaultSBBPaginatorThemeData(mergedBaseStyle);
    final mergedPaginatorTheme = defaultPaginatorTheme.merge(paginatorTheme);

    final defaultPopupTheme = DefaultSBBPopupThemeData(mergedBaseStyle);
    final mergedPopupTheme = defaultPopupTheme.merge(popupTheme);

    final defaultRadioTheme = DefaultSBBRadioThemeData(mergedBaseStyle);
    final mergedRadioTheme = defaultRadioTheme.merge(radioTheme);

    final defaultStatusTheme = DefaultSBBStatusThemeData(baseStyle: mergedBaseStyle);
    final mergedStatusTheme = defaultStatusTheme.merge(statusTheme);

    final defaultStepperTheme = DefaultSBBStepperThemeData(mergedBaseStyle);
    final mergedStepperTheme = defaultStepperTheme.merge(stepperTheme);

    final defaultSegmentedButtonTheme = DefaultSBBSegmentedButtonThemeData(mergedBaseStyle);
    final mergedSegmentedButtonTheme = defaultSegmentedButtonTheme.merge(segmentedButtonTheme);

    final defaultSliderTheme = DefaultSBBSliderThemeData(mergedBaseStyle);
    final mergedSliderTheme = defaultSliderTheme.merge(sliderTheme);

    final defaultSwitchTheme = DefaultSBBSwitchThemeData(mergedBaseStyle);
    final mergedSwitchTheme = defaultSwitchTheme.merge(switchTheme);

    final defaultTextInputTheme = DefaultSBBTextInputThemeData(mergedBaseStyle);
    final mergedTextInputTheme = defaultTextInputTheme.merge(textInputTheme);

    final defaultToastTheme = DefaultSBBToastThemeData(mergedBaseStyle);
    final mergedToastTheme = defaultToastTheme.merge(toastTheme);

    final defaultInputDecorationTheme = DefaultSBBInputDecorationThemeData(mergedBaseStyle);
    final mergedInputDecorationTheme = defaultInputDecorationTheme.merge(inputDecorationTheme);

    final defaultTabBarTheme = DefaultSBBTabBarThemeData(mergedBaseStyle);
    final mergedTabBarTheme = defaultTabBarTheme.merge(tabBarTheme);

    final defaultDropdownTheme = SBBDropdownThemeData(
      triggerDecorationTheme: defaultInputDecorationTheme,
      triggerStyle: defaultDecoratedTextTheme.style,
      sheetStyle: defaultBottomSheetTheme.style,
    );
    final mergedDropdownTheme = defaultDropdownTheme.merge(dropdownTheme);

    return raw(
      baseStyle: mergedBaseStyle,
      bottomSheetTheme: mergedBottomSheetTheme,
      primaryButtonTheme: mergedPrimaryButtonTheme,
      secondaryButtonTheme: mergedSecondaryButtonTheme,
      tertiaryButtonTheme: mergedTertiaryButtonTheme,
      accentButtonTheme: mergedAccentButtonTheme,
      checkboxTheme: mergedCheckboxTheme,
      chipTheme: mergedChipTheme,
      controlStyles: mergedControlStyles,
      contentBoxTheme: mergedContentBoxTheme,
      decoratedTextTheme: mergedDecoratedTextTheme,
      dropdownTheme: mergedDropdownTheme,
      headerTheme: mergedHeaderTheme,
      headerBoxStyle: mergedHeaderBoxStyle,
      inputDecorationTheme: mergedInputDecorationTheme,
      listHeaderTheme: mergedListHeaderTheme,
      listItemTheme: mergedListItemTheme,
      messageTheme: mergedMessageTheme,
      paginatorTheme: mergedPaginatorTheme,
      popupTheme: mergedPopupTheme,
      radioTheme: mergedRadioTheme,
      statusTheme: mergedStatusTheme,
      segmentedButtonTheme: mergedSegmentedButtonTheme,
      sliderTheme: mergedSliderTheme,
      stepperTheme: mergedStepperTheme,
      switchTheme: mergedSwitchTheme,
      tabBarTheme: mergedTabBarTheme,
      textInputTheme: mergedTextInputTheme,
      toastTheme: mergedToastTheme,
    );
  }

  static ThemeData raw({
    required SBBBaseStyle baseStyle,
    required SBBBottomSheetThemeData bottomSheetTheme,
    required SBBPrimaryButtonThemeData primaryButtonTheme,
    required SBBSecondaryButtonThemeData secondaryButtonTheme,
    required SBBTertiaryButtonThemeData tertiaryButtonTheme,
    required SBBAccentButtonThemeData accentButtonTheme,
    required SBBCheckboxThemeData checkboxTheme,
    required SBBChipThemeData chipTheme,
    required SBBContentBoxThemeData contentBoxTheme,
    required SBBControlStyles controlStyles,
    required SBBDecoratedTextThemeData decoratedTextTheme,
    required SBBDropdownThemeData dropdownTheme,
    required SBBHeaderThemeData headerTheme,
    required SBBHeaderBoxStyle headerBoxStyle,
    required SBBInputDecorationThemeData inputDecorationTheme,
    required SBBListHeaderThemeData listHeaderTheme,
    required SBBListItemThemeData listItemTheme,
    required SBBMessageThemeData messageTheme,
    required SBBPaginatorThemeData paginatorTheme,
    required SBBPopupThemeData popupTheme,
    required SBBRadioThemeData radioTheme,
    required SBBStatusThemeData statusTheme,
    required SBBSegmentedButtonThemeData segmentedButtonTheme,
    required SBBSliderThemeData sliderTheme,
    required SBBStepperThemeData stepperTheme,
    required SBBSwitchThemeData switchTheme,
    required SBBTabBarThemeData tabBarTheme,
    required SBBTextInputThemeData textInputTheme,
    required SBBToastThemeData toastTheme,
  }) {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: baseStyle.colorScheme.primarySwatch,
        accentColor: baseStyle.colorScheme.primaryColor,
        cardColor: baseStyle.colorScheme.backgroundColor,
        backgroundColor: baseStyle.colorScheme.backgroundColor,
        errorColor: baseStyle.colorScheme.errorColor,
        brightness: baseStyle.brightness,
      ).copyWith(surfaceTint: SBBColors.transparent),
      scaffoldBackgroundColor: baseStyle.colorScheme.backgroundColor,
      iconTheme: baseStyle.iconTheme,
      dividerColor: baseStyle.dividerTheme?.color,
      dividerTheme: baseStyle.dividerTheme,
      textTheme: baseStyle.textTheme.toTextTheme(labelColor: baseStyle.colorScheme.labelColor),
      appBarTheme: headerTheme.appBarTheme,
      filledButtonTheme: FilledButtonThemeData(style: primaryButtonTheme.style?.toButtonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonTheme.style?.toButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: tertiaryButtonTheme.style?.toButtonStyle()),
      textSelectionTheme: baseStyle.textSelectionTheme,
      extensions: [
        baseStyle,
        bottomSheetTheme,
        primaryButtonTheme,
        secondaryButtonTheme,
        tertiaryButtonTheme,
        accentButtonTheme,
        checkboxTheme,
        contentBoxTheme,
        chipTheme,
        controlStyles,
        decoratedTextTheme,
        dropdownTheme,
        headerTheme,
        headerBoxStyle,
        inputDecorationTheme,
        listHeaderTheme,
        listItemTheme,
        messageTheme,
        paginatorTheme,
        popupTheme,
        radioTheme,
        statusTheme,
        segmentedButtonTheme,
        sliderTheme,
        stepperTheme,
        switchTheme,
        tabBarTheme,
        textInputTheme,
        toastTheme,
      ],
    );
  }
}
