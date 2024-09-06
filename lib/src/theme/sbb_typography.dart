import 'package:flutter/material.dart';

const String sbbWebFont = 'packages/design_system_flutter/SBBWeb';

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
    fontFamily: sbbWebFont,
  );

  static const TextStyle largeLight = TextStyle(
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: sbbWebFont,
  );

  static const TextStyle largeBold = TextStyle(
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: sbbWebFont,
  );

  static const TextStyle mediumLight = TextStyle(
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: sbbWebFont,
  );

  static const TextStyle mediumBold = TextStyle(
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: sbbWebFont,
  );

  static const TextStyle smallLight = TextStyle(
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: sbbWebFont,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: sbbWebFont,
  );

  static const TextStyle extraSmallLight = TextStyle(
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: sbbWebFont,
  );

  static const TextStyle extraSmallBold = TextStyle(
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: sbbWebFont,
  );

  static const TextStyle helpersLabel = TextStyle(
    fontSize: 10.0,
    height: 12.0 / 10.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: sbbWebFont,
  );
}
