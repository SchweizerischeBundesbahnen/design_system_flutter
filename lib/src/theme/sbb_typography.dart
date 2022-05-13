import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../sbb_internal.dart';
import 'sbb_colors.dart';

const String SBBWebFont = 'packages/design_system_flutter/SBBWeb';

class SBBTextStyles {
  SBBTextStyles._();

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
    height: 20.0 / 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle mediumBold = TextStyle(
    fontSize: 16.0,
    height: 20.0 / 16.0,
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
    height: 16.0 / 12.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
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

class SBBWebTextStyles {
  SBBWebTextStyles._();

  static const TextStyle _headerOne = TextStyle(
    fontSize: 28.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
    height: 34.0 / 28.0,
    color: SBBColors.black,
  );
  static const TextStyle _headerTwo = TextStyle(
    fontSize: 21.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
    height: 25.0 / 21.0,
    color: SBBColors.black,
  );
  static const TextStyle _headerThree = TextStyle(
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
    height: 22.0 / 18.0,
    color: SBBColors.black,
  );
  static const TextStyle _headerFour = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
    height: 19.0 / 16.0,
    color: SBBColors.black,
  );

  static const TextStyle _running = TextStyle(
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFamily: SBBWebFont,
    height: 23.0 / 15.0,
    color: SBBColors.black,
  );

  static const TextStyle headerTitle = TextStyle(
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFamily: SBBWebFont,
    color: SBBColors.black,
  );

  static const TextStyle headerSubtitle = TextStyle(
    fontSize: 13.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
    color: SBBColors.metal,
  );

  static const TextStyle contextMenu = TextStyle(
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFamily: SBBWebFont,
    color: SBBColors.iron,
  );

  static const TextStyle userMenuInitials = TextStyle(
    fontSize: 10.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: SBBWebFont,
    color: SBBColors.metal,
  );

  static const TextStyle breadcrumb = TextStyle(
    fontSize: 13.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFamily: SBBWebFont,
  );
}

class SBBWebText extends StatelessWidget {
  const SBBWebText.headerOne(
    this.data, {
    Key? key,
    this.color,
    this.style = SBBWebTextStyles._headerOne,
    this.padding = const EdgeInsets.only(
        top: SBBWebDivider.big, bottom: SBBWebDivider.medium),
    this.selectable = false,
  }) : super(key: key);

  const SBBWebText.headerTwo(
    this.data, {
    Key? key,
    this.color,
    this.style = SBBWebTextStyles._headerTwo,
    this.padding = const EdgeInsets.only(
        top: SBBWebDivider.medium, bottom: SBBWebDivider.small),
    this.selectable = false,
  }) : super(key: key);

  const SBBWebText.headerThree(
    this.data, {
    Key? key,
    this.color,
    this.style = SBBWebTextStyles._headerThree,
    this.padding = const EdgeInsets.only(
        top: SBBWebDivider.small, bottom: SBBWebDivider.thin),
    this.selectable = false,
  }) : super(key: key);

  const SBBWebText.headerFour(
    this.data, {
    Key? key,
    this.color,
    this.style = SBBWebTextStyles._headerFour,
    this.padding = const EdgeInsets.only(
        top: SBBWebDivider.small, bottom: SBBWebDivider.thin),
    this.selectable = false,
  }) : super(key: key);

  const SBBWebText.running(
    this.data, {
    Key? key,
    this.color,
    this.style = SBBWebTextStyles._running,
    this.padding = const EdgeInsets.only(
        top: SBBWebDivider.thin, bottom: SBBWebDivider.thin),
    this.selectable = false,
  }) : super(key: key);

  final String data;
  final Color? color;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: selectable
          ? SelectableText(data, style: style.copyWith(color: color))
          : Text(data, style: style.copyWith(color: color)),
    );
  }
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

  static const TextStyle formLightDefault = TextStyle(
    color: SBBColors.black,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkDefault = TextStyle(
    color: SBBColors.white,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightDisabledDefault = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkDisabledDefault = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightDisabledLabel = TextStyle(
    color: SBBColors.metal,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkDisabledLabel = TextStyle(
    color: SBBColors.metal,
    fontSize: 10.0,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formLightDisabledPlaceholder = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
    height: 1.25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontFamily: SBBWebFont,
  );

  static const TextStyle formDarkDisabledPlaceholder = TextStyle(
    color: SBBColors.metal,
    fontSize: 16.0,
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
