import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData theme, ThemeData darkTheme);

const sbbDefaultSpacing = 16.0;

enum HostPlatform { web, native }

class SBBTheme extends StatelessWidget {
  factory SBBTheme({
    SBBThemeData? theme,
    SBBThemeData? darkTheme,
    HostPlatform hostType = kIsWeb ? HostPlatform.web : HostPlatform.native,
    required ThemedWidgetBuilder builder,
  }) {
    return SBBTheme._(
      theme: theme ?? SBBThemeData.light(hostPlatform: hostType),
      darkTheme: darkTheme ?? SBBThemeData.dark(hostPlatform: hostType),
      hostType: hostType,
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
    this.hostType = kIsWeb ? HostPlatform.web : HostPlatform.native,
    required this.theme,
    required this.darkTheme,
    required this.builder,
  }) : super(key: key);

  final SBBThemeData theme;
  final SBBThemeData darkTheme;
  final ThemedWidgetBuilder builder;
  final HostPlatform hostType;

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
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    const defaultHostPlatform = kIsWeb ? HostPlatform.web : HostPlatform.native;
    return Theme.of(context).brightness == Brightness.dark
        ? inheritedTheme?.darkTheme ??
            SBBThemeData.dark(
                hostPlatform: inheritedTheme?.darkTheme.hostPlatform ??
                    defaultHostPlatform)
        : inheritedTheme?.theme ??
            SBBThemeData.light(
                hostPlatform:
                    inheritedTheme?.theme.hostPlatform ?? defaultHostPlatform);
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
  bool updateShouldNotify(_InheritedTheme oldWidget) =>
      child != oldWidget.child ||
      theme != oldWidget.theme ||
      darkTheme != oldWidget.darkTheme;
}

class SBBThemeData {
  factory SBBThemeData({
    required Brightness brightness,
    Color? primaryColor,
    Color? primaryColorDark,
    MaterialColor? primarySwatch,
    Color? backgroundColor,
    String? fontFamily,
    Color? defaultTextColor,
    TextStyle? defaultTextStyle,
    Color? dividerColor,
    double? defaultRootContainerPadding,

    // web / native
    HostPlatform? hostPlatform,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,
    MaterialStateProperty<Color?>? headerNavItemForegroundColor,

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

    // Menu
    Color? menuBackgroundColor,
    Color? menuBorderColor,

    // Menu Entry
    MaterialStateProperty<Color?>? menuEntryForegroundColor,
    MaterialStateProperty<Color?>? menuEntryBackgroundColor,
    TextStyle? menuEntryTextStyle,

    // UserMenu
    TextStyle? userMenuTextStyle,
    MaterialStateProperty<Color?>? userMenuForegroundColor,

    // Breadcrumb
    TextStyle? breadcrumbTextStyle,
    MaterialStateProperty<Color?>? breadcrumbForegroundColor,

    //Sidebar
    Color? sidebarBackgroundColor,
    Color? sidebarBorderColor,
    MaterialStateProperty<Color?>? sidebarItemBackgroundColor,
    MaterialStateProperty<Color?>? sidebarItemForegroundColor,
    TextStyle? sidebarItemTextStyle,
  }) {
    // SET hard-coded default values HERE

    final bool _isLight = brightness == Brightness.light;

    themeValue<T>(T lightThemeValue, T darkThemeValue) =>
        _isLight ? lightThemeValue : darkThemeValue;

    primaryColor = primaryColor ?? SBBColors.red;
    primaryColorDark = primaryColorDark ?? SBBColors.red125;
    primarySwatch = primarySwatch ??
        MaterialColor(
          primaryColor.value,
          <int, Color>{
            50: primaryColor,
            100: primaryColor,
            200: primaryColor,
            300: primaryColor,
            400: primaryColor,
            500: primaryColor,
            600: primaryColor,
            700: primaryColor,
            800: primaryColor,
            900: primaryColor,
          },
        );
    backgroundColor =
        backgroundColor ?? themeValue(SBBColors.milk, SBBColors.black);
    fontFamily = fontFamily ?? defaultTextStyle?.fontFamily ?? SBBWebFont;
    defaultTextColor = defaultTextColor ??
        defaultTextStyle?.color ??
        themeValue(SBBColors.black, SBBColors.white);
    defaultTextStyle = (defaultTextStyle ?? SBBTextStyles.mediumLight).copyWith(
        fontFamily: defaultTextStyle?.fontFamily ?? fontFamily,
        color: defaultTextStyle?.color ?? defaultTextColor);
    dividerColor =
        dividerColor ?? themeValue(SBBColors.cloud, const Color(0xFF2A2A2A));
    defaultRootContainerPadding =
        defaultRootContainerPadding ?? sbbDefaultSpacing;

    themedTextStyle({TextStyle? textStyle, Color? color}) =>
        (textStyle ?? defaultTextStyle!)
            .copyWith(fontFamily: fontFamily, color: color ?? defaultTextColor);

    // defaults to native
    hostPlatform = hostPlatform ?? HostPlatform.native;

    // Icon
    iconColor = iconColor ?? themeValue(SBBColors.black, SBBColors.white);

    // Header
    headerBackgroundColor = headerBackgroundColor ?? primaryColor;
    headerButtonBackgroundColorHighlighted =
        headerButtonBackgroundColorHighlighted ?? primaryColorDark;
    headerIconColor = headerIconColor ?? SBBColors.white;
    headerTextStyle = headerTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.largeLight, color: headerIconColor);
    
    headerNavItemForegroundColor = headerNavItemForegroundColor ?? resolveStatesWith(
            defaultValue: SBBColors.black,
            disabledValue: SBBColors.black,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125);

    // PrimaryButton
    primaryButtonBackgroundColor = primaryButtonBackgroundColor ?? primaryColor;
    primaryButtonBackgroundColorHighlighted =
        primaryButtonBackgroundColorHighlighted ?? primaryColorDark;
    primaryButtonBackgroundColorDisabled =
        primaryButtonBackgroundColorDisabled ??
            themeValue(SBBColors.cement, SBBColors.iron);
    primaryButtonBackgroundColorLoading = primaryButtonBackgroundColorLoading ??
        primaryButtonBackgroundColorDisabled;
    primaryButtonTextStyle =
        primaryButtonTextStyle ?? themedTextStyle(color: SBBColors.white);
    primaryButtonTextStyleHighlighted =
        primaryButtonTextStyleHighlighted ?? primaryButtonTextStyle;
    primaryButtonTextStyleDisabled =
        primaryButtonTextStyleDisabled ?? primaryButtonTextStyle;
    primaryButtonTextStyleLoading =
        primaryButtonTextStyleLoading ?? primaryButtonTextStyleDisabled;

    // PrimaryButtonNegative
    primaryButtonNegativeBackgroundColor =
        primaryButtonNegativeBackgroundColor ?? SBBColors.transparent;
    primaryButtonNegativeBackgroundColorHighlighted =
        primaryButtonNegativeBackgroundColorHighlighted ??
            themeValue(SBBColors.black.withOpacity(0.2),
                SBBColors.white.withOpacity(0.2));
    primaryButtonNegativeBackgroundColorDisabled =
        primaryButtonNegativeBackgroundColorDisabled ?? SBBColors.transparent;
    primaryButtonNegativeBackgroundColorLoading =
        primaryButtonNegativeBackgroundColorLoading ??
            primaryButtonNegativeBackgroundColorDisabled;
    primaryButtonNegativeBorderColor =
        primaryButtonNegativeBorderColor ?? SBBColors.white;
    primaryButtonNegativeBorderColorHighlighted =
        primaryButtonNegativeBorderColorHighlighted ??
            primaryButtonNegativeBorderColor;
    primaryButtonNegativeBorderColorDisabled =
        primaryButtonNegativeBorderColorDisabled ??
            SBBColors.white.withOpacity(0.5);
    primaryButtonNegativeBorderColorLoading =
        primaryButtonNegativeBorderColorLoading ??
            primaryButtonNegativeBorderColorDisabled;
    primaryButtonNegativeTextStyle = primaryButtonNegativeTextStyle ??
        themedTextStyle(color: SBBColors.white);
    primaryButtonNegativeTextStyleHighlighted =
        primaryButtonNegativeTextStyleHighlighted ??
            primaryButtonNegativeTextStyle;
    primaryButtonNegativeTextStyleDisabled =
        primaryButtonNegativeTextStyleDisabled ??
            primaryButtonNegativeTextStyle;
    primaryButtonNegativeTextStyleLoading =
        primaryButtonNegativeTextStyleLoading ??
            primaryButtonNegativeTextStyleDisabled;

    // SecondaryButton
    secondaryButtonBackgroundColor =
        secondaryButtonBackgroundColor ?? SBBColors.transparent;
    secondaryButtonBackgroundColorHighlighted =
        secondaryButtonBackgroundColorHighlighted ??
            themeValue(SBBColors.milk, SBBColors.iron);
    secondaryButtonBackgroundColorDisabled =
        secondaryButtonBackgroundColorDisabled ??
            secondaryButtonBackgroundColor;
    secondaryButtonBackgroundColorLoading =
        secondaryButtonBackgroundColorLoading ??
            secondaryButtonBackgroundColorDisabled;
    secondaryButtonBorderColor = secondaryButtonBorderColor ?? primaryColor;
    secondaryButtonBorderColorHighlighted =
        secondaryButtonBorderColorHighlighted ?? primaryColorDark;
    secondaryButtonBorderColorDisabled = secondaryButtonBorderColorDisabled ??
        themeValue(SBBColors.cement, SBBColors.iron);
    secondaryButtonBorderColorLoading =
        secondaryButtonBorderColorLoading ?? secondaryButtonBorderColorDisabled;
    secondaryButtonTextStyle =
        secondaryButtonTextStyle ?? themedTextStyle(color: primaryColor);
    secondaryButtonTextStyleHighlighted = secondaryButtonTextStyleHighlighted ??
        themedTextStyle(color: primaryColorDark);
    secondaryButtonTextStyleDisabled = secondaryButtonTextStyleDisabled ??
        themedTextStyle(color: SBBColors.metal);
    secondaryButtonTextStyleLoading =
        secondaryButtonTextStyleLoading ?? secondaryButtonTextStyleDisabled;

    // TertiaryButtonLarge
    tertiaryButtonLargeBackgroundColor = tertiaryButtonLargeBackgroundColor ??
        themeValue(SBBColors.white, SBBColors.transparent);
    tertiaryButtonLargeBackgroundColorHighlighted =
        tertiaryButtonLargeBackgroundColorHighlighted ??
            themeValue(SBBColors.milk, SBBColors.iron);
    tertiaryButtonLargeBackgroundColorDisabled =
        tertiaryButtonLargeBackgroundColorDisabled ??
            themeValue(SBBColors.transparent, SBBColors.transparent);
    tertiaryButtonLargeBorderColor =
        tertiaryButtonLargeBorderColor ?? SBBColors.smoke;
    tertiaryButtonLargeBorderColorHighlighted =
        tertiaryButtonLargeBorderColorHighlighted ??
            tertiaryButtonLargeBorderColor;
    tertiaryButtonLargeBorderColorDisabled =
        tertiaryButtonLargeBorderColorDisabled ??
            themeValue(SBBColors.cloud, SBBColors.iron);
    tertiaryButtonLargeTextStyle =
        tertiaryButtonLargeTextStyle ?? themedTextStyle();
    tertiaryButtonLargeTextStyleHighlighted =
        tertiaryButtonLargeTextStyleHighlighted ?? tertiaryButtonLargeTextStyle;
    tertiaryButtonLargeTextStyleDisabled =
        tertiaryButtonLargeTextStyleDisabled ??
            tertiaryButtonLargeTextStyle.copyWith(color: SBBColors.metal);

    // TertiaryButtonSmall
    tertiaryButtonSmallBackgroundColor = tertiaryButtonSmallBackgroundColor ??
        tertiaryButtonLargeBackgroundColor;
    tertiaryButtonSmallBackgroundColorHighlighted =
        tertiaryButtonSmallBackgroundColorHighlighted ??
            tertiaryButtonLargeBackgroundColorHighlighted;
    tertiaryButtonSmallBackgroundColorDisabled =
        tertiaryButtonSmallBackgroundColorDisabled ??
            tertiaryButtonLargeBackgroundColorDisabled;
    tertiaryButtonSmallBorderColor =
        tertiaryButtonSmallBorderColor ?? tertiaryButtonLargeBorderColor;
    tertiaryButtonSmallBorderColorHighlighted =
        tertiaryButtonSmallBorderColorHighlighted ??
            tertiaryButtonLargeBorderColorHighlighted;
    tertiaryButtonSmallBorderColorDisabled =
        tertiaryButtonSmallBorderColorDisabled ??
            tertiaryButtonLargeBorderColorDisabled;
    tertiaryButtonSmallTextStyle = tertiaryButtonSmallTextStyle ??
        themedTextStyle(textStyle: SBBTextStyles.smallLight);
    tertiaryButtonSmallTextStyleHighlighted =
        tertiaryButtonSmallTextStyleHighlighted ?? tertiaryButtonSmallTextStyle;
    tertiaryButtonSmallTextStyleDisabled =
        tertiaryButtonSmallTextStyleDisabled ??
            tertiaryButtonSmallTextStyle.copyWith(
                color: tertiaryButtonLargeTextStyleDisabled.color);

    // IconButtonLarge
    iconButtonLargeBackgroundColor =
        iconButtonLargeBackgroundColor ?? tertiaryButtonLargeBackgroundColor;
    iconButtonLargeBackgroundColorHighlighted =
        iconButtonLargeBackgroundColorHighlighted ??
            tertiaryButtonLargeBackgroundColorHighlighted;
    iconButtonLargeBackgroundColorDisabled =
        iconButtonLargeBackgroundColorDisabled ?? SBBColors.transparent;
    iconButtonLargeBorderColor =
        iconButtonLargeBorderColor ?? tertiaryButtonLargeBorderColor;
    iconButtonLargeBorderColorHighlighted =
        iconButtonLargeBorderColorHighlighted ??
            tertiaryButtonLargeBorderColorHighlighted;
    iconButtonLargeBorderColorDisabled = iconButtonLargeBorderColorDisabled ??
        themeValue(SBBColors.cloud, SBBColors.iron);
    iconButtonLargeIconColor = iconButtonLargeIconColor ?? iconColor;
    iconButtonLargeIconColorHighlighted =
        iconButtonLargeIconColorHighlighted ?? iconButtonLargeIconColor;
    iconButtonLargeIconColorDisabled =
        iconButtonLargeIconColorDisabled ?? iconButtonLargeBorderColorDisabled;

    // IconButtonSmall
    iconButtonSmallBackgroundColor =
        iconButtonSmallBackgroundColor ?? iconButtonLargeBackgroundColor;
    iconButtonSmallBackgroundColorHighlighted =
        iconButtonSmallBackgroundColorHighlighted ??
            iconButtonLargeBackgroundColorHighlighted;
    iconButtonSmallBackgroundColorDisabled =
        iconButtonSmallBackgroundColorDisabled ??
            iconButtonLargeBackgroundColorDisabled;
    iconButtonSmallBorderColor =
        iconButtonSmallBorderColor ?? iconButtonLargeBorderColor;
    iconButtonSmallBorderColorHighlighted =
        iconButtonSmallBorderColorHighlighted ??
            iconButtonLargeBorderColorHighlighted;
    iconButtonSmallBorderColorDisabled = iconButtonSmallBorderColorDisabled ??
        iconButtonLargeBorderColorDisabled;
    iconButtonSmallIconColor =
        iconButtonSmallIconColor ?? iconButtonLargeIconColor;
    iconButtonSmallIconColorHighlighted = iconButtonSmallIconColorHighlighted ??
        iconButtonLargeIconColorHighlighted;
    iconButtonSmallIconColorDisabled =
        iconButtonSmallIconColorDisabled ?? iconButtonLargeIconColorDisabled;

