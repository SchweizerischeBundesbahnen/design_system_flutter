import 'package:flutter/material.dart';

/// Use [sbbFont] instead.
@Deprecated('Use sbbFont instead')
@Deprecated(
  'Use of sbbWebFont was deprecated and replaced by sbbFont for a clearer and more consistent naming convention '
  'This feature was deprecated after v2.2.0.',
)
const String sbbWebFont = sbbFont;

/// Global constant for default SBB font family [SBBTextStyles.sbbFontLight].
///
/// See also:
///
/// * [SBBTextStyles], which contains the constants for all SBB font families.
const String sbbFont = SBBTextStyles.sbbFontLight;

/// Global constant for default SBB text style for easier use of extension methods defined in [TextStylesExtensions].
const TextStyle sbbTextStyle = SBBTextStyles.mediumLight;

/// Provides constants for all text styles defined in the SBB design system mobile.
///
/// When in need of a more custom text style, consider using the extension methods defined in [TextStylesExtensions].
/// The intended way to use this is to start with [sbbTextStyle] and use the corresponding methods to achieve the
/// desired [TextStyle]:
/// ```dart
/// const Text(
///   'This text is roman, extra large and italic',
///   style: sbbTextStyle.romanStyle.xLarge.italic,
/// );
/// ```
///
/// * <https://digital.sbb.ch/en/design-system/mobile/basics/typography/>
class SBBTextStyles {
  SBBTextStyles._();

  // Font families
  static const String sbbFontUltraLight = 'packages/sbb_design_system_mobile/SBBWebUltraLight';
  static const String sbbFontThin = 'packages/sbb_design_system_mobile/SBBWebThin';
  static const String sbbFontLight = 'packages/sbb_design_system_mobile/SBBWebLight';
  static const String sbbFontRoman = 'packages/sbb_design_system_mobile/SBBWebRoman';
  static const String sbbFontBold = 'packages/sbb_design_system_mobile/SBBWebBold';
  static const String sbbFontCondensedBold = 'packages/sbb_design_system_mobile/SBBWebCondensedBold';
  static const String sbbFontCondensedHeavy = 'packages/sbb_design_system_mobile/SBBWebCondensedHeavy';

  // Font sizes
  static const double xxLargeFontSize = 30.0;
  static const double xLargeFontSize = 24.0;
  static const double largeFontSize = 18.0;
  static const double mediumFontSize = 16.0;
  static const double smallFontSize = 14.0;
  static const double xSmallFontSize = 12.0;

  // Font heights
  static const double xxLargeFontHeight = 32.0 / xxLargeFontSize;
  static const double xLargeFontHeight = 32.0 / xLargeFontSize;
  static const double largeFontHeight = 24.0 / largeFontSize;
  static const double mediumFontHeight = 20.0 / mediumFontSize;
  static const double smallFontHeight = 20.0 / smallFontSize;
  static const double xSmallFontHeight = 16.0 / xSmallFontSize;

  // Text styles
  static const TextStyle extraExtraLargeLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: xxLargeFontSize,
    height: xxLargeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle extraExtraLargeBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: xxLargeFontSize,
    height: xxLargeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle extraLargeLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: xLargeFontSize,
    height: xLargeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle extraLargeBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: xLargeFontSize,
    height: xLargeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle largeLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle largeBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: largeFontSize,
    height: largeFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle mediumLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle mediumBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: mediumFontSize,
    height: mediumFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle smallLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle smallBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: smallFontSize,
    height: smallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle extraSmallLight = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle extraSmallBold = TextStyle(
    fontFamily: sbbFontBold,
    fontSize: xSmallFontSize,
    height: xSmallFontHeight,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle helpersLabel = TextStyle(
    fontFamily: sbbFontLight,
    fontSize: 10.0,
    height: 12.0 / 10.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}

extension TextStylesExtensions on TextStyle {
  // Font families

  /// Returns an ultra light ([fontFamily]) copy of this text style
  TextStyle get ultraLightStyle => copyWith(fontFamily: SBBTextStyles.sbbFontUltraLight);

  /// Returns a thin ([fontFamily]) copy of this text style
  TextStyle get thinStyle => copyWith(fontFamily: SBBTextStyles.sbbFontThin);

  /// Returns a light ([fontFamily]) copy of this text style
  TextStyle get lightStyle => copyWith(fontFamily: SBBTextStyles.sbbFontLight);

  /// Returns a roman ([fontFamily]) copy of this text style
  TextStyle get romanStyle => copyWith(fontFamily: SBBTextStyles.sbbFontRoman);

  /// Returns a bold ([fontFamily]) copy of this text style
  TextStyle get boldStyle => copyWith(fontFamily: SBBTextStyles.sbbFontBold);

  /// Returns a condensed bold ([fontFamily]) copy of this text style
  TextStyle get condensedBoldStyle => copyWith(fontFamily: SBBTextStyles.sbbFontCondensedBold);

  /// Returns a condensed heavy ([fontFamily]) copy of this text style
  TextStyle get condensedHeavyStyle => copyWith(fontFamily: SBBTextStyles.sbbFontCondensedHeavy);

  // Text sizes (fontSize, height)

  /// Returns an extra extra large ([fontSize], [height]) copy of this text style
  TextStyle get xxLarge => copyWith(fontSize: SBBTextStyles.xxLargeFontSize, height: SBBTextStyles.xxLargeFontHeight);

  /// Returns an extra large ([fontSize], [height]) copy of this text style
  TextStyle get xLarge => copyWith(fontSize: SBBTextStyles.xLargeFontSize, height: SBBTextStyles.xLargeFontHeight);

  /// Returns a large ([fontSize], [height]) copy of this text style
  TextStyle get large => copyWith(fontSize: SBBTextStyles.largeFontSize, height: SBBTextStyles.largeFontHeight);

  /// Returns a medium ([fontSize], [height]) copy of this text style
  TextStyle get medium => copyWith(fontSize: SBBTextStyles.mediumFontSize, height: SBBTextStyles.mediumFontHeight);

  /// Returns a small ([fontSize], [height]) copy of this text style
  TextStyle get small => copyWith(fontSize: SBBTextStyles.smallFontSize, height: SBBTextStyles.smallFontHeight);

  /// Returns an extra small ([fontSize], [height]) copy of this text style
  TextStyle get xSmall => copyWith(fontSize: SBBTextStyles.xSmallFontSize, height: SBBTextStyles.xSmallFontHeight);

  // Font styles

  /// Returns an italic ([fontStyle] copy of this text style)
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Returns an normal ([fontStyle] copy of this text style)
  TextStyle get normal => copyWith(fontStyle: FontStyle.normal);
}
