import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

typedef ThemedWidgetBuilder = Widget Function(BuildContext context, ThemeData theme, ThemeData darkTheme);

const sbbDefaultSpacing = 16.0;

class SBBTheme extends StatelessWidget {
  factory SBBTheme({
    SBBThemeData? theme,
    SBBThemeData? darkTheme,
    required ThemedWidgetBuilder builder,
  }) {
    return SBBTheme._(
      theme: theme ?? SBBThemeData.light(),
      darkTheme: darkTheme ?? SBBThemeData.dark(),
      builder: builder,
    );
  }

  factory SBBTheme.override({
    required SBBThemeData theme,
    required Widget child,
  }) {
    return SBBTheme._(
      theme: theme,
      darkTheme: theme,
      builder: (context, theme, darkTheme) => child,
    );
  }

  const SBBTheme._({
    Key? key,
    required this.theme,
    required this.darkTheme,
    required this.builder,
  }) : super(key: key);

  final SBBThemeData theme;
  final SBBThemeData darkTheme;
  final ThemedWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
        theme: theme,
        darkTheme: darkTheme,
        child: builder(
          context,
          theme.createTheme(),
          darkTheme.createTheme(),
        ));
  }

  static SBBThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return Theme.of(context).brightness == Brightness.dark ? inheritedTheme?.darkTheme ?? SBBThemeData.dark() : inheritedTheme?.theme ?? SBBThemeData.light();
  }
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    required this.theme,
    required this.darkTheme,
    required Widget child,
  }) : super(child: child);

  final SBBThemeData theme;
  final SBBThemeData darkTheme;

  @override
  bool updateShouldNotify(_InheritedTheme oldWidget) => child != oldWidget.child || theme != oldWidget.theme || darkTheme != oldWidget.darkTheme;
}

class SBBThemeData {
  SBBThemeData({
    Brightness? brightness,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,

    // PrimaryButton
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonBackgroundColorHighlighted,
    Color? primaryButtonBackgroundColorDisabled,
    Color? primaryButtonBackgroundColorLoading,
    TextStyle? primaryButtonTextStyle,
    TextStyle? primaryButtonTextStyleHighlighted,
    TextStyle? primaryButtonTextStyleDisabled,
    TextStyle? primaryButtonTextStyleLoading,

    // PrimaryButtonNegative
    Color? primaryButtonNegativeBackgroundColor,
    Color? primaryButtonNegativeBackgroundColorHighlighted,
    Color? primaryButtonNegativeBackgroundColorDisabled,
    Color? primaryButtonNegativeBackgroundColorLoading,
    Color? primaryButtonNegativeBorderColor,
    Color? primaryButtonNegativeBorderColorHighlighted,
    Color? primaryButtonNegativeBorderColorDisabled,
    Color? primaryButtonNegativeBorderColorLoading,
    TextStyle? primaryButtonNegativeTextStyle,
    TextStyle? primaryButtonNegativeTextStyleHighlighted,
    TextStyle? primaryButtonNegativeTextStyleDisabled,
    TextStyle? primaryButtonNegativeTextStyleLoading,

    // SecondaryButton
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonBackgroundColorHighlighted,
    Color? secondaryButtonBackgroundColorDisabled,
    Color? secondaryButtonBackgroundColorLoading,
    Color? secondaryButtonBorderColor,
    Color? secondaryButtonBorderColorHighlighted,
    Color? secondaryButtonBorderColorDisabled,
    Color? secondaryButtonBorderColorLoading,
    TextStyle? secondaryButtonTextStyle,
    TextStyle? secondaryButtonTextStyleHighlighted,
    TextStyle? secondaryButtonTextStyleDisabled,
    TextStyle? secondaryButtonTextStyleLoading,

    // TertiaryButtonLarge
    Color? tertiaryButtonLargeBackgroundColor,
    Color? tertiaryButtonLargeBackgroundColorHighlighted,
    Color? tertiaryButtonLargeBackgroundColorDisabled,
    Color? tertiaryButtonLargeBorderColor,
    Color? tertiaryButtonLargeBorderColorHighlighted,
    Color? tertiaryButtonLargeBorderColorDisabled,
    TextStyle? tertiaryButtonLargeTextStyle,
    TextStyle? tertiaryButtonLargeTextStyleHighlighted,
    TextStyle? tertiaryButtonLargeTextStyleDisabled,

    // TertiaryButtonSmall
    Color? tertiaryButtonSmallBackgroundColor,
    Color? tertiaryButtonSmallBackgroundColorHighlighted,
    Color? tertiaryButtonSmallBackgroundColorDisabled,
    Color? tertiaryButtonSmallBorderColor,
    Color? tertiaryButtonSmallBorderColorHighlighted,
    Color? tertiaryButtonSmallBorderColorDisabled,
    TextStyle? tertiaryButtonSmallTextStyle,
    TextStyle? tertiaryButtonSmallTextStyleHighlighted,
    TextStyle? tertiaryButtonSmallTextStyleDisabled,

    // IconButtonLarge
    Color? iconButtonLargeBackgroundColor,
    Color? iconButtonLargeBackgroundColorHighlighted,
    Color? iconButtonLargeBackgroundColorDisabled,
    Color? iconButtonLargeBorderColor,
    Color? iconButtonLargeBorderColorHighlighted,
    Color? iconButtonLargeBorderColorDisabled,
    Color? iconButtonLargeIconColor,
    Color? iconButtonLargeIconColorHighlighted,
    Color? iconButtonLargeIconColorDisabled,

    // IconButtonSmall
    Color? iconButtonSmallBackgroundColor,
    Color? iconButtonSmallBackgroundColorHighlighted,
    Color? iconButtonSmallBackgroundColorDisabled,
    Color? iconButtonSmallBorderColor,
    Color? iconButtonSmallBorderColorHighlighted,
    Color? iconButtonSmallBorderColorDisabled,
    Color? iconButtonSmallIconColor,
    Color? iconButtonSmallIconColorHighlighted,
    Color? iconButtonSmallIconColorDisabled,

    // IconButtonSmallNegative
    Color? iconButtonSmallNegativeBackgroundColor,
    Color? iconButtonSmallNegativeBackgroundColorHighlighted,
    Color? iconButtonSmallNegativeBackgroundColorDisabled,
    Color? iconButtonSmallNegativeBorderColor,
    Color? iconButtonSmallNegativeBorderColorHighlighted,
    Color? iconButtonSmallNegativeBorderColorDisabled,
    Color? iconButtonSmallNegativeIconColor,
    Color? iconButtonSmallNegativeIconColorHighlighted,
    Color? iconButtonSmallNegativeIconColorDisabled,

    // IconButtonSmallBorderless
    Color? iconButtonSmallBorderlessBackgroundColor,
    Color? iconButtonSmallBorderlessBackgroundColorHighlighted,
    Color? iconButtonSmallBorderlessBackgroundColorDisabled,
    Color? iconButtonSmallBorderlessIconColor,
    Color? iconButtonSmallBorderlessIconColorHighlighted,
    Color? iconButtonSmallBorderlessIconColorDisabled,

    // IconFormButton
    Color? iconFormButtonBackgroundColor,
    Color? iconFormButtonBackgroundColorHighlighted,
    Color? iconFormButtonBackgroundColorDisabled,
    Color? iconFormButtonBorderColor,
    Color? iconFormButtonBorderColorHighlighted,
    Color? iconFormButtonBorderColorDisabled,
    Color? iconFormButtonIconColor,
    Color? iconFormButtonIconColorHighlighted,
    Color? iconFormButtonIconColorDisabled,

    // IconTextButton
    Color? iconTextButtonBackgroundColor,
    Color? iconTextButtonBackgroundColorHighlighted,
    Color? iconTextButtonBackgroundColorDisabled,
    Color? iconTextButtonIconColor,
    Color? iconTextButtonIconColorHighlighted,
    Color? iconTextButtonIconColorDisabled,
    TextStyle? iconTextButtonTextStyle,
    TextStyle? iconTextButtonTextStyleHighlighted,
    TextStyle? iconTextButtonTextStyleDisabled,

    // Link
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,

    //ListHeader
    TextStyle? listHeaderTextStyle,

    // ListItem
    Color? listItemBackgroundColor,
    Color? listItemBackgroundColorHighlighted,
    TextStyle? listItemTitleTextStyle,
    TextStyle? listItemSubtitleTextStyle,

    // Checkbox
    Color? checkboxColor,
    Color? checkboxColorDisabled,
    Color? checkboxBackgroundColor,
    Color? checkboxBackgroundColorHighlighted,
    Color? checkboxBackgroundColorDisabled,
    Color? checkboxBorderColor,
    Color? checkboxBorderColorDisabled,
    Color? checkboxListItemBackgroundColor,
    Color? checkboxListItemBackgroundColorHighlighted,
    Color? checkboxListItemBackgroundColorDisabled,
    Color? checkboxListItemIconColor,
    Color? checkboxListItemIconColorDisabled,
    TextStyle? checkboxListItemTextStyle,
    TextStyle? checkboxListItemTextStyleDisabled,
    TextStyle? checkboxListItemSecondaryTextStyle,
    TextStyle? checkboxListItemSecondaryTextStyleDisabled,

    // RadioButton
    Color? radioButtonColor,
    Color? radioButtonColorDisabled,
    Color? radioButtonBackgroundColor,
    Color? radioButtonBackgroundColorHighlighted,
    Color? radioButtonBackgroundColorDisabled,
    Color? radioButtonBorderColor,
    Color? radioButtonBorderColorDisabled,
    Color? radioButtonListItemBackgroundColor,
    Color? radioButtonListItemBackgroundColorHighlighted,
    Color? radioButtonListItemBackgroundColorDisabled,
    Color? radioButtonListItemIconColor,
    Color? radioButtonListItemIconColorDisabled,
    TextStyle? radioButtonListItemTextStyle,
    TextStyle? radioButtonListItemTextStyleDisabled,
    TextStyle? radioButtonListItemSecondaryTextStyle,
    TextStyle? radioButtonListItemSecondaryTextStyleDisabled,

    // SegmentedButton
    Color? segmentedButtonBackgroundColor,
    Color? segmentedButtonSelectedColor,
    TextStyle? segmentedButtonTextStyle,

    // TextField
    TextStyle? textFieldTextStyle,
    TextStyle? textFieldTextStyleDisabled,
    TextStyle? textFieldPlaceholderTextStyle,
    TextStyle? textFieldPlaceholderTextStyleDisabled,
    TextStyle? textFieldErrorTextStyle,
    Color? textFieldDividerColor,
    Color? textFieldDividerColorHighlighted,
    Color? textFieldDividerColorError,
    Color? textFieldCursorColor,
    Color? textFieldSelectionColor,
    Color? textFieldSelectionHandleColor,
    Color? textFieldIconColor,
    Color? textFieldIconColorDisabled,

    // Group
    Color? groupBackgroundColor,

    // Accordion
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,

    // Modal
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,

    // Select
    TextStyle? selectLabelTextStyle,
    TextStyle? selectLabelTextStyleDisabled,

    // Toast
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,

    // Tab Bar
    TextStyle? tabBarTextStyle,
  }) {
    _setDefaultValues(
      brightness: brightness,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor,
      fontFamily: fontFamily,
      defaultTextColor: defaultTextColor,
      defaultTextStyle: defaultTextStyle,
      dividerColor: dividerColor,
      defaultRootContainerPadding: defaultRootContainerPadding,

      // Icon
      iconColor: iconColor,

      // Header
      headerBackgroundColor: headerBackgroundColor,
      headerButtonBackgroundColorHighlighted: headerButtonBackgroundColorHighlighted,
      headerIconColor: headerIconColor,
      headerTextStyle: headerTextStyle,

      // PrimaryButton
      primaryButtonBackgroundColor: primaryButtonBackgroundColor,
      primaryButtonBackgroundColorHighlighted: primaryButtonBackgroundColorHighlighted,
      primaryButtonBackgroundColorDisabled: primaryButtonBackgroundColorDisabled,
      primaryButtonBackgroundColorLoading: primaryButtonBackgroundColorLoading,
      primaryButtonTextStyle: primaryButtonTextStyle,
      primaryButtonTextStyleHighlighted: primaryButtonTextStyleHighlighted,
      primaryButtonTextStyleDisabled: primaryButtonTextStyleDisabled,
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading,

      // PrimaryButtonNegative
      primaryButtonNegativeBackgroundColor: primaryButtonNegativeBackgroundColor,
      primaryButtonNegativeBackgroundColorHighlighted: primaryButtonNegativeBackgroundColorHighlighted,
      primaryButtonNegativeBackgroundColorDisabled: primaryButtonNegativeBackgroundColorDisabled,
      primaryButtonNegativeBackgroundColorLoading: primaryButtonNegativeBackgroundColorLoading,
      primaryButtonNegativeBorderColor: primaryButtonNegativeBorderColor,
      primaryButtonNegativeBorderColorHighlighted: primaryButtonNegativeBorderColorHighlighted,
      primaryButtonNegativeBorderColorDisabled: primaryButtonNegativeBorderColorDisabled,
      primaryButtonNegativeBorderColorLoading: primaryButtonNegativeBorderColorLoading,
      primaryButtonNegativeTextStyle: primaryButtonNegativeTextStyle,
      primaryButtonNegativeTextStyleHighlighted: primaryButtonNegativeTextStyleHighlighted,
      primaryButtonNegativeTextStyleDisabled: primaryButtonNegativeTextStyleDisabled,
      primaryButtonNegativeTextStyleLoading: primaryButtonNegativeTextStyleLoading,

      // SecondaryButton
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor,
      secondaryButtonBackgroundColorHighlighted: secondaryButtonBackgroundColorHighlighted,
      secondaryButtonBackgroundColorDisabled: secondaryButtonBackgroundColorDisabled,
      secondaryButtonBackgroundColorLoading: secondaryButtonBackgroundColorLoading,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
      secondaryButtonBorderColorHighlighted: secondaryButtonBorderColorHighlighted,
      secondaryButtonBorderColorDisabled: secondaryButtonBorderColorDisabled,
      secondaryButtonBorderColorLoading: secondaryButtonBorderColorLoading,
      secondaryButtonTextStyle: secondaryButtonTextStyle,
      secondaryButtonTextStyleHighlighted: secondaryButtonTextStyleHighlighted,
      secondaryButtonTextStyleDisabled: secondaryButtonTextStyleDisabled,
      secondaryButtonTextStyleLoading: secondaryButtonTextStyleLoading,

      // TertiaryButtonLarge
      tertiaryButtonLargeBackgroundColor: tertiaryButtonLargeBackgroundColor,
      tertiaryButtonLargeBackgroundColorHighlighted: tertiaryButtonLargeBackgroundColorHighlighted,
      tertiaryButtonLargeBackgroundColorDisabled: tertiaryButtonLargeBackgroundColorDisabled,
      tertiaryButtonLargeBorderColor: tertiaryButtonLargeBorderColor,
      tertiaryButtonLargeBorderColorHighlighted: tertiaryButtonLargeBorderColorHighlighted,
      tertiaryButtonLargeBorderColorDisabled: tertiaryButtonLargeBorderColorDisabled,
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle,
      tertiaryButtonLargeTextStyleHighlighted: tertiaryButtonLargeTextStyleHighlighted,
      tertiaryButtonLargeTextStyleDisabled: tertiaryButtonLargeTextStyleDisabled,

      // TertiaryButtonSmall
      tertiaryButtonSmallBackgroundColor: tertiaryButtonSmallBackgroundColor,
      tertiaryButtonSmallBackgroundColorHighlighted: tertiaryButtonSmallBackgroundColorHighlighted,
      tertiaryButtonSmallBackgroundColorDisabled: tertiaryButtonSmallBackgroundColorDisabled,
      tertiaryButtonSmallBorderColor: tertiaryButtonSmallBorderColor,
      tertiaryButtonSmallBorderColorHighlighted: tertiaryButtonSmallBorderColorHighlighted,
      tertiaryButtonSmallBorderColorDisabled: tertiaryButtonSmallBorderColorDisabled,
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle,
      tertiaryButtonSmallTextStyleHighlighted: tertiaryButtonSmallTextStyleHighlighted,
      tertiaryButtonSmallTextStyleDisabled: tertiaryButtonSmallTextStyleDisabled,

      // IconButtonLarge
      iconButtonLargeBackgroundColor: iconButtonLargeBackgroundColor,
      iconButtonLargeBackgroundColorHighlighted: iconButtonLargeBackgroundColorHighlighted,
      iconButtonLargeBackgroundColorDisabled: iconButtonLargeBackgroundColorDisabled,
      iconButtonLargeBorderColor: iconButtonLargeBorderColor,
      iconButtonLargeBorderColorHighlighted: iconButtonLargeBorderColorHighlighted,
      iconButtonLargeBorderColorDisabled: iconButtonLargeBorderColorDisabled,
      iconButtonLargeIconColor: iconButtonLargeIconColor,
      iconButtonLargeIconColorHighlighted: iconButtonLargeIconColorHighlighted,
      iconButtonLargeIconColorDisabled: iconButtonLargeIconColorDisabled,

      // IconButtonSmall
      iconButtonSmallBackgroundColor: iconButtonSmallBackgroundColor,
      iconButtonSmallBackgroundColorHighlighted: iconButtonSmallBackgroundColorHighlighted,
      iconButtonSmallBackgroundColorDisabled: iconButtonSmallBackgroundColorDisabled,
      iconButtonSmallBorderColor: iconButtonSmallBorderColor,
      iconButtonSmallBorderColorHighlighted: iconButtonSmallBorderColorHighlighted,
      iconButtonSmallBorderColorDisabled: iconButtonSmallBorderColorDisabled,
      iconButtonSmallIconColor: iconButtonSmallIconColor,
      iconButtonSmallIconColorHighlighted: iconButtonSmallIconColorHighlighted,
      iconButtonSmallIconColorDisabled: iconButtonSmallIconColorDisabled,

      // IconButtonSmallNegative
      iconButtonSmallNegativeBackgroundColor: iconButtonSmallNegativeBackgroundColor,
      iconButtonSmallNegativeBackgroundColorHighlighted: iconButtonSmallNegativeBackgroundColorHighlighted,
      iconButtonSmallNegativeBackgroundColorDisabled: iconButtonSmallNegativeBackgroundColorDisabled,
      iconButtonSmallNegativeBorderColor: iconButtonSmallNegativeBorderColor,
      iconButtonSmallNegativeBorderColorHighlighted: iconButtonSmallNegativeBorderColorHighlighted,
      iconButtonSmallNegativeBorderColorDisabled: iconButtonSmallNegativeBorderColorDisabled,
      iconButtonSmallNegativeIconColor: iconButtonSmallNegativeIconColor,
      iconButtonSmallNegativeIconColorHighlighted: iconButtonSmallNegativeIconColorHighlighted,
      iconButtonSmallNegativeIconColorDisabled: iconButtonSmallNegativeIconColorDisabled,

      // IconButtonSmallBorderless
      iconButtonSmallBorderlessBackgroundColor: iconButtonSmallBorderlessBackgroundColor,
      iconButtonSmallBorderlessBackgroundColorHighlighted: iconButtonSmallBorderlessBackgroundColorHighlighted,
      iconButtonSmallBorderlessBackgroundColorDisabled: iconButtonSmallBorderlessBackgroundColorDisabled,
      iconButtonSmallBorderlessIconColor: iconButtonSmallBorderlessIconColor,
      iconButtonSmallBorderlessIconColorHighlighted: iconButtonSmallBorderlessIconColorHighlighted,
      iconButtonSmallBorderlessIconColorDisabled: iconButtonSmallBorderlessIconColorDisabled,

      // IconFormButton
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor,
      iconFormButtonBackgroundColorHighlighted: iconFormButtonBackgroundColorHighlighted,
      iconFormButtonBackgroundColorDisabled: iconFormButtonBackgroundColorDisabled,
      iconFormButtonBorderColor: iconFormButtonBorderColor,
      iconFormButtonBorderColorHighlighted: iconFormButtonBorderColorHighlighted,
      iconFormButtonBorderColorDisabled: iconFormButtonBorderColorDisabled,
      iconFormButtonIconColor: iconFormButtonIconColor,
      iconFormButtonIconColorHighlighted: iconFormButtonIconColorHighlighted,
      iconFormButtonIconColorDisabled: iconFormButtonIconColorDisabled,

      // IconTextButton
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor,
      iconTextButtonBackgroundColorHighlighted: iconTextButtonBackgroundColorHighlighted,
      iconTextButtonBackgroundColorDisabled: iconTextButtonBackgroundColorDisabled,
      iconTextButtonIconColor: iconTextButtonIconColor,
      iconTextButtonIconColorHighlighted: iconTextButtonIconColorHighlighted,
      iconTextButtonIconColorDisabled: iconTextButtonIconColorDisabled,
      iconTextButtonTextStyle: iconTextButtonTextStyle,
      iconTextButtonTextStyleHighlighted: iconTextButtonTextStyleHighlighted,
      iconTextButtonTextStyleDisabled: iconTextButtonTextStyleDisabled,

      // Link
      linkTextStyle: linkTextStyle,
      linkTextStyleHighlighted: linkTextStyleHighlighted,

      //ListHeader
      listHeaderTextStyle: listHeaderTextStyle,

      // ListItem
      listItemBackgroundColor: listItemBackgroundColor,
      listItemBackgroundColorHighlighted: listItemBackgroundColorHighlighted,
      listItemTitleTextStyle: listItemTitleTextStyle,
      listItemSubtitleTextStyle: listItemSubtitleTextStyle,

      // Checkbox
      checkboxColor: checkboxColor,
      checkboxColorDisabled: checkboxColorDisabled,
      checkboxBackgroundColor: checkboxBackgroundColor,
      checkboxBackgroundColorHighlighted: checkboxBackgroundColorHighlighted,
      checkboxBackgroundColorDisabled: checkboxBackgroundColorDisabled,
      checkboxBorderColor: checkboxBorderColor,
      checkboxBorderColorDisabled: checkboxBorderColorDisabled,
      checkboxListItemBackgroundColor: checkboxListItemBackgroundColor,
      checkboxListItemBackgroundColorHighlighted: checkboxListItemBackgroundColorHighlighted,
      checkboxListItemBackgroundColorDisabled: checkboxListItemBackgroundColorDisabled,
      checkboxListItemIconColor: checkboxListItemIconColor,
      checkboxListItemIconColorDisabled: checkboxListItemIconColorDisabled,
      checkboxListItemTextStyle: checkboxListItemTextStyle,
      checkboxListItemTextStyleDisabled: checkboxListItemTextStyleDisabled,
      checkboxListItemSecondaryTextStyle: checkboxListItemSecondaryTextStyle,
      checkboxListItemSecondaryTextStyleDisabled: checkboxListItemSecondaryTextStyleDisabled,

      // RadioButton
      radioButtonColor: radioButtonColor,
      radioButtonColorDisabled: radioButtonColorDisabled,
      radioButtonBackgroundColor: radioButtonBackgroundColor,
      radioButtonBackgroundColorHighlighted: radioButtonBackgroundColorHighlighted,
      radioButtonBackgroundColorDisabled: radioButtonBackgroundColorDisabled,
      radioButtonBorderColor: radioButtonBorderColor,
      radioButtonBorderColorDisabled: radioButtonBorderColorDisabled,
      radioButtonListItemBackgroundColor: radioButtonListItemBackgroundColor,
      radioButtonListItemBackgroundColorHighlighted: radioButtonListItemBackgroundColorHighlighted,
      radioButtonListItemBackgroundColorDisabled: radioButtonListItemBackgroundColorDisabled,
      radioButtonListItemIconColor: radioButtonListItemIconColor,
      radioButtonListItemIconColorDisabled: radioButtonListItemIconColorDisabled,
      radioButtonListItemTextStyle: radioButtonListItemTextStyle,
      radioButtonListItemTextStyleDisabled: radioButtonListItemTextStyleDisabled,
      radioButtonListItemSecondaryTextStyle: radioButtonListItemSecondaryTextStyle,
      radioButtonListItemSecondaryTextStyleDisabled: radioButtonListItemSecondaryTextStyleDisabled,

      // SegmentedButton
      segmentedButtonBackgroundColor: segmentedButtonBackgroundColor,
      segmentedButtonSelectedColor: segmentedButtonSelectedColor,
      segmentedButtonTextStyle: segmentedButtonTextStyle,

      // TextField
      textFieldTextStyle: textFieldTextStyle,
      textFieldTextStyleDisabled: textFieldTextStyleDisabled,
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle,
      textFieldPlaceholderTextStyleDisabled: textFieldPlaceholderTextStyleDisabled,
      textFieldErrorTextStyle: textFieldErrorTextStyle,
      textFieldDividerColor: textFieldDividerColor,
      textFieldDividerColorHighlighted: textFieldDividerColorHighlighted,
      textFieldDividerColorError: textFieldDividerColorError,
      textFieldCursorColor: textFieldCursorColor,
      textFieldSelectionColor: textFieldSelectionColor,
      textFieldSelectionHandleColor: textFieldSelectionHandleColor,
      textFieldIconColor: textFieldIconColor,
      textFieldIconColorDisabled: textFieldIconColorDisabled,

      // Group
      groupBackgroundColor: groupBackgroundColor,

      // Accordion
      accordionTitleTextStyle: accordionTitleTextStyle,
      accordionBodyTextStyle: accordionBodyTextStyle,
      accordionBackgroundColor: accordionBackgroundColor,

      // Modal
      modalBackgroundColor: modalBackgroundColor,
      modalTitleTextStyle: modalTitleTextStyle,

      // Select
      selectLabelTextStyle: selectLabelTextStyle,
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled,

      // Toast
      toastTextStyle: toastTextStyle,
      toastBackgroundColor: toastBackgroundColor,

      // Tab Bar
      tabBarTextStyle: tabBarTextStyle,
    );
  }