    // IconButtonSmallNegative
    iconButtonSmallNegativeBackgroundColor =
        iconButtonSmallNegativeBackgroundColor ??
            primaryButtonNegativeBackgroundColor;
    iconButtonSmallNegativeBackgroundColorHighlighted =
        iconButtonSmallNegativeBackgroundColorHighlighted ??
            primaryButtonNegativeBackgroundColorHighlighted;
    iconButtonSmallNegativeBackgroundColorDisabled =
        iconButtonSmallNegativeBackgroundColorDisabled ??
            primaryButtonNegativeBackgroundColorDisabled;
    iconButtonSmallNegativeBorderColor =
        iconButtonSmallNegativeBorderColor ?? primaryButtonNegativeBorderColor;
    iconButtonSmallNegativeBorderColorHighlighted =
        iconButtonSmallNegativeBorderColorHighlighted ??
            primaryButtonNegativeBorderColorHighlighted;
    iconButtonSmallNegativeBorderColorDisabled =
        iconButtonSmallNegativeBorderColorDisabled ??
            primaryButtonNegativeBorderColorDisabled;
    iconButtonSmallNegativeIconColor =
        iconButtonSmallNegativeIconColor ?? iconButtonSmallNegativeBorderColor;
    iconButtonSmallNegativeIconColorHighlighted =
        iconButtonSmallNegativeIconColorHighlighted ??
            iconButtonSmallNegativeBorderColorHighlighted;
    iconButtonSmallNegativeIconColorDisabled =
        iconButtonSmallNegativeIconColorDisabled ??
            iconButtonSmallNegativeBorderColorDisabled;

    // IconButtonSmallBorderless
    iconButtonSmallBorderlessBackgroundColor =
        iconButtonSmallBorderlessBackgroundColor ?? SBBColors.transparent;
    iconButtonSmallBorderlessBackgroundColorHighlighted =
        iconButtonSmallBorderlessBackgroundColorHighlighted ??
            SBBColors.transparent;
    iconButtonSmallBorderlessBackgroundColorDisabled =
        iconButtonSmallBorderlessBackgroundColorDisabled ??
            SBBColors.transparent;
    iconButtonSmallBorderlessIconColor =
        iconButtonSmallBorderlessIconColor ?? iconButtonSmallIconColor;
    iconButtonSmallBorderlessIconColorHighlighted =
        iconButtonSmallBorderlessIconColorHighlighted ??
            themeValue(SBBColors.metal, SBBColors.aluminum);
    iconButtonSmallBorderlessIconColorDisabled =
        iconButtonSmallBorderlessIconColorDisabled ??
            iconButtonSmallIconColorDisabled;

    // IconFormButton
    iconFormButtonBackgroundColor =
        iconFormButtonBackgroundColor ?? iconButtonLargeBackgroundColor;
    iconFormButtonBackgroundColorHighlighted =
        iconFormButtonBackgroundColorHighlighted ??
            iconButtonLargeBackgroundColorHighlighted;
    iconFormButtonBackgroundColorDisabled =
        iconFormButtonBackgroundColorDisabled ??
            iconButtonLargeBackgroundColorDisabled;
    iconFormButtonBorderColor =
        iconFormButtonBorderColor ?? iconButtonLargeBorderColor;
    iconFormButtonBorderColorHighlighted =
        iconFormButtonBorderColorHighlighted ??
            iconButtonLargeBorderColorHighlighted;
    iconFormButtonBorderColorDisabled =
        iconFormButtonBorderColorDisabled ?? iconButtonLargeBorderColorDisabled;
    iconFormButtonIconColor =
        iconFormButtonIconColor ?? iconButtonLargeIconColor;
    iconFormButtonIconColorHighlighted = iconFormButtonIconColorHighlighted ??
        iconButtonLargeIconColorHighlighted;
    iconFormButtonIconColorDisabled =
        iconFormButtonIconColorDisabled ?? iconButtonLargeIconColorDisabled;

    // IconTextButton
    iconTextButtonBackgroundColor = iconTextButtonBackgroundColor ??
        themeValue(SBBColors.white, SBBColors.charcoal);
    iconTextButtonBackgroundColorHighlighted =
        iconTextButtonBackgroundColorHighlighted ??
            themeValue(SBBColors.milk, SBBColors.iron);
    iconTextButtonBackgroundColorDisabled =
        iconTextButtonBackgroundColorDisabled ?? iconTextButtonBackgroundColor;
    iconTextButtonTextStyle =
        iconTextButtonTextStyle ?? tertiaryButtonSmallTextStyle;
    iconTextButtonTextStyleHighlighted = iconTextButtonTextStyleHighlighted ??
        tertiaryButtonSmallTextStyleHighlighted;
    iconTextButtonTextStyleDisabled =
        iconTextButtonTextStyleDisabled ?? tertiaryButtonSmallTextStyleDisabled;
    iconTextButtonIconColor =
        iconTextButtonIconColor ?? iconTextButtonTextStyle.color!;
    iconTextButtonIconColorHighlighted = iconTextButtonIconColorHighlighted ??
        iconTextButtonTextStyleHighlighted.color!;
    iconTextButtonIconColorDisabled = iconTextButtonIconColorDisabled ??
        iconTextButtonTextStyleDisabled.color!;

    // Link
    linkTextStyle =
        linkTextStyle ?? defaultTextStyle.copyWith(color: primaryColor);
    linkTextStyleHighlighted = linkTextStyleHighlighted ??
        linkTextStyle.copyWith(
            color: themeValue(primaryColorDark, SBBColors.white));

    //ListHeader
    listHeaderTextStyle = listHeaderTextStyle ??
        themedTextStyle(textStyle: SBBTextStyles.smallLight);

