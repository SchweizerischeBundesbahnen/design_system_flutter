import 'dart:convert';

import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class Specs {
  const Specs._({
    required this.size,
    required this.brightness,
  });

  factory Specs.mobile() => Specs._(
        size: _mobileSize,
        brightness: Brightness.light,
      );

  factory Specs.web() => Specs._(
        size: _webSize,
        brightness: Brightness.light,
      );

  Specs dark() => Specs._(
        size: size,
        brightness: Brightness.dark,
      );

  static const _mobileSize = Size(600, 1000);
  static const _webSize = Size(1600, 900);

  final Size size;
  final Brightness brightness;

  static List<Specs> mobileSpecs = [
    Specs.mobile(),
    Specs.mobile().dark(),
  ];

  static List<Specs> webSpecs = [
    Specs.web(),
  ];

  String get name => brightness.name;

  static Future<void> run(
    List<Specs> specs,
    Widget widget,
    WidgetTester tester,
    String name,
    Finder finder, {
    Function(Widget w)? wrap,
    HostPlatform hostType = HostPlatform.native,
  }) async {
    for (final spec in specs) {
      await tester.binding.setSurfaceSize(spec.size);
      tester.view.physicalSize = spec.size;
      tester.view.devicePixelRatio = 1.0;
      tester.platformDispatcher.platformBrightnessTestValue = spec.brightness;

      await tester.pumpWidget(
        wrap?.call(widget) ?? TestApp(child: widget, hostType: hostType),
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
  const TestApp(
      {Key? key, required this.child, this.hostType = HostPlatform.native})
      : super(key: key);

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

  final HostPlatform hostType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SBBTheme.light(hostPlatform: hostType),
      darkTheme: SBBTheme.dark(hostPlatform: hostType),
      debugShowCheckedModeBanner: false,
      builder: (_, __) => Scaffold(body: child),
    );
  }
}