  SBBThemeData.light({
    Brightness? brightness = Brightness.light,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,

    // PrimaryButton
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonBackgroundColorHighlighted,
    Color? primaryButtonBackgroundColorDisabled,
    Color? primaryButtonBackgroundColorLoading,
    TextStyle? primaryButtonTextStyle,
    TextStyle? primaryButtonTextStyleHighlighted,
    TextStyle? primaryButtonTextStyleDisabled,
    TextStyle? primaryButtonTextStyleLoading,

    // PrimaryButtonNegative
    Color? primaryButtonNegativeBackgroundColor,
    Color? primaryButtonNegativeBackgroundColorHighlighted,
    Color? primaryButtonNegativeBackgroundColorDisabled,
    Color? primaryButtonNegativeBackgroundColorLoading,
    Color? primaryButtonNegativeBorderColor,
    Color? primaryButtonNegativeBorderColorHighlighted,
    Color? primaryButtonNegativeBorderColorDisabled,
    Color? primaryButtonNegativeBorderColorLoading,
    TextStyle? primaryButtonNegativeTextStyle,
    TextStyle? primaryButtonNegativeTextStyleHighlighted,
    TextStyle? primaryButtonNegativeTextStyleDisabled,
    TextStyle? primaryButtonNegativeTextStyleLoading,

    // SecondaryButton
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonBackgroundColorHighlighted,
    Color? secondaryButtonBackgroundColorDisabled,
    Color? secondaryButtonBackgroundColorLoading,
    Color? secondaryButtonBorderColor,
    Color? secondaryButtonBorderColorHighlighted,
    Color? secondaryButtonBorderColorDisabled,
    Color? secondaryButtonBorderColorLoading,
    TextStyle? secondaryButtonTextStyle,
    TextStyle? secondaryButtonTextStyleHighlighted,
    TextStyle? secondaryButtonTextStyleDisabled,
    TextStyle? secondaryButtonTextStyleLoading,

    // TertiaryButtonLarge
    Color? tertiaryButtonLargeBackgroundColor,
    Color? tertiaryButtonLargeBackgroundColorHighlighted,
    Color? tertiaryButtonLargeBackgroundColorDisabled,
    Color? tertiaryButtonLargeBorderColor,
    Color? tertiaryButtonLargeBorderColorHighlighted,
    Color? tertiaryButtonLargeBorderColorDisabled,
    TextStyle? tertiaryButtonLargeTextStyle,
    TextStyle? tertiaryButtonLargeTextStyleHighlighted,
    TextStyle? tertiaryButtonLargeTextStyleDisabled,

    // TertiaryButtonSmall
    Color? tertiaryButtonSmallBackgroundColor,
    Color? tertiaryButtonSmallBackgroundColorHighlighted,
    Color? tertiaryButtonSmallBackgroundColorDisabled,
    Color? tertiaryButtonSmallBorderColor,
    Color? tertiaryButtonSmallBorderColorHighlighted,
    Color? tertiaryButtonSmallBorderColorDisabled,
    TextStyle? tertiaryButtonSmallTextStyle,
    TextStyle? tertiaryButtonSmallTextStyleHighlighted,
    TextStyle? tertiaryButtonSmallTextStyleDisabled,

    // IconButtonLarge
    Color? iconButtonLargeBackgroundColor,
    Color? iconButtonLargeBackgroundColorHighlighted,
    Color? iconButtonLargeBackgroundColorDisabled,
    Color? iconButtonLargeBorderColor,
    Color? iconButtonLargeBorderColorHighlighted,
    Color? iconButtonLargeBorderColorDisabled,
    Color? iconButtonLargeIconColor,
    Color? iconButtonLargeIconColorHighlighted,
    Color? iconButtonLargeIconColorDisabled,

    // IconButtonSmall
    Color? iconButtonSmallBackgroundColor,
    Color? iconButtonSmallBackgroundColorHighlighted,
    Color? iconButtonSmallBackgroundColorDisabled,
    Color? iconButtonSmallBorderColor,
    Color? iconButtonSmallBorderColorHighlighted,
    Color? iconButtonSmallBorderColorDisabled,
    Color? iconButtonSmallIconColor,
    Color? iconButtonSmallIconColorHighlighted,
    Color? iconButtonSmallIconColorDisabled,

    // IconButtonSmallNegative
    Color? iconButtonSmallNegativeBackgroundColor,
    Color? iconButtonSmallNegativeBackgroundColorHighlighted,
    Color? iconButtonSmallNegativeBackgroundColorDisabled,
    Color? iconButtonSmallNegativeBorderColor,
    Color? iconButtonSmallNegativeBorderColorHighlighted,
    Color? iconButtonSmallNegativeBorderColorDisabled,
    Color? iconButtonSmallNegativeIconColor,
    Color? iconButtonSmallNegativeIconColorHighlighted,
    Color? iconButtonSmallNegativeIconColorDisabled,

    // IconButtonSmallBorderless
    Color? iconButtonSmallBorderlessBackgroundColor,
    Color? iconButtonSmallBorderlessBackgroundColorHighlighted,
    Color? iconButtonSmallBorderlessBackgroundColorDisabled,
    Color? iconButtonSmallBorderlessIconColor,
    Color? iconButtonSmallBorderlessIconColorHighlighted,
    Color? iconButtonSmallBorderlessIconColorDisabled,

    // IconFormButton
    Color? iconFormButtonBackgroundColor,
    Color? iconFormButtonBackgroundColorHighlighted,
    Color? iconFormButtonBackgroundColorDisabled,
    Color? iconFormButtonBorderColor,
    Color? iconFormButtonBorderColorHighlighted,
    Color? iconFormButtonBorderColorDisabled,
    Color? iconFormButtonIconColor,
    Color? iconFormButtonIconColorHighlighted,
    Color? iconFormButtonIconColorDisabled,

    // IconTextButton
    Color? iconTextButtonBackgroundColor,
    Color? iconTextButtonBackgroundColorHighlighted,
    Color? iconTextButtonBackgroundColorDisabled,
    Color? iconTextButtonIconColor,
    Color? iconTextButtonIconColorHighlighted,
    Color? iconTextButtonIconColorDisabled,
    TextStyle? iconTextButtonTextStyle,
    TextStyle? iconTextButtonTextStyleHighlighted,
    TextStyle? iconTextButtonTextStyleDisabled,

    // Link
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,

    //ListHeader
    TextStyle? listHeaderTextStyle,

    // ListItem
    Color? listItemBackgroundColor,
    Color? listItemBackgroundColorHighlighted,
    TextStyle? listItemTitleTextStyle,
    TextStyle? listItemSubtitleTextStyle,

    // Checkbox
    Color? checkboxColor,
    Color? checkboxColorDisabled,
    Color? checkboxBackgroundColor,
    Color? checkboxBackgroundColorHighlighted,
    Color? checkboxBackgroundColorDisabled,
    Color? checkboxBorderColor,
    Color? checkboxBorderColorDisabled,
    Color? checkboxListItemBackgroundColor,
    Color? checkboxListItemBackgroundColorHighlighted,
    Color? checkboxListItemBackgroundColorDisabled,
    Color? checkboxListItemIconColor,
    Color? checkboxListItemIconColorDisabled,
    TextStyle? checkboxListItemTextStyle,
    TextStyle? checkboxListItemTextStyleDisabled,
    TextStyle? checkboxListItemSecondaryTextStyle,
    TextStyle? checkboxListItemSecondaryTextStyleDisabled,

    // RadioButton
    Color? radioButtonColor,
    Color? radioButtonColorDisabled,
    Color? radioButtonBackgroundColor,
    Color? radioButtonBackgroundColorHighlighted,
    Color? radioButtonBackgroundColorDisabled,
    Color? radioButtonBorderColor,
    Color? radioButtonBorderColorDisabled,
    Color? radioButtonListItemBackgroundColor,
    Color? radioButtonListItemBackgroundColorHighlighted,
    Color? radioButtonListItemBackgroundColorDisabled,
    Color? radioButtonListItemIconColor,
    Color? radioButtonListItemIconColorDisabled,
    TextStyle? radioButtonListItemTextStyle,
    TextStyle? radioButtonListItemTextStyleDisabled,
    TextStyle? radioButtonListItemSecondaryTextStyle,
    TextStyle? radioButtonListItemSecondaryTextStyleDisabled,

    // SegmentedButton
    Color? segmentedButtonBackgroundColor,
    Color? segmentedButtonSelectedColor,
    TextStyle? segmentedButtonTextStyle,

    // TextField
    TextStyle? textFieldTextStyle,
    TextStyle? textFieldTextStyleDisabled,
    TextStyle? textFieldPlaceholderTextStyle,
    TextStyle? textFieldPlaceholderTextStyleDisabled,
    TextStyle? textFieldErrorTextStyle,
    Color? textFieldDividerColor,
    Color? textFieldDividerColorHighlighted,
    Color? textFieldDividerColorError,
    Color? textFieldCursorColor,
    Color? textFieldSelectionColor,
    Color? textFieldSelectionHandleColor,
    Color? textFieldIconColor,
    Color? textFieldIconColorDisabled,

    // Group
    Color? groupBackgroundColor,

    // Accordion
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,

    // Modal
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,

    // Select
    TextStyle? selectLabelTextStyle,
    TextStyle? selectLabelTextStyleDisabled,

    // Toast
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,

    // Tab Bar
    TextStyle? tabBarTextStyle,
  }) {
    _setDefaultValues(
      brightness: brightness,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor,
      fontFamily: fontFamily,
      defaultTextColor: defaultTextColor,
      defaultTextStyle: defaultTextStyle,
      dividerColor: dividerColor,
      defaultRootContainerPadding: defaultRootContainerPadding,

      // Icon
      iconColor: iconColor,

      // Header
      headerBackgroundColor: headerBackgroundColor,
      headerButtonBackgroundColorHighlighted: headerButtonBackgroundColorHighlighted,
      headerIconColor: headerIconColor,
      headerTextStyle: headerTextStyle,

      // PrimaryButton
      primaryButtonBackgroundColor: primaryButtonBackgroundColor,
      primaryButtonBackgroundColorHighlighted: primaryButtonBackgroundColorHighlighted,
      primaryButtonBackgroundColorDisabled: primaryButtonBackgroundColorDisabled,
      primaryButtonBackgroundColorLoading: primaryButtonBackgroundColorLoading,
      primaryButtonTextStyle: primaryButtonTextStyle,
      primaryButtonTextStyleHighlighted: primaryButtonTextStyleHighlighted,
      primaryButtonTextStyleDisabled: primaryButtonTextStyleDisabled,
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading,

      // PrimaryButtonNegative
      primaryButtonNegativeBackgroundColor: primaryButtonNegativeBackgroundColor,
      primaryButtonNegativeBackgroundColorHighlighted: primaryButtonNegativeBackgroundColorHighlighted,
      primaryButtonNegativeBackgroundColorDisabled: primaryButtonNegativeBackgroundColorDisabled,
      primaryButtonNegativeBackgroundColorLoading: primaryButtonNegativeBackgroundColorLoading,
      primaryButtonNegativeBorderColor: primaryButtonNegativeBorderColor,
      primaryButtonNegativeBorderColorHighlighted: primaryButtonNegativeBorderColorHighlighted,
      primaryButtonNegativeBorderColorDisabled: primaryButtonNegativeBorderColorDisabled,
      primaryButtonNegativeBorderColorLoading: primaryButtonNegativeBorderColorLoading,
      primaryButtonNegativeTextStyle: primaryButtonNegativeTextStyle,
      primaryButtonNegativeTextStyleHighlighted: primaryButtonNegativeTextStyleHighlighted,
      primaryButtonNegativeTextStyleDisabled: primaryButtonNegativeTextStyleDisabled,
      primaryButtonNegativeTextStyleLoading: primaryButtonNegativeTextStyleLoading,

      // SecondaryButton
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor,
      secondaryButtonBackgroundColorHighlighted: secondaryButtonBackgroundColorHighlighted,
      secondaryButtonBackgroundColorDisabled: secondaryButtonBackgroundColorDisabled,
      secondaryButtonBackgroundColorLoading: secondaryButtonBackgroundColorLoading,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
      secondaryButtonBorderColorHighlighted: secondaryButtonBorderColorHighlighted,
      secondaryButtonBorderColorDisabled: secondaryButtonBorderColorDisabled,
      secondaryButtonBorderColorLoading: secondaryButtonBorderColorLoading,
      secondaryButtonTextStyle: secondaryButtonTextStyle,
      secondaryButtonTextStyleHighlighted: secondaryButtonTextStyleHighlighted,
      secondaryButtonTextStyleDisabled: secondaryButtonTextStyleDisabled,
      secondaryButtonTextStyleLoading: secondaryButtonTextStyleLoading,

      // TertiaryButtonLarge
      tertiaryButtonLargeBackgroundColor: tertiaryButtonLargeBackgroundColor,
      tertiaryButtonLargeBackgroundColorHighlighted: tertiaryButtonLargeBackgroundColorHighlighted,
      tertiaryButtonLargeBackgroundColorDisabled: tertiaryButtonLargeBackgroundColorDisabled,
      tertiaryButtonLargeBorderColor: tertiaryButtonLargeBorderColor,
      tertiaryButtonLargeBorderColorHighlighted: tertiaryButtonLargeBorderColorHighlighted,
      tertiaryButtonLargeBorderColorDisabled: tertiaryButtonLargeBorderColorDisabled,
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle,
      tertiaryButtonLargeTextStyleHighlighted: tertiaryButtonLargeTextStyleHighlighted,
      tertiaryButtonLargeTextStyleDisabled: tertiaryButtonLargeTextStyleDisabled,

      // TertiaryButtonSmall
      tertiaryButtonSmallBackgroundColor: tertiaryButtonSmallBackgroundColor,
      tertiaryButtonSmallBackgroundColorHighlighted: tertiaryButtonSmallBackgroundColorHighlighted,
      tertiaryButtonSmallBackgroundColorDisabled: tertiaryButtonSmallBackgroundColorDisabled,
      tertiaryButtonSmallBorderColor: tertiaryButtonSmallBorderColor,
      tertiaryButtonSmallBorderColorHighlighted: tertiaryButtonSmallBorderColorHighlighted,
      tertiaryButtonSmallBorderColorDisabled: tertiaryButtonSmallBorderColorDisabled,
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle,
      tertiaryButtonSmallTextStyleHighlighted: tertiaryButtonSmallTextStyleHighlighted,
      tertiaryButtonSmallTextStyleDisabled: tertiaryButtonSmallTextStyleDisabled,

      // IconButtonLarge
      iconButtonLargeBackgroundColor: iconButtonLargeBackgroundColor,
      iconButtonLargeBackgroundColorHighlighted: iconButtonLargeBackgroundColorHighlighted,
      iconButtonLargeBackgroundColorDisabled: iconButtonLargeBackgroundColorDisabled,
      iconButtonLargeBorderColor: iconButtonLargeBorderColor,
      iconButtonLargeBorderColorHighlighted: iconButtonLargeBorderColorHighlighted,
      iconButtonLargeBorderColorDisabled: iconButtonLargeBorderColorDisabled,
      iconButtonLargeIconColor: iconButtonLargeIconColor,
      iconButtonLargeIconColorHighlighted: iconButtonLargeIconColorHighlighted,
      iconButtonLargeIconColorDisabled: iconButtonLargeIconColorDisabled,

      // IconButtonSmall
      iconButtonSmallBackgroundColor: iconButtonSmallBackgroundColor,
      iconButtonSmallBackgroundColorHighlighted: iconButtonSmallBackgroundColorHighlighted,
      iconButtonSmallBackgroundColorDisabled: iconButtonSmallBackgroundColorDisabled,
      iconButtonSmallBorderColor: iconButtonSmallBorderColor,
      iconButtonSmallBorderColorHighlighted: iconButtonSmallBorderColorHighlighted,
      iconButtonSmallBorderColorDisabled: iconButtonSmallBorderColorDisabled,
      iconButtonSmallIconColor: iconButtonSmallIconColor,
      iconButtonSmallIconColorHighlighted: iconButtonSmallIconColorHighlighted,
      iconButtonSmallIconColorDisabled: iconButtonSmallIconColorDisabled,

      // IconButtonSmallNegative
      iconButtonSmallNegativeBackgroundColor: iconButtonSmallNegativeBackgroundColor,
      iconButtonSmallNegativeBackgroundColorHighlighted: iconButtonSmallNegativeBackgroundColorHighlighted,
      iconButtonSmallNegativeBackgroundColorDisabled: iconButtonSmallNegativeBackgroundColorDisabled,
      iconButtonSmallNegativeBorderColor: iconButtonSmallNegativeBorderColor,
      iconButtonSmallNegativeBorderColorHighlighted: iconButtonSmallNegativeBorderColorHighlighted,
      iconButtonSmallNegativeBorderColorDisabled: iconButtonSmallNegativeBorderColorDisabled,
      iconButtonSmallNegativeIconColor: iconButtonSmallNegativeIconColor,
      iconButtonSmallNegativeIconColorHighlighted: iconButtonSmallNegativeIconColorHighlighted,
      iconButtonSmallNegativeIconColorDisabled: iconButtonSmallNegativeIconColorDisabled,

      // IconButtonSmallBorderless
      iconButtonSmallBorderlessBackgroundColor: iconButtonSmallBorderlessBackgroundColor,
      iconButtonSmallBorderlessBackgroundColorHighlighted: iconButtonSmallBorderlessBackgroundColorHighlighted,
      iconButtonSmallBorderlessBackgroundColorDisabled: iconButtonSmallBorderlessBackgroundColorDisabled,
      iconButtonSmallBorderlessIconColor: iconButtonSmallBorderlessIconColor,
      iconButtonSmallBorderlessIconColorHighlighted: iconButtonSmallBorderlessIconColorHighlighted,
      iconButtonSmallBorderlessIconColorDisabled: iconButtonSmallBorderlessIconColorDisabled,

      // IconFormButton
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor,
      iconFormButtonBackgroundColorHighlighted: iconFormButtonBackgroundColorHighlighted,
      iconFormButtonBackgroundColorDisabled: iconFormButtonBackgroundColorDisabled,
      iconFormButtonBorderColor: iconFormButtonBorderColor,
      iconFormButtonBorderColorHighlighted: iconFormButtonBorderColorHighlighted,
      iconFormButtonBorderColorDisabled: iconFormButtonBorderColorDisabled,
      iconFormButtonIconColor: iconFormButtonIconColor,
      iconFormButtonIconColorHighlighted: iconFormButtonIconColorHighlighted,
      iconFormButtonIconColorDisabled: iconFormButtonIconColorDisabled,

      // IconTextButton
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor,
      iconTextButtonBackgroundColorHighlighted: iconTextButtonBackgroundColorHighlighted,
      iconTextButtonBackgroundColorDisabled: iconTextButtonBackgroundColorDisabled,
      iconTextButtonIconColor: iconTextButtonIconColor,
      iconTextButtonIconColorHighlighted: iconTextButtonIconColorHighlighted,
      iconTextButtonIconColorDisabled: iconTextButtonIconColorDisabled,
      iconTextButtonTextStyle: iconTextButtonTextStyle,
      iconTextButtonTextStyleHighlighted: iconTextButtonTextStyleHighlighted,
      iconTextButtonTextStyleDisabled: iconTextButtonTextStyleDisabled,

      // Link
      linkTextStyle: linkTextStyle,
      linkTextStyleHighlighted: linkTextStyleHighlighted,

      //ListHeader
      listHeaderTextStyle: listHeaderTextStyle,

      // ListItem
      listItemBackgroundColor: listItemBackgroundColor,
      listItemBackgroundColorHighlighted: listItemBackgroundColorHighlighted,
      listItemTitleTextStyle: listItemTitleTextStyle,
      listItemSubtitleTextStyle: listItemSubtitleTextStyle,

      // Checkbox
      checkboxColor: checkboxColor,
      checkboxColorDisabled: checkboxColorDisabled,
      checkboxBackgroundColor: checkboxBackgroundColor,
      checkboxBackgroundColorHighlighted: checkboxBackgroundColorHighlighted,
      checkboxBackgroundColorDisabled: checkboxBackgroundColorDisabled,
      checkboxBorderColor: checkboxBorderColor,
      checkboxBorderColorDisabled: checkboxBorderColorDisabled,
      checkboxListItemBackgroundColor: checkboxListItemBackgroundColor,
      checkboxListItemBackgroundColorHighlighted: checkboxListItemBackgroundColorHighlighted,
      checkboxListItemBackgroundColorDisabled: checkboxListItemBackgroundColorDisabled,
      checkboxListItemIconColor: checkboxListItemIconColor,
      checkboxListItemIconColorDisabled: checkboxListItemIconColorDisabled,
      checkboxListItemTextStyle: checkboxListItemTextStyle,
      checkboxListItemTextStyleDisabled: checkboxListItemTextStyleDisabled,
      checkboxListItemSecondaryTextStyle: checkboxListItemSecondaryTextStyle,
      checkboxListItemSecondaryTextStyleDisabled: checkboxListItemSecondaryTextStyleDisabled,

      // RadioButton
      radioButtonColor: radioButtonColor,
      radioButtonColorDisabled: radioButtonColorDisabled,
      radioButtonBackgroundColor: radioButtonBackgroundColor,
      radioButtonBackgroundColorHighlighted: radioButtonBackgroundColorHighlighted,
      radioButtonBackgroundColorDisabled: radioButtonBackgroundColorDisabled,
      radioButtonBorderColor: radioButtonBorderColor,
      radioButtonBorderColorDisabled: radioButtonBorderColorDisabled,
      radioButtonListItemBackgroundColor: radioButtonListItemBackgroundColor,
      radioButtonListItemBackgroundColorHighlighted: radioButtonListItemBackgroundColorHighlighted,
      radioButtonListItemBackgroundColorDisabled: radioButtonListItemBackgroundColorDisabled,
      radioButtonListItemIconColor: radioButtonListItemIconColor,
      radioButtonListItemIconColorDisabled: radioButtonListItemIconColorDisabled,
      radioButtonListItemTextStyle: radioButtonListItemTextStyle,
      radioButtonListItemTextStyleDisabled: radioButtonListItemTextStyleDisabled,
      radioButtonListItemSecondaryTextStyle: radioButtonListItemSecondaryTextStyle,
      radioButtonListItemSecondaryTextStyleDisabled: radioButtonListItemSecondaryTextStyleDisabled,

      // SegmentedButton
      segmentedButtonBackgroundColor: segmentedButtonBackgroundColor,
      segmentedButtonSelectedColor: segmentedButtonSelectedColor,
      segmentedButtonTextStyle: segmentedButtonTextStyle,

      // TextField
      textFieldTextStyle: textFieldTextStyle,
      textFieldTextStyleDisabled: textFieldTextStyleDisabled,
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle,
      textFieldPlaceholderTextStyleDisabled: textFieldPlaceholderTextStyleDisabled,
      textFieldErrorTextStyle: textFieldErrorTextStyle,
      textFieldDividerColor: textFieldDividerColor,
      textFieldDividerColorHighlighted: textFieldDividerColorHighlighted,
      textFieldDividerColorError: textFieldDividerColorError,
      textFieldCursorColor: textFieldCursorColor,
      textFieldSelectionColor: textFieldSelectionColor,
      textFieldSelectionHandleColor: textFieldSelectionHandleColor,
      textFieldIconColor: textFieldIconColor,
      textFieldIconColorDisabled: textFieldIconColorDisabled,

      // Group
      groupBackgroundColor: groupBackgroundColor,

      // Accordion
      accordionTitleTextStyle: accordionTitleTextStyle,
      accordionBodyTextStyle: accordionBodyTextStyle,
      accordionBackgroundColor: accordionBackgroundColor,

      // Modal
      modalBackgroundColor: modalBackgroundColor,
      modalTitleTextStyle: modalTitleTextStyle,

      // Select
      selectLabelTextStyle: selectLabelTextStyle,
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled,

      // Toast
      toastTextStyle: toastTextStyle,
      toastBackgroundColor: toastBackgroundColor,

      // Tab Bar
      tabBarTextStyle: tabBarTextStyle,
    );
  }

