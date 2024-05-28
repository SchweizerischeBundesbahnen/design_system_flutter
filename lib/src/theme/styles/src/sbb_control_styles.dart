import 'package:flutter/material.dart';

import '../../../toast/sbb_toast.dart';
import '../sbb_styles.dart';

class SBBControlStyles extends ThemeExtension<SBBControlStyles> {
  SBBControlStyles({
    this.checkbox,
    this.chip,
    this.pagination,
    this.slider,
    this.radioButton,
    this.textField,
    this.segmentedButton,
    this.redSegmentedButton,
    this.listItem,
    this.selectLabel,
    this.switchToggle,
    this.headerBackgroundColor,
    this.headerButtonBackgroundColorHighlighted,
    this.headerIconColor,
    this.headerTextStyle,
    this.linkTextStyle,
    this.linkTextStyleHighlighted,
    this.listHeaderTextStyle,
    this.groupBackgroundColor,
    this.accordionTitleTextStyle,
    this.accordionBodyTextStyle,
    this.accordionBackgroundColor,
    this.modalBackgroundColor,
    this.modalTitleTextStyle,
    this.toastTextStyle,
    this.toastBackgroundColor,
    this.tabBarTextStyle,
    this.menuBackgroundColor,
    this.menuBorderColor,
    this.menuEntryForegroundColor,
    this.menuEntryBackgroundColor,
    this.menuEntryTextStyle,
    this.userMenuTextStyle,
    this.userMenuForegroundColor,
    this.breadcrumbTextStyle,
    this.breadcrumbForegroundColor,
    this.sidebarBackgroundColor,
    this.sidebarBorderColor,
    this.sidebarItemBackgroundColor,
    this.sidebarItemForegroundColor,
    this.sidebarItemTextStyle,
    this.headerNavItemForegroundColor,
    this.promotionBox,
  });

