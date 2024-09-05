import 'package:flutter/material.dart';

import '../sbb_internal.dart';
import 'sbb_colors.dart';

const String SBBWebFont = 'packages/design_system_flutter/SBBWeb';

class SBBTextStyles {
  SBBTextStyles._();

  static const double largeFontSize = 18.0;
  static const double mediumFontSize = 16.0;
  static const double smallFontSize = 14.0;
  static const double xSmallFontSize = 12.0;

  static const double largeFontHeight = 24.0 / largeFontSize;
  static const double mediumFontHeight = 20.0 / mediumFontSize;
  static const double smallFontHeight = 20.0 / smallFontSize;
  static const double xSmallFontHeight = 16.0 / smallFontSize;

  static const TextStyle extraLargeLight = TextStyle(
    fontSize: 30.0,
    height: 32.0 / 30.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle largeLight = TextStyle(
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle largeBold = TextStyle(
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle mediumLight = TextStyle(
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle mediumBold = TextStyle(
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle smallLight = TextStyle(
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle extraSmallLight = TextStyle(
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle extraSmallBold = TextStyle(
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle helpersLabel = TextStyle(
    fontSize: 10.0,
    height: 12.0 / 10.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );
}

@Deprecated('Use SBBTextStyles instead. Migration Guide for SBBTextStyles.')
class SBBBaseTextStyles {
  SBBBaseTextStyles._();

  static const TextStyle extraLargeLight = TextStyle(
    fontSize: 30.0,
    height: 32.0 / 30.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle largeLight = TextStyle(
    fontSize: 18.0,
    height: 24.0 / 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle largeBold = TextStyle(
    fontSize: 18.0,
    height: 24.0 / 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle mediumLight = TextStyle(
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle mediumBold = TextStyle(
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle smallLight = TextStyle(
    fontSize: 14.0,
    height: 20.0 / 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: 14.0,
    height: 20.0 / 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
  );

  static const TextStyle extraSmallLight = TextStyle(
    fontSize: 12.0,
    height: 20.0 / 12.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle helpersLabel = TextStyle(
    fontSize: 12.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle primaryButton = TextStyle(
    color: SBBColors.white,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle secondaryButtonDefault = TextStyle(
    color: SBBColors.red,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle secondaryButtonDisabledOrLoading = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle secondaryButtonPressed = TextStyle(
    color: SBBColors.red125,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle tertiaryButtonLargeDark = TextStyle(
    color: SBBColors.white,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle tertiaryButtonLargeLight = TextStyle(
    color: SBBColors.black,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle tertiaryButtonSmallDark = TextStyle(
    color: SBBColors.white,
    fontSize: 14.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle tertiaryButtonSmallLight = TextStyle(
    color: SBBColors.black,
    fontSize: 14.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle iconTextButtonLight = TextStyle(
    color: SBBColors.black,
    fontSize: 14.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle iconTextButtonDark = TextStyle(
    color: SBBColors.white,
    fontSize: 14.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightError = TextStyle(
    color: SBBColors.red150,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkError = TextStyle(
    color: SBBColors.red,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightLabel = TextStyle(
    color: SBBColors.metal,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkLabel = TextStyle(
    color: SBBColors.cement,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightPlaceholder = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkPlaceholder = TextStyle(
    color: SBBColors.cement,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle listItemTitleLight = TextStyle(
    color: SBBColors.black,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle listItemTitleDark = TextStyle(
    color: SBBColors.white,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle listItemSubtitleLight = TextStyle(
    color: SBBColors.metal,
    fontSize: 12.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle listItemSubtitleDark = TextStyle(
    color: SBBColors.cement,
    fontSize: 12.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle modalTitleLight = TextStyle(
    color: SBBColors.black,
    fontSize: 18.0,
    height: 1.33,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle modalTitleDark = TextStyle(
    color: SBBColors.white,
    fontSize: 18.0,
    height: 1.33,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle header = TextStyle(
    color: SBBColors.white,
    fontSize: 22.0,
    height: 1.55,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle headline_black = TextStyle(
    color: SBBColors.black,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle headline_white = TextStyle(
    color: SBBColors.white,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle title_default_black = TextStyle(
    color: SBBColors.black,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle title_default_metal = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle title_module = TextStyle(
    color: SBBColors.red,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle subtitle_black = TextStyle(
    color: SBBColors.black,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle subtitle_metal = TextStyle(
    color: SBBColors.metal,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: SBBWebFont,
  );

  static const TextStyle copy_black = TextStyle(
    color: SBBColors.black,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle copy_white = TextStyle(
    color: SBBColors.white,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle body_black = TextStyle(
    color: SBBColors.black,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle body_metal = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle body_red = TextStyle(
    color: SBBColors.red,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle legend_normal_black = TextStyle(
    color: SBBColors.black,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle legend_normal_metal = TextStyle(
    color: SBBColors.metal,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle legend_normal_red = TextStyle(
    color: SBBColors.red,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle legend_normal_white = TextStyle(
    color: SBBColors.white,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle legend_small_black = TextStyle(
    color: SBBColors.black,
    fontSize: 12.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );
}