  SBBThemeData.dark({
    Brightness? brightness = Brightness.dark,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,

    // PrimaryButton
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonBackgroundColorHighlighted,
    Color? primaryButtonBackgroundColorDisabled,
    Color? primaryButtonBackgroundColorLoading,
    TextStyle? primaryButtonTextStyle,
    TextStyle? primaryButtonTextStyleHighlighted,
    TextStyle? primaryButtonTextStyleDisabled,
    TextStyle? primaryButtonTextStyleLoading,

    // PrimaryButtonNegative
    Color? primaryButtonNegativeBackgroundColor,
    Color? primaryButtonNegativeBackgroundColorHighlighted,
    Color? primaryButtonNegativeBackgroundColorDisabled,
    Color? primaryButtonNegativeBackgroundColorLoading,
    Color? primaryButtonNegativeBorderColor,
    Color? primaryButtonNegativeBorderColorHighlighted,
    Color? primaryButtonNegativeBorderColorDisabled,
    Color? primaryButtonNegativeBorderColorLoading,
    TextStyle? primaryButtonNegativeTextStyle,
    TextStyle? primaryButtonNegativeTextStyleHighlighted,
    TextStyle? primaryButtonNegativeTextStyleDisabled,
    TextStyle? primaryButtonNegativeTextStyleLoading,

    // SecondaryButton
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonBackgroundColorHighlighted,
    Color? secondaryButtonBackgroundColorDisabled,
    Color? secondaryButtonBackgroundColorLoading,
    Color? secondaryButtonBorderColor,
    Color? secondaryButtonBorderColorHighlighted,
    Color? secondaryButtonBorderColorDisabled,
    Color? secondaryButtonBorderColorLoading,
    TextStyle? secondaryButtonTextStyle,
    TextStyle? secondaryButtonTextStyleHighlighted,
    TextStyle? secondaryButtonTextStyleDisabled,
    TextStyle? secondaryButtonTextStyleLoading,

    // TertiaryButtonLarge
    Color? tertiaryButtonLargeBackgroundColor,
    Color? tertiaryButtonLargeBackgroundColorHighlighted,
    Color? tertiaryButtonLargeBackgroundColorDisabled,
    Color? tertiaryButtonLargeBorderColor,
    Color? tertiaryButtonLargeBorderColorHighlighted,
    Color? tertiaryButtonLargeBorderColorDisabled,
    TextStyle? tertiaryButtonLargeTextStyle,
    TextStyle? tertiaryButtonLargeTextStyleHighlighted,
    TextStyle? tertiaryButtonLargeTextStyleDisabled,

    // TertiaryButtonSmall
    Color? tertiaryButtonSmallBackgroundColor,
    Color? tertiaryButtonSmallBackgroundColorHighlighted,
    Color? tertiaryButtonSmallBackgroundColorDisabled,
    Color? tertiaryButtonSmallBorderColor,
    Color? tertiaryButtonSmallBorderColorHighlighted,
    Color? tertiaryButtonSmallBorderColorDisabled,
    TextStyle? tertiaryButtonSmallTextStyle,
    TextStyle? tertiaryButtonSmallTextStyleHighlighted,
    TextStyle? tertiaryButtonSmallTextStyleDisabled,

    // IconButtonLarge
    Color? iconButtonLargeBackgroundColor,
    Color? iconButtonLargeBackgroundColorHighlighted,
    Color? iconButtonLargeBackgroundColorDisabled,
    Color? iconButtonLargeBorderColor,
    Color? iconButtonLargeBorderColorHighlighted,
    Color? iconButtonLargeBorderColorDisabled,
    Color? iconButtonLargeIconColor,
    Color? iconButtonLargeIconColorHighlighted,
    Color? iconButtonLargeIconColorDisabled,

    // IconButtonSmall
    Color? iconButtonSmallBackgroundColor,
    Color? iconButtonSmallBackgroundColorHighlighted,
    Color? iconButtonSmallBackgroundColorDisabled,
    Color? iconButtonSmallBorderColor,
    Color? iconButtonSmallBorderColorHighlighted,
    Color? iconButtonSmallBorderColorDisabled,
    Color? iconButtonSmallIconColor,
    Color? iconButtonSmallIconColorHighlighted,
    Color? iconButtonSmallIconColorDisabled,

    // IconButtonSmallNegative
    Color? iconButtonSmallNegativeBackgroundColor,
    Color? iconButtonSmallNegativeBackgroundColorHighlighted,
    Color? iconButtonSmallNegativeBackgroundColorDisabled,
    Color? iconButtonSmallNegativeBorderColor,
    Color? iconButtonSmallNegativeBorderColorHighlighted,
    Color? iconButtonSmallNegativeBorderColorDisabled,
    Color? iconButtonSmallNegativeIconColor,
    Color? iconButtonSmallNegativeIconColorHighlighted,
    Color? iconButtonSmallNegativeIconColorDisabled,

    // IconButtonSmallBorderless
    Color? iconButtonSmallBorderlessBackgroundColor,
    Color? iconButtonSmallBorderlessBackgroundColorHighlighted,
    Color? iconButtonSmallBorderlessBackgroundColorDisabled,
    Color? iconButtonSmallBorderlessIconColor,
    Color? iconButtonSmallBorderlessIconColorHighlighted,
    Color? iconButtonSmallBorderlessIconColorDisabled,

    // IconFormButton
    Color? iconFormButtonBackgroundColor,
    Color? iconFormButtonBackgroundColorHighlighted,
    Color? iconFormButtonBackgroundColorDisabled,
    Color? iconFormButtonBorderColor,
    Color? iconFormButtonBorderColorHighlighted,
    Color? iconFormButtonBorderColorDisabled,
    Color? iconFormButtonIconColor,
    Color? iconFormButtonIconColorHighlighted,
    Color? iconFormButtonIconColorDisabled,

    // IconTextButton
    Color? iconTextButtonBackgroundColor,
    Color? iconTextButtonBackgroundColorHighlighted,
    Color? iconTextButtonBackgroundColorDisabled,
    Color? iconTextButtonIconColor,
    Color? iconTextButtonIconColorHighlighted,
    Color? iconTextButtonIconColorDisabled,
    TextStyle? iconTextButtonTextStyle,
    TextStyle? iconTextButtonTextStyleHighlighted,
    TextStyle? iconTextButtonTextStyleDisabled,

    // Link
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,

    //ListHeader
    TextStyle? listHeaderTextStyle,

    // ListItem
    Color? listItemBackgroundColor,
    Color? listItemBackgroundColorHighlighted,
    TextStyle? listItemTitleTextStyle,
    TextStyle? listItemSubtitleTextStyle,

    // Checkbox
    Color? checkboxColor,
    Color? checkboxColorDisabled,
    Color? checkboxBackgroundColor,
    Color? checkboxBackgroundColorHighlighted,
    Color? checkboxBackgroundColorDisabled,
    Color? checkboxBorderColor,
    Color? checkboxBorderColorDisabled,
    Color? checkboxListItemBackgroundColor,
    Color? checkboxListItemBackgroundColorHighlighted,
    Color? checkboxListItemBackgroundColorDisabled,
    Color? checkboxListItemIconColor,
    Color? checkboxListItemIconColorDisabled,
    TextStyle? checkboxListItemTextStyle,
    TextStyle? checkboxListItemTextStyleDisabled,
    TextStyle? checkboxListItemSecondaryTextStyle,
    TextStyle? checkboxListItemSecondaryTextStyleDisabled,

    // RadioButton
    Color? radioButtonColor,
    Color? radioButtonColorDisabled,
    Color? radioButtonBackgroundColor,
    Color? radioButtonBackgroundColorHighlighted,
    Color? radioButtonBackgroundColorDisabled,
    Color? radioButtonBorderColor,
    Color? radioButtonBorderColorDisabled,
    Color? radioButtonListItemBackgroundColor,
    Color? radioButtonListItemBackgroundColorHighlighted,
    Color? radioButtonListItemBackgroundColorDisabled,
    Color? radioButtonListItemIconColor,
    Color? radioButtonListItemIconColorDisabled,
    TextStyle? radioButtonListItemTextStyle,
    TextStyle? radioButtonListItemTextStyleDisabled,
    TextStyle? radioButtonListItemSecondaryTextStyle,
    TextStyle? radioButtonListItemSecondaryTextStyleDisabled,

    // SegmentedButton
    Color? segmentedButtonBackgroundColor,
    Color? segmentedButtonSelectedColor,
    TextStyle? segmentedButtonTextStyle,

    // TextField
    TextStyle? textFieldTextStyle,
    TextStyle? textFieldTextStyleDisabled,
    TextStyle? textFieldPlaceholderTextStyle,
    TextStyle? textFieldPlaceholderTextStyleDisabled,
    TextStyle? textFieldErrorTextStyle,
    Color? textFieldDividerColor,
    Color? textFieldDividerColorHighlighted,
    Color? textFieldDividerColorError,
    Color? textFieldCursorColor,
    Color? textFieldSelectionColor,
    Color? textFieldSelectionHandleColor,
    Color? textFieldIconColor,
    Color? textFieldIconColorDisabled,

    // Group
    Color? groupBackgroundColor,

    // Accordion
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,

    // Modal
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,

    // Select
    TextStyle? selectLabelTextStyle,
    TextStyle? selectLabelTextStyleDisabled,

    // Toast
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,

    // Tab Bar
    TextStyle? tabBarTextStyle,
  }) {
    _setDefaultValues(
      brightness: brightness,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor,
      fontFamily: fontFamily,
      defaultTextColor: defaultTextColor,
      defaultTextStyle: defaultTextStyle,
      dividerColor: dividerColor,
      defaultRootContainerPadding: defaultRootContainerPadding,

      // Icon
      iconColor: iconColor,

      // Header
      headerBackgroundColor: headerBackgroundColor,
      headerButtonBackgroundColorHighlighted: headerButtonBackgroundColorHighlighted,
      headerIconColor: headerIconColor,
      headerTextStyle: headerTextStyle,

      // PrimaryButton
      primaryButtonBackgroundColor: primaryButtonBackgroundColor,
      primaryButtonBackgroundColorHighlighted: primaryButtonBackgroundColorHighlighted,
      primaryButtonBackgroundColorDisabled: primaryButtonBackgroundColorDisabled,
      primaryButtonBackgroundColorLoading: primaryButtonBackgroundColorLoading,
      primaryButtonTextStyle: primaryButtonTextStyle,
      primaryButtonTextStyleHighlighted: primaryButtonTextStyleHighlighted,
      primaryButtonTextStyleDisabled: primaryButtonTextStyleDisabled,
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading,

      // PrimaryButtonNegative
      primaryButtonNegativeBackgroundColor: primaryButtonNegativeBackgroundColor,
      primaryButtonNegativeBackgroundColorHighlighted: primaryButtonNegativeBackgroundColorHighlighted,
      primaryButtonNegativeBackgroundColorDisabled: primaryButtonNegativeBackgroundColorDisabled,
      primaryButtonNegativeBackgroundColorLoading: primaryButtonNegativeBackgroundColorLoading,
      primaryButtonNegativeBorderColor: primaryButtonNegativeBorderColor,
      primaryButtonNegativeBorderColorHighlighted: primaryButtonNegativeBorderColorHighlighted,
      primaryButtonNegativeBorderColorDisabled: primaryButtonNegativeBorderColorDisabled,
      primaryButtonNegativeBorderColorLoading: primaryButtonNegativeBorderColorLoading,
      primaryButtonNegativeTextStyle: primaryButtonNegativeTextStyle,
      primaryButtonNegativeTextStyleHighlighted: primaryButtonNegativeTextStyleHighlighted,
      primaryButtonNegativeTextStyleDisabled: primaryButtonNegativeTextStyleDisabled,
      primaryButtonNegativeTextStyleLoading: primaryButtonNegativeTextStyleLoading,

      // SecondaryButton
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor,
      secondaryButtonBackgroundColorHighlighted: secondaryButtonBackgroundColorHighlighted,
      secondaryButtonBackgroundColorDisabled: secondaryButtonBackgroundColorDisabled,
      secondaryButtonBackgroundColorLoading: secondaryButtonBackgroundColorLoading,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
      secondaryButtonBorderColorHighlighted: secondaryButtonBorderColorHighlighted,
      secondaryButtonBorderColorDisabled: secondaryButtonBorderColorDisabled,
      secondaryButtonBorderColorLoading: secondaryButtonBorderColorLoading,
      secondaryButtonTextStyle: secondaryButtonTextStyle,
      secondaryButtonTextStyleHighlighted: secondaryButtonTextStyleHighlighted,
      secondaryButtonTextStyleDisabled: secondaryButtonTextStyleDisabled,
      secondaryButtonTextStyleLoading: secondaryButtonTextStyleLoading,

      // TertiaryButtonLarge
      tertiaryButtonLargeBackgroundColor: tertiaryButtonLargeBackgroundColor,
      tertiaryButtonLargeBackgroundColorHighlighted: tertiaryButtonLargeBackgroundColorHighlighted,
      tertiaryButtonLargeBackgroundColorDisabled: tertiaryButtonLargeBackgroundColorDisabled,
      tertiaryButtonLargeBorderColor: tertiaryButtonLargeBorderColor,
      tertiaryButtonLargeBorderColorHighlighted: tertiaryButtonLargeBorderColorHighlighted,
      tertiaryButtonLargeBorderColorDisabled: tertiaryButtonLargeBorderColorDisabled,
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle,
      tertiaryButtonLargeTextStyleHighlighted: tertiaryButtonLargeTextStyleHighlighted,
      tertiaryButtonLargeTextStyleDisabled: tertiaryButtonLargeTextStyleDisabled,

      // TertiaryButtonSmall
      tertiaryButtonSmallBackgroundColor: tertiaryButtonSmallBackgroundColor,
      tertiaryButtonSmallBackgroundColorHighlighted: tertiaryButtonSmallBackgroundColorHighlighted,
      tertiaryButtonSmallBackgroundColorDisabled: tertiaryButtonSmallBackgroundColorDisabled,
      tertiaryButtonSmallBorderColor: tertiaryButtonSmallBorderColor,
      tertiaryButtonSmallBorderColorHighlighted: tertiaryButtonSmallBorderColorHighlighted,
      tertiaryButtonSmallBorderColorDisabled: tertiaryButtonSmallBorderColorDisabled,
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle,
      tertiaryButtonSmallTextStyleHighlighted: tertiaryButtonSmallTextStyleHighlighted,
      tertiaryButtonSmallTextStyleDisabled: tertiaryButtonSmallTextStyleDisabled,

      // IconButtonLarge
      iconButtonLargeBackgroundColor: iconButtonLargeBackgroundColor,
      iconButtonLargeBackgroundColorHighlighted: iconButtonLargeBackgroundColorHighlighted,
      iconButtonLargeBackgroundColorDisabled: iconButtonLargeBackgroundColorDisabled,
      iconButtonLargeBorderColor: iconButtonLargeBorderColor,
      iconButtonLargeBorderColorHighlighted: iconButtonLargeBorderColorHighlighted,
      iconButtonLargeBorderColorDisabled: iconButtonLargeBorderColorDisabled,
      iconButtonLargeIconColor: iconButtonLargeIconColor,
      iconButtonLargeIconColorHighlighted: iconButtonLargeIconColorHighlighted,
      iconButtonLargeIconColorDisabled: iconButtonLargeIconColorDisabled,

      // IconButtonSmall
      iconButtonSmallBackgroundColor: iconButtonSmallBackgroundColor,
      iconButtonSmallBackgroundColorHighlighted: iconButtonSmallBackgroundColorHighlighted,
      iconButtonSmallBackgroundColorDisabled: iconButtonSmallBackgroundColorDisabled,
      iconButtonSmallBorderColor: iconButtonSmallBorderColor,
      iconButtonSmallBorderColorHighlighted: iconButtonSmallBorderColorHighlighted,
      iconButtonSmallBorderColorDisabled: iconButtonSmallBorderColorDisabled,
      iconButtonSmallIconColor: iconButtonSmallIconColor,
      iconButtonSmallIconColorHighlighted: iconButtonSmallIconColorHighlighted,
      iconButtonSmallIconColorDisabled: iconButtonSmallIconColorDisabled,

      // IconButtonSmallNegative
      iconButtonSmallNegativeBackgroundColor: iconButtonSmallNegativeBackgroundColor,
      iconButtonSmallNegativeBackgroundColorHighlighted: iconButtonSmallNegativeBackgroundColorHighlighted,
      iconButtonSmallNegativeBackgroundColorDisabled: iconButtonSmallNegativeBackgroundColorDisabled,
      iconButtonSmallNegativeBorderColor: iconButtonSmallNegativeBorderColor,
      iconButtonSmallNegativeBorderColorHighlighted: iconButtonSmallNegativeBorderColorHighlighted,
      iconButtonSmallNegativeBorderColorDisabled: iconButtonSmallNegativeBorderColorDisabled,
      iconButtonSmallNegativeIconColor: iconButtonSmallNegativeIconColor,
      iconButtonSmallNegativeIconColorHighlighted: iconButtonSmallNegativeIconColorHighlighted,
      iconButtonSmallNegativeIconColorDisabled: iconButtonSmallNegativeIconColorDisabled,

      // IconButtonSmallBorderless
      iconButtonSmallBorderlessBackgroundColor: iconButtonSmallBorderlessBackgroundColor,
      iconButtonSmallBorderlessBackgroundColorHighlighted: iconButtonSmallBorderlessBackgroundColorHighlighted,
      iconButtonSmallBorderlessBackgroundColorDisabled: iconButtonSmallBorderlessBackgroundColorDisabled,
      iconButtonSmallBorderlessIconColor: iconButtonSmallBorderlessIconColor,
      iconButtonSmallBorderlessIconColorHighlighted: iconButtonSmallBorderlessIconColorHighlighted,
      iconButtonSmallBorderlessIconColorDisabled: iconButtonSmallBorderlessIconColorDisabled,

      // IconFormButton
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor,
      iconFormButtonBackgroundColorHighlighted: iconFormButtonBackgroundColorHighlighted,
      iconFormButtonBackgroundColorDisabled: iconFormButtonBackgroundColorDisabled,
      iconFormButtonBorderColor: iconFormButtonBorderColor,
      iconFormButtonBorderColorHighlighted: iconFormButtonBorderColorHighlighted,
      iconFormButtonBorderColorDisabled: iconFormButtonBorderColorDisabled,
      iconFormButtonIconColor: iconFormButtonIconColor,
      iconFormButtonIconColorHighlighted: iconFormButtonIconColorHighlighted,
      iconFormButtonIconColorDisabled: iconFormButtonIconColorDisabled,

      // IconTextButton
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor,
      iconTextButtonBackgroundColorHighlighted: iconTextButtonBackgroundColorHighlighted,
      iconTextButtonBackgroundColorDisabled: iconTextButtonBackgroundColorDisabled,
      iconTextButtonIconColor: iconTextButtonIconColor,
      iconTextButtonIconColorHighlighted: iconTextButtonIconColorHighlighted,
      iconTextButtonIconColorDisabled: iconTextButtonIconColorDisabled,
      iconTextButtonTextStyle: iconTextButtonTextStyle,
      iconTextButtonTextStyleHighlighted: iconTextButtonTextStyleHighlighted,
      iconTextButtonTextStyleDisabled: iconTextButtonTextStyleDisabled,

      // Link
      linkTextStyle: linkTextStyle,
      linkTextStyleHighlighted: linkTextStyleHighlighted,

      //ListHeader
      listHeaderTextStyle: listHeaderTextStyle,

      // ListItem
      listItemBackgroundColor: listItemBackgroundColor,
      listItemBackgroundColorHighlighted: listItemBackgroundColorHighlighted,
      listItemTitleTextStyle: listItemTitleTextStyle,
      listItemSubtitleTextStyle: listItemSubtitleTextStyle,

      // Checkbox
      checkboxColor: checkboxColor,
      checkboxColorDisabled: checkboxColorDisabled,
      checkboxBackgroundColor: checkboxBackgroundColor,
      checkboxBackgroundColorHighlighted: checkboxBackgroundColorHighlighted,
      checkboxBackgroundColorDisabled: checkboxBackgroundColorDisabled,
      checkboxBorderColor: checkboxBorderColor,
      checkboxBorderColorDisabled: checkboxBorderColorDisabled,
      checkboxListItemBackgroundColor: checkboxListItemBackgroundColor,
      checkboxListItemBackgroundColorHighlighted: checkboxListItemBackgroundColorHighlighted,
      checkboxListItemBackgroundColorDisabled: checkboxListItemBackgroundColorDisabled,
      checkboxListItemIconColor: checkboxListItemIconColor,
      checkboxListItemIconColorDisabled: checkboxListItemIconColorDisabled,
      checkboxListItemTextStyle: checkboxListItemTextStyle,
      checkboxListItemTextStyleDisabled: checkboxListItemTextStyleDisabled,
      checkboxListItemSecondaryTextStyle: checkboxListItemSecondaryTextStyle,
      checkboxListItemSecondaryTextStyleDisabled: checkboxListItemSecondaryTextStyleDisabled,

      // RadioButton
      radioButtonColor: radioButtonColor,
      radioButtonColorDisabled: radioButtonColorDisabled,
      radioButtonBackgroundColor: radioButtonBackgroundColor,
      radioButtonBackgroundColorHighlighted: radioButtonBackgroundColorHighlighted,
      radioButtonBackgroundColorDisabled: radioButtonBackgroundColorDisabled,
      radioButtonBorderColor: radioButtonBorderColor,
      radioButtonBorderColorDisabled: radioButtonBorderColorDisabled,
      radioButtonListItemBackgroundColor: radioButtonListItemBackgroundColor,
      radioButtonListItemBackgroundColorHighlighted: radioButtonListItemBackgroundColorHighlighted,
      radioButtonListItemBackgroundColorDisabled: radioButtonListItemBackgroundColorDisabled,
      radioButtonListItemIconColor: radioButtonListItemIconColor,
      radioButtonListItemIconColorDisabled: radioButtonListItemIconColorDisabled,
      radioButtonListItemTextStyle: radioButtonListItemTextStyle,
      radioButtonListItemTextStyleDisabled: radioButtonListItemTextStyleDisabled,
      radioButtonListItemSecondaryTextStyle: radioButtonListItemSecondaryTextStyle,
      radioButtonListItemSecondaryTextStyleDisabled: radioButtonListItemSecondaryTextStyleDisabled,

      // SegmentedButton
      segmentedButtonBackgroundColor: segmentedButtonBackgroundColor,
      segmentedButtonSelectedColor: segmentedButtonSelectedColor,
      segmentedButtonTextStyle: segmentedButtonTextStyle,

      // TextField
      textFieldTextStyle: textFieldTextStyle,
      textFieldTextStyleDisabled: textFieldTextStyleDisabled,
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle,
      textFieldPlaceholderTextStyleDisabled: textFieldPlaceholderTextStyleDisabled,
      textFieldErrorTextStyle: textFieldErrorTextStyle,
      textFieldDividerColor: textFieldDividerColor,
      textFieldDividerColorHighlighted: textFieldDividerColorHighlighted,
      textFieldDividerColorError: textFieldDividerColorError,
      textFieldCursorColor: textFieldCursorColor,
      textFieldSelectionColor: textFieldSelectionColor,
      textFieldSelectionHandleColor: textFieldSelectionHandleColor,
      textFieldIconColor: textFieldIconColor,
      textFieldIconColorDisabled: textFieldIconColorDisabled,

      // Group
      groupBackgroundColor: groupBackgroundColor,

      // Accordion
      accordionTitleTextStyle: accordionTitleTextStyle,
      accordionBodyTextStyle: accordionBodyTextStyle,
      accordionBackgroundColor: accordionBackgroundColor,

      // Modal
      modalBackgroundColor: modalBackgroundColor,
      modalTitleTextStyle: modalTitleTextStyle,

      // Select
      selectLabelTextStyle: selectLabelTextStyle,
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled,

      // Toast
      toastTextStyle: toastTextStyle,
      toastBackgroundColor: toastBackgroundColor,

      // Tab Bar
      tabBarTextStyle: tabBarTextStyle,
    );
  }

