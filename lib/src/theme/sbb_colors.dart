import 'package:flutter/material.dart';

/// The colors as defined in https://www.figma.com/design/5j2eZ2D0sHYFKkRSmFdBPJ/SBB-Colors
/// and https://digital.sbb.ch/de/foundation/colors/base-colors/
class SBBColors {
  SBBColors._();

  // standard SBB colors
  static const Color red = Color(0xFFEB0000);
  static const Color red125 = Color(0xFFC60018);
  static const Color red150 = Color(0xFFA20013);
  static const Color redDark = Color(0xFFFF3838); // red85
  static const Color white = Color(0xFFFFFFFF);
  static const Color milk = Color(0xFFF6F6F6);
  static const Color cloud = Color(0xFFE5E5E5);
  static const Color silver = Color(0xFFDCDCDC);
  static const Color aluminum = Color(0xFFD2D2D2);
  static const Color platinum = Color(0xFFCDCDCD);
  static const Color cement = Color(0xFFBDBDBD);
  static const Color graphite = Color(0xFFB7B7B7);
  static const Color storm = Color(0xFFA8A8A8);
  static const Color smoke = Color(0xFF8D8D8D);
  static const Color metal = Color(0xFF767676);
  static const Color granite = Color(0xFF686868);
  static const Color anthracite = Color(0xFF5A5A5A);
  static const Color iron = Color(0xFF444444);
  static const Color charcoal = Color(0xFF212121);
  static const Color midnight = Color(0xFF151515);
  static const Color black = Color(0xFF000000);
  static const Color blue = Color(0xFF2D327D);
  static const Color transparent = Color(0x00000000);

  // additional colors
  static const Color sky = Color(0xFF0074BF);
  static const Color night = Color(0xFF143A85);
  static const Color violet = Color(0xFF6F2282);
  static const Color pink = Color(0xFFC7387A);
  static const Color autumn = Color(0xFFCF3B00);
  static const Color orange = Color(0xFFF27E00);
  static const Color peach = Color(0xFFFCBB00);
  static const Color lemon = Color(0xFFFFDE15);
  static const Color brown = Color(0xFFA05400);
  static const Color green = Color(0xFF008233);
  static const Color turquoise = Color(0xFF007E84);

  // additional colors dark
  static const Color skyDark = Color(0xFF128EDE);
  static const Color nightDark = Color(0xFF6587CA);
  static const Color violetDark = Color(0xFFB36CC5);
  static const Color pinkDark = Color(0xFFE45295);
  static const Color autumnDark = Color(0xFFF05313);
  static const Color orangeDark = Color(0xFFFB8E19);
  static const Color peachDark = Color(0xFFFFC727);
  static const Color lemonDark = Color(0xFFFFE547);
  static const Color brownDark = Color(0xFFCF6F04);
  static const Color greenDark = Color(0xFF109D47);
  static const Color turquoiseDark = Color(0xFF00A59B);

  // functional colors
  static const Color success = Color(0xFF008233);
  static const Color warning = Color(0xFFFCBB00);
  static const Color error = Color(0xFFC60018);
  static const Color brand = Color(0xFFEB0000);
  static const Color product = Color(0xFFEB0000);

  // functional colors dark
  static const Color successDark = Color(0xFF109D47);
  static const Color warningDark = Color(0xFFFFC727);
  static const Color errorDark = Color(0xFFFF3838);
  static const Color brandDark = brand;
  static const Color productDark = product;

  // off brand / safety relevant colors
  static const Color royal = Color(0xFF06348B);
  static const Color royalDark = Color(0xFF4077DF); // royal85
  static const Color royal125 = Color(0xFF032668);
  static const Color royal150 = Color(0xFF021C4E);
}
