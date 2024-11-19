import 'dart:convert';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class TestSpecs {
  const TestSpecs._({
    required this.size,
    required this.brightness,
  });

  factory TestSpecs.light() => const TestSpecs._(
        size: _size,
        brightness: Brightness.light,
      );

  factory TestSpecs.dark() => const TestSpecs._(
        size: _size,
        brightness: Brightness.dark,
      );

  static const _size = Size(600, 1000);

  final Size size;
  final Brightness brightness;

  static List<TestSpecs> themedSpecs = [
    TestSpecs.light(),
    TestSpecs.dark(),
  ];

  String get name => brightness.name;

  static Future<void> run(
    List<TestSpecs> specs,
    Widget widget,
    WidgetTester tester,
    String name,
    Finder finder, {
    Function(Widget w)? wrap,
  }) async {
    for (final spec in specs) {
      await tester.binding.setSurfaceSize(spec.size);
      tester.view.physicalSize = spec.size;
      tester.view.devicePixelRatio = 1.0;
      tester.platformDispatcher.platformBrightnessTestValue = spec.brightness;

      await tester.pumpWidget(
        wrap?.call(widget) ?? TestApp(child: widget),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(() => tester.pumpAndSettle());
      await tester.pumpAndSettle();

      await expectLater(
        finder,
        matchesGoldenFile('goldens/$name.${spec.name}.png'),
      );
    }
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.child});

  static Future<void> setupAll() async => await _loadFonts();

  static Future<void> _loadFonts() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final fontManifest = await rootBundle.loadStructuredData<Iterable<dynamic>>(
      'FontManifest.json',
      (s) async => json.decode(s),
    );
    for (final font in fontManifest) {
      final fontName = 'packages/design_system_flutter/${font['family']}';
      final fontLoader = FontLoader(fontName);
      for (final Map<String, dynamic> fontType in font['fonts']) {
        fontLoader.addFont(rootBundle.load(fontType['asset']));
      }
      await fontLoader.load();
    }
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SBBTheme.light(),
      darkTheme: SBBTheme.dark(),
      debugShowCheckedModeBanner: false,
      builder: (_, __) => Scaffold(body: child),
    );
  }
}
