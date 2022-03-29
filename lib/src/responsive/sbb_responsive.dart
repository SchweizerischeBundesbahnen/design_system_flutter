import 'package:flutter/material.dart';

class SBBResponsive extends StatelessWidget {
  const SBBResponsive({Key? key}) : super(key: key);

  // see https://github.com/sbb-design-systems/sbb-angular/blob/master/src/angular/breakpoints.md
  static int mobileBreakpoint = 643;
  static int tabletBreakpoint = 1025;
  static int desktopBreakpoint = 1281;
  static int desktopLargeBreakpoint = 1441;
  static int desktop2kBreakpoint = 2561;
  static int desktop4kBreakpoint = 3841;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
