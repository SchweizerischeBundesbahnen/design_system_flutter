import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Duration of the implicit [AnimatedTheme] that [MaterialApp] wraps the app in.
const _themeSwitch = kThemeAnimationDuration;

/// Frames at which the theme lerp is sampled, as fractions of [_themeSwitch].
const _sampleFractions = [0.0, 0.25, 0.5, 0.75, 1.0];

void main() {
  group('theme switch', () {
    testWidgets('standalone bottom line follows the theme lerp frame by frame', (tester) async {
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.cloud);

      _switchToDark(tester);
      await _expectAtEveryFrame(tester, (t) {
        expect(_borderColorOf(tester), _closeTo(_lerped(SBBColors.cloud, SBBColors.iron, t)), reason: 'at t=$t');
      });
    });

    testWidgets('label color follows the theme lerp frame by frame', (tester) async {
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(_labelColorOf(tester), SBBColors.granite);

      _switchToDark(tester);
      await _expectAtEveryFrame(tester, (t) {
        expect(_labelColorOf(tester), _closeTo(_lerped(SBBColors.granite, SBBColors.graphite, t)), reason: 'at t=$t');
      });
    });

    testWidgets('focused bottom line follows the theme lerp frame by frame', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            focusNode: focusNode,
            decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
          ),
        ),
      );
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.black);

      _switchToDark(tester);
      await _expectAtEveryFrame(tester, (t) {
        expect(_borderColorOf(tester), _closeTo(_lerped(SBBColors.black, SBBColors.white, t)), reason: 'at t=$t');
      });
    });

    testWidgets('boxed border with error follows the theme lerp frame by frame', (tester) async {
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInputBoxed(
            decoration: SBBInputDecoration(labelText: 'Label', errorText: 'Error'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.error);

      _switchToDark(tester);
      await _expectAtEveryFrame(tester, (t) {
        expect(_borderColorOf(tester), _closeTo(_lerped(SBBColors.error, SBBColors.errorDark, t)), reason: 'at t=$t');
      });
    });
  });

  group('state change', () {
    testWidgets('bottom line still animates from unfocused to focused', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            focusNode: focusNode,
            decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
          ),
        ),
      );
      await tester.pumpAndSettle();

      focusNode.requestFocus();
      await tester.pump(); // applies the focus change
      await tester.pump(); // rebuilds with the focused state and starts the transition
      await tester.pump(const Duration(milliseconds: 84));
      final midway = _borderColorOf(tester);
      expect(midway, isNot(SBBColors.cloud));
      expect(midway, isNot(SBBColors.black));
      expect(midway.r, inExclusiveRange(SBBColors.black.r, SBBColors.cloud.r));

      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.black);
    });

    testWidgets('losing focus midway continues from the color on screen', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            focusNode: focusNode,
            decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
          ),
        ),
      );
      await tester.pumpAndSettle();

      focusNode.requestFocus();
      await tester.pump(); // applies the focus change
      await tester.pump(); // rebuilds with the focused state and starts the transition
      await tester.pump(const Duration(milliseconds: 84));
      final beforeBlur = _borderColorOf(tester);

      focusNode.unfocus();
      await tester.pump(); // applies the focus change
      await tester.pump(); // rebuilds with the unfocused state and restarts the transition
      expect(_borderColorOf(tester), beforeBlur);

      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.cloud);
    });
  });
}

/// Pumps one frame at [fraction] × [_themeSwitch] for every fraction in [_sampleFractions]
/// and runs [check] with the fraction, once the first frame of the switch has been built.
Future<void> _expectAtEveryFrame(WidgetTester tester, void Function(double t) check) async {
  var elapsed = Duration.zero;
  for (final fraction in _sampleFractions) {
    final target = _themeSwitch * fraction;
    await tester.pump(target - elapsed);
    elapsed = target;
    check(fraction);
  }
}

Color _lerped(Color a, Color b, double t) => Color.lerp(a, b, t)!;

/// Matches a color whose channels are within floating point noise of [expected].
Matcher _closeTo(Color expected) => _ColorCloseTo(expected);

class _ColorCloseTo extends Matcher {
  const _ColorCloseTo(this.expected);

  final Color expected;
  static const _tolerance = 1e-6;

  @override
  bool matches(Object? item, Map<dynamic, dynamic> matchState) {
    if (item is! Color) return false;
    return (item.a - expected.a).abs() < _tolerance &&
        (item.r - expected.r).abs() < _tolerance &&
        (item.g - expected.g).abs() < _tolerance &&
        (item.b - expected.b).abs() < _tolerance;
  }

  @override
  Description describe(Description description) => description.add('a color within $_tolerance of $expected');
}

/// The painted border color of the decorator's container slot under the single [SBBTextInput].
Color _borderColorOf(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find.descendant(
      of: find.byWidgetPredicate((w) => w is SBBTextInput),
      matching: find.byWidgetPredicate(
        (w) => w is DecoratedBox && w.decoration is BoxDecoration && (w.decoration as BoxDecoration).border != null,
      ),
    ),
  );
  return ((box.decoration as BoxDecoration).border as Border).bottom.color;
}

/// The text color the label is painted with.
Color? _labelColorOf(WidgetTester tester) => DefaultTextStyle.of(tester.element(find.text('Label'))).style.color;

void _switchToDark(WidgetTester tester) {
  tester.state<_ThemeSwitchHostState>(find.byType(_ThemeSwitchHost)).switchToDark();
}

class _ThemeSwitchHost extends StatefulWidget {
  const _ThemeSwitchHost({required this.child});

  final Widget child;

  @override
  State<_ThemeSwitchHost> createState() => _ThemeSwitchHostState();
}

class _ThemeSwitchHostState extends State<_ThemeSwitchHost> {
  ThemeMode _mode = .light;

  void switchToDark() => setState(() => _mode = .dark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SBBTheme.light(),
      darkTheme: SBBTheme.dark(),
      themeMode: _mode,
      home: Scaffold(body: widget.child),
    );
  }
}
