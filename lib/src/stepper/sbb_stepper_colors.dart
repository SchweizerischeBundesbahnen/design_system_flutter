import 'package:flutter/widgets.dart';

import '../theme/sbb_colors.dart';

enum SBBStepperColors {
  light(
    activeCircleBackground: SBBColors.red,
    activeCircleContent: SBBColors.white,
    inactiveCircleBackground: SBBColors.white,
    inactiveCircleBorder: SBBColors.smoke,
    inactiveCircleContent: SBBColors.black,
    label: SBBColors.black,
    line: SBBColors.smoke,
  ),
  dark(
    activeCircleBackground: SBBColors.white,
    activeCircleContent: SBBColors.black,
    inactiveCircleBackground: SBBColors.charcoal,
    inactiveCircleBorder: SBBColors.white,
    inactiveCircleContent: SBBColors.white,
    label: SBBColors.white,
    line: Color(0xB3FFFFFF),
  ),
  red(
    activeCircleBackground: SBBColors.white,
    activeCircleContent: SBBColors.red,
    inactiveCircleBackground: SBBColors.transparent,
    inactiveCircleBorder: SBBColors.white,
    inactiveCircleContent: SBBColors.white,
    label: SBBColors.white,
    line: Color(0xB3FFFFFF),
  );

  const SBBStepperColors({
    required this.activeCircleBackground,
    required this.activeCircleContent,
    required this.inactiveCircleBackground,
    required this.inactiveCircleBorder,
    required this.inactiveCircleContent,
    required this.label,
    required this.line,
  });

  final Color activeCircleBackground;
  final Color activeCircleContent;
  final Color inactiveCircleBackground;
  final Color inactiveCircleBorder;
  final Color inactiveCircleContent;
  final Color label;
  final Color line;

  Color circleBackground(bool active) {
    if (active) {
      return activeCircleBackground;
    } else {
      return inactiveCircleBackground;
    }
  }

  Color circleBorder(bool active) {
    if (active) {
      return SBBColors.transparent;
    } else {
      return inactiveCircleBorder;
    }
  }

  Color circleContent(bool active) {
    if (active) {
      return activeCircleContent;
    } else {
      return inactiveCircleContent;
    }
  }
}
