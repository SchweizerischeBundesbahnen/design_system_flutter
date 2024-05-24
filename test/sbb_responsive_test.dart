import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_flutter/design_system_flutter.dart';

void main() {
  group(
    'SBBResponsive static bool screen width tests.',
    (() {
      testWidgets(
        'Screen width below mobile breakpoint.',
        (WidgetTester tester) async {
          testMediaQueryBreakpoint(
            tester,
            SBBResponsive.mobileBreakpoint,
            SBBResponsive.isMobile,
          );
        },
      );
      testWidgets(
        'Screen width below tablet breakpoint.',
        (WidgetTester tester) async {
          testMediaQueryBreakpoint(
            tester,
            SBBResponsive.tabletBreakpoint,
            SBBResponsive.isTablet,
          );
        },
      );
      testWidgets(
        'Screen width below desktop breakpoint.',
        (WidgetTester tester) async {
          testMediaQueryBreakpoint(
            tester,
            SBBResponsive.desktopBreakpoint,
            SBBResponsive.isDesktop,
          );
        },
      );
    }),
  );
}

void testMediaQueryBreakpoint(
    WidgetTester tester, int breakpoint, Function func) {
  tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(
        size: Size(
          breakpoint - 1,
          400,
        ),
      ),
      child: MaterialApp(
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            expect(func(context), true);
            return Placeholder();
          }),
        ),
      ),
    ),
  );
}