  late Brightness brightness;
  late Color primaryColor;
  late Color primaryColorDark;
  late MaterialColor primarySwatch;
  late Color backgroundColor;
  late String fontFamily;
  late Color defaultTextColor;
  late TextStyle defaultTextStyle;
  late Color dividerColor;
  late double defaultRootContainerPadding;

  // Icon
  late Color iconColor;

  // Header
  late Color headerBackgroundColor;
  late Color headerButtonBackgroundColorHighlighted;
  late Color headerIconColor;
  late TextStyle headerTextStyle;

  // PrimaryButton
  late Color primaryButtonBackgroundColor;
  late Color primaryButtonBackgroundColorHighlighted;
  late Color primaryButtonBackgroundColorDisabled;
  late Color primaryButtonBackgroundColorLoading;
  late TextStyle primaryButtonTextStyle;
  late TextStyle primaryButtonTextStyleHighlighted;
  late TextStyle primaryButtonTextStyleDisabled;
  late TextStyle primaryButtonTextStyleLoading;

  // PrimaryButtonNegative
  late Color primaryButtonNegativeBackgroundColor;
  late Color primaryButtonNegativeBackgroundColorHighlighted;
  late Color primaryButtonNegativeBackgroundColorDisabled;
  late Color primaryButtonNegativeBackgroundColorLoading;
  late Color primaryButtonNegativeBorderColor;
  late Color primaryButtonNegativeBorderColorHighlighted;
  late Color primaryButtonNegativeBorderColorDisabled;
  late Color primaryButtonNegativeBorderColorLoading;
  late TextStyle primaryButtonNegativeTextStyle;
  late TextStyle primaryButtonNegativeTextStyleHighlighted;
  late TextStyle primaryButtonNegativeTextStyleDisabled;
  late TextStyle primaryButtonNegativeTextStyleLoading;

  // SecondaryButton
  late Color secondaryButtonBackgroundColor;
  late Color secondaryButtonBackgroundColorHighlighted;
  late Color secondaryButtonBackgroundColorDisabled;
  late Color secondaryButtonBackgroundColorLoading;
  late Color secondaryButtonBorderColor;
  late Color secondaryButtonBorderColorHighlighted;
  late Color secondaryButtonBorderColorDisabled;
  late Color secondaryButtonBorderColorLoading;
  late TextStyle secondaryButtonTextStyle;
  late TextStyle secondaryButtonTextStyleHighlighted;
  late TextStyle secondaryButtonTextStyleDisabled;
  late TextStyle secondaryButtonTextStyleLoading;

  // TertiaryButtonLarge
  late Color tertiaryButtonLargeBackgroundColor;
  late Color tertiaryButtonLargeBackgroundColorHighlighted;
  late Color tertiaryButtonLargeBackgroundColorDisabled;
  late Color tertiaryButtonLargeBorderColor;
  late Color tertiaryButtonLargeBorderColorHighlighted;
  late Color tertiaryButtonLargeBorderColorDisabled;
  late TextStyle tertiaryButtonLargeTextStyle;
  late TextStyle tertiaryButtonLargeTextStyleHighlighted;
  late TextStyle tertiaryButtonLargeTextStyleDisabled;

  // TertiaryButtonSmall
  late Color tertiaryButtonSmallBackgroundColor;
  late Color tertiaryButtonSmallBackgroundColorHighlighted;
  late Color tertiaryButtonSmallBackgroundColorDisabled;
  late Color tertiaryButtonSmallBorderColor;
  late Color tertiaryButtonSmallBorderColorHighlighted;
  late Color tertiaryButtonSmallBorderColorDisabled;
  late TextStyle tertiaryButtonSmallTextStyle;
  late TextStyle tertiaryButtonSmallTextStyleHighlighted;
  late TextStyle tertiaryButtonSmallTextStyleDisabled;

  // IconButtonLarge
  late Color iconButtonLargeBackgroundColor;
  late Color iconButtonLargeBackgroundColorHighlighted;
  late Color iconButtonLargeBackgroundColorDisabled;
  late Color iconButtonLargeBorderColor;
  late Color iconButtonLargeBorderColorHighlighted;
  late Color iconButtonLargeBorderColorDisabled;
  late Color iconButtonLargeIconColor;
  late Color iconButtonLargeIconColorHighlighted;
  late Color iconButtonLargeIconColorDisabled;

  // IconButtonSmall
  late Color iconButtonSmallBackgroundColor;
  late Color iconButtonSmallBackgroundColorHighlighted;
  late Color iconButtonSmallBackgroundColorDisabled;
  late Color iconButtonSmallBorderColor;
  late Color iconButtonSmallBorderColorHighlighted;
  late Color iconButtonSmallBorderColorDisabled;
  late Color iconButtonSmallIconColor;
  late Color iconButtonSmallIconColorHighlighted;
  late Color iconButtonSmallIconColorDisabled;

  // IconButtonSmallNegative
  late Color iconButtonSmallNegativeBackgroundColor;
  late Color iconButtonSmallNegativeBackgroundColorHighlighted;
  late Color iconButtonSmallNegativeBackgroundColorDisabled;
  late Color iconButtonSmallNegativeBorderColor;
  late Color iconButtonSmallNegativeBorderColorHighlighted;
  late Color iconButtonSmallNegativeBorderColorDisabled;
  late Color iconButtonSmallNegativeIconColor;
  late Color iconButtonSmallNegativeIconColorHighlighted;
  late Color iconButtonSmallNegativeIconColorDisabled;

  // IconButtonSmallBorderless
  late Color iconButtonSmallBorderlessBackgroundColor;
  late Color iconButtonSmallBorderlessBackgroundColorHighlighted;
  late Color iconButtonSmallBorderlessBackgroundColorDisabled;
  late Color iconButtonSmallBorderlessIconColor;
  late Color iconButtonSmallBorderlessIconColorHighlighted;
  late Color iconButtonSmallBorderlessIconColorDisabled;

  // IconFormButton
  late Color iconFormButtonBackgroundColor;
  late Color iconFormButtonBackgroundColorHighlighted;
  late Color iconFormButtonBackgroundColorDisabled;
  late Color iconFormButtonBorderColor;
  late Color iconFormButtonBorderColorHighlighted;
  late Color iconFormButtonBorderColorDisabled;
  late Color iconFormButtonIconColor;
  late Color iconFormButtonIconColorHighlighted;
  late Color iconFormButtonIconColorDisabled;

  // IconTextButton
  late Color iconTextButtonBackgroundColor;
  late Color iconTextButtonBackgroundColorHighlighted;
  late Color iconTextButtonBackgroundColorDisabled;
  late Color iconTextButtonIconColor;
  late Color iconTextButtonIconColorHighlighted;
  late Color iconTextButtonIconColorDisabled;
  late TextStyle iconTextButtonTextStyle;
  late TextStyle iconTextButtonTextStyleHighlighted;
  late TextStyle iconTextButtonTextStyleDisabled;

  // Link
  late TextStyle linkTextStyle;
  late TextStyle linkTextStyleHighlighted;

  //ListHeader
  late TextStyle listHeaderTextStyle;

  // ListItem
  late Color listItemBackgroundColor;
  late Color listItemBackgroundColorHighlighted;
  late TextStyle listItemTitleTextStyle;
  late TextStyle listItemSubtitleTextStyle;

  // Checkbox
  late Color checkboxColor;
  late Color checkboxColorDisabled;
  late Color checkboxBackgroundColor;
  late Color checkboxBackgroundColorHighlighted;
  late Color checkboxBackgroundColorDisabled;
  late Color checkboxBorderColor;
  late Color checkboxBorderColorDisabled;
  late Color checkboxListItemBackgroundColor;
  late Color checkboxListItemBackgroundColorHighlighted;
  late Color checkboxListItemBackgroundColorDisabled;
  late Color checkboxListItemIconColor;
  late Color checkboxListItemIconColorDisabled;
  late TextStyle checkboxListItemTextStyle;
  late TextStyle checkboxListItemTextStyleDisabled;
  late TextStyle checkboxListItemSecondaryTextStyle;
  late TextStyle checkboxListItemSecondaryTextStyleDisabled;

  // RadioButton
  late Color radioButtonColor;
  late Color radioButtonColorDisabled;
  late Color radioButtonBackgroundColor;
  late Color radioButtonBackgroundColorHighlighted;
  late Color radioButtonBackgroundColorDisabled;
  late Color radioButtonBorderColor;
  late Color radioButtonBorderColorDisabled;
  late Color radioButtonListItemBackgroundColor;
  late Color radioButtonListItemBackgroundColorHighlighted;
  late Color radioButtonListItemBackgroundColorDisabled;
  late Color radioButtonListItemIconColor;
  late Color radioButtonListItemIconColorDisabled;
  late TextStyle radioButtonListItemTextStyle;
  late TextStyle radioButtonListItemTextStyleDisabled;
  late TextStyle radioButtonListItemSecondaryTextStyle;
  late TextStyle radioButtonListItemSecondaryTextStyleDisabled;

  // SegmentedButton
  late Color segmentedButtonBackgroundColor;
  late Color segmentedButtonSelectedColor;
  late TextStyle segmentedButtonTextStyle;

  // TextField
  late TextStyle textFieldTextStyle;
  late TextStyle textFieldTextStyleDisabled;
  late TextStyle textFieldPlaceholderTextStyle;
  late TextStyle textFieldPlaceholderTextStyleDisabled;
  late TextStyle textFieldErrorTextStyle;
  late Color textFieldDividerColor;
  late Color textFieldDividerColorHighlighted;
  late Color textFieldDividerColorError;
  late Color textFieldCursorColor;
  late Color textFieldSelectionColor;
  late Color textFieldSelectionHandleColor;
  late Color textFieldIconColor;
  late Color textFieldIconColorDisabled;

  // Group
  late Color groupBackgroundColor;

  // Accordion
  late TextStyle accordionTitleTextStyle;
  late TextStyle accordionBodyTextStyle;
  late Color accordionBackgroundColor;

  // Modal
  late Color modalBackgroundColor;
  late TextStyle modalTitleTextStyle;

  // Select
  late TextStyle selectLabelTextStyle;
  late TextStyle selectLabelTextStyleDisabled;

  // Toast
  late TextStyle toastTextStyle;
  late Color toastBackgroundColor;

  // Tab Bar
  late TextStyle tabBarTextStyle;

  SBBThemeData copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,

    // PrimaryButton
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonBackgroundColorHighlighted,
    Color? primaryButtonBackgroundColorDisabled,
    Color? primaryButtonBackgroundColorLoading,
    TextStyle? primaryButtonTextStyle,
    TextStyle? primaryButtonTextStyleHighlighted,
    TextStyle? primaryButtonTextStyleDisabled,
    TextStyle? primaryButtonTextStyleLoading,

    // PrimaryButtonNegative
    Color? primaryButtonNegativeBackgroundColor,
    Color? primaryButtonNegativeBackgroundColorHighlighted,
    Color? primaryButtonNegativeBackgroundColorDisabled,
    Color? primaryButtonNegativeBackgroundColorLoading,
    Color? primaryButtonNegativeBorderColor,
    Color? primaryButtonNegativeBorderColorHighlighted,
    Color? primaryButtonNegativeBorderColorDisabled,
    Color? primaryButtonNegativeBorderColorLoading,
    TextStyle? primaryButtonNegativeTextStyle,
    TextStyle? primaryButtonNegativeTextStyleHighlighted,
    TextStyle? primaryButtonNegativeTextStyleDisabled,
    TextStyle? primaryButtonNegativeTextStyleLoading,

    // SecondaryButton
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonBackgroundColorHighlighted,
    Color? secondaryButtonBackgroundColorDisabled,
    Color? secondaryButtonBackgroundColorLoading,
    Color? secondaryButtonBorderColor,
    Color? secondaryButtonBorderColorHighlighted,
    Color? secondaryButtonBorderColorDisabled,
    Color? secondaryButtonBorderColorLoading,
    TextStyle? secondaryButtonTextStyle,
    TextStyle? secondaryButtonTextStyleHighlighted,
    TextStyle? secondaryButtonTextStyleDisabled,
    TextStyle? secondaryButtonTextStyleLoading,

    // TertiaryButtonLarge
    Color? tertiaryButtonLargeBackgroundColor,
    Color? tertiaryButtonLargeBackgroundColorHighlighted,
    Color? tertiaryButtonLargeBackgroundColorDisabled,
    Color? tertiaryButtonLargeBorderColor,
    Color? tertiaryButtonLargeBorderColorHighlighted,
    Color? tertiaryButtonLargeBorderColorDisabled,
    TextStyle? tertiaryButtonLargeTextStyle,
    TextStyle? tertiaryButtonLargeTextStyleHighlighted,
    TextStyle? tertiaryButtonLargeTextStyleDisabled,

    // TertiaryButtonSmall
    Color? tertiaryButtonSmallBackgroundColor,
    Color? tertiaryButtonSmallBackgroundColorHighlighted,
    Color? tertiaryButtonSmallBackgroundColorDisabled,
    Color? tertiaryButtonSmallBorderColor,
    Color? tertiaryButtonSmallBorderColorHighlighted,
    Color? tertiaryButtonSmallBorderColorDisabled,
    TextStyle? tertiaryButtonSmallTextStyle,
    TextStyle? tertiaryButtonSmallTextStyleHighlighted,
    TextStyle? tertiaryButtonSmallTextStyleDisabled,

    // IconButtonLarge
    Color? iconButtonLargeBackgroundColor,
    Color? iconButtonLargeBackgroundColorHighlighted,
    Color? iconButtonLargeBackgroundColorDisabled,
    Color? iconButtonLargeBorderColor,
    Color? iconButtonLargeBorderColorHighlighted,
    Color? iconButtonLargeBorderColorDisabled,
    Color? iconButtonLargeIconColor,
    Color? iconButtonLargeIconColorHighlighted,
    Color? iconButtonLargeIconColorDisabled,

    // IconButtonSmall
    Color? iconButtonSmallBackgroundColor,
    Color? iconButtonSmallBackgroundColorHighlighted,
    Color? iconButtonSmallBackgroundColorDisabled,
    Color? iconButtonSmallBorderColor,
    Color? iconButtonSmallBorderColorHighlighted,
    Color? iconButtonSmallBorderColorDisabled,
    Color? iconButtonSmallIconColor,
    Color? iconButtonSmallIconColorHighlighted,
    Color? iconButtonSmallIconColorDisabled,

    // IconButtonSmallNegative
    Color? iconButtonSmallNegativeBackgroundColor,
    Color? iconButtonSmallNegativeBackgroundColorHighlighted,
    Color? iconButtonSmallNegativeBackgroundColorDisabled,
    Color? iconButtonSmallNegativeBorderColor,
    Color? iconButtonSmallNegativeBorderColorHighlighted,
    Color? iconButtonSmallNegativeBorderColorDisabled,
    Color? iconButtonSmallNegativeIconColor,
    Color? iconButtonSmallNegativeIconColorHighlighted,
    Color? iconButtonSmallNegativeIconColorDisabled,

    // IconButtonSmallBorderless
    Color? iconButtonSmallBorderlessBackgroundColor,
    Color? iconButtonSmallBorderlessBackgroundColorHighlighted,
    Color? iconButtonSmallBorderlessBackgroundColorDisabled,
    Color? iconButtonSmallBorderlessIconColor,
    Color? iconButtonSmallBorderlessIconColorHighlighted,
    Color? iconButtonSmallBorderlessIconColorDisabled,

