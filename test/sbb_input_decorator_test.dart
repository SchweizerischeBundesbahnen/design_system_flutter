// Frame-sampled widget tests instead of goldens: the behaviour under test is the color of the
// border and label at single frames of a running transition, which a settled golden cannot show.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Duration of the implicit [AnimatedTheme] that [MaterialApp] wraps the app in.
const _themeSwitch = kThemeAnimationDuration;

/// Frames at which the theme lerp is sampled, as fractions of [_themeSwitch].
const _sampleFractions = [0.0, 0.25, 0.5, 0.75, 1.0];

/// Halfway through the 168 ms state transition of the decorator.
const _midTransition = Duration(milliseconds: 84);

void main() {
  group('theme switch', () {
    for (final c in [
      _LockstepCase(
        'standalone bottom line',
        (focusNode) => SBBTextInput(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
        ),
        read: _borderColorOf,
        light: SBBColors.cloud,
        dark: SBBColors.iron,
      ),
      _LockstepCase(
        'standalone label',
        (focusNode) => SBBTextInput(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
        ),
        read: _labelColorOf,
        light: SBBColors.granite,
        dark: SBBColors.graphite,
      ),
      _LockstepCase(
        'focused standalone bottom line',
        (focusNode) => SBBTextInput(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
        ),
        focus: true,
        read: _borderColorOf,
        light: SBBColors.black,
        dark: SBBColors.white,
      ),
      _LockstepCase(
        'focused standalone label',
        (focusNode) => SBBTextInput(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label', borderType: .standalone),
        ),
        focus: true,
        read: _labelColorOf,
        light: SBBColors.granite,
        dark: SBBColors.graphite,
      ),
      _LockstepCase(
        'boxed border with error',
        (focusNode) => SBBTextInputBoxed(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label', errorText: 'Error'),
        ),
        read: _borderColorOf,
        light: SBBColors.error,
        dark: SBBColors.errorDark,
      ),
      _LockstepCase(
        'boxed label',
        (focusNode) => SBBTextInputBoxed(
          focusNode: focusNode,
          decoration: SBBInputDecoration(labelText: 'Label'),
        ),
        read: _labelColorOf,
        light: SBBColors.granite,
        dark: SBBColors.graphite,
      ),
    ]) {
      testWidgets('${c.name} follows the theme lerp frame by frame', (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);
        await tester.pumpWidget(_ThemeSwitchHost(child: c.build(focusNode)));
        if (c.focus) focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(c.read(tester), c.light);

        _switchToDark(tester);
        await _expectAtEveryFrame(tester, (t) {
          expect(c.read(tester), isSameColorAs(Color.lerp(c.light, c.dark, t)!), reason: 'at t=$t');
        });
      });
    }
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

      await _changeFocus(tester, focusNode, focused: true);
      await tester.pump(_midTransition);
      final midway = _borderColorOf(tester);
      expect(midway.r, inExclusiveRange(SBBColors.black.r, SBBColors.cloud.r));

      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.black);
    });

    testWidgets('bottom line losing focus midway continues from the color on screen', (tester) async {
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

      await _changeFocus(tester, focusNode, focused: true);
      await tester.pump(_midTransition);
      final beforeBlur = _borderColorOf(tester);

      await _changeFocus(tester, focusNode, focused: false);
      expect(_borderColorOf(tester), beforeBlur);

      await tester.pumpAndSettle();
      expect(_borderColorOf(tester), SBBColors.cloud);
    });

    testWidgets('label losing focus midway continues from the color on screen', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _ThemeSwitchHost(
          child: SBBTextInput(
            focusNode: focusNode,
            decoration: SBBInputDecoration(
              labelText: 'Label',
              labelForegroundColor: WidgetStateProperty.fromMap({
                WidgetState.focused: SBBColors.red,
                WidgetState.any: SBBColors.granite,
              }),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await _changeFocus(tester, focusNode, focused: true);
      await tester.pump(_midTransition);
      final beforeBlur = _labelColorOf(tester);
      expect(beforeBlur!.r, inExclusiveRange(SBBColors.granite.r, SBBColors.red.r));

      await _changeFocus(tester, focusNode, focused: false);
      expect(_labelColorOf(tester), beforeBlur);

      await tester.pumpAndSettle();
      expect(_labelColorOf(tester), SBBColors.granite);
    });
  });
}

/// One sampled color of one decorated input through a light to dark theme switch.
class _LockstepCase {
  const _LockstepCase(
    this.name,
    this.build, {
    this.focus = false,
    required this.read,
    required this.light,
    required this.dark,
  });

  final String name;
  final Widget Function(FocusNode focusNode) build;
  final bool focus;
  final Color? Function(WidgetTester tester) read;
  final Color light;
  final Color dark;
}

/// Pumps one frame at [fraction] × [_themeSwitch] for every fraction in [_sampleFractions]
/// and runs [check] with the fraction.
Future<void> _expectAtEveryFrame(WidgetTester tester, void Function(double t) check) async {
  var elapsed = Duration.zero;
  for (final fraction in _sampleFractions) {
    final target = _themeSwitch * fraction;
    await tester.pump(target - elapsed);
    elapsed = target;
    check(fraction);
  }
}

/// Changes focus and pumps until the decorator has rebuilt with the new state and started its
/// transition: one frame applies the focus change, the next rebuilds with the new states.
Future<void> _changeFocus(WidgetTester tester, FocusNode focusNode, {required bool focused}) async {
  if (focused) {
    focusNode.requestFocus();
  } else {
    focusNode.unfocus();
  }
  await tester.pump();
  await tester.pump();
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

/// A [MaterialApp] with the SBB themes whose [ThemeMode] can be switched while mounted.
///
/// Not [TestApp] from test_app.dart, which has no theme mode and is tuned for goldens.
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
