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
    this.promotionBox,
    this.picker,
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
        promotionBox: PromotionBoxStyle.$default(baseStyle: baseStyle),
        picker: SBBPickerStyle.$default(baseStyle: baseStyle),
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
  final PromotionBoxStyle? promotionBox;
  final SBBPickerStyle? picker;

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
    PromotionBoxStyle? promotionBox,
    SBBPickerStyle? picker,
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
        promotionBox: promotionBox ?? this.promotionBox,
        picker: picker ?? this.picker,
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
      promotionBox: PromotionBoxStyle.lerp(promotionBox, other.promotionBox, t),
      picker: picker?.lerp(other.picker, t),
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
      picker: this!.picker.merge(other?.picker),
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
      promotionBox: this!.promotionBox ?? other?.promotionBox,
    ) as SBBControlStyles;
  }
}