    // IconFormButton
    Color? iconFormButtonBackgroundColor,
    Color? iconFormButtonBackgroundColorHighlighted,
    Color? iconFormButtonBackgroundColorDisabled,
    Color? iconFormButtonBorderColor,
    Color? iconFormButtonBorderColorHighlighted,
    Color? iconFormButtonBorderColorDisabled,
    Color? iconFormButtonIconColor,
    Color? iconFormButtonIconColorHighlighted,
    Color? iconFormButtonIconColorDisabled,

    // IconTextButton
    Color? iconTextButtonBackgroundColor,
    Color? iconTextButtonBackgroundColorHighlighted,
    Color? iconTextButtonBackgroundColorDisabled,
    Color? iconTextButtonIconColor,
    Color? iconTextButtonIconColorHighlighted,
    Color? iconTextButtonIconColorDisabled,
    TextStyle? iconTextButtonTextStyle,
    TextStyle? iconTextButtonTextStyleHighlighted,
    TextStyle? iconTextButtonTextStyleDisabled,

    // Link
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,

    //ListHeader
    TextStyle? listHeaderTextStyle,

    // ListItem
    Color? listItemBackgroundColor,
    Color? listItemBackgroundColorHighlighted,
    TextStyle? listItemTitleTextStyle,
    TextStyle? listItemSubtitleTextStyle,

    // Checkbox
    Color? checkboxColor,
    Color? checkboxColorDisabled,
    Color? checkboxBackgroundColor,
    Color? checkboxBackgroundColorHighlighted,
    Color? checkboxBackgroundColorDisabled,
    Color? checkboxBorderColor,
    Color? checkboxBorderColorDisabled,
    Color? checkboxListItemBackgroundColor,
    Color? checkboxListItemBackgroundColorHighlighted,
    Color? checkboxListItemBackgroundColorDisabled,
    Color? checkboxListItemIconColor,
    Color? checkboxListItemIconColorDisabled,
    TextStyle? checkboxListItemTextStyle,
    TextStyle? checkboxListItemTextStyleDisabled,
    TextStyle? checkboxListItemSecondaryTextStyle,
    TextStyle? checkboxListItemSecondaryTextStyleDisabled,

    // RadioButton
    Color? radioButtonColor,
    Color? radioButtonColorDisabled,
    Color? radioButtonBackgroundColor,
    Color? radioButtonBackgroundColorHighlighted,
    Color? radioButtonBackgroundColorDisabled,
    Color? radioButtonBorderColor,
    Color? radioButtonBorderColorDisabled,
    Color? radioButtonListItemBackgroundColor,
    Color? radioButtonListItemBackgroundColorHighlighted,
    Color? radioButtonListItemBackgroundColorDisabled,
    Color? radioButtonListItemIconColor,
    Color? radioButtonListItemIconColorDisabled,
    TextStyle? radioButtonListItemTextStyle,
    TextStyle? radioButtonListItemTextStyleDisabled,
    TextStyle? radioButtonListItemSecondaryTextStyle,
    TextStyle? radioButtonListItemSecondaryTextStyleDisabled,

    // SegmentedButton
    Color? segmentedButtonBackgroundColor,
    Color? segmentedButtonSelectedColor,
    TextStyle? segmentedButtonTextStyle,

    // TextField
    TextStyle? textFieldTextStyle,
    TextStyle? textFieldTextStyleDisabled,
    TextStyle? textFieldPlaceholderTextStyle,
    TextStyle? textFieldPlaceholderTextStyleDisabled,
    TextStyle? textFieldErrorTextStyle,
    Color? textFieldDividerColor,
    Color? textFieldDividerColorHighlighted,
    Color? textFieldDividerColorError,
    Color? textFieldCursorColor,
    Color? textFieldSelectionColor,
    Color? textFieldSelectionHandleColor,
    Color? textFieldIconColor,
    Color? textFieldIconColorDisabled,

    // Group
    Color? groupBackgroundColor,

    // Accordion
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,

    // Modal
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,

    // Select
    TextStyle? selectLabelTextStyle,
    TextStyle? selectLabelTextStyleDisabled,

    // Toast
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,

