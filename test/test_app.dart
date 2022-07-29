import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key, required this.child, this.expanded = false}) : super(key: key);

  factory TestApp.expanded({Key? key, required Widget child}) => TestApp(key: key, child: child, expanded: true);

  static const defaultSize = Size(600, 1000);
  static const devices = [
    Device(
      size: defaultSize,
      name: 'light',
    ),
    Device(
      size: defaultSize,
      brightness: Brightness.dark,
      name: 'dark',
    ),
  ];

  static Future<void> setupAll() async => await loadAppFonts();

  final Widget child;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final widget = MaterialApp(
      theme: SBBTheme.light(),
      darkTheme: SBBTheme.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: child),
    );

    if (!expanded) {
      return widget;
    }

    return LayoutBuilder(
      builder: (context, snapshot) {
        final mediaQuery = MediaQuery.of(context);
        return SizedBox(
          width: mediaQuery.size.width * mediaQuery.devicePixelRatio,
          height: (mediaQuery.size.height - 75) * mediaQuery.devicePixelRatio,
          child: widget,
        );
      },
    );
  }
}