    // ListItem
    listItemBackgroundColor = listItemBackgroundColor ?? SBBColors.transparent;
    listItemBackgroundColorHighlighted = listItemBackgroundColorHighlighted ??
        themeValue(SBBColors.milk, SBBColors.iron);
    listItemTitleTextStyle = listItemTitleTextStyle ?? themedTextStyle();
    listItemSubtitleTextStyle = listItemSubtitleTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.smallLight,
            color: themeValue(SBBColors.metal, SBBColors.smoke));

    // Checkbox TODO define toggleable colors for checkbox and radiobutton?
    checkboxColor = checkboxColor ?? primaryColor;
    checkboxColorDisabled = checkboxColorDisabled ?? SBBColors.metal;
    checkboxBackgroundColor = checkboxBackgroundColor ??
        themeValue(SBBColors.white, SBBColors.transparent);
    checkboxBackgroundColorHighlighted = checkboxBackgroundColorHighlighted ??
        listItemBackgroundColorHighlighted;
    checkboxBackgroundColorDisabled =
        checkboxBackgroundColorDisabled ?? SBBColors.transparent;
    checkboxBorderColor = checkboxBorderColor ?? SBBColors.smoke;
    checkboxBorderColorDisabled = checkboxBorderColorDisabled ??
        themeValue(SBBColors.cloud, SBBColors.iron);
    checkboxListItemBackgroundColor =
        checkboxListItemBackgroundColor ?? listItemBackgroundColor;
    checkboxListItemBackgroundColorHighlighted =
        checkboxListItemBackgroundColorHighlighted ??
            listItemBackgroundColorHighlighted;
    checkboxListItemBackgroundColorDisabled =
        checkboxListItemBackgroundColorDisabled ??
            checkboxListItemBackgroundColor;
    checkboxListItemIconColor = checkboxListItemIconColor ?? iconColor;
    checkboxListItemIconColorDisabled =
        checkboxListItemIconColorDisabled ?? SBBColors.metal;
    checkboxListItemTextStyle = checkboxListItemTextStyle ??
        (hostPlatform == HostPlatform.web
            ? SBBWebTextStyles.medium.copyWith(color: SBBColors.iron)
            : listItemTitleTextStyle);
    checkboxListItemTextStyleDisabled = checkboxListItemTextStyleDisabled ??
        (hostPlatform == HostPlatform.web
            ? checkboxListItemTextStyle.copyWith(color: SBBColors.metal)
            : listItemTitleTextStyle.copyWith(color: SBBColors.metal));
    checkboxListItemSecondaryTextStyle = checkboxListItemSecondaryTextStyle ??
        (hostPlatform == HostPlatform.web
            ? SBBWebTextStyles.mediumLight.copyWith(color: SBBColors.metal)
            : listItemSubtitleTextStyle);
    checkboxListItemSecondaryTextStyleDisabled =
        checkboxListItemSecondaryTextStyleDisabled ??
            checkboxListItemSecondaryTextStyle.copyWith(color: SBBColors.metal);

    // RadioButton TODO define toggleable colors for checkbox and radiobutton?
    radioButtonColor = radioButtonColor ?? primaryColor;
    radioButtonColorDisabled = radioButtonColorDisabled ?? SBBColors.metal;
    radioButtonBackgroundColor = radioButtonBackgroundColor ??
        themeValue(SBBColors.white, SBBColors.transparent);
    radioButtonBackgroundColorHighlighted =
        radioButtonBackgroundColorHighlighted ??
            listItemBackgroundColorHighlighted;
    radioButtonBackgroundColorDisabled =
        radioButtonBackgroundColorDisabled ?? SBBColors.transparent;
    radioButtonBorderColor = radioButtonBorderColor ?? SBBColors.smoke;
    radioButtonBorderColorDisabled = radioButtonBorderColorDisabled ??
        themeValue(SBBColors.cloud, SBBColors.iron);
    radioButtonListItemBackgroundColor =
        radioButtonListItemBackgroundColor ?? listItemBackgroundColor;
    radioButtonListItemBackgroundColorHighlighted =
        radioButtonListItemBackgroundColorHighlighted ??
            listItemBackgroundColorHighlighted;
    radioButtonListItemBackgroundColorDisabled =
        radioButtonListItemBackgroundColorDisabled ??
            radioButtonListItemBackgroundColor;
    radioButtonListItemIconColor = radioButtonListItemIconColor ?? iconColor;
    radioButtonListItemIconColorDisabled =
        radioButtonListItemIconColorDisabled ?? SBBColors.metal;
    radioButtonListItemTextStyle =
        radioButtonListItemTextStyle ?? listItemTitleTextStyle;
    radioButtonListItemTextStyleDisabled =
        radioButtonListItemTextStyleDisabled ??
            listItemTitleTextStyle.copyWith(color: SBBColors.metal);
    radioButtonListItemSecondaryTextStyle =
        radioButtonListItemSecondaryTextStyle ?? listItemSubtitleTextStyle;
    radioButtonListItemSecondaryTextStyleDisabled =
        radioButtonListItemSecondaryTextStyleDisabled ??
            radioButtonListItemSecondaryTextStyle.copyWith(
                color: SBBColors.metal);

    // SegmentedButton
    segmentedButtonBackgroundColor = segmentedButtonBackgroundColor ??
        themeValue(SBBColors.cloud, SBBColors.iron);
    segmentedButtonSelectedColor = segmentedButtonSelectedColor ??
        themeValue(SBBColors.white, SBBColors.black);
    segmentedButtonTextStyle = segmentedButtonTextStyle ?? themedTextStyle();

    // TextField
    textFieldTextStyle = textFieldTextStyle ?? themedTextStyle();
    textFieldTextStyleDisabled = textFieldTextStyleDisabled ??
        textFieldTextStyle.copyWith(color: SBBColors.metal);
    textFieldPlaceholderTextStyle = textFieldPlaceholderTextStyle ??
        themedTextStyle(color: themeValue(SBBColors.metal, SBBColors.cement));
    textFieldPlaceholderTextStyleDisabled =
        textFieldPlaceholderTextStyleDisabled ??
            themeValue(textFieldPlaceholderTextStyle,
                textFieldPlaceholderTextStyle.copyWith(color: SBBColors.metal));
    textFieldErrorTextStyle = textFieldErrorTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.helpersLabel, color: SBBColors.red150);
    textFieldDividerColor = textFieldDividerColor ?? dividerColor;
    textFieldDividerColorHighlighted = textFieldDividerColorHighlighted ??
        themeValue(SBBColors.black, SBBColors.white);
    textFieldDividerColorError = textFieldDividerColorError ?? SBBColors.red;
    textFieldCursorColor = textFieldCursorColor ?? SBBColors.sky;
    textFieldSelectionColor =
        textFieldSelectionColor ?? textFieldCursorColor.withOpacity(0.5);
    textFieldSelectionHandleColor =
        textFieldSelectionHandleColor ?? textFieldCursorColor;
    textFieldIconColor = textFieldIconColor ?? iconColor;
    textFieldIconColorDisabled = textFieldIconColorDisabled ?? SBBColors.metal;

    // Group
    groupBackgroundColor =
        groupBackgroundColor ?? themeValue(SBBColors.white, SBBColors.charcoal);

    // Accordion
    accordionTitleTextStyle = accordionTitleTextStyle ??
        themedTextStyle(textStyle: SBBTextStyles.mediumLight);
    accordionBodyTextStyle = accordionBodyTextStyle ??
        themedTextStyle(textStyle: SBBTextStyles.smallLight);
    accordionBackgroundColor = accordionBackgroundColor ?? groupBackgroundColor;

    // Modal
    modalBackgroundColor =
        modalBackgroundColor ?? themeValue(SBBColors.milk, SBBColors.midnight);
    modalTitleTextStyle = modalTitleTextStyle ??
        themedTextStyle(textStyle: SBBTextStyles.largeLight);

    // Select
    selectLabelTextStyle = selectLabelTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.helpersLabel,
            color: textFieldPlaceholderTextStyle.color);
    selectLabelTextStyleDisabled = selectLabelTextStyleDisabled ??
        selectLabelTextStyle.copyWith(
            color: textFieldPlaceholderTextStyleDisabled?.color);

    // Toast
    toastTextStyle = toastTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.smallLight, color: SBBColors.white);
    toastBackgroundColor =
        toastBackgroundColor ?? themeValue(SBBColors.metal, SBBColors.smoke);

    // Tab Bar
    tabBarTextStyle = tabBarTextStyle ??
        themedTextStyle(
            textStyle: SBBTextStyles.extraSmallLight
                .copyWith(fontWeight: FontWeight.w500));

    // Menu
    menuBackgroundColor = menuBackgroundColor ?? SBBColors.white;
    menuBorderColor = menuBorderColor ?? SBBColors.iron;

    // Menu entry
    menuEntryBackgroundColor = menuEntryBackgroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.white,
            disabledValue: SBBColors.white,
            hoveredValue: SBBColors.milk,
            pressedValue: SBBColors.milk);
    menuEntryForegroundColor = menuEntryForegroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.iron,
            disabledValue: SBBColors.iron,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125);
    menuEntryTextStyle = menuEntryTextStyle ??
        SBBWebTextStyles.medium.copyWith(color: SBBColors.iron);

    // UserMenu
    userMenuTextStyle = userMenuTextStyle ?? menuEntryTextStyle;
    userMenuForegroundColor = userMenuForegroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.iron,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125,
            disabledValue: SBBColors.iron);

    // Breadcrumb
    breadcrumbTextStyle = breadcrumbTextStyle ?? SBBWebTextStyles.small;
    breadcrumbForegroundColor = breadcrumbForegroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.granite,
            disabledValue: SBBColors.black,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125);

    //Sidebar
    sidebarBackgroundColor = sidebarBackgroundColor ?? SBBColors.white;
    sidebarBorderColor = sidebarBorderColor ?? SBBColors.silver;
    sidebarItemBackgroundColor = sidebarItemBackgroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.transparent,
            hoveredValue: SBBColors.milk,
            selectedValue: SBBColors.cloud);
    sidebarItemForegroundColor = sidebarItemForegroundColor ??
        resolveStatesWith(
            defaultValue: SBBColors.iron,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125,
            selectedValue: SBBColors.black);
    sidebarItemTextStyle = sidebarItemTextStyle ??
        SBBWebTextStyles.medium.copyWith(color: SBBColors.iron);

    // pass them on to constructor that requires all
    return SBBThemeData.raw(
      brightness: brightness,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor!,
      fontFamily: fontFamily,
      defaultTextColor: defaultTextColor!,
      defaultTextStyle: defaultTextStyle,
      dividerColor: dividerColor!,
      defaultRootContainerPadding: defaultRootContainerPadding,
      hostPlatform: hostPlatform,
      iconColor: iconColor!,
      headerBackgroundColor: headerBackgroundColor,
      headerButtonBackgroundColorHighlighted:
          headerButtonBackgroundColorHighlighted,
      headerIconColor: headerIconColor,
      headerTextStyle: headerTextStyle,
      headerNavItemForegroundColor: headerNavItemForegroundColor,
      primaryButtonBackgroundColor: primaryButtonBackgroundColor,
      primaryButtonBackgroundColorHighlighted:
          primaryButtonBackgroundColorHighlighted,
      primaryButtonBackgroundColorDisabled:
          primaryButtonBackgroundColorDisabled!,
      primaryButtonBackgroundColorLoading: primaryButtonBackgroundColorLoading!,
      primaryButtonTextStyle: primaryButtonTextStyle,
      primaryButtonTextStyleHighlighted: primaryButtonTextStyleHighlighted,
      primaryButtonTextStyleDisabled: primaryButtonTextStyleDisabled,
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading,
      primaryButtonNegativeBackgroundColor:
          primaryButtonNegativeBackgroundColor,
      primaryButtonNegativeBackgroundColorHighlighted:
          primaryButtonNegativeBackgroundColorHighlighted!,
      primaryButtonNegativeBackgroundColorDisabled:
          primaryButtonNegativeBackgroundColorDisabled,
      primaryButtonNegativeBackgroundColorLoading:
          primaryButtonNegativeBackgroundColorLoading,
      primaryButtonNegativeBorderColor: primaryButtonNegativeBorderColor,
      primaryButtonNegativeBorderColorHighlighted:
          primaryButtonNegativeBorderColorHighlighted,
      primaryButtonNegativeBorderColorDisabled:
          primaryButtonNegativeBorderColorDisabled,
      primaryButtonNegativeBorderColorLoading:
          primaryButtonNegativeBorderColorLoading,
      primaryButtonNegativeTextStyle: primaryButtonNegativeTextStyle,
      primaryButtonNegativeTextStyleHighlighted:
          primaryButtonNegativeTextStyleHighlighted,
      primaryButtonNegativeTextStyleDisabled:
          primaryButtonNegativeTextStyleDisabled,
      primaryButtonNegativeTextStyleLoading:
          primaryButtonNegativeTextStyleLoading,
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor,
      secondaryButtonBackgroundColorHighlighted:
          secondaryButtonBackgroundColorHighlighted!,
      secondaryButtonBackgroundColorDisabled:
          secondaryButtonBackgroundColorDisabled,
      secondaryButtonBackgroundColorLoading:
          secondaryButtonBackgroundColorLoading,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
      secondaryButtonBorderColorHighlighted:
          secondaryButtonBorderColorHighlighted,
      secondaryButtonBorderColorDisabled: secondaryButtonBorderColorDisabled!,
      secondaryButtonBorderColorLoading: secondaryButtonBorderColorLoading!,
      secondaryButtonTextStyle: secondaryButtonTextStyle,
      secondaryButtonTextStyleHighlighted: secondaryButtonTextStyleHighlighted,
      secondaryButtonTextStyleDisabled: secondaryButtonTextStyleDisabled,
      secondaryButtonTextStyleLoading: secondaryButtonTextStyleLoading,
      tertiaryButtonLargeBackgroundColor: tertiaryButtonLargeBackgroundColor!,
      tertiaryButtonLargeBackgroundColorHighlighted:
          tertiaryButtonLargeBackgroundColorHighlighted!,
      tertiaryButtonLargeBackgroundColorDisabled:
          tertiaryButtonLargeBackgroundColorDisabled!,
      tertiaryButtonLargeBorderColor: tertiaryButtonLargeBorderColor,
      tertiaryButtonLargeBorderColorHighlighted:
          tertiaryButtonLargeBorderColorHighlighted,
      tertiaryButtonLargeBorderColorDisabled:
          tertiaryButtonLargeBorderColorDisabled!,
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle,
      tertiaryButtonLargeTextStyleHighlighted:
          tertiaryButtonLargeTextStyleHighlighted,
      tertiaryButtonLargeTextStyleDisabled:
          tertiaryButtonLargeTextStyleDisabled,
      tertiaryButtonSmallBackgroundColor: tertiaryButtonSmallBackgroundColor!,
      tertiaryButtonSmallBackgroundColorHighlighted:
          tertiaryButtonSmallBackgroundColorHighlighted!,
      tertiaryButtonSmallBackgroundColorDisabled:
          tertiaryButtonSmallBackgroundColorDisabled!,
      tertiaryButtonSmallBorderColor: tertiaryButtonSmallBorderColor,
      tertiaryButtonSmallBorderColorHighlighted:
          tertiaryButtonSmallBorderColorHighlighted,
      tertiaryButtonSmallBorderColorDisabled:
          tertiaryButtonSmallBorderColorDisabled!,
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle,
      tertiaryButtonSmallTextStyleHighlighted:
          tertiaryButtonSmallTextStyleHighlighted,
      tertiaryButtonSmallTextStyleDisabled:
          tertiaryButtonSmallTextStyleDisabled,
      iconButtonLargeBackgroundColor: iconButtonLargeBackgroundColor!,
      iconButtonLargeBackgroundColorHighlighted:
          iconButtonLargeBackgroundColorHighlighted!,
      iconButtonLargeBackgroundColorDisabled:
          iconButtonLargeBackgroundColorDisabled,
      iconButtonLargeBorderColor: iconButtonLargeBorderColor,
      iconButtonLargeBorderColorHighlighted:
          iconButtonLargeBorderColorHighlighted,
      iconButtonLargeBorderColorDisabled: iconButtonLargeBorderColorDisabled!,
      iconButtonLargeIconColor: iconButtonLargeIconColor!,
      iconButtonLargeIconColorHighlighted: iconButtonLargeIconColorHighlighted!,
      iconButtonLargeIconColorDisabled: iconButtonLargeIconColorDisabled!,
      iconButtonSmallBackgroundColor: iconButtonSmallBackgroundColor!,
      iconButtonSmallBackgroundColorHighlighted:
          iconButtonSmallBackgroundColorHighlighted!,
      iconButtonSmallBackgroundColorDisabled:
          iconButtonSmallBackgroundColorDisabled,
      iconButtonSmallBorderColor: iconButtonSmallBorderColor,
      iconButtonSmallBorderColorHighlighted:
          iconButtonSmallBorderColorHighlighted,
      iconButtonSmallBorderColorDisabled: iconButtonSmallBorderColorDisabled!,
      iconButtonSmallIconColor: iconButtonSmallIconColor!,
      iconButtonSmallIconColorHighlighted: iconButtonSmallIconColorHighlighted!,
      iconButtonSmallIconColorDisabled: iconButtonSmallIconColorDisabled!,
      iconButtonSmallNegativeBackgroundColor:
          iconButtonSmallNegativeBackgroundColor,
      iconButtonSmallNegativeBackgroundColorHighlighted:
          iconButtonSmallNegativeBackgroundColorHighlighted!,
      iconButtonSmallNegativeBackgroundColorDisabled:
          iconButtonSmallNegativeBackgroundColorDisabled,
      iconButtonSmallNegativeBorderColor: iconButtonSmallNegativeBorderColor,
      iconButtonSmallNegativeBorderColorHighlighted:
          iconButtonSmallNegativeBorderColorHighlighted,
      iconButtonSmallNegativeBorderColorDisabled:
          iconButtonSmallNegativeBorderColorDisabled,
      iconButtonSmallNegativeIconColor: iconButtonSmallNegativeIconColor,
      iconButtonSmallNegativeIconColorHighlighted:
          iconButtonSmallNegativeIconColorHighlighted,
      iconButtonSmallNegativeIconColorDisabled:
          iconButtonSmallNegativeIconColorDisabled,
      iconButtonSmallBorderlessBackgroundColor:
          iconButtonSmallBorderlessBackgroundColor,
      iconButtonSmallBorderlessBackgroundColorHighlighted:
          iconButtonSmallBorderlessBackgroundColorHighlighted,
      iconButtonSmallBorderlessBackgroundColorDisabled:
          iconButtonSmallBorderlessBackgroundColorDisabled,
      iconButtonSmallBorderlessIconColor: iconButtonSmallBorderlessIconColor!,
      iconButtonSmallBorderlessIconColorHighlighted:
          iconButtonSmallBorderlessIconColorHighlighted!,
      iconButtonSmallBorderlessIconColorDisabled:
          iconButtonSmallBorderlessIconColorDisabled!,
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor!,
      iconFormButtonBackgroundColorHighlighted:
          iconFormButtonBackgroundColorHighlighted!,
      iconFormButtonBackgroundColorDisabled:
          iconFormButtonBackgroundColorDisabled,
      iconFormButtonBorderColor: iconFormButtonBorderColor,
      iconFormButtonBorderColorHighlighted:
          iconFormButtonBorderColorHighlighted,
      iconFormButtonBorderColorDisabled: iconFormButtonBorderColorDisabled!,
      iconFormButtonIconColor: iconFormButtonIconColor!,
      iconFormButtonIconColorHighlighted: iconFormButtonIconColorHighlighted!,
      iconFormButtonIconColorDisabled: iconFormButtonIconColorDisabled!,
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor!,
      iconTextButtonBackgroundColorHighlighted:
          iconTextButtonBackgroundColorHighlighted!,
      iconTextButtonBackgroundColorDisabled:
          iconTextButtonBackgroundColorDisabled!,
      iconTextButtonIconColor: iconTextButtonIconColor,
      iconTextButtonIconColorHighlighted: iconTextButtonIconColorHighlighted,
      iconTextButtonIconColorDisabled: iconTextButtonIconColorDisabled,
      iconTextButtonTextStyle: iconTextButtonTextStyle,
      iconTextButtonTextStyleHighlighted: iconTextButtonTextStyleHighlighted,
      iconTextButtonTextStyleDisabled: iconTextButtonTextStyleDisabled,
      linkTextStyle: linkTextStyle,
      linkTextStyleHighlighted: linkTextStyleHighlighted,
      listHeaderTextStyle: listHeaderTextStyle,
      listItemBackgroundColor: listItemBackgroundColor,
      listItemBackgroundColorHighlighted: listItemBackgroundColorHighlighted!,
      listItemTitleTextStyle: listItemTitleTextStyle,
      listItemSubtitleTextStyle: listItemSubtitleTextStyle,
      checkboxColor: checkboxColor,
      checkboxColorDisabled: checkboxColorDisabled,
      checkboxBackgroundColor: checkboxBackgroundColor!,
      checkboxBackgroundColorHighlighted: checkboxBackgroundColorHighlighted!,
      checkboxBackgroundColorDisabled: checkboxBackgroundColorDisabled,
      checkboxBorderColor: checkboxBorderColor,
      checkboxBorderColorDisabled: checkboxBorderColorDisabled!,
      checkboxListItemBackgroundColor: checkboxListItemBackgroundColor,
      checkboxListItemBackgroundColorHighlighted:
          checkboxListItemBackgroundColorHighlighted!,
      checkboxListItemBackgroundColorDisabled:
          checkboxListItemBackgroundColorDisabled,
      checkboxListItemIconColor: checkboxListItemIconColor!,
      checkboxListItemIconColorDisabled: checkboxListItemIconColorDisabled,
      checkboxListItemTextStyle: checkboxListItemTextStyle,
      checkboxListItemTextStyleDisabled: checkboxListItemTextStyleDisabled,
      checkboxListItemSecondaryTextStyle: checkboxListItemSecondaryTextStyle,
      checkboxListItemSecondaryTextStyleDisabled:
          checkboxListItemSecondaryTextStyleDisabled,
      radioButtonColor: radioButtonColor,
      radioButtonColorDisabled: radioButtonColorDisabled,
      radioButtonBackgroundColor: radioButtonBackgroundColor!,
      radioButtonBackgroundColorHighlighted:
          radioButtonBackgroundColorHighlighted!,
      radioButtonBackgroundColorDisabled: radioButtonBackgroundColorDisabled,
      radioButtonBorderColor: radioButtonBorderColor,
      radioButtonBorderColorDisabled: radioButtonBorderColorDisabled!,
      radioButtonListItemBackgroundColor: radioButtonListItemBackgroundColor,
      radioButtonListItemBackgroundColorHighlighted:
          radioButtonListItemBackgroundColorHighlighted!,
      radioButtonListItemBackgroundColorDisabled:
          radioButtonListItemBackgroundColorDisabled,
      radioButtonListItemIconColor: radioButtonListItemIconColor!,
      radioButtonListItemIconColorDisabled:
          radioButtonListItemIconColorDisabled,
      radioButtonListItemTextStyle: radioButtonListItemTextStyle,
      radioButtonListItemTextStyleDisabled:
          radioButtonListItemTextStyleDisabled,
      radioButtonListItemSecondaryTextStyle:
          radioButtonListItemSecondaryTextStyle,
      radioButtonListItemSecondaryTextStyleDisabled:
          radioButtonListItemSecondaryTextStyleDisabled,
      segmentedButtonBackgroundColor: segmentedButtonBackgroundColor!,
      segmentedButtonSelectedColor: segmentedButtonSelectedColor!,
      segmentedButtonTextStyle: segmentedButtonTextStyle,
      textFieldTextStyle: textFieldTextStyle,
      textFieldTextStyleDisabled: textFieldTextStyleDisabled,
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle,
      textFieldPlaceholderTextStyleDisabled:
          textFieldPlaceholderTextStyleDisabled!,
      textFieldErrorTextStyle: textFieldErrorTextStyle,
      textFieldDividerColor: textFieldDividerColor!,
      textFieldDividerColorHighlighted: textFieldDividerColorHighlighted!,
      textFieldDividerColorError: textFieldDividerColorError,
      textFieldCursorColor: textFieldCursorColor,
      textFieldSelectionColor: textFieldSelectionColor,
      textFieldSelectionHandleColor: textFieldSelectionHandleColor,
      textFieldIconColor: textFieldIconColor!,
      textFieldIconColorDisabled: textFieldIconColorDisabled,
      groupBackgroundColor: groupBackgroundColor!,
      accordionTitleTextStyle: accordionTitleTextStyle,
      accordionBodyTextStyle: accordionBodyTextStyle,
      accordionBackgroundColor: accordionBackgroundColor!,
      modalBackgroundColor: modalBackgroundColor!,
      modalTitleTextStyle: modalTitleTextStyle,
      selectLabelTextStyle: selectLabelTextStyle,
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled,
      toastTextStyle: toastTextStyle,
      toastBackgroundColor: toastBackgroundColor!,
      tabBarTextStyle: tabBarTextStyle,
      menuBackgroundColor: menuBackgroundColor,
      menuBorderColor: menuBorderColor,
      menuEntryForegroundColor: menuEntryForegroundColor,
      menuEntryBackgroundColor: menuEntryBackgroundColor,
      menuEntryTextStyle: menuEntryTextStyle,
      userMenuTextStyle: userMenuTextStyle,
      userMenuForegroundColor: userMenuForegroundColor,
      breadcrumbTextStyle: breadcrumbTextStyle,
      breadcrumbForegroundColor: breadcrumbForegroundColor,
      sidebarBackgroundColor: sidebarBackgroundColor,
      sidebarBorderColor: sidebarBorderColor,
      sidebarItemBackgroundColor: sidebarItemBackgroundColor,
      sidebarItemForegroundColor: sidebarItemForegroundColor,
      sidebarItemTextStyle: sidebarItemTextStyle,
    );
  }

  SBBThemeData.raw({
    required this.brightness,
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primarySwatch,
    required this.backgroundColor,
    required this.fontFamily,
    required this.defaultTextColor,
    required this.defaultTextStyle,
    required this.dividerColor,
    required this.defaultRootContainerPadding,
    required this.hostPlatform,
    required this.iconColor,
    required this.headerBackgroundColor,
    required this.headerButtonBackgroundColorHighlighted,
    required this.headerIconColor,
    required this.headerTextStyle,
    required this.headerNavItemForegroundColor,
    required this.primaryButtonBackgroundColor,
    required this.primaryButtonBackgroundColorHighlighted,
    required this.primaryButtonBackgroundColorDisabled,
    required this.primaryButtonBackgroundColorLoading,
    required this.primaryButtonTextStyle,
    required this.primaryButtonTextStyleHighlighted,
    required this.primaryButtonTextStyleDisabled,
    required this.primaryButtonTextStyleLoading,
    required this.primaryButtonNegativeBackgroundColor,
    required this.primaryButtonNegativeBackgroundColorHighlighted,
    required this.primaryButtonNegativeBackgroundColorDisabled,
    required this.primaryButtonNegativeBackgroundColorLoading,
    required this.primaryButtonNegativeBorderColor,
    required this.primaryButtonNegativeBorderColorHighlighted,
    required this.primaryButtonNegativeBorderColorDisabled,
    required this.primaryButtonNegativeBorderColorLoading,
    required this.primaryButtonNegativeTextStyle,
    required this.primaryButtonNegativeTextStyleHighlighted,
    required this.primaryButtonNegativeTextStyleDisabled,
    required this.primaryButtonNegativeTextStyleLoading,
    required this.secondaryButtonBackgroundColor,
    required this.secondaryButtonBackgroundColorHighlighted,
    required this.secondaryButtonBackgroundColorDisabled,
    required this.secondaryButtonBackgroundColorLoading,
    required this.secondaryButtonBorderColor,
    required this.secondaryButtonBorderColorHighlighted,
    required this.secondaryButtonBorderColorDisabled,
    required this.secondaryButtonBorderColorLoading,
    required this.secondaryButtonTextStyle,
    required this.secondaryButtonTextStyleHighlighted,
    required this.secondaryButtonTextStyleDisabled,
    required this.secondaryButtonTextStyleLoading,
    required this.tertiaryButtonLargeBackgroundColor,
    required this.tertiaryButtonLargeBackgroundColorHighlighted,
    required this.tertiaryButtonLargeBackgroundColorDisabled,
    required this.tertiaryButtonLargeBorderColor,
    required this.tertiaryButtonLargeBorderColorHighlighted,
    required this.tertiaryButtonLargeBorderColorDisabled,
    required this.tertiaryButtonLargeTextStyle,
    required this.tertiaryButtonLargeTextStyleHighlighted,
    required this.tertiaryButtonLargeTextStyleDisabled,
    required this.tertiaryButtonSmallBackgroundColor,
    required this.tertiaryButtonSmallBackgroundColorHighlighted,
    required this.tertiaryButtonSmallBackgroundColorDisabled,
    required this.tertiaryButtonSmallBorderColor,
    required this.tertiaryButtonSmallBorderColorHighlighted,
    required this.tertiaryButtonSmallBorderColorDisabled,
    required this.tertiaryButtonSmallTextStyle,
    required this.tertiaryButtonSmallTextStyleHighlighted,
    required this.tertiaryButtonSmallTextStyleDisabled,
    required this.iconButtonLargeBackgroundColor,
    required this.iconButtonLargeBackgroundColorHighlighted,
    required this.iconButtonLargeBackgroundColorDisabled,
    required this.iconButtonLargeBorderColor,
    required this.iconButtonLargeBorderColorHighlighted,
    required this.iconButtonLargeBorderColorDisabled,
    required this.iconButtonLargeIconColor,
    required this.iconButtonLargeIconColorHighlighted,
    required this.iconButtonLargeIconColorDisabled,
    required this.iconButtonSmallBackgroundColor,
    required this.iconButtonSmallBackgroundColorHighlighted,
    required this.iconButtonSmallBackgroundColorDisabled,
    required this.iconButtonSmallBorderColor,
    required this.iconButtonSmallBorderColorHighlighted,
    required this.iconButtonSmallBorderColorDisabled,
    required this.iconButtonSmallIconColor,
    required this.iconButtonSmallIconColorHighlighted,
    required this.iconButtonSmallIconColorDisabled,
    required this.iconButtonSmallNegativeBackgroundColor,
    required this.iconButtonSmallNegativeBackgroundColorHighlighted,
    required this.iconButtonSmallNegativeBackgroundColorDisabled,
    required this.iconButtonSmallNegativeBorderColor,
    required this.iconButtonSmallNegativeBorderColorHighlighted,
    required this.iconButtonSmallNegativeBorderColorDisabled,
    required this.iconButtonSmallNegativeIconColor,
    required this.iconButtonSmallNegativeIconColorHighlighted,
    required this.iconButtonSmallNegativeIconColorDisabled,
    required this.iconButtonSmallBorderlessBackgroundColor,
    required this.iconButtonSmallBorderlessBackgroundColorHighlighted,
    required this.iconButtonSmallBorderlessBackgroundColorDisabled,
    required this.iconButtonSmallBorderlessIconColor,
    required this.iconButtonSmallBorderlessIconColorHighlighted,
    required this.iconButtonSmallBorderlessIconColorDisabled,
    required this.iconFormButtonBackgroundColor,
    required this.iconFormButtonBackgroundColorHighlighted,
    required this.iconFormButtonBackgroundColorDisabled,
    required this.iconFormButtonBorderColor,
    required this.iconFormButtonBorderColorHighlighted,
    required this.iconFormButtonBorderColorDisabled,
    required this.iconFormButtonIconColor,
    required this.iconFormButtonIconColorHighlighted,
    required this.iconFormButtonIconColorDisabled,
    required this.iconTextButtonBackgroundColor,
    required this.iconTextButtonBackgroundColorHighlighted,
    required this.iconTextButtonBackgroundColorDisabled,
    required this.iconTextButtonIconColor,
    required this.iconTextButtonIconColorHighlighted,
    required this.iconTextButtonIconColorDisabled,
    required this.iconTextButtonTextStyle,
    required this.iconTextButtonTextStyleHighlighted,
    required this.iconTextButtonTextStyleDisabled,
    required this.linkTextStyle,
    required this.linkTextStyleHighlighted,
    required this.listHeaderTextStyle,
    required this.listItemBackgroundColor,
    required this.listItemBackgroundColorHighlighted,
    required this.listItemTitleTextStyle,
    required this.listItemSubtitleTextStyle,
    required this.checkboxColor,
    required this.checkboxColorDisabled,
    required this.checkboxBackgroundColor,
    required this.checkboxBackgroundColorHighlighted,
    required this.checkboxBackgroundColorDisabled,
    required this.checkboxBorderColor,
    required this.checkboxBorderColorDisabled,
    required this.checkboxListItemBackgroundColor,
    required this.checkboxListItemBackgroundColorHighlighted,
    required this.checkboxListItemBackgroundColorDisabled,
    required this.checkboxListItemIconColor,
    required this.checkboxListItemIconColorDisabled,
    required this.checkboxListItemTextStyle,
    required this.checkboxListItemTextStyleDisabled,
    required this.checkboxListItemSecondaryTextStyle,
    required this.checkboxListItemSecondaryTextStyleDisabled,
    required this.radioButtonColor,
    required this.radioButtonColorDisabled,
    required this.radioButtonBackgroundColor,
    required this.radioButtonBackgroundColorHighlighted,
    required this.radioButtonBackgroundColorDisabled,
    required this.radioButtonBorderColor,
    required this.radioButtonBorderColorDisabled,
    required this.radioButtonListItemBackgroundColor,
    required this.radioButtonListItemBackgroundColorHighlighted,
    required this.radioButtonListItemBackgroundColorDisabled,
    required this.radioButtonListItemIconColor,
    required this.radioButtonListItemIconColorDisabled,
    required this.radioButtonListItemTextStyle,
    required this.radioButtonListItemTextStyleDisabled,
    required this.radioButtonListItemSecondaryTextStyle,
    required this.radioButtonListItemSecondaryTextStyleDisabled,
    required this.segmentedButtonBackgroundColor,
    required this.segmentedButtonSelectedColor,
    required this.segmentedButtonTextStyle,
    required this.textFieldTextStyle,
    required this.textFieldTextStyleDisabled,
    required this.textFieldPlaceholderTextStyle,
    required this.textFieldPlaceholderTextStyleDisabled,
    required this.textFieldErrorTextStyle,
    required this.textFieldDividerColor,
    required this.textFieldDividerColorHighlighted,
    required this.textFieldDividerColorError,
    required this.textFieldCursorColor,
    required this.textFieldSelectionColor,
    required this.textFieldSelectionHandleColor,
    required this.textFieldIconColor,
    required this.textFieldIconColorDisabled,
    required this.groupBackgroundColor,
    required this.accordionTitleTextStyle,
    required this.accordionBodyTextStyle,
    required this.accordionBackgroundColor,
    required this.modalBackgroundColor,
    required this.modalTitleTextStyle,
    required this.selectLabelTextStyle,
    required this.selectLabelTextStyleDisabled,
    required this.toastTextStyle,
    required this.toastBackgroundColor,
    required this.tabBarTextStyle,
    required this.menuBackgroundColor,
    required this.menuBorderColor,
    required this.menuEntryBackgroundColor,
    required this.menuEntryForegroundColor,
    required this.menuEntryTextStyle,
    required this.userMenuTextStyle,
    required this.userMenuForegroundColor,
    required this.breadcrumbTextStyle,
    required this.breadcrumbForegroundColor,
    required this.sidebarBackgroundColor,
    required this.sidebarBorderColor,
    required this.sidebarItemBackgroundColor,
    required this.sidebarItemForegroundColor,
    required this.sidebarItemTextStyle,
  });

  /// Light Theme
  ///
  /// used as fallback
  factory SBBThemeData.light(
          {HostPlatform hostPlatform =
              kIsWeb ? HostPlatform.web : HostPlatform.native}) =>
      SBBThemeData(brightness: Brightness.light, hostPlatform: hostPlatform);

  /// Dark Theme
  factory SBBThemeData.dark(
          {HostPlatform hostPlatform =
              kIsWeb ? HostPlatform.web : HostPlatform.native}) =>
      SBBThemeData(brightness: Brightness.dark, hostPlatform: hostPlatform);

  factory SBBThemeData.fallback() => SBBThemeData.light(
      hostPlatform: kIsWeb ? HostPlatform.web : HostPlatform.native);

  final Brightness brightness;
  final Color primaryColor;
  final Color primaryColorDark;
  final MaterialColor primarySwatch;
  final Color backgroundColor;
  final String fontFamily;
  final Color defaultTextColor;
  final TextStyle defaultTextStyle;
  final Color dividerColor;
  final double defaultRootContainerPadding;

  final HostPlatform hostPlatform;

  // Icon
  final Color iconColor;

  // Header
  final Color headerBackgroundColor;
  final Color headerButtonBackgroundColorHighlighted;
  final Color headerIconColor;
  final TextStyle headerTextStyle;
  final MaterialStateProperty<Color?> headerNavItemForegroundColor;

  // PrimaryButton
  final Color primaryButtonBackgroundColor;
  final Color primaryButtonBackgroundColorHighlighted;
  final Color primaryButtonBackgroundColorDisabled;
  final Color primaryButtonBackgroundColorLoading;
  final TextStyle primaryButtonTextStyle;
  final TextStyle primaryButtonTextStyleHighlighted;
  final TextStyle primaryButtonTextStyleDisabled;
  final TextStyle primaryButtonTextStyleLoading;

  // PrimaryButtonNegative
  final Color primaryButtonNegativeBackgroundColor;
  final Color primaryButtonNegativeBackgroundColorHighlighted;
  final Color primaryButtonNegativeBackgroundColorDisabled;
  final Color primaryButtonNegativeBackgroundColorLoading;
  final Color primaryButtonNegativeBorderColor;
  final Color primaryButtonNegativeBorderColorHighlighted;
  final Color primaryButtonNegativeBorderColorDisabled;
  final Color primaryButtonNegativeBorderColorLoading;
  final TextStyle primaryButtonNegativeTextStyle;
  final TextStyle primaryButtonNegativeTextStyleHighlighted;
  final TextStyle primaryButtonNegativeTextStyleDisabled;
  final TextStyle primaryButtonNegativeTextStyleLoading;

  // SecondaryButton
  final Color secondaryButtonBackgroundColor;
  final Color secondaryButtonBackgroundColorHighlighted;
  final Color secondaryButtonBackgroundColorDisabled;
  final Color secondaryButtonBackgroundColorLoading;
  final Color secondaryButtonBorderColor;
  final Color secondaryButtonBorderColorHighlighted;
  final Color secondaryButtonBorderColorDisabled;
  final Color secondaryButtonBorderColorLoading;
  final TextStyle secondaryButtonTextStyle;
  final TextStyle secondaryButtonTextStyleHighlighted;
  final TextStyle secondaryButtonTextStyleDisabled;
  final TextStyle secondaryButtonTextStyleLoading;

  // TertiaryButtonLarge
  final Color tertiaryButtonLargeBackgroundColor;
  final Color tertiaryButtonLargeBackgroundColorHighlighted;
  final Color tertiaryButtonLargeBackgroundColorDisabled;
  final Color tertiaryButtonLargeBorderColor;
  final Color tertiaryButtonLargeBorderColorHighlighted;
  final Color tertiaryButtonLargeBorderColorDisabled;
  final TextStyle tertiaryButtonLargeTextStyle;
  final TextStyle tertiaryButtonLargeTextStyleHighlighted;
  final TextStyle tertiaryButtonLargeTextStyleDisabled;

  // TertiaryButtonSmall
  final Color tertiaryButtonSmallBackgroundColor;
  final Color tertiaryButtonSmallBackgroundColorHighlighted;
  final Color tertiaryButtonSmallBackgroundColorDisabled;
  final Color tertiaryButtonSmallBorderColor;
  final Color tertiaryButtonSmallBorderColorHighlighted;
  final Color tertiaryButtonSmallBorderColorDisabled;
  final TextStyle tertiaryButtonSmallTextStyle;
  final TextStyle tertiaryButtonSmallTextStyleHighlighted;
  final TextStyle tertiaryButtonSmallTextStyleDisabled;

  // IconButtonLarge
  final Color iconButtonLargeBackgroundColor;
  final Color iconButtonLargeBackgroundColorHighlighted;
  final Color iconButtonLargeBackgroundColorDisabled;
  final Color iconButtonLargeBorderColor;
  final Color iconButtonLargeBorderColorHighlighted;
  final Color iconButtonLargeBorderColorDisabled;
  final Color iconButtonLargeIconColor;
  final Color iconButtonLargeIconColorHighlighted;
  final Color iconButtonLargeIconColorDisabled;

  // IconButtonSmall
  final Color iconButtonSmallBackgroundColor;
  final Color iconButtonSmallBackgroundColorHighlighted;
  final Color iconButtonSmallBackgroundColorDisabled;
  final Color iconButtonSmallBorderColor;
  final Color iconButtonSmallBorderColorHighlighted;
  final Color iconButtonSmallBorderColorDisabled;
  final Color iconButtonSmallIconColor;
  final Color iconButtonSmallIconColorHighlighted;
  final Color iconButtonSmallIconColorDisabled;

  // IconButtonSmallNegative
  final Color iconButtonSmallNegativeBackgroundColor;
  final Color iconButtonSmallNegativeBackgroundColorHighlighted;
  final Color iconButtonSmallNegativeBackgroundColorDisabled;
  final Color iconButtonSmallNegativeBorderColor;
  final Color iconButtonSmallNegativeBorderColorHighlighted;
  final Color iconButtonSmallNegativeBorderColorDisabled;
  final Color iconButtonSmallNegativeIconColor;
  final Color iconButtonSmallNegativeIconColorHighlighted;
  final Color iconButtonSmallNegativeIconColorDisabled;

  // IconButtonSmallBorderless
  final Color iconButtonSmallBorderlessBackgroundColor;
  final Color iconButtonSmallBorderlessBackgroundColorHighlighted;
  final Color iconButtonSmallBorderlessBackgroundColorDisabled;
  final Color iconButtonSmallBorderlessIconColor;
  final Color iconButtonSmallBorderlessIconColorHighlighted;
  final Color iconButtonSmallBorderlessIconColorDisabled;

  // IconFormButton
  final Color iconFormButtonBackgroundColor;
  final Color iconFormButtonBackgroundColorHighlighted;
  final Color iconFormButtonBackgroundColorDisabled;
  final Color iconFormButtonBorderColor;
  final Color iconFormButtonBorderColorHighlighted;
  final Color iconFormButtonBorderColorDisabled;
  final Color iconFormButtonIconColor;
  final Color iconFormButtonIconColorHighlighted;
  final Color iconFormButtonIconColorDisabled;

  // IconTextButton
  final Color iconTextButtonBackgroundColor;
  final Color iconTextButtonBackgroundColorHighlighted;
  final Color iconTextButtonBackgroundColorDisabled;
  final Color iconTextButtonIconColor;
  final Color iconTextButtonIconColorHighlighted;
  final Color iconTextButtonIconColorDisabled;
  final TextStyle iconTextButtonTextStyle;
  final TextStyle iconTextButtonTextStyleHighlighted;
  final TextStyle iconTextButtonTextStyleDisabled;

  // Link
  final TextStyle linkTextStyle;
  final TextStyle linkTextStyleHighlighted;

  //ListHeader
  final TextStyle listHeaderTextStyle;

  // ListItem
  final Color listItemBackgroundColor;
  final Color listItemBackgroundColorHighlighted;
  final TextStyle listItemTitleTextStyle;
  final TextStyle listItemSubtitleTextStyle;

  // Checkbox
  final Color checkboxColor;
  final Color checkboxColorDisabled;
  final Color checkboxBackgroundColor;
  final Color checkboxBackgroundColorHighlighted;
  final Color checkboxBackgroundColorDisabled;
  final Color checkboxBorderColor;
  final Color checkboxBorderColorDisabled;
  final Color checkboxListItemBackgroundColor;
  final Color checkboxListItemBackgroundColorHighlighted;
  final Color checkboxListItemBackgroundColorDisabled;
  final Color checkboxListItemIconColor;
  final Color checkboxListItemIconColorDisabled;
  final TextStyle checkboxListItemTextStyle;
  final TextStyle checkboxListItemTextStyleDisabled;
  final TextStyle checkboxListItemSecondaryTextStyle;
  final TextStyle checkboxListItemSecondaryTextStyleDisabled;

  // RadioButton
  final Color radioButtonColor;
  final Color radioButtonColorDisabled;
  final Color radioButtonBackgroundColor;
  final Color radioButtonBackgroundColorHighlighted;
  final Color radioButtonBackgroundColorDisabled;
  final Color radioButtonBorderColor;
  final Color radioButtonBorderColorDisabled;
  final Color radioButtonListItemBackgroundColor;
  final Color radioButtonListItemBackgroundColorHighlighted;
  final Color radioButtonListItemBackgroundColorDisabled;
  final Color radioButtonListItemIconColor;
  final Color radioButtonListItemIconColorDisabled;
  final TextStyle radioButtonListItemTextStyle;
  final TextStyle radioButtonListItemTextStyleDisabled;
  final TextStyle radioButtonListItemSecondaryTextStyle;
  final TextStyle radioButtonListItemSecondaryTextStyleDisabled;

  // SegmentedButton
  final Color segmentedButtonBackgroundColor;
  final Color segmentedButtonSelectedColor;
  final TextStyle segmentedButtonTextStyle;

  // TextField
  final TextStyle textFieldTextStyle;
  final TextStyle textFieldTextStyleDisabled;
  final TextStyle textFieldPlaceholderTextStyle;
  final TextStyle textFieldPlaceholderTextStyleDisabled;
  final TextStyle textFieldErrorTextStyle;
  final Color textFieldDividerColor;
  final Color textFieldDividerColorHighlighted;
  final Color textFieldDividerColorError;
  final Color textFieldCursorColor;
  final Color textFieldSelectionColor;
  final Color textFieldSelectionHandleColor;
  final Color textFieldIconColor;
  final Color textFieldIconColorDisabled;

  // Group
  final Color groupBackgroundColor;

  // Accordion
  final TextStyle accordionTitleTextStyle;
  final TextStyle accordionBodyTextStyle;
  final Color accordionBackgroundColor;

  // Modal
  final Color modalBackgroundColor;
  final TextStyle modalTitleTextStyle;

  // Select
  final TextStyle selectLabelTextStyle;
  final TextStyle selectLabelTextStyleDisabled;

  // Toast
  final TextStyle toastTextStyle;
  final Color toastBackgroundColor;

  // Tab Bar
  final TextStyle tabBarTextStyle;

  // Menu
  final Color menuBackgroundColor;
  final Color menuBorderColor;

  // Menu Entry
  final MaterialStateProperty<Color?> menuEntryBackgroundColor;
  final MaterialStateProperty<Color?> menuEntryForegroundColor;
  final TextStyle menuEntryTextStyle;

  // UserMenu
  final TextStyle userMenuTextStyle;
  final MaterialStateProperty<Color?> userMenuForegroundColor;

  // Breadcrumb
  final TextStyle breadcrumbTextStyle;
  final MaterialStateProperty<Color?> breadcrumbForegroundColor;

  //Sidebar
  final Color sidebarBackgroundColor;
  final Color sidebarBorderColor;
  final MaterialStateProperty<Color?> sidebarItemBackgroundColor;
  final MaterialStateProperty<Color?> sidebarItemForegroundColor;
  final TextStyle sidebarItemTextStyle;

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
    HostPlatform? hostPlatform,

    // Icon
    Color? iconColor,

    // Header
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,
    MaterialStateProperty<Color?>? headerNavItemForegroundColor,

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

    // Menu
    Color? menuBackgroundColor,
    Color? menuBorderColor,

    //Menu Entry
    TextStyle? menuEntryTextStyle,
    MaterialStateProperty<Color?>? menuEntryBackgroundColor,
    MaterialStateProperty<Color?>? menuEntryForegroundColor,

    //UserMenu
    TextStyle? userMenuTextStyle,
    MaterialStateProperty<Color?>? userMenuForegroundColor,

    // Breadcrumb
    TextStyle? breadcrumbTextStyle,
    MaterialStateProperty<Color?>? breadcrumbForegroundColor,

    //Sidebar
    Color? sidebarBackgroundColor,
    Color? sidebarBorderColor,
    MaterialStateProperty<Color?>? sidebarItemBackgroundColor,
    MaterialStateProperty<Color?>? sidebarItemForegroundColor,
    TextStyle? sidebarItemTextStyle,
  }) {
    final defaultTheme = SBBThemeData.fallback();
    return SBBThemeData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ??
          (this.primaryColor == defaultTheme.primaryColor
              ? null
              : this.primaryColor),
      primaryColorDark: primaryColorDark ??
          (this.primaryColorDark == defaultTheme.primaryColorDark
              ? null
              : this.primaryColorDark),
      primarySwatch: primarySwatch ??
          (this.primarySwatch == defaultTheme.primarySwatch
              ? null
              : this.primarySwatch),
      backgroundColor: backgroundColor ??
          (this.backgroundColor == defaultTheme.backgroundColor
              ? null
              : this.backgroundColor),
      fontFamily: fontFamily ??
          (this.fontFamily == defaultTheme.fontFamily ? null : this.fontFamily),
      defaultTextColor: defaultTextColor ??
          (this.defaultTextColor == defaultTheme.defaultTextColor
              ? null
              : this.defaultTextColor),
      defaultTextStyle: defaultTextStyle ??
          (this.defaultTextStyle == defaultTheme.defaultTextStyle
              ? null
              : this.defaultTextStyle),
      dividerColor: dividerColor ??
          (this.dividerColor == defaultTheme.dividerColor
              ? null
              : this.dividerColor),
      defaultRootContainerPadding: defaultRootContainerPadding ??
          (this.defaultRootContainerPadding ==
                  defaultTheme.defaultRootContainerPadding
              ? null
              : this.defaultRootContainerPadding),

      // native / web
      hostPlatform: hostPlatform ?? defaultTheme.hostPlatform,

      // Icon
      iconColor: iconColor ??
          (this.iconColor == defaultTheme.iconColor ? null : this.iconColor),

      // Header
      headerBackgroundColor: headerBackgroundColor ??
          (this.headerBackgroundColor == defaultTheme.headerBackgroundColor
              ? null
              : this.headerBackgroundColor),
      headerButtonBackgroundColorHighlighted:
          headerButtonBackgroundColorHighlighted ??
              (this.headerButtonBackgroundColorHighlighted ==
                      defaultTheme.headerButtonBackgroundColorHighlighted
                  ? null
                  : this.headerButtonBackgroundColorHighlighted),
      headerIconColor: headerIconColor ??
          (this.headerIconColor == defaultTheme.headerIconColor
              ? null
              : this.headerIconColor),
      headerTextStyle: headerTextStyle ??
          (this.headerTextStyle == defaultTheme.headerTextStyle
              ? null
              : this.headerTextStyle),
      
      headerNavItemForegroundColor: headerNavItemForegroundColor ?? (this.headerNavItemForegroundColor == defaultTheme.headerNavItemForegroundColor ? null: this.headerNavItemForegroundColor),

      // PrimaryButton
      primaryButtonBackgroundColor: primaryButtonBackgroundColor ??
          (this.primaryButtonBackgroundColor ==
                  defaultTheme.primaryButtonBackgroundColor
              ? null
              : this.primaryButtonBackgroundColor),
      primaryButtonBackgroundColorHighlighted:
          primaryButtonBackgroundColorHighlighted ??
              (this.primaryButtonBackgroundColorHighlighted ==
                      defaultTheme.primaryButtonBackgroundColorHighlighted
                  ? null
                  : this.primaryButtonBackgroundColorHighlighted),
      primaryButtonBackgroundColorDisabled:
          primaryButtonBackgroundColorDisabled ??
              (this.primaryButtonBackgroundColorDisabled ==
                      defaultTheme.primaryButtonBackgroundColorDisabled
                  ? null
                  : this.primaryButtonBackgroundColorDisabled),
      primaryButtonBackgroundColorLoading:
          primaryButtonBackgroundColorLoading ??
              (this.primaryButtonBackgroundColorLoading ==
                      defaultTheme.primaryButtonBackgroundColorLoading
                  ? null
                  : this.primaryButtonBackgroundColorLoading),
      primaryButtonTextStyle: primaryButtonTextStyle ??
          (this.primaryButtonTextStyle == defaultTheme.primaryButtonTextStyle
              ? null
              : this.primaryButtonTextStyle),
      primaryButtonTextStyleHighlighted: primaryButtonTextStyleHighlighted ??
          (this.primaryButtonTextStyleHighlighted ==
                  defaultTheme.primaryButtonTextStyleHighlighted
              ? null
              : this.primaryButtonTextStyleHighlighted),
      primaryButtonTextStyleDisabled: primaryButtonTextStyleDisabled ??
          (this.primaryButtonTextStyleDisabled ==
                  defaultTheme.primaryButtonTextStyleDisabled
              ? null
              : this.primaryButtonTextStyleDisabled),
      primaryButtonTextStyleLoading: primaryButtonTextStyleLoading ??
          (this.primaryButtonTextStyleLoading ==
                  defaultTheme.primaryButtonTextStyleLoading
              ? null
              : this.primaryButtonTextStyleLoading),

      // PrimaryButtonNegative
      primaryButtonNegativeBackgroundColor:
          primaryButtonNegativeBackgroundColor ??
              (this.primaryButtonNegativeBackgroundColor ==
                      defaultTheme.primaryButtonNegativeBackgroundColor
                  ? null
                  : this.primaryButtonNegativeBackgroundColor),
      primaryButtonNegativeBackgroundColorHighlighted:
          primaryButtonNegativeBackgroundColorHighlighted ??
              (this.primaryButtonNegativeBackgroundColorHighlighted ==
                      defaultTheme
                          .primaryButtonNegativeBackgroundColorHighlighted
                  ? null
                  : this.primaryButtonNegativeBackgroundColorHighlighted),
      primaryButtonNegativeBackgroundColorDisabled:
          primaryButtonNegativeBackgroundColorDisabled ??
              (this.primaryButtonNegativeBackgroundColorDisabled ==
                      defaultTheme.primaryButtonNegativeBackgroundColorDisabled
                  ? null
                  : this.primaryButtonNegativeBackgroundColorDisabled),
      primaryButtonNegativeBackgroundColorLoading:
          primaryButtonNegativeBackgroundColorLoading ??
              (this.primaryButtonNegativeBackgroundColorLoading ==
                      defaultTheme.primaryButtonNegativeBackgroundColorLoading
                  ? null
                  : this.primaryButtonNegativeBackgroundColorLoading),
      primaryButtonNegativeBorderColor: primaryButtonNegativeBorderColor ??
          (this.primaryButtonNegativeBorderColor ==
                  defaultTheme.primaryButtonNegativeBorderColor
              ? null
              : this.primaryButtonNegativeBorderColor),
      primaryButtonNegativeBorderColorHighlighted:
          primaryButtonNegativeBorderColorHighlighted ??
              (this.primaryButtonNegativeBorderColorHighlighted ==
                      defaultTheme.primaryButtonNegativeBorderColorHighlighted
                  ? null
                  : this.primaryButtonNegativeBorderColorHighlighted),
      primaryButtonNegativeBorderColorDisabled:
          primaryButtonNegativeBorderColorDisabled ??
              (this.primaryButtonNegativeBorderColorDisabled ==
                      defaultTheme.primaryButtonNegativeBorderColorDisabled
                  ? null
                  : this.primaryButtonNegativeBorderColorDisabled),
      primaryButtonNegativeBorderColorLoading:
          primaryButtonNegativeBorderColorLoading ??
              (this.primaryButtonNegativeBorderColorLoading ==
                      defaultTheme.primaryButtonNegativeBorderColorLoading
                  ? null
                  : this.primaryButtonNegativeBorderColorLoading),
      primaryButtonNegativeTextStyle: primaryButtonNegativeTextStyle ??
          (this.primaryButtonNegativeTextStyle ==
                  defaultTheme.primaryButtonNegativeTextStyle
              ? null
              : this.primaryButtonNegativeTextStyle),
      primaryButtonNegativeTextStyleHighlighted:
          primaryButtonNegativeTextStyleHighlighted ??
              (this.primaryButtonNegativeTextStyleHighlighted ==
                      defaultTheme.primaryButtonNegativeTextStyleHighlighted
                  ? null
                  : this.primaryButtonNegativeTextStyleHighlighted),
      primaryButtonNegativeTextStyleDisabled:
          primaryButtonNegativeTextStyleDisabled ??
              (this.primaryButtonNegativeTextStyleDisabled ==
                      defaultTheme.primaryButtonNegativeTextStyleDisabled
                  ? null
                  : this.primaryButtonNegativeTextStyleDisabled),
      primaryButtonNegativeTextStyleLoading:
          primaryButtonNegativeTextStyleLoading ??
              (this.primaryButtonNegativeTextStyleLoading ==
                      defaultTheme.primaryButtonNegativeTextStyleLoading
                  ? null
                  : this.primaryButtonNegativeTextStyleLoading),

      // SecondaryButton
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor ??
          (this.secondaryButtonBackgroundColor ==
                  defaultTheme.secondaryButtonBackgroundColor
              ? null
              : this.secondaryButtonBackgroundColor),
      secondaryButtonBackgroundColorHighlighted:
          secondaryButtonBackgroundColorHighlighted ??
              (this.secondaryButtonBackgroundColorHighlighted ==
                      defaultTheme.secondaryButtonBackgroundColorHighlighted
                  ? null
                  : this.secondaryButtonBackgroundColorHighlighted),
      secondaryButtonBackgroundColorDisabled:
          secondaryButtonBackgroundColorDisabled ??
              (this.secondaryButtonBackgroundColorDisabled ==
                      defaultTheme.secondaryButtonBackgroundColorDisabled
                  ? null
                  : this.secondaryButtonBackgroundColorDisabled),
      secondaryButtonBackgroundColorLoading:
          secondaryButtonBackgroundColorLoading ??
              (this.secondaryButtonBackgroundColorLoading ==
                      defaultTheme.secondaryButtonBackgroundColorLoading
                  ? null
                  : this.secondaryButtonBackgroundColorLoading),
      secondaryButtonBorderColor: secondaryButtonBorderColor ??
          (this.secondaryButtonBorderColor ==
                  defaultTheme.secondaryButtonBorderColor
              ? null
              : this.secondaryButtonBorderColor),
      secondaryButtonBorderColorHighlighted:
          secondaryButtonBorderColorHighlighted ??
              (this.secondaryButtonBorderColorHighlighted ==
                      defaultTheme.secondaryButtonBorderColorHighlighted
                  ? null
                  : this.secondaryButtonBorderColorHighlighted),
      secondaryButtonBorderColorDisabled: secondaryButtonBorderColorDisabled ??
          (this.secondaryButtonBorderColorDisabled ==
                  defaultTheme.secondaryButtonBorderColorDisabled
              ? null
              : this.secondaryButtonBorderColorDisabled),
      secondaryButtonBorderColorLoading: secondaryButtonBorderColorLoading ??
          (this.secondaryButtonBorderColorLoading ==
                  defaultTheme.secondaryButtonBorderColorLoading
              ? null
              : this.secondaryButtonBorderColorLoading),
      secondaryButtonTextStyle: secondaryButtonTextStyle ??
          (this.secondaryButtonTextStyle ==
                  defaultTheme.secondaryButtonTextStyle
              ? null
              : this.secondaryButtonTextStyle),
      secondaryButtonTextStyleHighlighted:
          secondaryButtonTextStyleHighlighted ??
              (this.secondaryButtonTextStyleHighlighted ==
                      defaultTheme.secondaryButtonTextStyleHighlighted
                  ? null
                  : this.secondaryButtonTextStyleHighlighted),
      secondaryButtonTextStyleDisabled: secondaryButtonTextStyleDisabled ??
          (this.secondaryButtonTextStyleDisabled ==
                  defaultTheme.secondaryButtonTextStyleDisabled
              ? null
              : this.secondaryButtonTextStyleDisabled),
      secondaryButtonTextStyleLoading: secondaryButtonTextStyleLoading ??
          (this.secondaryButtonTextStyleLoading ==
                  defaultTheme.secondaryButtonTextStyleLoading
              ? null
              : this.secondaryButtonTextStyleLoading),

      // TertiaryButtonLarge
      tertiaryButtonLargeBackgroundColor: tertiaryButtonLargeBackgroundColor ??
          (this.tertiaryButtonLargeBackgroundColor ==
                  defaultTheme.tertiaryButtonLargeBackgroundColor
              ? null
              : this.tertiaryButtonLargeBackgroundColor),
      tertiaryButtonLargeBackgroundColorHighlighted:
          tertiaryButtonLargeBackgroundColorHighlighted ??
              (this.tertiaryButtonLargeBackgroundColorHighlighted ==
                      defaultTheme.tertiaryButtonLargeBackgroundColorHighlighted
                  ? null
                  : this.tertiaryButtonLargeBackgroundColorHighlighted),
      tertiaryButtonLargeBackgroundColorDisabled:
          tertiaryButtonLargeBackgroundColorDisabled ??
              (this.tertiaryButtonLargeBackgroundColorDisabled ==
                      defaultTheme.tertiaryButtonLargeBackgroundColorDisabled
                  ? null
                  : this.tertiaryButtonLargeBackgroundColorDisabled),
      tertiaryButtonLargeBorderColor: tertiaryButtonLargeBorderColor ??
          (this.tertiaryButtonLargeBorderColor ==
                  defaultTheme.tertiaryButtonLargeBorderColor
              ? null
              : this.tertiaryButtonLargeBorderColor),
      tertiaryButtonLargeBorderColorHighlighted:
          tertiaryButtonLargeBorderColorHighlighted ??
              (this.tertiaryButtonLargeBorderColorHighlighted ==
                      defaultTheme.tertiaryButtonLargeBorderColorHighlighted
                  ? null
                  : this.tertiaryButtonLargeBorderColorHighlighted),
      tertiaryButtonLargeBorderColorDisabled:
          tertiaryButtonLargeBorderColorDisabled ??
              (this.tertiaryButtonLargeBorderColorDisabled ==
                      defaultTheme.tertiaryButtonLargeBorderColorDisabled
                  ? null
                  : this.tertiaryButtonLargeBorderColorDisabled),
      tertiaryButtonLargeTextStyle: tertiaryButtonLargeTextStyle ??
          (this.tertiaryButtonLargeTextStyle ==
                  defaultTheme.tertiaryButtonLargeTextStyle
              ? null
              : this.tertiaryButtonLargeTextStyle),
      tertiaryButtonLargeTextStyleHighlighted:
          tertiaryButtonLargeTextStyleHighlighted ??
              (this.tertiaryButtonLargeTextStyleHighlighted ==
                      defaultTheme.tertiaryButtonLargeTextStyleHighlighted
                  ? null
                  : this.tertiaryButtonLargeTextStyleHighlighted),
      tertiaryButtonLargeTextStyleDisabled:
          tertiaryButtonLargeTextStyleDisabled ??
              (this.tertiaryButtonLargeTextStyleDisabled ==
                      defaultTheme.tertiaryButtonLargeTextStyleDisabled
                  ? null
                  : this.tertiaryButtonLargeTextStyleDisabled),

      // TertiaryButtonSmall
      tertiaryButtonSmallBackgroundColor: tertiaryButtonSmallBackgroundColor ??
          (this.tertiaryButtonSmallBackgroundColor ==
                  defaultTheme.tertiaryButtonSmallBackgroundColor
              ? null
              : this.tertiaryButtonSmallBackgroundColor),
      tertiaryButtonSmallBackgroundColorHighlighted:
          tertiaryButtonSmallBackgroundColorHighlighted ??
              (this.tertiaryButtonSmallBackgroundColorHighlighted ==
                      defaultTheme.tertiaryButtonSmallBackgroundColorHighlighted
                  ? null
                  : this.tertiaryButtonSmallBackgroundColorHighlighted),
      tertiaryButtonSmallBackgroundColorDisabled:
          tertiaryButtonSmallBackgroundColorDisabled ??
              (this.tertiaryButtonSmallBackgroundColorDisabled ==
                      defaultTheme.tertiaryButtonSmallBackgroundColorDisabled
                  ? null
                  : this.tertiaryButtonSmallBackgroundColorDisabled),
      tertiaryButtonSmallBorderColor: tertiaryButtonSmallBorderColor ??
          (this.tertiaryButtonSmallBorderColor ==
                  defaultTheme.tertiaryButtonSmallBorderColor
              ? null
              : this.tertiaryButtonSmallBorderColor),
      tertiaryButtonSmallBorderColorHighlighted:
          tertiaryButtonSmallBorderColorHighlighted ??
              (this.tertiaryButtonSmallBorderColorHighlighted ==
                      defaultTheme.tertiaryButtonSmallBorderColorHighlighted
                  ? null
                  : this.tertiaryButtonSmallBorderColorHighlighted),
      tertiaryButtonSmallBorderColorDisabled:
          tertiaryButtonSmallBorderColorDisabled ??
              (this.tertiaryButtonSmallBorderColorDisabled ==
                      defaultTheme.tertiaryButtonSmallBorderColorDisabled
                  ? null
                  : this.tertiaryButtonSmallBorderColorDisabled),
      tertiaryButtonSmallTextStyle: tertiaryButtonSmallTextStyle ??
          (this.tertiaryButtonSmallTextStyle ==
                  defaultTheme.tertiaryButtonSmallTextStyle
              ? null
              : this.tertiaryButtonSmallTextStyle),
      tertiaryButtonSmallTextStyleHighlighted:
          tertiaryButtonSmallTextStyleHighlighted ??
              (this.tertiaryButtonSmallTextStyleHighlighted ==
                      defaultTheme.tertiaryButtonSmallTextStyleHighlighted
                  ? null
                  : this.tertiaryButtonSmallTextStyleHighlighted),
      tertiaryButtonSmallTextStyleDisabled:
          tertiaryButtonSmallTextStyleDisabled ??
              (this.tertiaryButtonSmallTextStyleDisabled ==
                      defaultTheme.tertiaryButtonSmallTextStyleDisabled
                  ? null
                  : this.tertiaryButtonSmallTextStyleDisabled),

      // IconButtonLarge
      iconButtonLargeBackgroundColor: iconButtonLargeBackgroundColor ??
          (this.iconButtonLargeBackgroundColor ==
                  defaultTheme.iconButtonLargeBackgroundColor
              ? null
              : this.iconButtonLargeBackgroundColor),
      iconButtonLargeBackgroundColorHighlighted:
          iconButtonLargeBackgroundColorHighlighted ??
              (this.iconButtonLargeBackgroundColorHighlighted ==
                      defaultTheme.iconButtonLargeBackgroundColorHighlighted
                  ? null
                  : this.iconButtonLargeBackgroundColorHighlighted),
      iconButtonLargeBackgroundColorDisabled:
          iconButtonLargeBackgroundColorDisabled ??
              (this.iconButtonLargeBackgroundColorDisabled ==
                      defaultTheme.iconButtonLargeBackgroundColorDisabled
                  ? null
                  : this.iconButtonLargeBackgroundColorDisabled),
      iconButtonLargeBorderColor: iconButtonLargeBorderColor ??
          (this.iconButtonLargeBorderColor ==
                  defaultTheme.iconButtonLargeBorderColor
              ? null
              : this.iconButtonLargeBorderColor),
      iconButtonLargeBorderColorHighlighted:
          iconButtonLargeBorderColorHighlighted ??
              (this.iconButtonLargeBorderColorHighlighted ==
                      defaultTheme.iconButtonLargeBorderColorHighlighted
                  ? null
                  : this.iconButtonLargeBorderColorHighlighted),
      iconButtonLargeBorderColorDisabled: iconButtonLargeBorderColorDisabled ??
          (this.iconButtonLargeBorderColorDisabled ==
                  defaultTheme.iconButtonLargeBorderColorDisabled
              ? null
              : this.iconButtonLargeBorderColorDisabled),
      iconButtonLargeIconColor: iconButtonLargeIconColor ??
          (this.iconButtonLargeIconColor ==
                  defaultTheme.iconButtonLargeIconColor
              ? null
              : this.iconButtonLargeIconColor),
      iconButtonLargeIconColorHighlighted:
          iconButtonLargeIconColorHighlighted ??
              (this.iconButtonLargeIconColorHighlighted ==
                      defaultTheme.iconButtonLargeIconColorHighlighted
                  ? null
                  : this.iconButtonLargeIconColorHighlighted),
      iconButtonLargeIconColorDisabled: iconButtonLargeIconColorDisabled ??
          (this.iconButtonLargeIconColorDisabled ==
                  defaultTheme.iconButtonLargeIconColorDisabled
              ? null
              : this.iconButtonLargeIconColorDisabled),

      // IconButtonSmall
      iconButtonSmallBackgroundColor: iconButtonSmallBackgroundColor ??
          (this.iconButtonSmallBackgroundColor ==
                  defaultTheme.iconButtonSmallBackgroundColor
              ? null
              : this.iconButtonSmallBackgroundColor),
      iconButtonSmallBackgroundColorHighlighted:
          iconButtonSmallBackgroundColorHighlighted ??
              (this.iconButtonSmallBackgroundColorHighlighted ==
                      defaultTheme.iconButtonSmallBackgroundColorHighlighted
                  ? null
                  : this.iconButtonSmallBackgroundColorHighlighted),
      iconButtonSmallBackgroundColorDisabled:
          iconButtonSmallBackgroundColorDisabled ??
              (this.iconButtonSmallBackgroundColorDisabled ==
                      defaultTheme.iconButtonSmallBackgroundColorDisabled
                  ? null
                  : this.iconButtonSmallBackgroundColorDisabled),
      iconButtonSmallBorderColor: iconButtonSmallBorderColor ??
          (this.iconButtonSmallBorderColor ==
                  defaultTheme.iconButtonSmallBorderColor
              ? null
              : this.iconButtonSmallBorderColor),
      iconButtonSmallBorderColorHighlighted:
          iconButtonSmallBorderColorHighlighted ??
              (this.iconButtonSmallBorderColorHighlighted ==
                      defaultTheme.iconButtonSmallBorderColorHighlighted
                  ? null
                  : this.iconButtonSmallBorderColorHighlighted),
      iconButtonSmallBorderColorDisabled: iconButtonSmallBorderColorDisabled ??
          (this.iconButtonSmallBorderColorDisabled ==
                  defaultTheme.iconButtonSmallBorderColorDisabled
              ? null
              : this.iconButtonSmallBorderColorDisabled),
      iconButtonSmallIconColor: iconButtonSmallIconColor ??
          (this.iconButtonSmallIconColor ==
                  defaultTheme.iconButtonSmallIconColor
              ? null
              : this.iconButtonSmallIconColor),
      iconButtonSmallIconColorHighlighted:
          iconButtonSmallIconColorHighlighted ??
              (this.iconButtonSmallIconColorHighlighted ==
                      defaultTheme.iconButtonSmallIconColorHighlighted
                  ? null
                  : this.iconButtonSmallIconColorHighlighted),
      iconButtonSmallIconColorDisabled: iconButtonSmallIconColorDisabled ??
          (this.iconButtonSmallIconColorDisabled ==
                  defaultTheme.iconButtonSmallIconColorDisabled
              ? null
              : this.iconButtonSmallIconColorDisabled),

      // IconButtonSmallNegative
      iconButtonSmallNegativeBackgroundColor:
          iconButtonSmallNegativeBackgroundColor ??
              (this.iconButtonSmallNegativeBackgroundColor ==
                      defaultTheme.iconButtonSmallNegativeBackgroundColor
                  ? null
                  : this.iconButtonSmallNegativeBackgroundColor),
      iconButtonSmallNegativeBackgroundColorHighlighted:
          iconButtonSmallNegativeBackgroundColorHighlighted ??
              (this.iconButtonSmallNegativeBackgroundColorHighlighted ==
                      defaultTheme
                          .iconButtonSmallNegativeBackgroundColorHighlighted
                  ? null
                  : this.iconButtonSmallNegativeBackgroundColorHighlighted),
      iconButtonSmallNegativeBackgroundColorDisabled:
          iconButtonSmallNegativeBackgroundColorDisabled ??
              (this.iconButtonSmallNegativeBackgroundColorDisabled ==
                      defaultTheme
                          .iconButtonSmallNegativeBackgroundColorDisabled
                  ? null
                  : this.iconButtonSmallNegativeBackgroundColorDisabled),
      iconButtonSmallNegativeBorderColor: iconButtonSmallNegativeBorderColor ??
          (this.iconButtonSmallNegativeBorderColor ==
                  defaultTheme.iconButtonSmallNegativeBorderColor
              ? null
              : this.iconButtonSmallNegativeBorderColor),
      iconButtonSmallNegativeBorderColorHighlighted:
          iconButtonSmallNegativeBorderColorHighlighted ??
              (this.iconButtonSmallNegativeBorderColorHighlighted ==
                      defaultTheme.iconButtonSmallNegativeBorderColorHighlighted
                  ? null
                  : this.iconButtonSmallNegativeBorderColorHighlighted),
      iconButtonSmallNegativeBorderColorDisabled:
          iconButtonSmallNegativeBorderColorDisabled ??
              (this.iconButtonSmallNegativeBorderColorDisabled ==
                      defaultTheme.iconButtonSmallNegativeBorderColorDisabled
                  ? null
                  : this.iconButtonSmallNegativeBorderColorDisabled),
      iconButtonSmallNegativeIconColor: iconButtonSmallNegativeIconColor ??
          (this.iconButtonSmallNegativeIconColor ==
                  defaultTheme.iconButtonSmallNegativeIconColor
              ? null
              : this.iconButtonSmallNegativeIconColor),
      iconButtonSmallNegativeIconColorHighlighted:
          iconButtonSmallNegativeIconColorHighlighted ??
              (this.iconButtonSmallNegativeIconColorHighlighted ==
                      defaultTheme.iconButtonSmallNegativeIconColorHighlighted
                  ? null
                  : this.iconButtonSmallNegativeIconColorHighlighted),
      iconButtonSmallNegativeIconColorDisabled:
          iconButtonSmallNegativeIconColorDisabled ??
              (this.iconButtonSmallNegativeIconColorDisabled ==
                      defaultTheme.iconButtonSmallNegativeIconColorDisabled
                  ? null
                  : this.iconButtonSmallNegativeIconColorDisabled),

      // IconButtonSmallBorderless
      iconButtonSmallBorderlessBackgroundColor:
          iconButtonSmallBorderlessBackgroundColor ??
              (this.iconButtonSmallBorderlessBackgroundColor ==
                      defaultTheme.iconButtonSmallBorderlessBackgroundColor
                  ? null
                  : this.iconButtonSmallBorderlessBackgroundColor),
      iconButtonSmallBorderlessBackgroundColorHighlighted:
          iconButtonSmallBorderlessBackgroundColorHighlighted ??
              (this.iconButtonSmallBorderlessBackgroundColorHighlighted ==
                      defaultTheme
                          .iconButtonSmallBorderlessBackgroundColorHighlighted
                  ? null
                  : this.iconButtonSmallBorderlessBackgroundColorHighlighted),
      iconButtonSmallBorderlessBackgroundColorDisabled:
          iconButtonSmallBorderlessBackgroundColorDisabled ??
              (this.iconButtonSmallBorderlessBackgroundColorDisabled ==
                      defaultTheme
                          .iconButtonSmallBorderlessBackgroundColorDisabled
                  ? null
                  : this.iconButtonSmallBorderlessBackgroundColorDisabled),
      iconButtonSmallBorderlessIconColor: iconButtonSmallBorderlessIconColor ??
          (this.iconButtonSmallBorderlessIconColor ==
                  defaultTheme.iconButtonSmallBorderlessIconColor
              ? null
              : this.iconButtonSmallBorderlessIconColor),
      iconButtonSmallBorderlessIconColorHighlighted:
          iconButtonSmallBorderlessIconColorHighlighted ??
              (this.iconButtonSmallBorderlessIconColorHighlighted ==
                      defaultTheme.iconButtonSmallBorderlessIconColorHighlighted
                  ? null
                  : this.iconButtonSmallBorderlessIconColorHighlighted),
      iconButtonSmallBorderlessIconColorDisabled:
          iconButtonSmallBorderlessIconColorDisabled ??
              (this.iconButtonSmallBorderlessIconColorDisabled ==
                      defaultTheme.iconButtonSmallBorderlessIconColorDisabled
                  ? null
                  : this.iconButtonSmallBorderlessIconColorDisabled),

      // IconFormButton
      iconFormButtonBackgroundColor: iconFormButtonBackgroundColor ??
          (this.iconFormButtonBackgroundColor ==
                  defaultTheme.iconFormButtonBackgroundColor
              ? null
              : this.iconFormButtonBackgroundColor),
      iconFormButtonBackgroundColorHighlighted:
          iconFormButtonBackgroundColorHighlighted ??
              (this.iconFormButtonBackgroundColorHighlighted ==
                      defaultTheme.iconFormButtonBackgroundColorHighlighted
                  ? null
                  : this.iconFormButtonBackgroundColorHighlighted),
      iconFormButtonBackgroundColorDisabled:
          iconFormButtonBackgroundColorDisabled ??
              (this.iconFormButtonBackgroundColorDisabled ==
                      defaultTheme.iconFormButtonBackgroundColorDisabled
                  ? null
                  : this.iconFormButtonBackgroundColorDisabled),
      iconFormButtonBorderColor: iconFormButtonBorderColor ??
          (this.iconFormButtonBorderColor ==
                  defaultTheme.iconFormButtonBorderColor
              ? null
              : this.iconFormButtonBorderColor),
      iconFormButtonBorderColorHighlighted:
          iconFormButtonBorderColorHighlighted ??
              (this.iconFormButtonBorderColorHighlighted ==
                      defaultTheme.iconFormButtonBorderColorHighlighted
                  ? null
                  : this.iconFormButtonBorderColorHighlighted),
      iconFormButtonBorderColorDisabled: iconFormButtonBorderColorDisabled ??
          (this.iconFormButtonBorderColorDisabled ==
                  defaultTheme.iconFormButtonBorderColorDisabled
              ? null
              : this.iconFormButtonBorderColorDisabled),
      iconFormButtonIconColor: iconFormButtonIconColor ??
          (this.iconFormButtonIconColor == defaultTheme.iconFormButtonIconColor
              ? null
              : this.iconFormButtonIconColor),
      iconFormButtonIconColorHighlighted: iconFormButtonIconColorHighlighted ??
          (this.iconFormButtonIconColorHighlighted ==
                  defaultTheme.iconFormButtonIconColorHighlighted
              ? null
              : this.iconFormButtonIconColorHighlighted),
      iconFormButtonIconColorDisabled: iconFormButtonIconColorDisabled ??
          (this.iconFormButtonIconColorDisabled ==
                  defaultTheme.iconFormButtonIconColorDisabled
              ? null
              : this.iconFormButtonIconColorDisabled),

      // IconTextButton
      iconTextButtonBackgroundColor: iconTextButtonBackgroundColor ??
          (this.iconTextButtonBackgroundColor ==
                  defaultTheme.iconTextButtonBackgroundColor
              ? null
              : this.iconTextButtonBackgroundColor),
      iconTextButtonBackgroundColorHighlighted:
          iconTextButtonBackgroundColorHighlighted ??
              (this.iconTextButtonBackgroundColorHighlighted ==
                      defaultTheme.iconTextButtonBackgroundColorHighlighted
                  ? null
                  : this.iconTextButtonBackgroundColorHighlighted),
      iconTextButtonBackgroundColorDisabled:
          iconTextButtonBackgroundColorDisabled ??
              (this.iconTextButtonBackgroundColorDisabled ==
                      defaultTheme.iconTextButtonBackgroundColorDisabled
                  ? null
                  : this.iconTextButtonBackgroundColorDisabled),
      iconTextButtonIconColor: iconTextButtonIconColor ??
          (this.iconTextButtonIconColor == defaultTheme.iconTextButtonIconColor
              ? null
              : this.iconTextButtonIconColor),
      iconTextButtonIconColorHighlighted: iconTextButtonIconColorHighlighted ??
          (this.iconTextButtonIconColorHighlighted ==
                  defaultTheme.iconTextButtonIconColorHighlighted
              ? null
              : this.iconTextButtonIconColorHighlighted),
      iconTextButtonIconColorDisabled: iconTextButtonIconColorDisabled ??
          (this.iconTextButtonIconColorDisabled ==
                  defaultTheme.iconTextButtonIconColorDisabled
              ? null
              : this.iconTextButtonIconColorDisabled),
      iconTextButtonTextStyle: iconTextButtonTextStyle ??
          (this.iconTextButtonTextStyle == defaultTheme.iconTextButtonTextStyle
              ? null
              : this.iconTextButtonTextStyle),
      iconTextButtonTextStyleHighlighted: iconTextButtonTextStyleHighlighted ??
          (this.iconTextButtonTextStyleHighlighted ==
                  defaultTheme.iconTextButtonTextStyleHighlighted
              ? null
              : this.iconTextButtonTextStyleHighlighted),
      iconTextButtonTextStyleDisabled: iconTextButtonTextStyleDisabled ??
          (this.iconTextButtonTextStyleDisabled ==
                  defaultTheme.iconTextButtonTextStyleDisabled
              ? null
              : this.iconTextButtonTextStyleDisabled),

      // Link
      linkTextStyle: linkTextStyle ??
          (this.linkTextStyle == defaultTheme.linkTextStyle
              ? null
              : this.linkTextStyle),
      linkTextStyleHighlighted: linkTextStyleHighlighted ??
          (this.linkTextStyleHighlighted ==
                  defaultTheme.linkTextStyleHighlighted
              ? null
              : this.linkTextStyleHighlighted),

      //ListHeader
      listHeaderTextStyle: listHeaderTextStyle ??
          (this.listHeaderTextStyle == defaultTheme.listHeaderTextStyle
              ? null
              : this.listHeaderTextStyle),

      // ListItem
      listItemBackgroundColor: listItemBackgroundColor ??
          (this.listItemBackgroundColor == defaultTheme.listItemBackgroundColor
              ? null
              : this.listItemBackgroundColor),
      listItemBackgroundColorHighlighted: listItemBackgroundColorHighlighted ??
          (this.listItemBackgroundColorHighlighted ==
                  defaultTheme.listItemBackgroundColorHighlighted
              ? null
              : this.listItemBackgroundColorHighlighted),
      listItemTitleTextStyle: listItemTitleTextStyle ??
          (this.listItemTitleTextStyle == defaultTheme.listItemTitleTextStyle
              ? null
              : this.listItemTitleTextStyle),
      listItemSubtitleTextStyle: listItemSubtitleTextStyle ??
          (this.listItemSubtitleTextStyle ==
                  defaultTheme.listItemSubtitleTextStyle
              ? null
              : this.listItemSubtitleTextStyle),

      // Checkbox
      checkboxColor: checkboxColor ??
          (this.checkboxColor == defaultTheme.checkboxColor
              ? null
              : this.checkboxColor),
      checkboxColorDisabled: checkboxColorDisabled ??
          (this.checkboxColorDisabled == defaultTheme.checkboxColorDisabled
              ? null
              : this.checkboxColorDisabled),
      checkboxBackgroundColor: checkboxBackgroundColor ??
          (this.checkboxBackgroundColor == defaultTheme.checkboxBackgroundColor
              ? null
              : this.checkboxBackgroundColor),
      checkboxBackgroundColorHighlighted: checkboxBackgroundColorHighlighted ??
          (this.checkboxBackgroundColorHighlighted ==
                  defaultTheme.checkboxBackgroundColorHighlighted
              ? null
              : this.checkboxBackgroundColorHighlighted),
      checkboxBackgroundColorDisabled: checkboxBackgroundColorDisabled ??
          (this.checkboxBackgroundColorDisabled ==
                  defaultTheme.checkboxBackgroundColorDisabled
              ? null
              : this.checkboxBackgroundColorDisabled),
      checkboxBorderColor: checkboxBorderColor ??
          (this.checkboxBorderColor == defaultTheme.checkboxBorderColor
              ? null
              : this.checkboxBorderColor),
      checkboxBorderColorDisabled: checkboxBorderColorDisabled ??
          (this.checkboxBorderColorDisabled ==
                  defaultTheme.checkboxBorderColorDisabled
              ? null
              : this.checkboxBorderColorDisabled),
      checkboxListItemBackgroundColor: checkboxListItemBackgroundColor ??
          (this.checkboxListItemBackgroundColor ==
                  defaultTheme.checkboxListItemBackgroundColor
              ? null
              : this.checkboxListItemBackgroundColor),
      checkboxListItemBackgroundColorHighlighted:
          checkboxListItemBackgroundColorHighlighted ??
              (this.checkboxListItemBackgroundColorHighlighted ==
                      defaultTheme.checkboxListItemBackgroundColorHighlighted
                  ? null
                  : this.checkboxListItemBackgroundColorHighlighted),
      checkboxListItemBackgroundColorDisabled:
          checkboxListItemBackgroundColorDisabled ??
              (this.checkboxListItemBackgroundColorDisabled ==
                      defaultTheme.checkboxListItemBackgroundColorDisabled
                  ? null
                  : this.checkboxListItemBackgroundColorDisabled),
      checkboxListItemIconColor: checkboxListItemIconColor ??
          (this.checkboxListItemIconColor ==
                  defaultTheme.checkboxListItemIconColor
              ? null
              : this.checkboxListItemIconColor),
      checkboxListItemIconColorDisabled: checkboxListItemIconColorDisabled ??
          (this.checkboxListItemIconColorDisabled ==
                  defaultTheme.checkboxListItemIconColorDisabled
              ? null
              : this.checkboxListItemIconColorDisabled),
      checkboxListItemTextStyle: checkboxListItemTextStyle ??
          (this.checkboxListItemTextStyle ==
                  defaultTheme.checkboxListItemTextStyle
              ? null
              : this.checkboxListItemTextStyle),
      checkboxListItemTextStyleDisabled: checkboxListItemTextStyleDisabled ??
          (this.checkboxListItemTextStyleDisabled ==
                  defaultTheme.checkboxListItemTextStyleDisabled
              ? null
              : this.checkboxListItemTextStyleDisabled),
      checkboxListItemSecondaryTextStyle: checkboxListItemSecondaryTextStyle ??
          (this.checkboxListItemSecondaryTextStyle ==
                  defaultTheme.checkboxListItemSecondaryTextStyle
              ? null
              : this.checkboxListItemSecondaryTextStyle),
      checkboxListItemSecondaryTextStyleDisabled:
          checkboxListItemSecondaryTextStyleDisabled ??
              (this.checkboxListItemSecondaryTextStyleDisabled ==
                      defaultTheme.checkboxListItemSecondaryTextStyleDisabled
                  ? null
                  : this.checkboxListItemSecondaryTextStyleDisabled),

      // RadioButton
      radioButtonColor: radioButtonColor ??
          (this.radioButtonColor == defaultTheme.radioButtonColor
              ? null
              : this.radioButtonColor),
      radioButtonColorDisabled: radioButtonColorDisabled ??
          (this.radioButtonColorDisabled ==
                  defaultTheme.radioButtonColorDisabled
              ? null
              : this.radioButtonColorDisabled),
      radioButtonBackgroundColor: radioButtonBackgroundColor ??
          (this.radioButtonBackgroundColor ==
                  defaultTheme.radioButtonBackgroundColor
              ? null
              : this.radioButtonBackgroundColor),
      radioButtonBackgroundColorHighlighted:
          radioButtonBackgroundColorHighlighted ??
              (this.radioButtonBackgroundColorHighlighted ==
                      defaultTheme.radioButtonBackgroundColorHighlighted
                  ? null
                  : this.radioButtonBackgroundColorHighlighted),
      radioButtonBackgroundColorDisabled: radioButtonBackgroundColorDisabled ??
          (this.radioButtonBackgroundColorDisabled ==
                  defaultTheme.radioButtonBackgroundColorDisabled
              ? null
              : this.radioButtonBackgroundColorDisabled),
      radioButtonBorderColor: radioButtonBorderColor ??
          (this.radioButtonBorderColor == defaultTheme.radioButtonBorderColor
              ? null
              : this.radioButtonBorderColor),
      radioButtonBorderColorDisabled: radioButtonBorderColorDisabled ??
          (this.radioButtonBorderColorDisabled ==
                  defaultTheme.radioButtonBorderColorDisabled
              ? null
              : this.radioButtonBorderColorDisabled),
      radioButtonListItemBackgroundColor: radioButtonListItemBackgroundColor ??
          (this.radioButtonListItemBackgroundColor ==
                  defaultTheme.radioButtonListItemBackgroundColor
              ? null
              : this.radioButtonListItemBackgroundColor),
      radioButtonListItemBackgroundColorHighlighted:
          radioButtonListItemBackgroundColorHighlighted ??
              (this.radioButtonListItemBackgroundColorHighlighted ==
                      defaultTheme.radioButtonListItemBackgroundColorHighlighted
                  ? null
                  : this.radioButtonListItemBackgroundColorHighlighted),
      radioButtonListItemBackgroundColorDisabled:
          radioButtonListItemBackgroundColorDisabled ??
              (this.radioButtonListItemBackgroundColorDisabled ==
                      defaultTheme.radioButtonListItemBackgroundColorDisabled
                  ? null
                  : this.radioButtonListItemBackgroundColorDisabled),
      radioButtonListItemIconColor: radioButtonListItemIconColor ??
          (this.radioButtonListItemIconColor ==
                  defaultTheme.radioButtonListItemIconColor
              ? null
              : this.radioButtonListItemIconColor),
      radioButtonListItemIconColorDisabled:
          radioButtonListItemIconColorDisabled ??
              (this.radioButtonListItemIconColorDisabled ==
                      defaultTheme.radioButtonListItemIconColorDisabled
                  ? null
                  : this.radioButtonListItemIconColorDisabled),
      radioButtonListItemTextStyle: radioButtonListItemTextStyle ??
          (this.radioButtonListItemTextStyle ==
                  defaultTheme.radioButtonListItemTextStyle
              ? null
              : this.radioButtonListItemTextStyle),
      radioButtonListItemTextStyleDisabled:
          radioButtonListItemTextStyleDisabled ??
              (this.radioButtonListItemTextStyleDisabled ==
                      defaultTheme.radioButtonListItemTextStyleDisabled
                  ? null
                  : this.radioButtonListItemTextStyleDisabled),
      radioButtonListItemSecondaryTextStyle:
          radioButtonListItemSecondaryTextStyle ??
              (this.radioButtonListItemSecondaryTextStyle ==
                      defaultTheme.radioButtonListItemSecondaryTextStyle
                  ? null
                  : this.radioButtonListItemSecondaryTextStyle),
      radioButtonListItemSecondaryTextStyleDisabled:
          radioButtonListItemSecondaryTextStyleDisabled ??
              (this.radioButtonListItemSecondaryTextStyleDisabled ==
                      defaultTheme.radioButtonListItemSecondaryTextStyleDisabled
                  ? null
                  : this.radioButtonListItemSecondaryTextStyleDisabled),

      // SegmentedButton
      segmentedButtonBackgroundColor: segmentedButtonBackgroundColor ??
          (this.segmentedButtonBackgroundColor ==
                  defaultTheme.segmentedButtonBackgroundColor
              ? null
              : this.segmentedButtonBackgroundColor),
      segmentedButtonSelectedColor: segmentedButtonSelectedColor ??
          (this.segmentedButtonSelectedColor ==
                  defaultTheme.segmentedButtonSelectedColor
              ? null
              : this.segmentedButtonSelectedColor),
      segmentedButtonTextStyle: segmentedButtonTextStyle ??
          (this.segmentedButtonTextStyle ==
                  defaultTheme.segmentedButtonTextStyle
              ? null
              : this.segmentedButtonTextStyle),

      // TextField
      textFieldTextStyle: textFieldTextStyle ??
          (this.textFieldTextStyle == defaultTheme.textFieldTextStyle
              ? null
              : this.textFieldTextStyle),
      textFieldTextStyleDisabled: textFieldTextStyleDisabled ??
          (this.textFieldTextStyleDisabled ==
                  defaultTheme.textFieldTextStyleDisabled
              ? null
              : this.textFieldTextStyleDisabled),
      textFieldPlaceholderTextStyle: textFieldPlaceholderTextStyle ??
          (this.textFieldPlaceholderTextStyle ==
                  defaultTheme.textFieldPlaceholderTextStyle
              ? null
              : this.textFieldPlaceholderTextStyle),
      textFieldPlaceholderTextStyleDisabled:
          textFieldPlaceholderTextStyleDisabled ??
              (this.textFieldPlaceholderTextStyleDisabled ==
                      defaultTheme.textFieldPlaceholderTextStyleDisabled
                  ? null
                  : this.textFieldPlaceholderTextStyleDisabled),
      textFieldErrorTextStyle: textFieldErrorTextStyle ??
          (this.textFieldErrorTextStyle == defaultTheme.textFieldErrorTextStyle
              ? null
              : this.textFieldErrorTextStyle),
      textFieldDividerColor: textFieldDividerColor ??
          (this.textFieldDividerColor == defaultTheme.textFieldDividerColor
              ? null
              : this.textFieldDividerColor),
      textFieldDividerColorHighlighted: textFieldDividerColorHighlighted ??
          (this.textFieldDividerColorHighlighted ==
                  defaultTheme.textFieldDividerColorHighlighted
              ? null
              : this.textFieldDividerColorHighlighted),
      textFieldDividerColorError: textFieldDividerColorError ??
          (this.textFieldDividerColorError ==
                  defaultTheme.textFieldDividerColorError
              ? null
              : this.textFieldDividerColorError),
      textFieldCursorColor: textFieldCursorColor ??
          (this.textFieldCursorColor == defaultTheme.textFieldCursorColor
              ? null
              : this.textFieldCursorColor),
      textFieldSelectionColor: textFieldSelectionColor ??
          (this.textFieldSelectionColor == defaultTheme.textFieldSelectionColor
              ? null
              : this.textFieldSelectionColor),
      textFieldSelectionHandleColor: textFieldSelectionHandleColor ??
          (this.textFieldSelectionHandleColor ==
                  defaultTheme.textFieldSelectionHandleColor
              ? null
              : this.textFieldSelectionHandleColor),
      textFieldIconColor: textFieldIconColor ??
          (this.textFieldIconColor == defaultTheme.textFieldIconColor
              ? null
              : this.textFieldIconColor),
      textFieldIconColorDisabled: textFieldIconColorDisabled ??
          (this.textFieldIconColorDisabled ==
                  defaultTheme.textFieldIconColorDisabled
              ? null
              : this.textFieldIconColorDisabled),

      // Group
      groupBackgroundColor: groupBackgroundColor ??
          (this.groupBackgroundColor == defaultTheme.groupBackgroundColor
              ? null
              : this.groupBackgroundColor),

      // Accordion
      accordionTitleTextStyle: accordionTitleTextStyle ??
          (this.accordionTitleTextStyle == defaultTheme.accordionTitleTextStyle
              ? null
              : this.accordionTitleTextStyle),
      accordionBodyTextStyle: accordionBodyTextStyle ??
          (this.accordionBodyTextStyle == defaultTheme.accordionBodyTextStyle
              ? null
              : this.accordionBodyTextStyle),
      accordionBackgroundColor: accordionBackgroundColor ??
          (this.accordionBackgroundColor ==
                  defaultTheme.accordionBackgroundColor
              ? null
              : this.accordionBackgroundColor),

      // Modal
      modalBackgroundColor: modalBackgroundColor ??
          (this.modalBackgroundColor == defaultTheme.modalBackgroundColor
              ? null
              : this.modalBackgroundColor),
      modalTitleTextStyle: modalTitleTextStyle ??
          (this.modalTitleTextStyle == defaultTheme.modalTitleTextStyle
              ? null
              : this.modalTitleTextStyle),

      // Select
      selectLabelTextStyle: selectLabelTextStyle ??
          (this.selectLabelTextStyle == defaultTheme.selectLabelTextStyle
              ? null
              : this.selectLabelTextStyle),
      selectLabelTextStyleDisabled: selectLabelTextStyleDisabled ??
          (this.selectLabelTextStyleDisabled ==
                  defaultTheme.selectLabelTextStyleDisabled
              ? null
              : this.selectLabelTextStyleDisabled),

      // Toast
      toastTextStyle: toastTextStyle ??
          (this.toastTextStyle == defaultTheme.toastTextStyle
              ? null
              : this.toastTextStyle),
      toastBackgroundColor: toastBackgroundColor ??
          (this.toastBackgroundColor == defaultTheme.toastBackgroundColor
              ? null
              : this.toastBackgroundColor),

      // Tab Bar
      tabBarTextStyle: tabBarTextStyle ??
          (this.tabBarTextStyle == defaultTheme.tabBarTextStyle
              ? null
              : this.tabBarTextStyle),

      // Menu
      menuBackgroundColor: menuBackgroundColor ??
          (this.menuBackgroundColor == defaultTheme.menuBackgroundColor
              ? null
              : this.menuBackgroundColor),
      menuBorderColor: menuBorderColor ??
          (this.menuBorderColor == defaultTheme.menuBorderColor
              ? null
              : this.menuBorderColor),

      // Menu Entry
      menuEntryTextStyle: menuEntryTextStyle ??
          (this.menuEntryTextStyle == defaultTheme.menuEntryTextStyle
              ? null
              : this.menuEntryTextStyle),
      menuEntryBackgroundColor: menuEntryBackgroundColor ??
          (this.menuEntryBackgroundColor ==
                  defaultTheme.menuEntryBackgroundColor
              ? null
              : this.menuEntryBackgroundColor),
      menuEntryForegroundColor: menuEntryForegroundColor ??
          (this.menuEntryForegroundColor ==
                  defaultTheme.menuEntryForegroundColor
              ? null
              : this.menuEntryForegroundColor),

      //User Menu
      userMenuTextStyle: userMenuTextStyle ??
          (this.userMenuTextStyle == defaultTheme.userMenuTextStyle
              ? null
              : this.userMenuTextStyle),
      userMenuForegroundColor: userMenuForegroundColor ??
          (this.userMenuForegroundColor == defaultTheme.userMenuForegroundColor
              ? null
              : this.userMenuForegroundColor),

      // Breadcrumb
      breadcrumbTextStyle: breadcrumbTextStyle ??
          (this.breadcrumbTextStyle == defaultTheme.breadcrumbTextStyle
              ? null
              : this.breadcrumbTextStyle),
      breadcrumbForegroundColor: breadcrumbForegroundColor ??
          (this.breadcrumbForegroundColor ==
                  defaultTheme.breadcrumbForegroundColor
              ? null
              : this.breadcrumbForegroundColor),

      //Sidebar
      sidebarBackgroundColor: sidebarBackgroundColor ??
          (this.sidebarBackgroundColor == defaultTheme.sidebarBackgroundColor
              ? null
              : this.sidebarBackgroundColor),
      sidebarBorderColor: sidebarBorderColor ??
          (this.sidebarBorderColor == defaultTheme.sidebarBorderColor
              ? null
              : this.sidebarBorderColor),
      sidebarItemBackgroundColor: sidebarItemBackgroundColor ??
          (this.sidebarItemBackgroundColor ==
                  defaultTheme.sidebarItemBackgroundColor
              ? null
              : this.sidebarItemBackgroundColor),
      sidebarItemForegroundColor: sidebarItemForegroundColor ??
          (this.sidebarItemForegroundColor ==
                  defaultTheme.sidebarItemForegroundColor
              ? null
              : this.sidebarItemForegroundColor),
      sidebarItemTextStyle: sidebarItemTextStyle ??
          (this.sidebarItemTextStyle == defaultTheme.sidebarItemTextStyle
              ? null
              : this.sidebarItemTextStyle),
    );
  }

  ThemeData createTheme() {
    final baseButtonStyle = ButtonStyle(
      overlayColor: allStates(SBBColors.transparent),
      shape: allStates(RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SBBInternal.defaultButtonHeight / 2))),
      fixedSize:
          allStates(const Size.fromHeight(SBBInternal.defaultButtonHeight)),
      padding: allStates(EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
      elevation: allStates(0),
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
      dividerTheme:
          DividerThemeData(thickness: 1.0, space: 0.0, color: dividerColor),
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
          overlayColor: resolveStatesWith(
            defaultValue: primaryButtonBackgroundColor,
            pressedValue: primaryButtonBackgroundColorHighlighted,
          ),
          backgroundColor: resolveStatesWith(
            defaultValue: primaryButtonBackgroundColor,
            pressedValue: primaryButtonBackgroundColor,
            disabledValue: primaryButtonBackgroundColorDisabled,
          ),
          foregroundColor: resolveStatesWith(
            defaultValue: primaryButtonTextStyle.color!,
            pressedValue: primaryButtonTextStyleHighlighted.color,
            disabledValue: primaryButtonTextStyleDisabled.color,
          ),
          textStyle: resolveStatesWith(
            defaultValue: primaryButtonTextStyle,
            pressedValue: primaryButtonTextStyleHighlighted,
            disabledValue: primaryButtonTextStyleDisabled,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: baseButtonStyle.copyWith(
          overlayColor: resolveStatesWith(
            defaultValue: secondaryButtonBackgroundColor,
            pressedValue: secondaryButtonBackgroundColorHighlighted,
          ),
          backgroundColor: resolveStatesWith(
            defaultValue: secondaryButtonBackgroundColor,
            pressedValue: secondaryButtonBackgroundColor,
            disabledValue: secondaryButtonBackgroundColorDisabled,
          ),
          foregroundColor: resolveStatesWith(
            defaultValue: secondaryButtonTextStyle.color!,
            pressedValue: secondaryButtonTextStyleHighlighted.color,
            disabledValue: secondaryButtonTextStyleDisabled.color,
          ),
          textStyle: resolveStatesWith(
            defaultValue: secondaryButtonTextStyle,
            pressedValue: secondaryButtonTextStyleHighlighted,
            disabledValue: secondaryButtonTextStyleDisabled,
          ),
          side: resolveStatesWith(
            defaultValue: BorderSide(color: secondaryButtonBorderColor),
            pressedValue:
                BorderSide(color: secondaryButtonBorderColorHighlighted),
            disabledValue:
                BorderSide(color: secondaryButtonBorderColorDisabled),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: baseButtonStyle.copyWith(
          overlayColor: resolveStatesWith(
            defaultValue: tertiaryButtonLargeBackgroundColor,
            pressedValue: tertiaryButtonLargeBackgroundColorHighlighted,
          ),
          backgroundColor: resolveStatesWith(
            defaultValue: tertiaryButtonLargeBackgroundColor,
            pressedValue: tertiaryButtonLargeBackgroundColor,
            disabledValue: tertiaryButtonLargeBackgroundColorDisabled,
          ),
          foregroundColor: resolveStatesWith(
            defaultValue: tertiaryButtonLargeTextStyle.color!,
            pressedValue: tertiaryButtonLargeTextStyleHighlighted.color,
            disabledValue: tertiaryButtonLargeTextStyleDisabled.color,
          ),
          textStyle: resolveStatesWith(
            defaultValue: tertiaryButtonLargeTextStyle,
            pressedValue: tertiaryButtonLargeTextStyleHighlighted,
            disabledValue: tertiaryButtonLargeTextStyleDisabled,
          ),
          side: resolveStatesWith(
            defaultValue: BorderSide(color: tertiaryButtonLargeBorderColor),
            pressedValue:
                BorderSide(color: tertiaryButtonLargeBorderColorHighlighted),
            disabledValue:
                BorderSide(color: tertiaryButtonLargeBorderColorDisabled),
          ),
        ),
      ),
      cardTheme: CardTheme(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing))),
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

  // used to get the statusBarHeight in various locations through _InheritedWidget (SBBTheme)
  //
  // workaround for modal bar & Onboarding in mobile
  // refer to https://github.com/flutter/flutter/issues/39205
  double _statusBarHeight = 24.0;
  double get statusBarHeight => _statusBarHeight;

  updateStatusBarHeight(BuildContext context) {
    if (_statusBarHeight == null) {
      _statusBarHeight = MediaQuery.of(context).padding.top;
    }
  }

  bool get isDark => brightness == Brightness.dark;

  /// Convenience method for easier use of [MaterialStateProperty.all].
  static MaterialStateProperty<T> allStates<T>(T value) {
    return MaterialStateProperty.all(value);
  }

  /// Convenience method for easier use of [MaterialStateProperty.resolveWith].
  static MaterialStateProperty<T?> resolveStatesWith<T>(
      {required T defaultValue,
      T? pressedValue,
      T? disabledValue,
      T? hoveredValue,
      T? selectedValue}) {
    return MaterialStateProperty.resolveWith((states) {
      // disabled
      if (states.contains(MaterialState.disabled) && disabledValue != null)
        return disabledValue;

      // pressed / focused
      if (states.any({MaterialState.pressed, MaterialState.focused}.contains)) {
        return pressedValue;
      }
      // hovered
      if (states.contains(MaterialState.hovered) && hoveredValue != null)
        return hoveredValue;

      // selected
      if (states.contains(MaterialState.selected) && hoveredValue != null)
        return selectedValue;

      // default
      return defaultValue;
    });
  }
}
