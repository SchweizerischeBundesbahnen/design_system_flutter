import 'package:flutter/material.dart';

import '../../../sbb_internal.dart';
import '../sbb_styles.dart';

typedef ButtonLabelBuilder = Widget Function(
    BuildContext context, String label);

class SBBButtonStyles extends ThemeExtension<SBBButtonStyles> {
  SBBButtonStyles({
    this.primaryStyle,
    this.primaryNegativeStyle,
    this.secondaryStyle,
    this.tertiarySmallStyle,
    this.tertiaryLargeStyle,
    this.iconLargeStyle,
    this.iconLargeNegativeStyle,
    this.iconSmallStyle,
    this.iconSmallNegativeStyle,
    this.iconSmallBorderlessStyle,
    this.iconFormStyle,
    this.iconTextStyle,
    this.buttonLabelBuilder,
  });

  factory SBBButtonStyles.$default({required SBBBaseStyle baseStyle}) =>
      SBBButtonStyles(
        primaryStyle: SBBButtonStyle(
          backgroundColor: baseStyle.primaryColor,
          backgroundColorHighlighted: baseStyle.primaryColorDark,
          backgroundColorDisabled:
              baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
          backgroundColorLoading:
              baseStyle.themeValue(SBBColors.cement, SBBColors.iron),
          textStyle: baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleHighlighted:
              baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleDisabled: baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleLoading: baseStyle.themedTextStyle(color: SBBColors.white),
        ),
        primaryNegativeStyle: SBBButtonStyle(
          backgroundColor: SBBColors.transparent,
          backgroundColorHighlighted: baseStyle.themeValue(
              SBBColors.black.withOpacity(0.2),
              SBBColors.white.withOpacity(0.2)),
          backgroundColorDisabled: SBBColors.transparent,
          backgroundColorLoading: SBBColors.transparent,
          borderColor: SBBColors.white,
          borderColorHighlighted: SBBColors.white,
          borderColorDisabled: SBBColors.white.withOpacity(0.5),
          borderColorLoading: SBBColors.white.withOpacity(0.5),
          textStyle: baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleHighlighted:
              baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleDisabled: baseStyle.themedTextStyle(color: SBBColors.white),
          textStyleLoading: baseStyle.themedTextStyle(color: SBBColors.white),
        ),
        secondaryStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.iron),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.charcoal),
          backgroundColorDisabled: SBBColors.transparent,
          backgroundColorLoading: SBBColors.transparent,
          borderColor:
              baseStyle.themeValue(baseStyle.primaryColor, SBBColors.smoke),
          borderColorHighlighted:
              baseStyle.themeValue(baseStyle.primaryColor, SBBColors.smoke),
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
          borderColorLoading:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
          textStyle: baseStyle.themedTextStyle(
              color: baseStyle.themeValue(
                  baseStyle.primaryColor, SBBColors.white)),
          textStyleHighlighted: baseStyle.themedTextStyle(
              color: baseStyle.themeValue(
                  baseStyle.primaryColorDark, SBBColors.white)),
          textStyleDisabled: baseStyle.themedTextStyle(color: baseStyle.themeValue(
              SBBColors.graphite, SBBColors.smoke)),
          textStyleLoading: baseStyle.themedTextStyle(color: baseStyle.themeValue(
              SBBColors.graphite, SBBColors.smoke)),
        ),
        tertiarySmallStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.smoke,
          borderColorHighlighted: SBBColors.smoke,
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          textStyle:
              baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
          textStyleHighlighted:
              baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
          textStyleDisabled: baseStyle.themedTextStyle(
              textStyle: SBBTextStyles.mediumLight,
              color: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
          ),
          iconColor: baseStyle.iconColor,
          iconColorHighlighted: baseStyle.iconColor,
          iconColorDisabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
        ),
        tertiaryLargeStyle: SBBButtonStyle(
            backgroundColor:
            baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          backgroundColorHighlighted:
          baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.smoke,
          borderColorHighlighted: SBBColors.smoke,
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          textStyle: baseStyle.themedTextStyle(),
          textStyleHighlighted: baseStyle.themedTextStyle(),
          textStyleDisabled: baseStyle.themedTextStyle(
              color: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
          ),
          iconColor: baseStyle.iconColor,
          iconColorHighlighted: baseStyle.iconColor,
          iconColorDisabled: baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
        ),
        iconLargeStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.smoke,
          borderColorHighlighted: SBBColors.smoke,
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          iconColor: baseStyle.iconColor,
          iconColorHighlighted: baseStyle.iconColor,
          iconColorDisabled:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
        ),
        iconLargeNegativeStyle: SBBButtonStyle(
          backgroundColor: SBBColors.transparent,
          backgroundColorHighlighted: baseStyle.themeValue(
              SBBColors.black.withOpacity(0.2),
              SBBColors.white.withOpacity(0.2)),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.white,
          borderColorHighlighted: SBBColors.white,
          borderColorDisabled: SBBColors.white.withOpacity(0.5),
          iconColor: SBBColors.white,
          iconColorHighlighted: SBBColors.white,
          iconColorDisabled: SBBColors.white.withOpacity(0.5),
        ),
        iconSmallStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.black),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.smoke,
          borderColorHighlighted: SBBColors.smoke,
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          iconColor: baseStyle.iconColor,
          iconColorHighlighted: baseStyle.iconColor,
          iconColorDisabled:
              baseStyle.themeValue(SBBColors.graphite, SBBColors.smoke),
        ),
        iconSmallNegativeStyle: SBBButtonStyle(
          backgroundColor: SBBColors.transparent,
          backgroundColorHighlighted: baseStyle.themeValue(
              SBBColors.black.withOpacity(0.2),
              SBBColors.white.withOpacity(0.2)),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.white,
          borderColorHighlighted: SBBColors.white,
          borderColorDisabled: SBBColors.white.withOpacity(0.5),
          iconColor: SBBColors.white,
          iconColorHighlighted: SBBColors.white,
          iconColorDisabled: SBBColors.white.withOpacity(0.5),
        ),
        iconSmallBorderlessStyle: SBBButtonStyle(
          backgroundColor: SBBColors.transparent,
          backgroundColorHighlighted: SBBColors.transparent,
          backgroundColorDisabled: SBBColors.transparent,
          iconColor: baseStyle.iconColor,
          iconColorHighlighted:
              baseStyle.themeValue(SBBColors.metal, SBBColors.aluminum),
          iconColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
        ),
        iconFormStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.transparent),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
          backgroundColorDisabled: SBBColors.transparent,
          borderColor: SBBColors.smoke,
          borderColorHighlighted: SBBColors.smoke,
          borderColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
          iconColor: baseStyle.iconColor,
          iconColorHighlighted: baseStyle.iconColor,
          iconColorDisabled:
              baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
        ),
        iconTextStyle: SBBButtonStyle(
          backgroundColor:
              baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          backgroundColorHighlighted:
              baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
          backgroundColorDisabled:
              baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          textStyle:
              baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          textStyleHighlighted:
              baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          textStyleDisabled: baseStyle.themedTextStyle(
              textStyle: SBBTextStyles.smallLight, color: SBBColors.metal),
          iconColor: baseStyle.defaultTextColor,
          iconColorHighlighted: baseStyle.defaultTextColor,
          iconColorDisabled: SBBColors.metal,
        ),
        buttonLabelBuilder: defaultButtonLabelBuilder,
      );

  static ButtonLabelBuilder defaultButtonLabelBuilder =
      (_, String label) => SBBButtonContent(label: label);

  final SBBButtonStyle? primaryStyle;
  final SBBButtonStyle? primaryNegativeStyle;
  final SBBButtonStyle? secondaryStyle;
  final SBBButtonStyle? tertiarySmallStyle;
  final SBBButtonStyle? tertiaryLargeStyle;
  final SBBButtonStyle? iconLargeStyle;
  final SBBButtonStyle? iconLargeNegativeStyle;
  final SBBButtonStyle? iconSmallStyle;
  final SBBButtonStyle? iconSmallNegativeStyle;
  final SBBButtonStyle? iconSmallBorderlessStyle;
  final SBBButtonStyle? iconFormStyle;
  final SBBButtonStyle? iconTextStyle;
  final ButtonLabelBuilder? buttonLabelBuilder;

  static SBBButtonStyles of(BuildContext context) =>
      Theme.of(context).extension<SBBButtonStyles>()!;

  ButtonStyle get baseButtonStyle => ButtonStyle(
        overlayColor: SBBTheme.allStates(SBBColors.transparent),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SBBInternal.defaultButtonHeight / 2),
          ),
        ),
        fixedSize: SBBTheme.allStates(
            const Size.fromHeight(SBBInternal.defaultButtonHeight)),
        padding: SBBTheme.allStates(
            const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing)),
        elevation: SBBTheme.allStates(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        mouseCursor: MaterialStateMouseCursor.clickable,
      );

  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
        style: primaryStyle?.overrideButtonStyle(baseButtonStyle),
      );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: secondaryStyle?.overrideButtonStyle(baseButtonStyle),
      );

  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: tertiaryLargeStyle?.overrideButtonStyle(baseButtonStyle),
      );

  @override
  ThemeExtension<SBBButtonStyles> copyWith({
    SBBButtonStyle? primaryStyle,
    SBBButtonStyle? primaryNegativeStyle,
    SBBButtonStyle? secondaryStyle,
    SBBButtonStyle? tertiarySmallStyle,
    SBBButtonStyle? tertiaryLargeStyle,
    SBBButtonStyle? iconLargeStyle,
    SBBButtonStyle? iconLargeNegativeStyle,
    SBBButtonStyle? iconSmallStyle,
    SBBButtonStyle? iconSmallNegativeStyle,
    SBBButtonStyle? iconSmallBorderlessStyle,
    SBBButtonStyle? iconFormStyle,
    SBBButtonStyle? iconTextStyle,
    ButtonLabelBuilder? buttonLabelBuilder,
  }) =>
      SBBButtonStyles(
        primaryStyle: primaryStyle ?? this.primaryStyle,
        primaryNegativeStyle: primaryNegativeStyle ?? this.primaryNegativeStyle,
        secondaryStyle: secondaryStyle ?? this.secondaryStyle,
        tertiarySmallStyle: tertiarySmallStyle ?? this.tertiarySmallStyle,
        tertiaryLargeStyle: tertiaryLargeStyle ?? this.tertiaryLargeStyle,
        iconLargeStyle: iconLargeStyle ?? this.iconLargeStyle,
        iconLargeNegativeStyle:
            iconLargeNegativeStyle ?? this.iconLargeNegativeStyle,
        iconSmallStyle: iconSmallStyle ?? this.iconSmallStyle,
        iconSmallNegativeStyle:
            iconSmallNegativeStyle ?? this.iconSmallNegativeStyle,
        iconSmallBorderlessStyle:
            iconSmallBorderlessStyle ?? this.iconSmallBorderlessStyle,
        iconFormStyle: iconFormStyle ?? this.iconFormStyle,
        iconTextStyle: iconTextStyle ?? this.iconTextStyle,
        buttonLabelBuilder: buttonLabelBuilder ?? this.buttonLabelBuilder,
      );

  @override
  ThemeExtension<SBBButtonStyles> lerp(
      ThemeExtension<SBBButtonStyles>? other, double t) {
    if (other is! SBBButtonStyles) return this;
    return SBBButtonStyles(
      primaryStyle: primaryStyle?.lerp(other.primaryStyle, t),
      primaryNegativeStyle:
          primaryNegativeStyle?.lerp(other.primaryNegativeStyle, t),
      secondaryStyle: secondaryStyle?.lerp(other.secondaryStyle, t),
      tertiarySmallStyle: tertiarySmallStyle?.lerp(other.tertiarySmallStyle, t),
      tertiaryLargeStyle: tertiaryLargeStyle?.lerp(other.tertiaryLargeStyle, t),
      iconLargeStyle: iconLargeStyle?.lerp(other.iconLargeStyle, t),
      iconLargeNegativeStyle:
          iconLargeNegativeStyle?.lerp(other.iconLargeNegativeStyle, t),
      iconSmallStyle: iconSmallStyle?.lerp(other.iconSmallStyle, t),
      iconSmallNegativeStyle:
          iconSmallNegativeStyle?.lerp(other.iconSmallNegativeStyle, t),
      iconSmallBorderlessStyle:
          iconSmallBorderlessStyle?.lerp(other.iconSmallBorderlessStyle, t),
      iconFormStyle: iconFormStyle?.lerp(other.iconFormStyle, t),
      iconTextStyle: iconTextStyle?.lerp(other.iconTextStyle, t),
      buttonLabelBuilder: other.buttonLabelBuilder,
    );
  }
}