  factory SBBControlStyles.$default({required SBBBaseStyle baseStyle}) =>
      SBBControlStyles(
        listItem: SBBListItemStyle.$default(baseStyle: baseStyle),
        slider: SBBSliderStyle.$default(baseStyle: baseStyle),
        checkbox: SBBControlStyle.$default(baseStyle: baseStyle),
        chip: SBBChipStyle.$default(baseStyle: baseStyle),
        pagination: SBBPaginationStyle.$default(baseStyle: baseStyle),
        radioButton: SBBControlStyle.$default(baseStyle: baseStyle),
        textField: SBBTextFieldStyle.$default(baseStyle: baseStyle),
        segmentedButton: SBBSegmentedButtonStyle.$default(baseStyle: baseStyle),
        redSegmentedButton: SBBSegmentedButtonStyle.red(baseStyle: baseStyle),
        selectLabel: SBBTextStyle(
          textStyle: baseStyle.themedTextStyle(
              textStyle: SBBTextStyles.helpersLabel,
              color: baseStyle.themeValue(SBBColors.metal, SBBColors.cement)),
          textStyleDisabled: baseStyle.themedTextStyle(
              textStyle: SBBTextStyles.helpersLabel, color: SBBColors.metal),
        ),
        switchToggle: SBBSwitchStyle.$default(baseStyle: baseStyle),
        headerBackgroundColor: baseStyle.primaryColor,
        headerButtonBackgroundColorHighlighted: baseStyle.primaryColorDark,
        headerIconColor: SBBColors.white,
        headerTextStyle: baseStyle.themedTextStyle(
            textStyle: SBBTextStyles.largeLight, color: SBBColors.white),
        linkTextStyle:
            baseStyle.defaultTextStyle?.copyWith(color: baseStyle.primaryColor),
        linkTextStyleHighlighted: baseStyle.defaultTextStyle?.copyWith(
          color:
              baseStyle.themeValue(baseStyle.primaryColorDark, SBBColors.white),
        ),
        listHeaderTextStyle:
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
        groupBackgroundColor:
            baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
        accordionTitleTextStyle:
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
        accordionBodyTextStyle:
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
        accordionBackgroundColor:
            baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
        modalBackgroundColor:
            baseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
        modalTitleTextStyle:
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight),
        toastTextStyle: baseStyle.themedTextStyle(
            textStyle: SBBTextStyles.smallLight, color: SBBColors.white),
        toastBackgroundColor:
            baseStyle.themeValue(SBBColors.metal, SBBColors.smoke),
        tabBarTextStyle:
            baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
        menuBackgroundColor: SBBColors.white,
        menuBorderColor: SBBColors.iron,
        menuEntryBackgroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.white,
          disabledValue: SBBColors.white,
          hoveredValue: SBBColors.milk,
          pressedValue: SBBColors.milk,
        ),
        menuEntryForegroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.iron,
          disabledValue: SBBColors.iron,
          hoveredValue: SBBColors.red125,
          pressedValue: SBBColors.red125,
        ),
        menuEntryTextStyle: SBBLeanTextStyles.contextMenu,
        userMenuTextStyle: SBBLeanTextStyles.contextMenu,
        userMenuForegroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.iron,
          hoveredValue: SBBColors.red125,
          pressedValue: SBBColors.red125,
          disabledValue: SBBColors.iron,
        ),
        breadcrumbTextStyle: SBBLeanTextStyles.breadcrumb,
        breadcrumbForegroundColor: SBBTheme.resolveStatesWith(
          defaultValue: SBBColors.granite,
          disabledValue: SBBColors.black,
          hoveredValue: SBBColors.red125,
          pressedValue: SBBColors.red125,
        ),
        sidebarBackgroundColor: SBBColors.white,
        sidebarBorderColor: SBBColors.silver,
        sidebarItemBackgroundColor: SBBTheme.resolveStatesWith(
            defaultValue: SBBColors.transparent,
            hoveredValue: SBBColors.milk,
            selectedValue: SBBColors.cloud),
        sidebarItemForegroundColor: SBBTheme.resolveStatesWith(
            defaultValue: SBBColors.iron,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125),
        sidebarItemTextStyle: SBBLeanTextStyles.contextMenu,
        headerNavItemForegroundColor: SBBTheme.resolveStatesWith(
            defaultValue: SBBColors.black,
            disabledValue: SBBColors.black,
            hoveredValue: SBBColors.red125,
            pressedValue: SBBColors.red125),
        promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
      );

  final SBBControlStyle? checkbox;
  final SBBSwitchStyle? switchToggle;
  final SBBControlStyle? radioButton;
  final SBBTextFieldStyle? textField;
  final SBBSegmentedButtonStyle? segmentedButton;
  final SBBSegmentedButtonStyle? redSegmentedButton;
  final SBBListItemStyle? listItem;
  final SBBTextStyle? selectLabel;
  final SBBSliderStyle? slider;
  final SBBChipStyle? chip;
  final SBBPaginationStyle? pagination;

  final Color? headerBackgroundColor;
  final Color? headerButtonBackgroundColorHighlighted;
  final Color? headerIconColor;
  final TextStyle? headerTextStyle;
  final TextStyle? linkTextStyle;
  final TextStyle? linkTextStyleHighlighted;
  final TextStyle? listHeaderTextStyle;
  final Color? groupBackgroundColor;
  final TextStyle? accordionTitleTextStyle;
  final TextStyle? accordionBodyTextStyle;
  final Color? accordionBackgroundColor;
  final Color? modalBackgroundColor;
  final TextStyle? modalTitleTextStyle;
  final TextStyle? toastTextStyle;
  final Color? toastBackgroundColor;
  final TextStyle? tabBarTextStyle;
  final Color? menuBackgroundColor;
  final Color? menuBorderColor;
  final MaterialStateProperty<Color?>? menuEntryForegroundColor;
  final MaterialStateProperty<Color?>? menuEntryBackgroundColor;
  final TextStyle? menuEntryTextStyle;
  final TextStyle? userMenuTextStyle;
  final MaterialStateProperty<Color?>? userMenuForegroundColor;
  final TextStyle? breadcrumbTextStyle;
  final MaterialStateProperty<Color?>? breadcrumbForegroundColor;
  final Color? sidebarBackgroundColor;
  final Color? sidebarBorderColor;
  final MaterialStateProperty<Color?>? sidebarItemBackgroundColor;
  final MaterialStateProperty<Color?>? sidebarItemForegroundColor;
  final TextStyle? sidebarItemTextStyle;
  final MaterialStateProperty<Color?>? headerNavItemForegroundColor;
  final PromotionBoxStyle? promotionBox;

  static SBBControlStyles of(BuildContext context) =>
      Theme.of(context).extension<SBBControlStyles>()!;

  AppBarTheme get appBarTheme => AppBarTheme(
        color: headerBackgroundColor,
        iconTheme: IconThemeData(color: headerIconColor),
        actionsIconTheme: IconThemeData(color: headerIconColor),
        elevation: 0.0,
        centerTitle: true,
      );

  CardTheme get cardTheme => CardTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing)),
        ),
        margin: EdgeInsets.zero,
        color: groupBackgroundColor,
        clipBehavior: Clip.hardEdge,
        elevation: 0,
      );

  TooltipThemeData get tooltipTheme => TooltipThemeData(
        decoration: BoxDecoration(
          color: toastBackgroundColor,
          borderRadius: new BorderRadius.all(const Radius.circular(19.0)),
        ),
        textStyle: toastTextStyle,
        showDuration: SBBToast.durationShort,
        margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      );

  TextSelectionThemeData get textSelectionTheme => TextSelectionThemeData(
        selectionColor: textField!.selectionColor,
        cursorColor: textField!.cursorColor,
        selectionHandleColor: textField!.selectionHandleColor,
      );

  @override
  ThemeExtension<SBBControlStyles> copyWith({
    SBBControlStyle? checkbox,
    SBBSliderStyle? slider,
    SBBChipStyle? chip,
    SBBPaginationStyle? pagination,
    SBBControlStyle? radioButton,
    SBBTextFieldStyle? textField,
    SBBSegmentedButtonStyle? segmentedButton,
    SBBSegmentedButtonStyle? redSegmentedButton,
    SBBListItemStyle? listItem,
    SBBTextStyle? selectLabel,
    SBBSwitchStyle? switchToggle,
    Color? headerBackgroundColor,
    Color? headerButtonBackgroundColorHighlighted,
    Color? headerIconColor,
    TextStyle? headerTextStyle,
    TextStyle? linkTextStyle,
    TextStyle? linkTextStyleHighlighted,
    TextStyle? listHeaderTextStyle,
    Color? groupBackgroundColor,
    TextStyle? accordionTitleTextStyle,
    TextStyle? accordionBodyTextStyle,
    Color? accordionBackgroundColor,
    Color? modalBackgroundColor,
    TextStyle? modalTitleTextStyle,
    TextStyle? toastTextStyle,
    Color? toastBackgroundColor,
    TextStyle? tabBarTextStyle,
    Color? menuBackgroundColor,
    Color? menuBorderColor,
    MaterialStateProperty<Color?>? menuEntryForegroundColor,
    MaterialStateProperty<Color?>? menuEntryBackgroundColor,
    TextStyle? menuEntryTextStyle,
    TextStyle? userMenuTextStyle,
    MaterialStateProperty<Color?>? userMenuForegroundColor,
    TextStyle? breadcrumbTextStyle,
    MaterialStateProperty<Color?>? breadcrumbForegroundColor,
    Color? sidebarBackgroundColor,
    Color? sidebarBorderColor,
    MaterialStateProperty<Color?>? sidebarItemBackgroundColor,
    MaterialStateProperty<Color?>? sidebarItemForegroundColor,
    TextStyle? sidebarItemTextStyle,
    MaterialStateProperty<Color?>? headerNavItemForegroundColor,
    PromotionBoxStyle? promotionBox,
  }) =>
      SBBControlStyles(
        checkbox: checkbox ?? this.checkbox,
        slider: slider ?? this.slider,
        chip: chip ?? this.chip,
        pagination: pagination ?? this.pagination,
        radioButton: radioButton ?? this.radioButton,
        textField: textField ?? this.textField,
        segmentedButton: segmentedButton ?? this.segmentedButton,
        redSegmentedButton: redSegmentedButton ?? this.redSegmentedButton,
        listItem: listItem ?? this.listItem,
        selectLabel: selectLabel ?? this.selectLabel,
        switchToggle: switchToggle ?? this.switchToggle,
        headerBackgroundColor:
            headerBackgroundColor ?? this.headerBackgroundColor,
        headerButtonBackgroundColorHighlighted:
            headerButtonBackgroundColorHighlighted ??
                this.headerButtonBackgroundColorHighlighted,
        headerIconColor: headerIconColor ?? this.headerIconColor,
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        linkTextStyle: linkTextStyle ?? this.linkTextStyle,
        linkTextStyleHighlighted:
            linkTextStyleHighlighted ?? this.linkTextStyleHighlighted,
        listHeaderTextStyle: listHeaderTextStyle ?? this.listHeaderTextStyle,
        groupBackgroundColor: groupBackgroundColor ?? this.groupBackgroundColor,
        accordionTitleTextStyle:
            accordionTitleTextStyle ?? this.accordionTitleTextStyle,
        accordionBodyTextStyle:
            accordionBodyTextStyle ?? this.accordionBodyTextStyle,
        accordionBackgroundColor:
            accordionBackgroundColor ?? this.accordionBackgroundColor,
        modalBackgroundColor: modalBackgroundColor ?? this.modalBackgroundColor,
        modalTitleTextStyle: modalTitleTextStyle ?? this.modalTitleTextStyle,
        toastTextStyle: toastTextStyle ?? this.toastTextStyle,
        toastBackgroundColor: toastBackgroundColor ?? this.toastBackgroundColor,
        tabBarTextStyle: tabBarTextStyle ?? this.tabBarTextStyle,
        menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
        menuBorderColor: menuBorderColor ?? this.menuBorderColor,
        menuEntryForegroundColor:
            menuEntryForegroundColor ?? this.menuEntryForegroundColor,
        menuEntryBackgroundColor:
            menuEntryBackgroundColor ?? this.menuEntryBackgroundColor,
        menuEntryTextStyle: menuEntryTextStyle ?? this.menuEntryTextStyle,
        userMenuTextStyle: userMenuTextStyle ?? this.userMenuTextStyle,
        userMenuForegroundColor:
            userMenuForegroundColor ?? this.userMenuForegroundColor,
        breadcrumbTextStyle: breadcrumbTextStyle ?? this.breadcrumbTextStyle,
        breadcrumbForegroundColor:
            breadcrumbForegroundColor ?? this.breadcrumbForegroundColor,
        sidebarBackgroundColor:
            sidebarBackgroundColor ?? this.sidebarBackgroundColor,
        sidebarBorderColor: sidebarBorderColor ?? this.sidebarBorderColor,
        sidebarItemBackgroundColor:
            sidebarItemBackgroundColor ?? this.sidebarItemBackgroundColor,
        sidebarItemForegroundColor:
            sidebarItemForegroundColor ?? this.sidebarItemForegroundColor,
        sidebarItemTextStyle: sidebarItemTextStyle ?? this.sidebarItemTextStyle,
        headerNavItemForegroundColor:
            headerNavItemForegroundColor ?? this.headerNavItemForegroundColor,
        promotionBox: promotionBox ?? this.promotionBox,
      );

  @override
  ThemeExtension<SBBControlStyles> lerp(
      ThemeExtension<SBBControlStyles>? other, double t) {
    if (other is! SBBControlStyles) return this;
    return SBBControlStyles(
      checkbox: checkbox?.lerp(other.checkbox, t),
      slider: slider?.lerp(other.slider, t),
      chip: chip?.lerp(other.chip, t),
      pagination: pagination?.lerp(other.pagination, t),
      radioButton: radioButton?.lerp(other.radioButton, t),
      textField: textField?.lerp(other.textField, t),
      segmentedButton: segmentedButton?.lerp(other.segmentedButton, t),
      redSegmentedButton: redSegmentedButton?.lerp(other.redSegmentedButton, t),
      listItem: listItem?.lerp(other.listItem, t),
      selectLabel: selectLabel?.lerp(other.selectLabel, t),
      switchToggle: switchToggle?.lerp(other.switchToggle, t),
      headerBackgroundColor:
          Color.lerp(headerBackgroundColor, other.headerBackgroundColor, t),
      headerButtonBackgroundColorHighlighted: Color.lerp(
          headerButtonBackgroundColorHighlighted,
          other.headerButtonBackgroundColorHighlighted,
          t),
      headerIconColor: Color.lerp(headerIconColor, other.headerIconColor, t),
      headerTextStyle:
          TextStyle.lerp(headerTextStyle, other.headerTextStyle, t),
      linkTextStyle: TextStyle.lerp(linkTextStyle, other.linkTextStyle, t),
      linkTextStyleHighlighted: TextStyle.lerp(
          linkTextStyleHighlighted, other.linkTextStyleHighlighted, t),
      listHeaderTextStyle:
          TextStyle.lerp(listHeaderTextStyle, other.listHeaderTextStyle, t),
      groupBackgroundColor:
          Color.lerp(groupBackgroundColor, other.groupBackgroundColor, t),
      accordionTitleTextStyle: TextStyle.lerp(
          accordionTitleTextStyle, other.accordionTitleTextStyle, t),
      accordionBodyTextStyle: TextStyle.lerp(
          accordionBodyTextStyle, other.accordionBodyTextStyle, t),
      accordionBackgroundColor: Color.lerp(
          accordionBackgroundColor, other.accordionBackgroundColor, t),
      modalBackgroundColor:
          Color.lerp(modalBackgroundColor, other.modalBackgroundColor, t),
      modalTitleTextStyle:
          TextStyle.lerp(modalTitleTextStyle, other.modalTitleTextStyle, t),
      toastTextStyle: TextStyle.lerp(toastTextStyle, other.toastTextStyle, t),
      toastBackgroundColor:
          Color.lerp(toastBackgroundColor, other.toastBackgroundColor, t),
      tabBarTextStyle:
          TextStyle.lerp(tabBarTextStyle, other.tabBarTextStyle, t),
      menuBackgroundColor:
          Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t),
      menuBorderColor: Color.lerp(menuBorderColor, other.menuBorderColor, t),
      menuEntryTextStyle:
          TextStyle.lerp(menuEntryTextStyle, other.menuEntryTextStyle, t),
      userMenuTextStyle:
          TextStyle.lerp(userMenuTextStyle, other.userMenuTextStyle, t),
      userMenuForegroundColor: other.userMenuForegroundColor,
      breadcrumbTextStyle:
          TextStyle.lerp(breadcrumbTextStyle, other.breadcrumbTextStyle, t),
      breadcrumbForegroundColor: breadcrumbForegroundColor,
      sidebarBackgroundColor:
          Color.lerp(sidebarBackgroundColor, other.sidebarBackgroundColor, t),
      sidebarBorderColor:
          Color.lerp(sidebarBorderColor, other.sidebarBorderColor, t),
      sidebarItemTextStyle:
          TextStyle.lerp(sidebarItemTextStyle, other.sidebarItemTextStyle, t),
      menuEntryForegroundColor: other.menuEntryForegroundColor,
      menuEntryBackgroundColor: other.menuEntryBackgroundColor,
      sidebarItemBackgroundColor: other.sidebarItemBackgroundColor,
      sidebarItemForegroundColor: other.sidebarItemForegroundColor,
      headerNavItemForegroundColor: other.headerNavItemForegroundColor,
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
    );
  }
}