    // Tab Bar
    TextStyle? tabBarTextStyle,
  }) {
    final defaultTheme = SBBThemeData(brightness: this.brightness);
    return SBBThemeData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? (this.primaryColor == defaultTheme.primaryColor ? null : this.primaryColor),
      primaryColorDark: primaryColorDark ?? (this.primaryColorDark == defaultTheme.primaryColorDark ? null : this.primaryColorDark),
      primarySwatch: primarySwatch ?? (this.primarySwatch == defaultTheme.primarySwatch ? null : this.primarySwatch),
      backgroundColor: backgroundColor ?? (this.backgroundColor == defaultTheme.backgroundColor ? null : this.backgroundColor),
      fontFamily: fontFamily ?? (this.fontFamily == defaultTheme.fontFamily ? null : this.fontFamily),
      defaultTextColor: defaultTextColor ?? (this.defaultTextColor == defaultTheme.defaultTextColor ? null : this.defaultTextColor),
      defaultTextStyle: defaultTextStyle ?? (this.defaultTextStyle == defaultTheme.defaultTextStyle ? null : this.defaultTextStyle),
      dividerColor: dividerColor ?? (this.dividerColor == defaultTheme.dividerColor ? null : this.dividerColor),
      defaultRootContainerPadding: defaultRootContainerPadding ?? (this.defaultRootContainerPadding == defaultTheme.defaultRootContainerPadding ? null : this.defaultRootContainerPadding),

      // Icon
      iconColor: iconColor ?? (this.iconColor == defaultTheme.iconColor ? null : this.iconColor),

      // Header
      headerBackgroundColor: headerBackgroundColor ?? (this.headerBackgroundColor == defaultTheme.headerBackgroundColor ? null : this.headerBackgroundColor),
      headerButtonBackgroundColorHighlighted: headerButtonBackgroundColorHighlighted ??
          (this.headerButtonBackgroundColorHighlighted == defaultTheme.headerButtonBackgroundColorHighlighted ? null : this.headerButtonBackgroundColorHighlighted),
      headerIconColor: headerIconColor ?? (this.headerIconColor == defaultTheme.headerIconColor ? null : this.headerIconColor),
      headerTextStyle: headerTextStyle ?? (this.headerTextStyle == defaultTheme.headerTextStyle ? null : this.headerTextStyle),

      // PrimaryButton
      primaryButtonBackgroundColor: primaryButtonBackgroundColor ?? (this.primaryButtonBackgroundColor == defaultTheme.primaryButtonBackgroundColor ? null : this.primaryButtonBackgroundColor),
      primaryButtonBackgroundColorHighlighted: primaryButtonBackgroundColorHighlighted ??
          (this.primaryButtonBackgroundColorHighlighted == defaultTheme.primaryButtonBackgroundColorHighlighted ? null : this.primaryButtonBackgroundColorHighlighted),
      primaryButtonBackgroundColorDisabled:
          primaryButtonBackgroundColorDisabled ?? (this.primaryButtonBackgroundColorDisabled == defaultTheme.primaryButtonBackgroundColorDisabled ? null : this.primaryButtonBackgroundColorDisabled),
      primaryButtonBackgroundColorLoading:
          primaryButtonBackgroundColorLoading ?? (this.primaryButtonBackgroundColorLoading == defaultTheme.primaryButtonBackgroundColorLoading ? null : this.primaryButtonBackgroundColorLoading),
      primaryButtonTextStyle: primaryButtonTextStyle ?? (this.primaryButtonTextStyle == defaultTheme.primaryButtonTextStyle ? null : this.primaryButtonTextStyle),
      primaryButtonTextStyleHighlighted:
          primaryButtonTextStyleHighlighted ?? (this.primaryButtonTextStyleHighlighted == defaultTheme.primaryButtonTextStyleHighlighted ? null : this.primaryButtonTextStyleHighlighted),
      primaryButtonTextStyleDisabled:
          primaryButtonTextStyleDisabled ?? (this.primaryButtonTextStyleDisabled == defaultTheme.primaryButtonTextStyleDisabled ? null : this.primaryButtonTextStyleDisabled),
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading ?? (this.primaryButtonTextStyleLoading == defaultTheme.primaryButtonTextStyleLoading ? null : this.primaryButtonTextStyleLoading),

      // PrimaryButtonNegative
      primaryButtonNegativeBackgroundColor:
          primaryButtonNegativeBackgroundColor ?? (this.primaryButtonNegativeBackgroundColor == defaultTheme.primaryButtonNegativeBackgroundColor ? null : this.primaryButtonNegativeBackgroundColor),
      primaryButtonNegativeBackgroundColorHighlighted: primaryButtonNegativeBackgroundColorHighlighted ??
          (this.primaryButtonNegativeBackgroundColorHighlighted == defaultTheme.primaryButtonNegativeBackgroundColorHighlighted ? null : this.primaryButtonNegativeBackgroundColorHighlighted),
      primaryButtonNegativeBackgroundColorDisabled: primaryButtonNegativeBackgroundColorDisabled ??
          (this.primaryButtonNegativeBackgroundColorDisabled == defaultTheme.primaryButtonNegativeBackgroundColorDisabled ? null : this.primaryButtonNegativeBackgroundColorDisabled),
      primaryButtonNegativeBackgroundColorLoading: primaryButtonNegativeBackgroundColorLoading ??
          (this.primaryButtonNegativeBackgroundColorLoading == defaultTheme.primaryButtonNegativeBackgroundColorLoading ? null : this.primaryButtonNegativeBackgroundColorLoading),
      primaryButtonNegativeBorderColor:
          primaryButtonNegativeBorderColor ?? (this.primaryButtonNegativeBorderColor == defaultTheme.primaryButtonNegativeBorderColor ? null : this.primaryButtonNegativeBorderColor),
      primaryButtonNegativeBorderColorHighlighted: primaryButtonNegativeBorderColorHighlighted ??
          (this.primaryButtonNegativeBorderColorHighlighted == defaultTheme.primaryButtonNegativeBorderColorHighlighted ? null : this.primaryButtonNegativeBorderColorHighlighted),
      primaryButtonNegativeBorderColorDisabled: primaryButtonNegativeBorderColorDisabled ??
          (this.primaryButtonNegativeBorderColorDisabled == defaultTheme.primaryButtonNegativeBorderColorDisabled ? null : this.primaryButtonNegativeBorderColorDisabled),
      primaryButtonNegativeBorderColorLoading: primaryButtonNegativeBorderColorLoading ??
          (this.primaryButtonNegativeBorderColorLoading == defaultTheme.primaryButtonNegativeBorderColorLoading ? null : this.primaryButtonNegativeBorderColorLoading),
      primaryButtonNegativeTextStyle:
          primaryButtonNegativeTextStyle ?? (this.primaryButtonNegativeTextStyle == defaultTheme.primaryButtonNegativeTextStyle ? null : this.primaryButtonNegativeTextStyle),
      primaryButtonNegativeTextStyleHighlighted: primaryButtonNegativeTextStyleHighlighted ??
          (this.primaryButtonNegativeTextStyleHighlighted == defaultTheme.primaryButtonNegativeTextStyleHighlighted ? null : this.primaryButtonNegativeTextStyleHighlighted),
      primaryButtonNegativeTextStyleDisabled: primaryButtonNegativeTextStyleDisabled ??
          (this.primaryButtonNegativeTextStyleDisabled == defaultTheme.primaryButtonNegativeTextStyleDisabled ? null : this.primaryButtonNegativeTextStyleDisabled),
      primaryButtonNegativeTextStyleLoading: primaryButtonNegativeTextStyleLoading ??
          (this.primaryButtonNegativeTextStyleLoading == defaultTheme.primaryButtonNegativeTextStyleLoading ? null : this.primaryButtonNegativeTextStyleLoading),

      // SecondaryButton
      secondaryButtonBackgroundColor:
          secondaryButtonBackgroundColor ?? (this.secondaryButtonBackgroundColor == defaultTheme.secondaryButtonBackgroundColor ? null : this.secondaryButtonBackgroundColor),
      secondaryButtonBackgroundColorHighlighted: secondaryButtonBackgroundColorHighlighted ??
          (this.secondaryButtonBackgroundColorHighlighted == defaultTheme.secondaryButtonBackgroundColorHighlighted ? null : this.secondaryButtonBackgroundColorHighlighted),
      secondaryButtonBackgroundColorDisabled: secondaryButtonBackgroundColorDisabled ??
          (this.secondaryButtonBackgroundColorDisabled == defaultTheme.secondaryButtonBackgroundColorDisabled ? null : this.secondaryButtonBackgroundColorDisabled),
      secondaryButtonBackgroundColorLoading: secondaryButtonBackgroundColorLoading ??
          (this.secondaryButtonBackgroundColorLoading == defaultTheme.secondaryButtonBackgroundColorLoading ? null : this.secondaryButtonBackgroundColorLoading),
      secondaryButtonBorderColor: secondaryButtonBorderColor ?? (this.secondaryButtonBorderColor == defaultTheme.secondaryButtonBorderColor ? null : this.secondaryButtonBorderColor),
      secondaryButtonBorderColorHighlighted: secondaryButtonBorderColorHighlighted ??
          (this.secondaryButtonBorderColorHighlighted == defaultTheme.secondaryButtonBorderColorHighlighted ? null : this.secondaryButtonBorderColorHighlighted),
      secondaryButtonBorderColorDisabled:
          secondaryButtonBorderColorDisabled ?? (this.secondaryButtonBorderColorDisabled == defaultTheme.secondaryButtonBorderColorDisabled ? null : this.secondaryButtonBorderColorDisabled),
      secondaryButtonBorderColorLoading:
          secondaryButtonBorderColorLoading ?? (this.secondaryButtonBorderColorLoading == defaultTheme.secondaryButtonBorderColorLoading ? null : this.secondaryButtonBorderColorLoading),
      secondaryButtonTextStyle: secondaryButtonTextStyle ?? (this.secondaryButtonTextStyle == defaultTheme.secondaryButtonTextStyle ? null : this.secondaryButtonTextStyle),
      secondaryButtonTextStyleHighlighted:
          secondaryButtonTextStyleHighlighted ?? (this.secondaryButtonTextStyleHighlighted == defaultTheme.secondaryButtonTextStyleHighlighted ? null : this.secondaryButtonTextStyleHighlighted),
      secondaryButtonTextStyleDisabled:
          secondaryButtonTextStyleDisabled ?? (this.secondaryButtonTextStyleDisabled == defaultTheme.secondaryButtonTextStyleDisabled ? null : this.secondaryButtonTextStyleDisabled),
      secondaryButtonTextStyleLoading:
          secondaryButtonTextStyleLoading ?? (this.secondaryButtonTextStyleLoading == defaultTheme.secondaryButtonTextStyleLoading ? null : this.secondaryButtonTextStyleLoading),

      // TertiaryButtonLarge
      tertiaryButtonLargeBackgroundColor:
          tertiaryButtonLargeBackgroundColor ?? (this.tertiaryButtonLargeBackgroundColor == defaultTheme.tertiaryButtonLargeBackgroundColor ? null : this.tertiaryButtonLargeBackgroundColor),
      tertiaryButtonLargeBackgroundColorHighlighted: tertiaryButtonLargeBackgroundColorHighlighted ??
          (this.tertiaryButtonLargeBackgroundColorHighlighted == defaultTheme.tertiaryButtonLargeBackgroundColorHighlighted ? null : this.tertiaryButtonLargeBackgroundColorHighlighted),
      tertiaryButtonLargeBackgroundColorDisabled: tertiaryButtonLargeBackgroundColorDisabled ??
          (this.tertiaryButtonLargeBackgroundColorDisabled == defaultTheme.tertiaryButtonLargeBackgroundColorDisabled ? null : this.tertiaryButtonLargeBackgroundColorDisabled),
      tertiaryButtonLargeBorderColor:
          tertiaryButtonLargeBorderColor ?? (this.tertiaryButtonLargeBorderColor == defaultTheme.tertiaryButtonLargeBorderColor ? null : this.tertiaryButtonLargeBorderColor),
      tertiaryButtonLargeBorderColorHighlighted: tertiaryButtonLargeBorderColorHighlighted ??
          (this.tertiaryButtonLargeBorderColorHighlighted == defaultTheme.tertiaryButtonLargeBorderColorHighlighted ? null : this.tertiaryButtonLargeBorderColorHighlighted),
      tertiaryButtonLargeBorderColorDisabled: tertiaryButtonLargeBorderColorDisabled ??
          (this.tertiaryButtonLargeBorderColorDisabled == defaultTheme.tertiaryButtonLargeBorderColorDisabled ? null : this.tertiaryButtonLargeBorderColorDisabled),
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle ?? (this.tertiaryButtonLargeTextStyle == defaultTheme.tertiaryButtonLargeTextStyle ? null : this.tertiaryButtonLargeTextStyle),
      tertiaryButtonLargeTextStyleHighlighted: tertiaryButtonLargeTextStyleHighlighted ??
          (this.tertiaryButtonLargeTextStyleHighlighted == defaultTheme.tertiaryButtonLargeTextStyleHighlighted ? null : this.tertiaryButtonLargeTextStyleHighlighted),
      tertiaryButtonLargeTextStyleDisabled:
          tertiaryButtonLargeTextStyleDisabled ?? (this.tertiaryButtonLargeTextStyleDisabled == defaultTheme.tertiaryButtonLargeTextStyleDisabled ? null : this.tertiaryButtonLargeTextStyleDisabled),

      // TertiaryButtonSmall
      tertiaryButtonSmallBackgroundColor:
          tertiaryButtonSmallBackgroundColor ?? (this.tertiaryButtonSmallBackgroundColor == defaultTheme.tertiaryButtonSmallBackgroundColor ? null : this.tertiaryButtonSmallBackgroundColor),
      tertiaryButtonSmallBackgroundColorHighlighted: tertiaryButtonSmallBackgroundColorHighlighted ??
          (this.tertiaryButtonSmallBackgroundColorHighlighted == defaultTheme.tertiaryButtonSmallBackgroundColorHighlighted ? null : this.tertiaryButtonSmallBackgroundColorHighlighted),
      tertiaryButtonSmallBackgroundColorDisabled: tertiaryButtonSmallBackgroundColorDisabled ??
          (this.tertiaryButtonSmallBackgroundColorDisabled == defaultTheme.tertiaryButtonSmallBackgroundColorDisabled ? null : this.tertiaryButtonSmallBackgroundColorDisabled),
      tertiaryButtonSmallBorderColor:
          tertiaryButtonSmallBorderColor ?? (this.tertiaryButtonSmallBorderColor == defaultTheme.tertiaryButtonSmallBorderColor ? null : this.tertiaryButtonSmallBorderColor),
      tertiaryButtonSmallBorderColorHighlighted: tertiaryButtonSmallBorderColorHighlighted ??
          (this.tertiaryButtonSmallBorderColorHighlighted == defaultTheme.tertiaryButtonSmallBorderColorHighlighted ? null : this.tertiaryButtonSmallBorderColorHighlighted),
      tertiaryButtonSmallBorderColorDisabled: tertiaryButtonSmallBorderColorDisabled ??
          (this.tertiaryButtonSmallBorderColorDisabled == defaultTheme.tertiaryButtonSmallBorderColorDisabled ? null : this.tertiaryButtonSmallBorderColorDisabled),
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle ?? (this.tertiaryButtonSmallTextStyle == defaultTheme.tertiaryButtonSmallTextStyle ? null : this.tertiaryButtonSmallTextStyle),
      tertiaryButtonSmallTextStyleHighlighted: tertiaryButtonSmallTextStyleHighlighted ??
          (this.tertiaryButtonSmallTextStyleHighlighted == defaultTheme.tertiaryButtonSmallTextStyleHighlighted ? null : this.tertiaryButtonSmallTextStyleHighlighted),
      tertiaryButtonSmallTextStyleDisabled:
          tertiaryButtonSmallTextStyleDisabled ?? (this.tertiaryButtonSmallTextStyleDisabled == defaultTheme.tertiaryButtonSmallTextStyleDisabled ? null : this.tertiaryButtonSmallTextStyleDisabled),

      // IconButtonLarge
      iconButtonLargeBackgroundColor:
          iconButtonLargeBackgroundColor ?? (this.iconButtonLargeBackgroundColor == defaultTheme.iconButtonLargeBackgroundColor ? null : this.iconButtonLargeBackgroundColor),
      iconButtonLargeBackgroundColorHighlighted: iconButtonLargeBackgroundColorHighlighted ??
          (this.iconButtonLargeBackgroundColorHighlighted == defaultTheme.iconButtonLargeBackgroundColorHighlighted ? null : this.iconButtonLargeBackgroundColorHighlighted),
      iconButtonLargeBackgroundColorDisabled: iconButtonLargeBackgroundColorDisabled ??
          (this.iconButtonLargeBackgroundColorDisabled == defaultTheme.iconButtonLargeBackgroundColorDisabled ? null : this.iconButtonLargeBackgroundColorDisabled),
      iconButtonLargeBorderColor: iconButtonLargeBorderColor ?? (this.iconButtonLargeBorderColor == defaultTheme.iconButtonLargeBorderColor ? null : this.iconButtonLargeBorderColor),
      iconButtonLargeBorderColorHighlighted: iconButtonLargeBorderColorHighlighted ??
          (this.iconButtonLargeBorderColorHighlighted == defaultTheme.iconButtonLargeBorderColorHighlighted ? null : this.iconButtonLargeBorderColorHighlighted),
      iconButtonLargeBorderColorDisabled:
          iconButtonLargeBorderColorDisabled ?? (this.iconButtonLargeBorderColorDisabled == defaultTheme.iconButtonLargeBorderColorDisabled ? null : this.iconButtonLargeBorderColorDisabled),
      iconButtonLargeIconColor: iconButtonLargeIconColor ?? (this.iconButtonLargeIconColor == defaultTheme.iconButtonLargeIconColor ? null : this.iconButtonLargeIconColor),
      iconButtonLargeIconColorHighlighted:
          iconButtonLargeIconColorHighlighted ?? (this.iconButtonLargeIconColorHighlighted == defaultTheme.iconButtonLargeIconColorHighlighted ? null : this.iconButtonLargeIconColorHighlighted),
      iconButtonLargeIconColorDisabled:
          iconButtonLargeIconColorDisabled ?? (this.iconButtonLargeIconColorDisabled == defaultTheme.iconButtonLargeIconColorDisabled ? null : this.iconButtonLargeIconColorDisabled),

      // IconButtonSmall
      iconButtonSmallBackgroundColor:
          iconButtonSmallBackgroundColor ?? (this.iconButtonSmallBackgroundColor == defaultTheme.iconButtonSmallBackgroundColor ? null : this.iconButtonSmallBackgroundColor),
      iconButtonSmallBackgroundColorHighlighted: iconButtonSmallBackgroundColorHighlighted ??
          (this.iconButtonSmallBackgroundColorHighlighted == defaultTheme.iconButtonSmallBackgroundColorHighlighted ? null : this.iconButtonSmallBackgroundColorHighlighted),
      iconButtonSmallBackgroundColorDisabled: iconButtonSmallBackgroundColorDisabled ??
          (this.iconButtonSmallBackgroundColorDisabled == defaultTheme.iconButtonSmallBackgroundColorDisabled ? null : this.iconButtonSmallBackgroundColorDisabled),
      iconButtonSmallBorderColor: iconButtonSmallBorderColor ?? (this.iconButtonSmallBorderColor == defaultTheme.iconButtonSmallBorderColor ? null : this.iconButtonSmallBorderColor),
      iconButtonSmallBorderColorHighlighted: iconButtonSmallBorderColorHighlighted ??
          (this.iconButtonSmallBorderColorHighlighted == defaultTheme.iconButtonSmallBorderColorHighlighted ? null : this.iconButtonSmallBorderColorHighlighted),
      iconButtonSmallBorderColorDisabled:
          iconButtonSmallBorderColorDisabled ?? (this.iconButtonSmallBorderColorDisabled == defaultTheme.iconButtonSmallBorderColorDisabled ? null : this.iconButtonSmallBorderColorDisabled),
      iconButtonSmallIconColor: iconButtonSmallIconColor ?? (this.iconButtonSmallIconColor == defaultTheme.iconButtonSmallIconColor ? null : this.iconButtonSmallIconColor),
      iconButtonSmallIconColorHighlighted:
          iconButtonSmallIconColorHighlighted ?? (this.iconButtonSmallIconColorHighlighted == defaultTheme.iconButtonSmallIconColorHighlighted ? null : this.iconButtonSmallIconColorHighlighted),
      iconButtonSmallIconColorDisabled:
          iconButtonSmallIconColorDisabled ?? (this.iconButtonSmallIconColorDisabled == defaultTheme.iconButtonSmallIconColorDisabled ? null : this.iconButtonSmallIconColorDisabled),

      // IconButtonSmallNegative
      iconButtonSmallNegativeBackgroundColor: iconButtonSmallNegativeBackgroundColor ??
          (this.iconButtonSmallNegativeBackgroundColor == defaultTheme.iconButtonSmallNegativeBackgroundColor ? null : this.iconButtonSmallNegativeBackgroundColor),
      iconButtonSmallNegativeBackgroundColorHighlighted: iconButtonSmallNegativeBackgroundColorHighlighted ??
          (this.iconButtonSmallNegativeBackgroundColorHighlighted == defaultTheme.iconButtonSmallNegativeBackgroundColorHighlighted ? null : this.iconButtonSmallNegativeBackgroundColorHighlighted),
      iconButtonSmallNegativeBackgroundColorDisabled: iconButtonSmallNegativeBackgroundColorDisabled ??
          (this.iconButtonSmallNegativeBackgroundColorDisabled == defaultTheme.iconButtonSmallNegativeBackgroundColorDisabled ? null : this.iconButtonSmallNegativeBackgroundColorDisabled),
      iconButtonSmallNegativeBorderColor:
          iconButtonSmallNegativeBorderColor ?? (this.iconButtonSmallNegativeBorderColor == defaultTheme.iconButtonSmallNegativeBorderColor ? null : this.iconButtonSmallNegativeBorderColor),
      iconButtonSmallNegativeBorderColorHighlighted: iconButtonSmallNegativeBorderColorHighlighted ??
          (this.iconButtonSmallNegativeBorderColorHighlighted == defaultTheme.iconButtonSmallNegativeBorderColorHighlighted ? null : this.iconButtonSmallNegativeBorderColorHighlighted),
      iconButtonSmallNegativeBorderColorDisabled: iconButtonSmallNegativeBorderColorDisabled ??
          (this.iconButtonSmallNegativeBorderColorDisabled == defaultTheme.iconButtonSmallNegativeBorderColorDisabled ? null : this.iconButtonSmallNegativeBorderColorDisabled),
      iconButtonSmallNegativeIconColor:
          iconButtonSmallNegativeIconColor ?? (this.iconButtonSmallNegativeIconColor == defaultTheme.iconButtonSmallNegativeIconColor ? null : this.iconButtonSmallNegativeIconColor),
      iconButtonSmallNegativeIconColorHighlighted: iconButtonSmallNegativeIconColorHighlighted ??
          (this.iconButtonSmallNegativeIconColorHighlighted == defaultTheme.iconButtonSmallNegativeIconColorHighlighted ? null : this.iconButtonSmallNegativeIconColorHighlighted),
      iconButtonSmallNegativeIconColorDisabled: iconButtonSmallNegativeIconColorDisabled ??
          (this.iconButtonSmallNegativeIconColorDisabled == defaultTheme.iconButtonSmallNegativeIconColorDisabled ? null : this.iconButtonSmallNegativeIconColorDisabled),

      // IconButtonSmallBorderless
      iconButtonSmallBorderlessBackgroundColor: iconButtonSmallBorderlessBackgroundColor ??
          (this.iconButtonSmallBorderlessBackgroundColor == defaultTheme.iconButtonSmallBorderlessBackgroundColor ? null : this.iconButtonSmallBorderlessBackgroundColor),
      iconButtonSmallBorderlessBackgroundColorHighlighted: iconButtonSmallBorderlessBackgroundColorHighlighted ??
          (this.iconButtonSmallBorderlessBackgroundColorHighlighted == defaultTheme.iconButtonSmallBorderlessBackgroundColorHighlighted
              ? null
              : this.iconButtonSmallBorderlessBackgroundColorHighlighted),
      iconButtonSmallBorderlessBackgroundColorDisabled: iconButtonSmallBorderlessBackgroundColorDisabled ??
          (this.iconButtonSmallBorderlessBackgroundColorDisabled == defaultTheme.iconButtonSmallBorderlessBackgroundColorDisabled ? null : this.iconButtonSmallBorderlessBackgroundColorDisabled),
      iconButtonSmallBorderlessIconColor:
          iconButtonSmallBorderlessIconColor ?? (this.iconButtonSmallBorderlessIconColor == defaultTheme.iconButtonSmallBorderlessIconColor ? null : this.iconButtonSmallBorderlessIconColor),
      iconButtonSmallBorderlessIconColorHighlighted: iconButtonSmallBorderlessIconColorHighlighted ??
          (this.iconButtonSmallBorderlessIconColorHighlighted == defaultTheme.iconButtonSmallBorderlessIconColorHighlighted ? null : this.iconButtonSmallBorderlessIconColorHighlighted),
      iconButtonSmallBorderlessIconColorDisabled: iconButtonSmallBorderlessIconColorDisabled ??
          (this.iconButtonSmallBorderlessIconColorDisabled == defaultTheme.iconButtonSmallBorderlessIconColorDisabled ? null : this.iconButtonSmallBorderlessIconColorDisabled),

      // IconFormButton
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor ?? (this.iconFormButtonBackgroundColor == defaultTheme.iconFormButtonBackgroundColor ? null : this.iconFormButtonBackgroundColor),
      iconFormButtonBackgroundColorHighlighted: iconFormButtonBackgroundColorHighlighted ??
          (this.iconFormButtonBackgroundColorHighlighted == defaultTheme.iconFormButtonBackgroundColorHighlighted ? null : this.iconFormButtonBackgroundColorHighlighted),
      iconFormButtonBackgroundColorDisabled: iconFormButtonBackgroundColorDisabled ??
          (this.iconFormButtonBackgroundColorDisabled == defaultTheme.iconFormButtonBackgroundColorDisabled ? null : this.iconFormButtonBackgroundColorDisabled),
      iconFormButtonBorderColor: iconFormButtonBorderColor ?? (this.iconFormButtonBorderColor == defaultTheme.iconFormButtonBorderColor ? null : this.iconFormButtonBorderColor),
      iconFormButtonBorderColorHighlighted:
          iconFormButtonBorderColorHighlighted ?? (this.iconFormButtonBorderColorHighlighted == defaultTheme.iconFormButtonBorderColorHighlighted ? null : this.iconFormButtonBorderColorHighlighted),
      iconFormButtonBorderColorDisabled:
          iconFormButtonBorderColorDisabled ?? (this.iconFormButtonBorderColorDisabled == defaultTheme.iconFormButtonBorderColorDisabled ? null : this.iconFormButtonBorderColorDisabled),
      iconFormButtonIconColor: iconFormButtonIconColor ?? (this.iconFormButtonIconColor == defaultTheme.iconFormButtonIconColor ? null : this.iconFormButtonIconColor),
      iconFormButtonIconColorHighlighted:
          iconFormButtonIconColorHighlighted ?? (this.iconFormButtonIconColorHighlighted == defaultTheme.iconFormButtonIconColorHighlighted ? null : this.iconFormButtonIconColorHighlighted),
      iconFormButtonIconColorDisabled:
          iconFormButtonIconColorDisabled ?? (this.iconFormButtonIconColorDisabled == defaultTheme.iconFormButtonIconColorDisabled ? null : this.iconFormButtonIconColorDisabled),

      // IconTextButton
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor ?? (this.iconTextButtonBackgroundColor == defaultTheme.iconTextButtonBackgroundColor ? null : this.iconTextButtonBackgroundColor),
      iconTextButtonBackgroundColorHighlighted: iconTextButtonBackgroundColorHighlighted ??
          (this.iconTextButtonBackgroundColorHighlighted == defaultTheme.iconTextButtonBackgroundColorHighlighted ? null : this.iconTextButtonBackgroundColorHighlighted),
      iconTextButtonBackgroundColorDisabled: iconTextButtonBackgroundColorDisabled ??
          (this.iconTextButtonBackgroundColorDisabled == defaultTheme.iconTextButtonBackgroundColorDisabled ? null : this.iconTextButtonBackgroundColorDisabled),
      iconTextButtonIconColor: iconTextButtonIconColor ?? (this.iconTextButtonIconColor == defaultTheme.iconTextButtonIconColor ? null : this.iconTextButtonIconColor),
      iconTextButtonIconColorHighlighted:
          iconTextButtonIconColorHighlighted ?? (this.iconTextButtonIconColorHighlighted == defaultTheme.iconTextButtonIconColorHighlighted ? null : this.iconTextButtonIconColorHighlighted),
      iconTextButtonIconColorDisabled:
          iconTextButtonIconColorDisabled ?? (this.iconTextButtonIconColorDisabled == defaultTheme.iconTextButtonIconColorDisabled ? null : this.iconTextButtonIconColorDisabled),
      iconTextButtonTextStyle: iconTextButtonTextStyle ?? (this.iconTextButtonTextStyle == defaultTheme.iconTextButtonTextStyle ? null : this.iconTextButtonTextStyle),
      iconTextButtonTextStyleHighlighted:
          iconTextButtonTextStyleHighlighted ?? (this.iconTextButtonTextStyleHighlighted == defaultTheme.iconTextButtonTextStyleHighlighted ? null : this.iconTextButtonTextStyleHighlighted),
      iconTextButtonTextStyleDisabled:
          iconTextButtonTextStyleDisabled ?? (this.iconTextButtonTextStyleDisabled == defaultTheme.iconTextButtonTextStyleDisabled ? null : this.iconTextButtonTextStyleDisabled),

      // Link
      linkTextStyle: linkTextStyle ?? (this.linkTextStyle == defaultTheme.linkTextStyle ? null : this.linkTextStyle),
      linkTextStyleHighlighted: linkTextStyleHighlighted ?? (this.linkTextStyleHighlighted == defaultTheme.linkTextStyleHighlighted ? null : this.linkTextStyleHighlighted),

      //ListHeader
      listHeaderTextStyle: listHeaderTextStyle ?? (this.listHeaderTextStyle == defaultTheme.listHeaderTextStyle ? null : this.listHeaderTextStyle),

      // ListItem
      listItemBackgroundColor: listItemBackgroundColor ?? (this.listItemBackgroundColor == defaultTheme.listItemBackgroundColor ? null : this.listItemBackgroundColor),
      listItemBackgroundColorHighlighted:
          listItemBackgroundColorHighlighted ?? (this.listItemBackgroundColorHighlighted == defaultTheme.listItemBackgroundColorHighlighted ? null : this.listItemBackgroundColorHighlighted),
      listItemTitleTextStyle: listItemTitleTextStyle ?? (this.listItemTitleTextStyle == defaultTheme.listItemTitleTextStyle ? null : this.listItemTitleTextStyle),
      listItemSubtitleTextStyle: listItemSubtitleTextStyle ?? (this.listItemSubtitleTextStyle == defaultTheme.listItemSubtitleTextStyle ? null : this.listItemSubtitleTextStyle),

      // Checkbox
      checkboxColor: checkboxColor ?? (this.checkboxColor == defaultTheme.checkboxColor ? null : this.checkboxColor),
      checkboxColorDisabled: checkboxColorDisabled ?? (this.checkboxColorDisabled == defaultTheme.checkboxColorDisabled ? null : this.checkboxColorDisabled),
      checkboxBackgroundColor: checkboxBackgroundColor ?? (this.checkboxBackgroundColor == defaultTheme.checkboxBackgroundColor ? null : this.checkboxBackgroundColor),
      checkboxBackgroundColorHighlighted:
          checkboxBackgroundColorHighlighted ?? (this.checkboxBackgroundColorHighlighted == defaultTheme.checkboxBackgroundColorHighlighted ? null : this.checkboxBackgroundColorHighlighted),
      checkboxBackgroundColorDisabled:
          checkboxBackgroundColorDisabled ?? (this.checkboxBackgroundColorDisabled == defaultTheme.checkboxBackgroundColorDisabled ? null : this.checkboxBackgroundColorDisabled),
      checkboxBorderColor: checkboxBorderColor ?? (this.checkboxBorderColor == defaultTheme.checkboxBorderColor ? null : this.checkboxBorderColor),
      checkboxBorderColorDisabled: checkboxBorderColorDisabled ?? (this.checkboxBorderColorDisabled == defaultTheme.checkboxBorderColorDisabled ? null : this.checkboxBorderColorDisabled),
      checkboxListItemBackgroundColor:
          checkboxListItemBackgroundColor ?? (this.checkboxListItemBackgroundColor == defaultTheme.checkboxListItemBackgroundColor ? null : this.checkboxListItemBackgroundColor),
      checkboxListItemBackgroundColorHighlighted: checkboxListItemBackgroundColorHighlighted ??
          (this.checkboxListItemBackgroundColorHighlighted == defaultTheme.checkboxListItemBackgroundColorHighlighted ? null : this.checkboxListItemBackgroundColorHighlighted),
      checkboxListItemBackgroundColorDisabled: checkboxListItemBackgroundColorDisabled ??
          (this.checkboxListItemBackgroundColorDisabled == defaultTheme.checkboxListItemBackgroundColorDisabled ? null : this.checkboxListItemBackgroundColorDisabled),
      checkboxListItemIconColor: checkboxListItemIconColor ?? (this.checkboxListItemIconColor == defaultTheme.checkboxListItemIconColor ? null : this.checkboxListItemIconColor),
      checkboxListItemIconColorDisabled:
          checkboxListItemIconColorDisabled ?? (this.checkboxListItemIconColorDisabled == defaultTheme.checkboxListItemIconColorDisabled ? null : this.checkboxListItemIconColorDisabled),
      checkboxListItemTextStyle: checkboxListItemTextStyle ?? (this.checkboxListItemTextStyle == defaultTheme.checkboxListItemTextStyle ? null : this.checkboxListItemTextStyle),
      checkboxListItemTextStyleDisabled:
          checkboxListItemTextStyleDisabled ?? (this.checkboxListItemTextStyleDisabled == defaultTheme.checkboxListItemTextStyleDisabled ? null : this.checkboxListItemTextStyleDisabled),
      checkboxListItemSecondaryTextStyle:
          checkboxListItemSecondaryTextStyle ?? (this.checkboxListItemSecondaryTextStyle == defaultTheme.checkboxListItemSecondaryTextStyle ? null : this.checkboxListItemSecondaryTextStyle),
      checkboxListItemSecondaryTextStyleDisabled: checkboxListItemSecondaryTextStyleDisabled ??
          (this.checkboxListItemSecondaryTextStyleDisabled == defaultTheme.checkboxListItemSecondaryTextStyleDisabled ? null : this.checkboxListItemSecondaryTextStyleDisabled),

      // RadioButton
      radioButtonColor: radioButtonColor ?? (this.radioButtonColor == defaultTheme.radioButtonColor ? null : this.radioButtonColor),
      radioButtonColorDisabled: radioButtonColorDisabled ?? (this.radioButtonColorDisabled == defaultTheme.radioButtonColorDisabled ? null : this.radioButtonColorDisabled),
      radioButtonBackgroundColor: radioButtonBackgroundColor ?? (this.radioButtonBackgroundColor == defaultTheme.radioButtonBackgroundColor ? null : this.radioButtonBackgroundColor),
      radioButtonBackgroundColorHighlighted: radioButtonBackgroundColorHighlighted ??
          (this.radioButtonBackgroundColorHighlighted == defaultTheme.radioButtonBackgroundColorHighlighted ? null : this.radioButtonBackgroundColorHighlighted),
      radioButtonBackgroundColorDisabled:
          radioButtonBackgroundColorDisabled ?? (this.radioButtonBackgroundColorDisabled == defaultTheme.radioButtonBackgroundColorDisabled ? null : this.radioButtonBackgroundColorDisabled),
      radioButtonBorderColor: radioButtonBorderColor ?? (this.radioButtonBorderColor == defaultTheme.radioButtonBorderColor ? null : this.radioButtonBorderColor),
      radioButtonBorderColorDisabled:
          radioButtonBorderColorDisabled ?? (this.radioButtonBorderColorDisabled == defaultTheme.radioButtonBorderColorDisabled ? null : this.radioButtonBorderColorDisabled),
      radioButtonListItemBackgroundColor:
          radioButtonListItemBackgroundColor ?? (this.radioButtonListItemBackgroundColor == defaultTheme.radioButtonListItemBackgroundColor ? null : this.radioButtonListItemBackgroundColor),
      radioButtonListItemBackgroundColorHighlighted: radioButtonListItemBackgroundColorHighlighted ??
          (this.radioButtonListItemBackgroundColorHighlighted == defaultTheme.radioButtonListItemBackgroundColorHighlighted ? null : this.radioButtonListItemBackgroundColorHighlighted),
      radioButtonListItemBackgroundColorDisabled: radioButtonListItemBackgroundColorDisabled ??
          (this.radioButtonListItemBackgroundColorDisabled == defaultTheme.radioButtonListItemBackgroundColorDisabled ? null : this.radioButtonListItemBackgroundColorDisabled),
      radioButtonListItemIconColor: radioButtonListItemIconColor ?? (this.radioButtonListItemIconColor == defaultTheme.radioButtonListItemIconColor ? null : this.radioButtonListItemIconColor),
      radioButtonListItemIconColorDisabled:
          radioButtonListItemIconColorDisabled ?? (this.radioButtonListItemIconColorDisabled == defaultTheme.radioButtonListItemIconColorDisabled ? null : this.radioButtonListItemIconColorDisabled),
      radioButtonListItemTextStyle: radioButtonListItemTextStyle ?? (this.radioButtonListItemTextStyle == defaultTheme.radioButtonListItemTextStyle ? null : this.radioButtonListItemTextStyle),
      radioButtonListItemTextStyleDisabled:
          radioButtonListItemTextStyleDisabled ?? (this.radioButtonListItemTextStyleDisabled == defaultTheme.radioButtonListItemTextStyleDisabled ? null : this.radioButtonListItemTextStyleDisabled),
      radioButtonListItemSecondaryTextStyle: radioButtonListItemSecondaryTextStyle ??
          (this.radioButtonListItemSecondaryTextStyle == defaultTheme.radioButtonListItemSecondaryTextStyle ? null : this.radioButtonListItemSecondaryTextStyle),
      radioButtonListItemSecondaryTextStyleDisabled: radioButtonListItemSecondaryTextStyleDisabled ??
          (this.radioButtonListItemSecondaryTextStyleDisabled == defaultTheme.radioButtonListItemSecondaryTextStyleDisabled ? null : this.radioButtonListItemSecondaryTextStyleDisabled),

      // SegmentedButton
      segmentedButtonBackgroundColor:
          segmentedButtonBackgroundColor ?? (this.segmentedButtonBackgroundColor == defaultTheme.segmentedButtonBackgroundColor ? null : this.segmentedButtonBackgroundColor),
      segmentedButtonSelectedColor: segmentedButtonSelectedColor ?? (this.segmentedButtonSelectedColor == defaultTheme.segmentedButtonSelectedColor ? null : this.segmentedButtonSelectedColor),
      segmentedButtonTextStyle: segmentedButtonTextStyle ?? (this.segmentedButtonTextStyle == defaultTheme.segmentedButtonTextStyle ? null : this.segmentedButtonTextStyle),

      // TextField
      textFieldTextStyle: textFieldTextStyle ?? (this.textFieldTextStyle == defaultTheme.textFieldTextStyle ? null : this.textFieldTextStyle),
      textFieldTextStyleDisabled: textFieldTextStyleDisabled ?? (this.textFieldTextStyleDisabled == defaultTheme.textFieldTextStyleDisabled ? null : this.textFieldTextStyleDisabled),
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle ?? (this.textFieldPlaceholderTextStyle == defaultTheme.textFieldPlaceholderTextStyle ? null : this.textFieldPlaceholderTextStyle),
      textFieldPlaceholderTextStyleDisabled: textFieldPlaceholderTextStyleDisabled ??
          (this.textFieldPlaceholderTextStyleDisabled == defaultTheme.textFieldPlaceholderTextStyleDisabled ? null : this.textFieldPlaceholderTextStyleDisabled),
      textFieldErrorTextStyle: textFieldErrorTextStyle ?? (this.textFieldErrorTextStyle == defaultTheme.textFieldErrorTextStyle ? null : this.textFieldErrorTextStyle),
      textFieldDividerColor: textFieldDividerColor ?? (this.textFieldDividerColor == defaultTheme.textFieldDividerColor ? null : this.textFieldDividerColor),
      textFieldDividerColorHighlighted:
          textFieldDividerColorHighlighted ?? (this.textFieldDividerColorHighlighted == defaultTheme.textFieldDividerColorHighlighted ? null : this.textFieldDividerColorHighlighted),
      textFieldDividerColorError: textFieldDividerColorError ?? (this.textFieldDividerColorError == defaultTheme.textFieldDividerColorError ? null : this.textFieldDividerColorError),
      textFieldCursorColor: textFieldCursorColor ?? (this.textFieldCursorColor == defaultTheme.textFieldCursorColor ? null : this.textFieldCursorColor),
      textFieldSelectionColor: textFieldSelectionColor ?? (this.textFieldSelectionColor == defaultTheme.textFieldSelectionColor ? null : this.textFieldSelectionColor),
      textFieldSelectionHandleColor: textFieldSelectionHandleColor ?? (this.textFieldSelectionHandleColor == defaultTheme.textFieldSelectionHandleColor ? null : this.textFieldSelectionHandleColor),
      textFieldIconColor: textFieldIconColor ?? (this.textFieldIconColor == defaultTheme.textFieldIconColor ? null : this.textFieldIconColor),
      textFieldIconColorDisabled: textFieldIconColorDisabled ?? (this.textFieldIconColorDisabled == defaultTheme.textFieldIconColorDisabled ? null : this.textFieldIconColorDisabled),

      // Group
      groupBackgroundColor: groupBackgroundColor ?? (this.groupBackgroundColor == defaultTheme.groupBackgroundColor ? null : this.groupBackgroundColor),

      // Accordion
      accordionTitleTextStyle: accordionTitleTextStyle ?? (this.accordionTitleTextStyle == defaultTheme.accordionTitleTextStyle ? null : this.accordionTitleTextStyle),
      accordionBodyTextStyle: accordionBodyTextStyle ?? (this.accordionBodyTextStyle == defaultTheme.accordionBodyTextStyle ? null : this.accordionBodyTextStyle),
      accordionBackgroundColor: accordionBackgroundColor ?? (this.accordionBackgroundColor == defaultTheme.accordionBackgroundColor ? null : this.accordionBackgroundColor),

      // Modal
      modalBackgroundColor: modalBackgroundColor ?? (this.modalBackgroundColor == defaultTheme.modalBackgroundColor ? null : this.modalBackgroundColor),
      modalTitleTextStyle: modalTitleTextStyle ?? (this.modalTitleTextStyle == defaultTheme.modalTitleTextStyle ? null : this.modalTitleTextStyle),

      // Select
      selectLabelTextStyle: selectLabelTextStyle ?? (this.selectLabelTextStyle == defaultTheme.selectLabelTextStyle ? null : this.selectLabelTextStyle),
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled ?? (this.selectLabelTextStyleDisabled == defaultTheme.selectLabelTextStyleDisabled ? null : this.selectLabelTextStyleDisabled),

      // Toast
      toastTextStyle: toastTextStyle ?? (this.toastTextStyle == defaultTheme.toastTextStyle ? null : this.toastTextStyle),
      toastBackgroundColor: toastBackgroundColor ?? (this.toastBackgroundColor == defaultTheme.toastBackgroundColor ? null : this.toastBackgroundColor),

      // Tab Bar
      tabBarTextStyle: tabBarTextStyle ?? (this.tabBarTextStyle == defaultTheme.tabBarTextStyle ? null : this.tabBarTextStyle),
    );
  }

  void _setDefaultValues({
    Brightness? brightness,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,

    // PrimaryButton
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonBackgroundColorHighlighted,
    Color? primaryButtonBackgroundColorDisabled,
    Color? primaryButtonBackgroundColorLoading,
    TextStyle? primaryButtonTextStyle,
    TextStyle? primaryButtonTextStyleHighlighted,
    TextStyle? primaryButtonTextStyleDisabled,
    TextStyle? primaryButtonTextStyleLoading,

    // PrimaryButtonNegative
    Color? primaryButtonNegativeBackgroundColor,
    Color? primaryButtonNegativeBackgroundColorHighlighted,
    Color? primaryButtonNegativeBackgroundColorDisabled,
    Color? primaryButtonNegativeBackgroundColorLoading,
    Color? primaryButtonNegativeBorderColor,
    Color? primaryButtonNegativeBorderColorHighlighted,
    Color? primaryButtonNegativeBorderColorDisabled,
    Color? primaryButtonNegativeBorderColorLoading,
    TextStyle? primaryButtonNegativeTextStyle,
    TextStyle? primaryButtonNegativeTextStyleHighlighted,
    TextStyle? primaryButtonNegativeTextStyleDisabled,
    TextStyle? primaryButtonNegativeTextStyleLoading,

    // SecondaryButton
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonBackgroundColorHighlighted,
    Color? secondaryButtonBackgroundColorDisabled,
    Color? secondaryButtonBackgroundColorLoading,
    Color? secondaryButtonBorderColor,
    Color? secondaryButtonBorderColorHighlighted,
    Color? secondaryButtonBorderColorDisabled,
    Color? secondaryButtonBorderColorLoading,
    TextStyle? secondaryButtonTextStyle,
    TextStyle? secondaryButtonTextStyleHighlighted,
    TextStyle? secondaryButtonTextStyleDisabled,
    TextStyle? secondaryButtonTextStyleLoading,

    // TertiaryButtonLarge
    Color? tertiaryButtonLargeBackgroundColor,
    Color? tertiaryButtonLargeBackgroundColorHighlighted,
    Color? tertiaryButtonLargeBackgroundColorDisabled,
    Color? tertiaryButtonLargeBorderColor,
    Color? tertiaryButtonLargeBorderColorHighlighted,
    Color? tertiaryButtonLargeBorderColorDisabled,
    TextStyle? tertiaryButtonLargeTextStyle,
    TextStyle? tertiaryButtonLargeTextStyleHighlighted,
    TextStyle? tertiaryButtonLargeTextStyleDisabled,

    // TertiaryButtonSmall
    Color? tertiaryButtonSmallBackgroundColor,
    Color? tertiaryButtonSmallBackgroundColorHighlighted,
    Color? tertiaryButtonSmallBackgroundColorDisabled,
    Color? tertiaryButtonSmallBorderColor,
    Color? tertiaryButtonSmallBorderColorHighlighted,
    Color? tertiaryButtonSmallBorderColorDisabled,
    TextStyle? tertiaryButtonSmallTextStyle,
    TextStyle? tertiaryButtonSmallTextStyleHighlighted,
    TextStyle? tertiaryButtonSmallTextStyleDisabled,

    // IconButtonLarge
    Color? iconButtonLargeBackgroundColor,
    Color? iconButtonLargeBackgroundColorHighlighted,
    Color? iconButtonLargeBackgroundColorDisabled,
    Color? iconButtonLargeBorderColor,
    Color? iconButtonLargeBorderColorHighlighted,
    Color? iconButtonLargeBorderColorDisabled,
    Color? iconButtonLargeIconColor,
    Color? iconButtonLargeIconColorHighlighted,
    Color? iconButtonLargeIconColorDisabled,

    // IconButtonSmall
    Color? iconButtonSmallBackgroundColor,
    Color? iconButtonSmallBackgroundColorHighlighted,
    Color? iconButtonSmallBackgroundColorDisabled,
    Color? iconButtonSmallBorderColor,
    Color? iconButtonSmallBorderColorHighlighted,
    Color? iconButtonSmallBorderColorDisabled,
    Color? iconButtonSmallIconColor,
    Color? iconButtonSmallIconColorHighlighted,
    Color? iconButtonSmallIconColorDisabled,

    // IconButtonSmallNegative
    Color? iconButtonSmallNegativeBackgroundColor,
    Color? iconButtonSmallNegativeBackgroundColorHighlighted,
    Color? iconButtonSmallNegativeBackgroundColorDisabled,
    Color? iconButtonSmallNegativeBorderColor,
    Color? iconButtonSmallNegativeBorderColorHighlighted,
    Color? iconButtonSmallNegativeBorderColorDisabled,
    Color? iconButtonSmallNegativeIconColor,
    Color? iconButtonSmallNegativeIconColorHighlighted,
    Color? iconButtonSmallNegativeIconColorDisabled,

    // IconButtonSmallBorderless
    Color? iconButtonSmallBorderlessBackgroundColor,
    Color? iconButtonSmallBorderlessBackgroundColorHighlighted,
    Color? iconButtonSmallBorderlessBackgroundColorDisabled,
    Color? iconButtonSmallBorderlessIconColor,
    Color? iconButtonSmallBorderlessIconColorHighlighted,
    Color? iconButtonSmallBorderlessIconColorDisabled,

    // IconFormButton
    Color? iconFormButtonBackgroundColor,
    Color? iconFormButtonBackgroundColorHighlighted,
    Color? iconFormButtonBackgroundColorDisabled,
    Color? iconFormButtonBorderColor,
    Color? iconFormButtonBorderColorHighlighted,
    Color? iconFormButtonBorderColorDisabled,
    Color? iconFormButtonIconColor,
    Color? iconFormButtonIconColorHighlighted,
    Color? iconFormButtonIconColorDisabled,

    // IconTextButton
    Color? iconTextButtonBackgroundColor,
    Color? iconTextButtonBackgroundColorHighlighted,
    Color? iconTextButtonBackgroundColorDisabled,
    Color? iconTextButtonIconColor,
    Color? iconTextButtonIconColorHighlighted,
    Color? iconTextButtonIconColorDisabled,
    TextStyle? iconTextButtonTextStyle,
    TextStyle? iconTextButtonTextStyleHighlighted,
    TextStyle? iconTextButtonTextStyleDisabled,

    // Link
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,

    //ListHeader
    TextStyle? listHeaderTextStyle,

    // ListItem
    Color? listItemBackgroundColor,
    Color? listItemBackgroundColorHighlighted,
    TextStyle? listItemTitleTextStyle,
    TextStyle? listItemSubtitleTextStyle,

    // Checkbox
    Color? checkboxColor,
    Color? checkboxColorDisabled,
    Color? checkboxBackgroundColor,
    Color? checkboxBackgroundColorHighlighted,
    Color? checkboxBackgroundColorDisabled,
    Color? checkboxBorderColor,
    Color? checkboxBorderColorDisabled,
    Color? checkboxListItemBackgroundColor,
    Color? checkboxListItemBackgroundColorHighlighted,
    Color? checkboxListItemBackgroundColorDisabled,
    Color? checkboxListItemIconColor,
    Color? checkboxListItemIconColorDisabled,
    TextStyle? checkboxListItemTextStyle,
    TextStyle? checkboxListItemTextStyleDisabled,
    TextStyle? checkboxListItemSecondaryTextStyle,
    TextStyle? checkboxListItemSecondaryTextStyleDisabled,

    // RadioButton
    Color? radioButtonColor,
    Color? radioButtonColorDisabled,
    Color? radioButtonBackgroundColor,
    Color? radioButtonBackgroundColorHighlighted,
    Color? radioButtonBackgroundColorDisabled,
    Color? radioButtonBorderColor,
    Color? radioButtonBorderColorDisabled,
    Color? radioButtonListItemBackgroundColor,
    Color? radioButtonListItemBackgroundColorHighlighted,
    Color? radioButtonListItemBackgroundColorDisabled,
    Color? radioButtonListItemIconColor,
    Color? radioButtonListItemIconColorDisabled,
    TextStyle? radioButtonListItemTextStyle,
    TextStyle? radioButtonListItemTextStyleDisabled,
    TextStyle? radioButtonListItemSecondaryTextStyle,
    TextStyle? radioButtonListItemSecondaryTextStyleDisabled,

    // SegmentedButton
    Color? segmentedButtonBackgroundColor,
    Color? segmentedButtonSelectedColor,
    TextStyle? segmentedButtonTextStyle,

    // TextField
    TextStyle? textFieldTextStyle,
    TextStyle? textFieldTextStyleDisabled,
    TextStyle? textFieldPlaceholderTextStyle,
    TextStyle? textFieldPlaceholderTextStyleDisabled,
    TextStyle? textFieldErrorTextStyle,
    Color? textFieldDividerColor,
    Color? textFieldDividerColorHighlighted,
    Color? textFieldDividerColorError,
    Color? textFieldCursorColor,
    Color? textFieldSelectionColor,
    Color? textFieldSelectionHandleColor,
    Color? textFieldIconColor,
    Color? textFieldIconColorDisabled,

    // Group
    Color? groupBackgroundColor,

    // Accordion
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,

    // Modal
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,

    // Select
    TextStyle? selectLabelTextStyle,
    TextStyle? selectLabelTextStyleDisabled,

    // Toast
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,

    // Tab Bar
    TextStyle? tabBarTextStyle,
  }) {
    this.brightness = brightness ?? Brightness.light;

    themeValue<T>(T lightThemeValue, T darkThemeValue) => this.brightness == Brightness.light ? lightThemeValue : darkThemeValue;

    this.primaryColor = primaryColor ?? SBBColors.red;
    this.primaryColorDark = primaryColorDark ?? SBBColors.red125;
    this.primarySwatch = primarySwatch ??
        MaterialColor(
          this.primaryColor.value,
          <int, Color>{
            50: this.primaryColor,
            100: this.primaryColor,
            200: this.primaryColor,
            300: this.primaryColor,
            400: this.primaryColor,
            500: this.primaryColor,
            600: this.primaryColor,
            700: this.primaryColor,
            800: this.primaryColor,
            900: this.primaryColor,
          },
        );
    this.backgroundColor = backgroundColor ?? themeValue(SBBColors.milk, SBBColors.black);
    this.fontFamily = fontFamily ?? defaultTextStyle?.fontFamily ?? SBBWebFont;
    this.defaultTextColor = defaultTextColor ?? defaultTextStyle?.color ?? themeValue(SBBColors.black, SBBColors.white);
    this.defaultTextStyle =
        (defaultTextStyle ?? SBBTextStyles.mediumLight).copyWith(fontFamily: defaultTextStyle?.fontFamily ?? this.fontFamily, color: defaultTextStyle?.color ?? this.defaultTextColor);
    this.dividerColor = dividerColor ?? themeValue(SBBColors.cloud, const Color(0xFF2A2A2A));
    this.defaultRootContainerPadding = defaultRootContainerPadding ?? sbbDefaultSpacing;

    themedTextStyle({TextStyle? textStyle, Color? color}) => (textStyle ?? this.defaultTextStyle).copyWith(fontFamily: this.fontFamily, color: color ?? this.defaultTextColor);

    // Icon
    this.iconColor = iconColor ?? themeValue(SBBColors.black, SBBColors.white);

    // Header
    this.headerBackgroundColor = headerBackgroundColor ?? this.primaryColor;
    this.headerButtonBackgroundColorHighlighted = headerButtonBackgroundColorHighlighted ?? this.primaryColorDark;
    this.headerIconColor = headerIconColor ?? SBBColors.white;
    this.headerTextStyle = headerTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.largeLight, color: this.headerIconColor);

    // PrimaryButton
    this.primaryButtonBackgroundColor = primaryButtonBackgroundColor ?? this.primaryColor;
    this.primaryButtonBackgroundColorHighlighted = primaryButtonBackgroundColorHighlighted ?? this.primaryColorDark;
    this.primaryButtonBackgroundColorDisabled = primaryButtonBackgroundColorDisabled ?? themeValue(SBBColors.cement, SBBColors.iron);
    this.primaryButtonBackgroundColorLoading = primaryButtonBackgroundColorLoading ?? this.primaryButtonBackgroundColorDisabled;
    this.primaryButtonTextStyle = primaryButtonTextStyle ?? themedTextStyle(color: SBBColors.white);
    this.primaryButtonTextStyleHighlighted = primaryButtonTextStyleHighlighted ?? this.primaryButtonTextStyle;
    this.primaryButtonTextStyleDisabled = primaryButtonTextStyleDisabled ?? this.primaryButtonTextStyle;
    this.primaryButtonTextStyleLoading = primaryButtonTextStyleLoading ?? this.primaryButtonTextStyleDisabled;

    // PrimaryButtonNegative
    this.primaryButtonNegativeBackgroundColor = primaryButtonNegativeBackgroundColor ?? SBBColors.transparent;
    this.primaryButtonNegativeBackgroundColorHighlighted = primaryButtonNegativeBackgroundColorHighlighted ?? themeValue(SBBColors.black.withOpacity(0.2), SBBColors.white.withOpacity(0.2));
    this.primaryButtonNegativeBackgroundColorDisabled = primaryButtonNegativeBackgroundColorDisabled ?? SBBColors.transparent;
    this.primaryButtonNegativeBackgroundColorLoading = primaryButtonNegativeBackgroundColorLoading ?? this.primaryButtonNegativeBackgroundColorDisabled;
    this.primaryButtonNegativeBorderColor = primaryButtonNegativeBorderColor ?? SBBColors.white;
    this.primaryButtonNegativeBorderColorHighlighted = primaryButtonNegativeBorderColorHighlighted ?? this.primaryButtonNegativeBorderColor;
    this.primaryButtonNegativeBorderColorDisabled = primaryButtonNegativeBorderColorDisabled ?? SBBColors.white.withOpacity(0.5);
    this.primaryButtonNegativeBorderColorLoading = primaryButtonNegativeBorderColorLoading ?? this.primaryButtonNegativeBorderColorDisabled;
    this.primaryButtonNegativeTextStyle = primaryButtonNegativeTextStyle ?? themedTextStyle(color: SBBColors.white);
    this.primaryButtonNegativeTextStyleHighlighted = primaryButtonNegativeTextStyleHighlighted ?? this.primaryButtonNegativeTextStyle;
    this.primaryButtonNegativeTextStyleDisabled = primaryButtonNegativeTextStyleDisabled ?? this.primaryButtonNegativeTextStyle;
    this.primaryButtonNegativeTextStyleLoading = primaryButtonNegativeTextStyleLoading ?? this.primaryButtonNegativeTextStyleDisabled;

    // SecondaryButton
    this.secondaryButtonBackgroundColor = secondaryButtonBackgroundColor ?? SBBColors.transparent;
    this.secondaryButtonBackgroundColorHighlighted = secondaryButtonBackgroundColorHighlighted ?? themeValue(SBBColors.milk, SBBColors.iron);
    this.secondaryButtonBackgroundColorDisabled = secondaryButtonBackgroundColorDisabled ?? this.secondaryButtonBackgroundColor;
    this.secondaryButtonBackgroundColorLoading = secondaryButtonBackgroundColorLoading ?? this.secondaryButtonBackgroundColorDisabled;
    this.secondaryButtonBorderColor = secondaryButtonBorderColor ?? this.primaryColor;
    this.secondaryButtonBorderColorHighlighted = secondaryButtonBorderColorHighlighted ?? this.primaryColorDark;
    this.secondaryButtonBorderColorDisabled = secondaryButtonBorderColorDisabled ?? themeValue(SBBColors.cement, SBBColors.iron);
    this.secondaryButtonBorderColorLoading = secondaryButtonBorderColorLoading ?? this.secondaryButtonBorderColorDisabled;
    this.secondaryButtonTextStyle = secondaryButtonTextStyle ?? themedTextStyle(color: this.primaryColor);
    this.secondaryButtonTextStyleHighlighted = secondaryButtonTextStyleHighlighted ?? themedTextStyle(color: this.primaryColorDark);
    this.secondaryButtonTextStyleDisabled = secondaryButtonTextStyleDisabled ?? themedTextStyle(color: SBBColors.metal);
    this.secondaryButtonTextStyleLoading = secondaryButtonTextStyleLoading ?? this.secondaryButtonTextStyleDisabled;

    // TertiaryButtonLarge
    this.tertiaryButtonLargeBackgroundColor = tertiaryButtonLargeBackgroundColor ?? themeValue(SBBColors.white, SBBColors.transparent);
    this.tertiaryButtonLargeBackgroundColorHighlighted = tertiaryButtonLargeBackgroundColorHighlighted ?? themeValue(SBBColors.milk, SBBColors.iron);
    this.tertiaryButtonLargeBackgroundColorDisabled = tertiaryButtonLargeBackgroundColorDisabled ?? themeValue(SBBColors.transparent, SBBColors.transparent);
    this.tertiaryButtonLargeBorderColor = tertiaryButtonLargeBorderColor ?? SBBColors.smoke;
    this.tertiaryButtonLargeBorderColorHighlighted = tertiaryButtonLargeBorderColorHighlighted ?? this.tertiaryButtonLargeBorderColor;
    this.tertiaryButtonLargeBorderColorDisabled = tertiaryButtonLargeBorderColorDisabled ?? themeValue(SBBColors.cloud, SBBColors.iron);
    this.tertiaryButtonLargeTextStyle = tertiaryButtonLargeTextStyle ?? themedTextStyle();
    this.tertiaryButtonLargeTextStyleHighlighted = tertiaryButtonLargeTextStyleHighlighted ?? this.tertiaryButtonLargeTextStyle;
    this.tertiaryButtonLargeTextStyleDisabled = tertiaryButtonLargeTextStyleDisabled ?? this.tertiaryButtonLargeTextStyle.copyWith(color: SBBColors.metal);

    // TertiaryButtonSmall
    this.tertiaryButtonSmallBackgroundColor = tertiaryButtonSmallBackgroundColor ?? this.tertiaryButtonLargeBackgroundColor;
    this.tertiaryButtonSmallBackgroundColorHighlighted = tertiaryButtonSmallBackgroundColorHighlighted ?? this.tertiaryButtonLargeBackgroundColorHighlighted;
    this.tertiaryButtonSmallBackgroundColorDisabled = tertiaryButtonSmallBackgroundColorDisabled ?? this.tertiaryButtonLargeBackgroundColorDisabled;
    this.tertiaryButtonSmallBorderColor = tertiaryButtonSmallBorderColor ?? this.tertiaryButtonLargeBorderColor;
    this.tertiaryButtonSmallBorderColorHighlighted = tertiaryButtonSmallBorderColorHighlighted ?? this.tertiaryButtonLargeBorderColorHighlighted;
    this.tertiaryButtonSmallBorderColorDisabled = tertiaryButtonSmallBorderColorDisabled ?? this.tertiaryButtonLargeBorderColorDisabled;
    this.tertiaryButtonSmallTextStyle = tertiaryButtonSmallTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.smallLight);
    this.tertiaryButtonSmallTextStyleHighlighted = tertiaryButtonSmallTextStyleHighlighted ?? this.tertiaryButtonSmallTextStyle;
    this.tertiaryButtonSmallTextStyleDisabled = tertiaryButtonSmallTextStyleDisabled ?? this.tertiaryButtonSmallTextStyle.copyWith(color: this.tertiaryButtonLargeTextStyleDisabled.color);

    // IconButtonLarge
    this.iconButtonLargeBackgroundColor = iconButtonLargeBackgroundColor ?? this.tertiaryButtonLargeBackgroundColor;
    this.iconButtonLargeBackgroundColorHighlighted = iconButtonLargeBackgroundColorHighlighted ?? this.tertiaryButtonLargeBackgroundColorHighlighted;
    this.iconButtonLargeBackgroundColorDisabled = iconButtonLargeBackgroundColorDisabled ?? SBBColors.transparent;
    this.iconButtonLargeBorderColor = iconButtonLargeBorderColor ?? this.tertiaryButtonLargeBorderColor;
    this.iconButtonLargeBorderColorHighlighted = iconButtonLargeBorderColorHighlighted ?? this.tertiaryButtonLargeBorderColorHighlighted;
    this.iconButtonLargeBorderColorDisabled = iconButtonLargeBorderColorDisabled ?? themeValue(SBBColors.cloud, SBBColors.iron);
    this.iconButtonLargeIconColor = iconButtonLargeIconColor ?? this.iconColor;
    this.iconButtonLargeIconColorHighlighted = iconButtonLargeIconColorHighlighted ?? this.iconButtonLargeIconColor;
    this.iconButtonLargeIconColorDisabled = iconButtonLargeIconColorDisabled ?? this.iconButtonLargeBorderColorDisabled;

    // IconButtonSmall
    this.iconButtonSmallBackgroundColor = iconButtonSmallBackgroundColor ?? this.iconButtonLargeBackgroundColor;
    this.iconButtonSmallBackgroundColorHighlighted = iconButtonSmallBackgroundColorHighlighted ?? this.iconButtonLargeBackgroundColorHighlighted;
    this.iconButtonSmallBackgroundColorDisabled = iconButtonSmallBackgroundColorDisabled ?? this.iconButtonLargeBackgroundColorDisabled;
    this.iconButtonSmallBorderColor = iconButtonSmallBorderColor ?? this.iconButtonLargeBorderColor;
    this.iconButtonSmallBorderColorHighlighted = iconButtonSmallBorderColorHighlighted ?? this.iconButtonLargeBorderColorHighlighted;
    this.iconButtonSmallBorderColorDisabled = iconButtonSmallBorderColorDisabled ?? this.iconButtonLargeBorderColorDisabled;
    this.iconButtonSmallIconColor = iconButtonSmallIconColor ?? this.iconButtonLargeIconColor;
    this.iconButtonSmallIconColorHighlighted = iconButtonSmallIconColorHighlighted ?? this.iconButtonLargeIconColorHighlighted;
    this.iconButtonSmallIconColorDisabled = iconButtonSmallIconColorDisabled ?? this.iconButtonLargeIconColorDisabled;

    // IconButtonSmallNegative
    this.iconButtonSmallNegativeBackgroundColor = iconButtonSmallNegativeBackgroundColor ?? this.primaryButtonNegativeBackgroundColor;
    this.iconButtonSmallNegativeBackgroundColorHighlighted = iconButtonSmallNegativeBackgroundColorHighlighted ?? this.primaryButtonNegativeBackgroundColorHighlighted;
    this.iconButtonSmallNegativeBackgroundColorDisabled = iconButtonSmallNegativeBackgroundColorDisabled ?? this.primaryButtonNegativeBackgroundColorDisabled;
    this.iconButtonSmallNegativeBorderColor = iconButtonSmallNegativeBorderColor ?? this.primaryButtonNegativeBorderColor;
    this.iconButtonSmallNegativeBorderColorHighlighted = iconButtonSmallNegativeBorderColorHighlighted ?? this.primaryButtonNegativeBorderColorHighlighted;
    this.iconButtonSmallNegativeBorderColorDisabled = iconButtonSmallNegativeBorderColorDisabled ?? this.primaryButtonNegativeBorderColorDisabled;
    this.iconButtonSmallNegativeIconColor = iconButtonSmallNegativeIconColor ?? this.iconButtonSmallNegativeBorderColor;
    this.iconButtonSmallNegativeIconColorHighlighted = iconButtonSmallNegativeIconColorHighlighted ?? this.iconButtonSmallNegativeBorderColorHighlighted;
    this.iconButtonSmallNegativeIconColorDisabled = iconButtonSmallNegativeIconColorDisabled ?? this.iconButtonSmallNegativeBorderColorDisabled;

    // IconButtonSmallBorderless
    this.iconButtonSmallBorderlessBackgroundColor = iconButtonSmallBorderlessBackgroundColor ?? SBBColors.transparent;
    this.iconButtonSmallBorderlessBackgroundColorHighlighted = iconButtonSmallBorderlessBackgroundColorHighlighted ?? SBBColors.transparent;
    this.iconButtonSmallBorderlessBackgroundColorDisabled = iconButtonSmallBorderlessBackgroundColorDisabled ?? SBBColors.transparent;
    this.iconButtonSmallBorderlessIconColor = iconButtonSmallBorderlessIconColor ?? this.iconButtonSmallIconColor;
    this.iconButtonSmallBorderlessIconColorHighlighted = iconButtonSmallBorderlessIconColorHighlighted ?? themeValue(SBBColors.metal, SBBColors.aluminum);
    this.iconButtonSmallBorderlessIconColorDisabled = iconButtonSmallBorderlessIconColorDisabled ?? this.iconButtonSmallIconColorDisabled;

    // IconFormButton
    this.iconFormButtonBackgroundColor = iconFormButtonBackgroundColor ?? this.iconButtonLargeBackgroundColor;
    this.iconFormButtonBackgroundColorHighlighted = iconFormButtonBackgroundColorHighlighted ?? this.iconButtonLargeBackgroundColorHighlighted;
    this.iconFormButtonBackgroundColorDisabled = iconFormButtonBackgroundColorDisabled ?? this.iconButtonLargeBackgroundColorDisabled;
    this.iconFormButtonBorderColor = iconFormButtonBorderColor ?? this.iconButtonLargeBorderColor;
    this.iconFormButtonBorderColorHighlighted = iconFormButtonBorderColorHighlighted ?? this.iconButtonLargeBorderColorHighlighted;
    this.iconFormButtonBorderColorDisabled = iconFormButtonBorderColorDisabled ?? this.iconButtonLargeBorderColorDisabled;
    this.iconFormButtonIconColor = iconFormButtonIconColor ?? this.iconButtonLargeIconColor;
    this.iconFormButtonIconColorHighlighted = iconFormButtonIconColorHighlighted ?? this.iconButtonLargeIconColorHighlighted;
    this.iconFormButtonIconColorDisabled = iconFormButtonIconColorDisabled ?? this.iconButtonLargeIconColorDisabled;

    // IconTextButton
    this.iconTextButtonBackgroundColor = iconTextButtonBackgroundColor ?? themeValue(SBBColors.white, SBBColors.charcoal);
    this.iconTextButtonBackgroundColorHighlighted = iconTextButtonBackgroundColorHighlighted ?? themeValue(SBBColors.milk, SBBColors.iron);
    this.iconTextButtonBackgroundColorDisabled = iconTextButtonBackgroundColorDisabled ?? this.iconTextButtonBackgroundColor;
    this.iconTextButtonTextStyle = iconTextButtonTextStyle ?? this.tertiaryButtonSmallTextStyle;
    this.iconTextButtonTextStyleHighlighted = iconTextButtonTextStyleHighlighted ?? this.tertiaryButtonSmallTextStyleHighlighted;
    this.iconTextButtonTextStyleDisabled = iconTextButtonTextStyleDisabled ?? this.tertiaryButtonSmallTextStyleDisabled;
    this.iconTextButtonIconColor = iconTextButtonIconColor ?? this.iconTextButtonTextStyle.color!;
    this.iconTextButtonIconColorHighlighted = iconTextButtonIconColorHighlighted ?? this.iconTextButtonTextStyleHighlighted.color!;
    this.iconTextButtonIconColorDisabled = iconTextButtonIconColorDisabled ?? this.iconTextButtonTextStyleDisabled.color!;

    // Link
    this.linkTextStyle = linkTextStyle ?? this.defaultTextStyle.copyWith(color: this.primaryColor);
    this.linkTextStyleHighlighted = linkTextStyleHighlighted ?? this.linkTextStyle.copyWith(color: themeValue(this.primaryColorDark, SBBColors.white));

    //ListHeader
    this.listHeaderTextStyle = listHeaderTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.smallLight);

    // ListItem
    this.listItemBackgroundColor = listItemBackgroundColor ?? SBBColors.transparent;
    this.listItemBackgroundColorHighlighted = listItemBackgroundColorHighlighted ?? themeValue(SBBColors.milk, SBBColors.iron);
    this.listItemTitleTextStyle = listItemTitleTextStyle ?? themedTextStyle();
    this.listItemSubtitleTextStyle =
        listItemSubtitleTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.extraSmallLight.copyWith(height: 16.0 / 12.0), color: themeValue(SBBColors.metal, SBBColors.cement));

    // Checkbox TODO define toggleable colors for checkbox and radiobutton?
    this.checkboxColor = checkboxColor ?? this.primaryColor;
    this.checkboxColorDisabled = checkboxColorDisabled ?? SBBColors.metal;
    this.checkboxBackgroundColor = checkboxBackgroundColor ?? themeValue(SBBColors.white, SBBColors.transparent);
    this.checkboxBackgroundColorHighlighted = checkboxBackgroundColorHighlighted ?? this.listItemBackgroundColorHighlighted;
    this.checkboxBackgroundColorDisabled = checkboxBackgroundColorDisabled ?? SBBColors.transparent;
    this.checkboxBorderColor = checkboxBorderColor ?? SBBColors.smoke;
    this.checkboxBorderColorDisabled = checkboxBorderColorDisabled ?? themeValue(SBBColors.cloud, SBBColors.iron);
    this.checkboxListItemBackgroundColor = checkboxListItemBackgroundColor ?? this.listItemBackgroundColor;
    this.checkboxListItemBackgroundColorHighlighted = checkboxListItemBackgroundColorHighlighted ?? this.listItemBackgroundColorHighlighted;
    this.checkboxListItemBackgroundColorDisabled = checkboxListItemBackgroundColorDisabled ?? this.checkboxListItemBackgroundColor;
    this.checkboxListItemIconColor = checkboxListItemIconColor ?? this.iconColor;
    this.checkboxListItemIconColorDisabled = checkboxListItemIconColorDisabled ?? SBBColors.metal;
    this.checkboxListItemTextStyle = checkboxListItemTextStyle ?? this.listItemTitleTextStyle;
    this.checkboxListItemTextStyleDisabled = checkboxListItemTextStyleDisabled ?? this.listItemTitleTextStyle.copyWith(color: SBBColors.metal);
    this.checkboxListItemSecondaryTextStyle = checkboxListItemSecondaryTextStyle ?? this.listItemSubtitleTextStyle;
    this.checkboxListItemSecondaryTextStyleDisabled = checkboxListItemSecondaryTextStyleDisabled ?? this.checkboxListItemSecondaryTextStyle.copyWith(color: SBBColors.metal);

    // RadioButton TODO define toggleable colors for checkbox and radiobutton?
    this.radioButtonColor = radioButtonColor ?? this.primaryColor;
    this.radioButtonColorDisabled = radioButtonColorDisabled ?? SBBColors.metal;
    this.radioButtonBackgroundColor = radioButtonBackgroundColor ?? themeValue(SBBColors.white, SBBColors.transparent);
    this.radioButtonBackgroundColorHighlighted = radioButtonBackgroundColorHighlighted ?? this.listItemBackgroundColorHighlighted;
    this.radioButtonBackgroundColorDisabled = radioButtonBackgroundColorDisabled ?? SBBColors.transparent;
    this.radioButtonBorderColor = radioButtonBorderColor ?? SBBColors.smoke;
    this.radioButtonBorderColorDisabled = radioButtonBorderColorDisabled ?? themeValue(SBBColors.cloud, SBBColors.iron);
    this.radioButtonListItemBackgroundColor = radioButtonListItemBackgroundColor ?? this.listItemBackgroundColor;
    this.radioButtonListItemBackgroundColorHighlighted = radioButtonListItemBackgroundColorHighlighted ?? this.listItemBackgroundColorHighlighted;
    this.radioButtonListItemBackgroundColorDisabled = radioButtonListItemBackgroundColorDisabled ?? this.radioButtonListItemBackgroundColor;
    this.radioButtonListItemIconColor = radioButtonListItemIconColor ?? this.iconColor;
    this.radioButtonListItemIconColorDisabled = radioButtonListItemIconColorDisabled ?? SBBColors.metal;
    this.radioButtonListItemTextStyle = radioButtonListItemTextStyle ?? this.listItemTitleTextStyle;
    this.radioButtonListItemTextStyleDisabled = radioButtonListItemTextStyleDisabled ?? this.listItemTitleTextStyle.copyWith(color: SBBColors.metal);
    this.radioButtonListItemSecondaryTextStyle = radioButtonListItemSecondaryTextStyle ?? this.listItemSubtitleTextStyle;
    this.radioButtonListItemSecondaryTextStyleDisabled = radioButtonListItemSecondaryTextStyleDisabled ?? this.radioButtonListItemSecondaryTextStyle.copyWith(color: SBBColors.metal);

    // SegmentedButton
    this.segmentedButtonBackgroundColor = segmentedButtonBackgroundColor ?? themeValue(SBBColors.cloud, SBBColors.iron);
    this.segmentedButtonSelectedColor = segmentedButtonSelectedColor ?? themeValue(SBBColors.white, SBBColors.black);
    this.segmentedButtonTextStyle = segmentedButtonTextStyle ?? themedTextStyle();

    // TextField
    this.textFieldTextStyle = textFieldTextStyle ?? themedTextStyle();
    this.textFieldTextStyleDisabled = textFieldTextStyleDisabled ?? this.textFieldTextStyle.copyWith(color: SBBColors.metal);
    this.textFieldPlaceholderTextStyle = textFieldPlaceholderTextStyle ?? themedTextStyle(color: themeValue(SBBColors.metal, SBBColors.cement));
    this.textFieldPlaceholderTextStyleDisabled =
        textFieldPlaceholderTextStyleDisabled ?? themeValue(this.textFieldPlaceholderTextStyle, this.textFieldPlaceholderTextStyle.copyWith(color: SBBColors.metal));
    this.textFieldErrorTextStyle = textFieldErrorTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.helpersLabel, color: SBBColors.red150);
    this.textFieldDividerColor = textFieldDividerColor ?? this.dividerColor;
    this.textFieldDividerColorHighlighted = textFieldDividerColorHighlighted ?? themeValue(SBBColors.black, SBBColors.white);
    this.textFieldDividerColorError = textFieldDividerColorError ?? SBBColors.red;
    this.textFieldCursorColor = textFieldCursorColor ?? SBBColors.sky;
    this.textFieldSelectionColor = textFieldSelectionColor ?? this.textFieldCursorColor.withOpacity(0.5);
    this.textFieldSelectionHandleColor = textFieldSelectionHandleColor ?? this.textFieldCursorColor;
    this.textFieldIconColor = textFieldIconColor ?? this.iconColor;
    this.textFieldIconColorDisabled = textFieldIconColorDisabled ?? SBBColors.metal;

    // Group
    this.groupBackgroundColor = groupBackgroundColor ?? themeValue(SBBColors.white, SBBColors.charcoal);

    // Accordion
    this.accordionTitleTextStyle = accordionTitleTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.largeLight);
    this.accordionBodyTextStyle = accordionBodyTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.smallLight);
    this.accordionBackgroundColor = accordionBackgroundColor ?? this.groupBackgroundColor;

    // Modal
    this.modalBackgroundColor = modalBackgroundColor ?? themeValue(SBBColors.milk, SBBColors.midnight);
    this.modalTitleTextStyle = modalTitleTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.largeLight);

    // Select
    this.selectLabelTextStyle = selectLabelTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.helpersLabel, color: this.textFieldPlaceholderTextStyle.color);
    this.selectLabelTextStyleDisabled = selectLabelTextStyleDisabled ?? this.selectLabelTextStyle.copyWith(color: this.textFieldPlaceholderTextStyleDisabled.color);

    // Toast
    this.toastTextStyle = toastTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.smallLight, color: SBBColors.white);
    this.toastBackgroundColor = toastBackgroundColor ?? themeValue(SBBColors.black.withOpacity(0.5), SBBColors.white.withOpacity(0.3));

    // Tab Bar
    this.tabBarTextStyle = tabBarTextStyle ?? themedTextStyle(textStyle: SBBTextStyles.extraSmallLight.copyWith(fontWeight: FontWeight.w500));
  }

  ThemeData createTheme() {
    final baseButtonStyle = ButtonStyle(
      overlayColor: SBBInternal.all(SBBColors.transparent),
      shape: SBBInternal.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(SBBInternal.defaultButtonHeight / 2))),
      fixedSize: SBBInternal.all(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
      padding: SBBInternal.all(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
      elevation: SBBInternal.all(0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mouseCursor: MaterialStateMouseCursor.clickable,
    );

    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      primarySwatch: primarySwatch,
      primaryColorDark: primaryColor,
      accentColor: primaryColor,
      toggleableActiveColor: primaryColor,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor, size: sbbIconSizeSmall),
      dividerTheme: DividerThemeData(thickness: 1.0, space: 0.0, color: dividerColor),
      fontFamily: fontFamily,
      textTheme: TextTheme(
        bodyText1: defaultTextStyle,
        bodyText2: defaultTextStyle,
      ),
      appBarTheme: AppBarTheme(
        color: headerBackgroundColor,
        iconTheme: IconThemeData(color: headerIconColor),
        actionsIconTheme: IconThemeData(color: headerIconColor),
        elevation: 0.0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseButtonStyle.copyWith(
          overlayColor: SBBInternal.resolveWith(
            defaultValue: primaryButtonBackgroundColor,
            pressedValue: primaryButtonBackgroundColorHighlighted,
          ),
          backgroundColor: SBBInternal.resolveWith(
            defaultValue: primaryButtonBackgroundColor,
            pressedValue: primaryButtonBackgroundColor,
            disabledValue: primaryButtonBackgroundColorDisabled,
          ),
          foregroundColor: SBBInternal.resolveWith(
            defaultValue: primaryButtonTextStyle.color!,
            pressedValue: primaryButtonTextStyleHighlighted.color,
            disabledValue: primaryButtonTextStyleDisabled.color,
          ),
          textStyle: SBBInternal.resolveWith(
            defaultValue: primaryButtonTextStyle,
            pressedValue: primaryButtonTextStyleHighlighted,
            disabledValue: primaryButtonTextStyleDisabled,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: baseButtonStyle.copyWith(
          overlayColor: SBBInternal.resolveWith(
            defaultValue: secondaryButtonBackgroundColor,
            pressedValue: secondaryButtonBackgroundColorHighlighted,
          ),
          backgroundColor: SBBInternal.resolveWith(
            defaultValue: secondaryButtonBackgroundColor,
            pressedValue: secondaryButtonBackgroundColor,
            disabledValue: secondaryButtonBackgroundColorDisabled,
          ),
          foregroundColor: SBBInternal.resolveWith(
            defaultValue: secondaryButtonTextStyle.color!,
            pressedValue: secondaryButtonTextStyleHighlighted.color,
            disabledValue: secondaryButtonTextStyleDisabled.color,
          ),
          textStyle: SBBInternal.resolveWith(
            defaultValue: secondaryButtonTextStyle,
            pressedValue: secondaryButtonTextStyleHighlighted,
            disabledValue: secondaryButtonTextStyleDisabled,
          ),
          side: SBBInternal.resolveWith(
            defaultValue: BorderSide(color: secondaryButtonBorderColor),
            pressedValue: BorderSide(color: secondaryButtonBorderColorHighlighted),
            disabledValue: BorderSide(color: secondaryButtonBorderColorDisabled),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: baseButtonStyle.copyWith(
          overlayColor: SBBInternal.resolveWith(
            defaultValue: tertiaryButtonLargeBackgroundColor,
            pressedValue: tertiaryButtonLargeBackgroundColorHighlighted,
          ),
          backgroundColor: SBBInternal.resolveWith(
            defaultValue: tertiaryButtonLargeBackgroundColor,
            pressedValue: tertiaryButtonLargeBackgroundColor,
            disabledValue: tertiaryButtonLargeBackgroundColorDisabled,
          ),
          foregroundColor: SBBInternal.resolveWith(
            defaultValue: tertiaryButtonLargeTextStyle.color!,
            pressedValue: tertiaryButtonLargeTextStyleHighlighted.color,
            disabledValue: tertiaryButtonLargeTextStyleDisabled.color,
          ),
          textStyle: SBBInternal.resolveWith(
            defaultValue: tertiaryButtonLargeTextStyle,
            pressedValue: tertiaryButtonLargeTextStyleHighlighted,
            disabledValue: tertiaryButtonLargeTextStyleDisabled,
          ),
          side: SBBInternal.resolveWith(
            defaultValue: BorderSide(color: tertiaryButtonLargeBorderColor),
            pressedValue: BorderSide(color: tertiaryButtonLargeBorderColorHighlighted),
            disabledValue: BorderSide(color: tertiaryButtonLargeBorderColorDisabled),
          ),
        ),
      ),
      cardTheme: CardTheme(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
        margin: EdgeInsets.zero,
        color: groupBackgroundColor,
        clipBehavior: Clip.hardEdge,
        elevation: 0,
      ),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: textFieldSelectionColor,
        cursorColor: textFieldCursorColor,
        selectionHandleColor: textFieldSelectionHandleColor,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: toastBackgroundColor,
          borderRadius: new BorderRadius.all(const Radius.circular(19.0)),
        ),
        textStyle: toastTextStyle,
        showDuration: SBBToast.durationShort,
        margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
    );
  }

  double? _statusBarHeight;

  double get statusBarHeight => _statusBarHeight ?? 24.0;

  updateStatusBarHeight(BuildContext context) {
    if (_statusBarHeight == null) {
      _statusBarHeight = MediaQuery.of(context).padding.top;
    }
  }

  bool get isDark => brightness == Brightness.dark;
}
