import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/theme/sbb_color_scheme.dart';

/// SBB Design System Mobile text theme.
///
/// Definitions for the various typographical styles found in SBB Design System Mobile.
///
/// Access by using `Theme.of(context).sbbTextTheme`.
///
/// See also:
///
/// * [SBBBaseStyle], theme extension where this theme is attached to.
/// * [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=0-1&p=f&t=8PFFztTe9RBMbOpq-0).
class SBBTextTheme extends ThemeExtension<SBBTextTheme> {
  const SBBTextTheme({
    this.xxSmallLight,
    this.xxSmallBold,
    this.xSmallLight,
    this.xSmallBold,
    this.smallLight,
    this.smallBold,
    this.mediumLight,
    this.mediumBold,
    this.largeLight,
    this.largeBold,
    this.xLargeLight,
    this.xLargeBold,
    this.xxLargeLight,
    this.xxLargeBold,
  });

  factory SBBTextTheme.$default({required SBBColorScheme colorScheme}) {
    final textColor = colorScheme.defaultTextColor;
    return SBBTextTheme(
      xxSmallLight: SBBTextStyles.extraExtraSmallLight.copyWith(color: textColor),
      xxSmallBold: SBBTextStyles.extraExtraSmallBold.copyWith(color: textColor),
      xSmallLight: SBBTextStyles.extraSmallLight.copyWith(color: textColor),
      xSmallBold: SBBTextStyles.extraSmallBold.copyWith(color: textColor),
      smallLight: SBBTextStyles.smallLight.copyWith(color: textColor),
      smallBold: SBBTextStyles.smallBold.copyWith(color: textColor),
      mediumLight: SBBTextStyles.mediumLight.copyWith(color: textColor),
      mediumBold: SBBTextStyles.mediumBold.copyWith(color: textColor),
      largeLight: SBBTextStyles.largeLight.copyWith(color: textColor),
      largeBold: SBBTextStyles.largeBold.copyWith(color: textColor),
      xLargeLight: SBBTextStyles.extraLargeLight.copyWith(color: textColor),
      xLargeBold: SBBTextStyles.extraLargeBold.copyWith(color: textColor),
      xxLargeLight: SBBTextStyles.extraExtraLargeLight.copyWith(color: textColor),
      xxLargeBold: SBBTextStyles.extraExtraLargeBold.copyWith(color: textColor),
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

  TextStyle? get defaultTextStyle => mediumLight;

  TextTheme toTextTheme({Color? labelColor}) {
    return TextTheme(
      bodySmall: smallLight,
      bodyMedium: mediumLight,
      bodyLarge: largeLight,
      labelSmall: smallLight?.copyWith(color: labelColor),
      labelMedium: mediumLight?.copyWith(color: labelColor),
      labelLarge: largeLight?.copyWith(color: labelColor),
      titleSmall: smallBold,
      titleMedium: mediumBold,
      titleLarge: largeBold,
    );
  }

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
    if (other is! SBBTextTheme) return this;
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
    if (other == null) return this;
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
}

extension SBBTextThemeThemeDataX on ThemeData {
  /// The SBB Design System Mobile text theme.
  SBBTextTheme get sbbTextTheme => sbbBaseStyle.textTheme;
}