extension SBBControlStylesExtension on SBBControlStyles? {
  SBBControlStyles merge(SBBControlStyles? other) {
    if (this == null) return other ?? SBBControlStyles();
    return this!.copyWith(
      checkbox: this!.checkbox.merge(other?.checkbox),
      slider: this!.slider.merge(other?.slider),
      chip: this!.chip.merge(other?.chip),
      pagination: this!.pagination.merge(other?.pagination),
      radioButton: this!.radioButton.merge(other?.radioButton),
      textField: this!.textField.merge(other?.textField),
      segmentedButton: this!.segmentedButton.merge(other?.segmentedButton),
      redSegmentedButton:
          this!.redSegmentedButton.merge(other?.redSegmentedButton),
      listItem: this!.listItem.merge(other?.listItem),
      selectLabel: this!.selectLabel.merge(other?.selectLabel),
      switchToggle: this!.switchToggle.merge(other?.switchToggle),
      headerBackgroundColor:
          this!.headerBackgroundColor ?? other?.headerBackgroundColor,
      headerButtonBackgroundColorHighlighted:
          this!.headerButtonBackgroundColorHighlighted ??
              other?.headerButtonBackgroundColorHighlighted,
      headerIconColor: this!.headerIconColor ?? other?.headerIconColor,
      headerTextStyle: this!.headerTextStyle ?? other?.headerTextStyle,
      linkTextStyle: this!.linkTextStyle ?? other?.linkTextStyle,
      linkTextStyleHighlighted:
          this!.linkTextStyleHighlighted ?? other?.linkTextStyleHighlighted,
      listHeaderTextStyle:
          this!.listHeaderTextStyle ?? other?.listHeaderTextStyle,
      groupBackgroundColor:
          this!.groupBackgroundColor ?? other?.groupBackgroundColor,
      accordionTitleTextStyle:
          this!.accordionTitleTextStyle ?? other?.accordionTitleTextStyle,
      accordionBodyTextStyle:
          this!.accordionBodyTextStyle ?? other?.accordionBodyTextStyle,
      accordionBackgroundColor:
          this!.accordionBackgroundColor ?? other?.accordionBackgroundColor,
      modalBackgroundColor:
          this!.modalBackgroundColor ?? other?.modalBackgroundColor,
      modalTitleTextStyle:
          this!.modalTitleTextStyle ?? other?.modalTitleTextStyle,
      toastTextStyle: this!.toastTextStyle ?? other?.toastTextStyle,
      toastBackgroundColor:
          this!.toastBackgroundColor ?? other?.toastBackgroundColor,
      tabBarTextStyle: this!.tabBarTextStyle ?? other?.tabBarTextStyle,
      menuBackgroundColor:
          this!.menuBackgroundColor ?? other?.menuBackgroundColor,
      menuBorderColor: this!.menuBorderColor ?? other?.menuBorderColor,
      menuEntryForegroundColor:
          this!.menuEntryForegroundColor ?? other?.menuEntryForegroundColor,
      menuEntryBackgroundColor:
          this!.menuEntryBackgroundColor ?? other?.menuEntryBackgroundColor,
      menuEntryTextStyle: this!.menuEntryTextStyle ?? other?.menuEntryTextStyle,
      userMenuTextStyle: this!.userMenuTextStyle ?? other?.userMenuTextStyle,
      userMenuForegroundColor:
          this!.userMenuForegroundColor ?? other?.userMenuForegroundColor,
      breadcrumbTextStyle:
          this!.breadcrumbTextStyle ?? other?.breadcrumbTextStyle,
      breadcrumbForegroundColor:
          this!.breadcrumbForegroundColor ?? other?.breadcrumbForegroundColor,
      sidebarBackgroundColor:
          this!.sidebarBackgroundColor ?? other?.sidebarBackgroundColor,
      sidebarBorderColor: this!.sidebarBorderColor ?? other?.sidebarBorderColor,
      sidebarItemBackgroundColor:
          this!.sidebarItemBackgroundColor ?? other?.sidebarItemBackgroundColor,
      sidebarItemForegroundColor:
          this!.sidebarItemForegroundColor ?? other?.sidebarItemForegroundColor,
      sidebarItemTextStyle:
          this!.sidebarItemTextStyle ?? other?.sidebarItemTextStyle,
      headerNavItemForegroundColor: this!.headerNavItemForegroundColor ??
          other?.headerNavItemForegroundColor,
      promotionBox: this!.promotionBox ?? other?.promotionBox,
    ) as SBBControlStyles;
  }
}