extension ButtonStylesExtension on SBBButtonStyles? {
  SBBButtonStyles merge(SBBButtonStyles? other) {
    if (this == null) return other ?? SBBButtonStyles();
    return this!.copyWith(
      primaryStyle: this!.primaryStyle.merge(other?.primaryStyle),
      primaryNegativeStyle:
          this!.primaryNegativeStyle.merge(other?.primaryNegativeStyle),
      secondaryStyle: this!.secondaryStyle.merge(other?.secondaryStyle),
      tertiarySmallStyle:
          this!.tertiarySmallStyle.merge(other?.tertiarySmallStyle),
      tertiaryLargeStyle:
          this!.tertiaryLargeStyle.merge(other?.tertiaryLargeStyle),
      iconLargeStyle: this!.iconLargeStyle.merge(other?.iconLargeStyle),
      iconLargeNegativeStyle:
          this!.iconLargeNegativeStyle.merge(other?.iconLargeNegativeStyle),
      iconSmallStyle: this!.iconSmallStyle.merge(other?.iconSmallStyle),
      iconSmallNegativeStyle:
          this!.iconSmallNegativeStyle.merge(other?.iconSmallNegativeStyle),
      iconSmallBorderlessStyle:
          this!.iconSmallBorderlessStyle.merge(other?.iconSmallBorderlessStyle),
      iconFormStyle: this!.iconFormStyle.merge(other?.iconFormStyle),
      iconTextStyle: this!.iconTextStyle.merge(other?.iconTextStyle),
      buttonLabelBuilder: this!.buttonLabelBuilder ?? other?.buttonLabelBuilder,
    ) as SBBButtonStyles;
  }
}
