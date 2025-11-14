import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// SBB Design System Mobile text theme.
///
/// Definitions for the various typographical styles found in SBB Design System Mobile. To obtain the current SBB text
/// theme, call [SBBTextTheme.of] with the current [BuildContext]. This is equivalent to calling [Theme.of] and reading
/// the [ThemeData.sbbTextTheme] property.
///
/// See all text theme definitions in
/// [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=0-1&p=f&t=8PFFztTe9RBMbOpq-0).
class SBBTextTheme extends ThemeExtension<SBBTextTheme> {
  const SBBTextTheme({
    required this.xxSmallLight,
    required this.xxSmallBold,
    required this.xSmallLight,
    required this.xSmallBold,
    required this.smallLight,
    required this.smallBold,
    required this.mediumLight,
    required this.mediumBold,
    required this.largeLight,
    required this.largeBold,
    required this.xLargeLight,
    required this.xLargeBold,
    required this.xxLargeLight,
    required this.xxLargeBold,
  });

  factory SBBTextTheme.$default({required SBBBaseStyle baseStyle}) {
    TextTheme();
    return SBBTextTheme(
      xxSmallLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraExtraSmallLight),
      xxSmallBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraExtraSmallBold),
      xSmallLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraSmallLight),
      xSmallBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraSmallBold),
      smallLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
      smallBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallBold),
      mediumLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumLight),
      mediumBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.mediumBold),
      largeLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight),
      largeBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeBold),
      xLargeLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraLargeLight),
      xLargeBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraLargeBold),
      xxLargeLight: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraExtraLargeLight),
      xxLargeBold: baseStyle.themedTextStyle(textStyle: SBBTextStyles.extraExtraLargeBold),
    );
  }

  final TextStyle? xxSmallLight;
  final TextStyle? xxSmallBold;
  final TextStyle? xSmallLight;
  final TextStyle? xSmallBold;
  final TextStyle? smallLight;
  final TextStyle? smallBold;
  final TextStyle? mediumLight;
  final TextStyle? mediumBold;
  final TextStyle? largeLight;
  final TextStyle? largeBold;
  final TextStyle? xLargeLight;
  final TextStyle? xLargeBold;
  final TextStyle? xxLargeLight;
  final TextStyle? xxLargeBold;

  @override
  SBBTextTheme copyWith({
    TextStyle? xxSmallLight,
    TextStyle? xxSmallBold,
    TextStyle? xSmallLight,
    TextStyle? xSmallBold,
    TextStyle? smallLight,
    TextStyle? smallBold,
    TextStyle? mediumLight,
    TextStyle? mediumBold,
    TextStyle? largeLight,
    TextStyle? largeBold,
    TextStyle? xLargeLight,
    TextStyle? xLargeBold,
    TextStyle? xxLargeLight,
    TextStyle? xxLargeBold,
  }) {
    return SBBTextTheme(
      xxSmallLight: xxSmallLight ?? this.xxSmallLight,
      xxSmallBold: xxSmallBold ?? this.xxSmallBold,
      xSmallLight: xSmallLight ?? this.xSmallLight,
      xSmallBold: xSmallBold ?? this.xSmallBold,
      smallLight: smallLight ?? this.smallLight,
      smallBold: smallBold ?? this.smallBold,
      mediumLight: mediumLight ?? this.mediumLight,
      mediumBold: mediumBold ?? this.mediumBold,
      largeLight: largeLight ?? this.largeLight,
      largeBold: largeBold ?? this.largeBold,
      xLargeLight: xLargeLight ?? this.xLargeLight,
      xLargeBold: xLargeBold ?? this.xLargeBold,
      xxLargeLight: xxLargeLight ?? this.xxLargeLight,
      xxLargeBold: xxLargeBold ?? this.xxLargeBold,
    );
  }

  @override
  SBBTextTheme lerp(covariant ThemeExtension<SBBTextTheme>? other, double t) {
    if (other is! SBBTextTheme) {
      return this;
    }
    return SBBTextTheme(
      xxSmallLight: TextStyle.lerp(xxSmallLight, other.xxSmallLight, t)!,
      xxSmallBold: TextStyle.lerp(xxSmallBold, other.xxSmallBold, t)!,
      xSmallLight: TextStyle.lerp(xSmallLight, other.xSmallLight, t)!,
      xSmallBold: TextStyle.lerp(xSmallBold, other.xSmallBold, t)!,
      smallLight: TextStyle.lerp(smallLight, other.smallLight, t)!,
      smallBold: TextStyle.lerp(smallBold, other.smallBold, t)!,
      mediumLight: TextStyle.lerp(mediumLight, other.mediumLight, t)!,
      mediumBold: TextStyle.lerp(mediumBold, other.mediumBold, t)!,
      largeLight: TextStyle.lerp(largeLight, other.largeLight, t)!,
      largeBold: TextStyle.lerp(largeBold, other.largeBold, t)!,
      xLargeLight: TextStyle.lerp(xLargeLight, other.xLargeLight, t)!,
      xLargeBold: TextStyle.lerp(xLargeBold, other.xLargeBold, t)!,
      xxLargeLight: TextStyle.lerp(xxLargeLight, other.xxLargeLight, t)!,
      xxLargeBold: TextStyle.lerp(xxLargeBold, other.xxLargeBold, t)!,
    );
  }

  SBBTextTheme merge(SBBTextTheme? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      xxSmallLight: other.xxSmallLight,
      xxSmallBold: other.xxSmallBold,
      xSmallLight: other.xSmallLight,
      xSmallBold: other.xSmallBold,
      smallLight: other.smallLight,
      smallBold: other.smallBold,
      mediumLight: other.mediumLight,
      mediumBold: other.mediumBold,
      largeLight: other.largeLight,
      largeBold: other.largeBold,
      xLargeLight: other.xLargeLight,
      xLargeBold: other.xLargeBold,
      xxLargeLight: other.xxLargeLight,
      xxLargeBold: other.xxLargeBold,
    );
  }

  static SBBTextTheme of(BuildContext context) {
    return Theme.of(context).sbbTextTheme;
  }
}

extension SBBTextThemeThemeDataX on ThemeData {
  SBBTextTheme get sbbTextTheme {
    return extension();
  }
}
