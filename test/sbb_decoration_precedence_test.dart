import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Checks the order in which the decoration style is applied for every decorated component:
/// widget, then component theme, then [SBBDecorationThemeData].
///
/// A golden cannot tell which of the three levels a value came from, so the border
/// drawn by the decoration is inspected instead (#762).
void main() {
  const globalColor = SBBColors.violet;
  const wrappedColor = SBBColors.peach;
  const componentColor = SBBColors.green;
  const widgetColor = SBBColors.sky;

  SBBDecorationStyle colored(Color color) => SBBDecorationStyle(borderColor: WidgetStatePropertyAll(color));
  const standalone = SBBDecorationStyle(borderType: .standalone);
  const boxedOrListed = SBBDecorationStyle(borderType: .boxedOrListed);
  final separatorColor = SBBTheme.light().sbbBaseStyle.colorScheme.strokeSeparator;

  for (final component in _components) {
    Future<Color> borderColor(
      WidgetTester tester, {
      SBBDecorationStyle? global,
      SBBDecorationStyle? wrapped,
      SBBDecorationStyle? componentTheme,
      SBBDecorationStyle? widget,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: component.theme(global: global, wrapped: wrapped, component: componentTheme),
          home: Scaffold(
            body: component.build(SBBDecoration(labelText: 'Label', style: widget)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      return ((container.decoration! as BoxDecoration).border! as Border).bottom.color;
    }

    group(component.name, () {
      testWidgets('applies the decoration theme', (tester) async {
        expect(await borderColor(tester, global: colored(globalColor)), globalColor);
        expect(await borderColor(tester, global: standalone), separatorColor);
      });

      testWidgets('component theme overrides the decoration theme', (tester) async {
        expect(
          await borderColor(tester, global: colored(globalColor), componentTheme: colored(componentColor)),
          componentColor,
        );
        expect(await borderColor(tester, global: standalone, componentTheme: boxedOrListed), SBBColors.transparent);
      });

      testWidgets('widget overrides the component theme and the decoration theme', (tester) async {
        expect(
          await borderColor(
            tester,
            global: colored(globalColor),
            componentTheme: colored(componentColor),
            widget: colored(widgetColor),
          ),
          widgetColor,
        );
        expect(
          await borderColor(tester, global: boxedOrListed, componentTheme: boxedOrListed, widget: standalone),
          separatorColor,
        );
      });

      if (component.wrapsDecoratedText) {
        testWidgets('decorated text theme reaches the trigger and is overridden by the trigger theme', (tester) async {
          expect(
            await borderColor(tester, global: colored(globalColor), wrapped: colored(wrappedColor)),
            wrappedColor,
          );
          expect(
            await borderColor(tester, wrapped: colored(wrappedColor), componentTheme: colored(componentColor)),
            componentColor,
          );
          expect(await borderColor(tester, wrapped: standalone), separatorColor);
          expect(await borderColor(tester, wrapped: standalone, componentTheme: boxedOrListed), SBBColors.transparent);
        });
      }
    });
  }
}

/// The component theme that holds the decoration style of a component.
enum _Layer { textInput, decorated, decoratedText, dropdown, picker }

class _Component {
  const _Component(this.name, this.layer, this.build);

  final String name;
  final _Layer layer;
  final Widget Function(SBBDecoration decoration) build;

  bool get wrapsDecoratedText => layer == .dropdown || layer == .picker;

  ThemeData theme({SBBDecorationStyle? global, SBBDecorationStyle? wrapped, SBBDecorationStyle? component}) {
    assert(wrapped == null || wrapsDecoratedText);
    return SBBTheme.light(
      decorationTheme: SBBDecorationThemeData(style: global),
      textInputTheme: SBBTextInputThemeData(decorationStyle: layer == .textInput ? component : null),
      decoratedTheme: SBBDecoratedThemeData(decorationStyle: layer == .decorated ? component : null),
      decoratedTextTheme: SBBDecoratedTextThemeData(decorationStyle: layer == .decoratedText ? component : wrapped),
      dropdownTheme: SBBDropdownThemeData(triggerDecorationStyle: layer == .dropdown ? component : null),
      pickerTheme: SBBPickerThemeData(triggerDecorationStyle: layer == .picker ? component : null),
    );
  }
}

final _date = DateTime(2024, 1, 1, 12, 30);

final _components = <_Component>[
  _Component('SBBTextInput', .textInput, (d) => SBBTextInput(decoration: d)),
  _Component('SBBTextInputFormField', .textInput, (d) => SBBTextInputFormField(decoration: d)),
  _Component(
    'SBBAutocompletion',
    .textInput,
    (d) => SBBAutocompletion<String>(
      key: GlobalKey<SBBAutocompletionState<String>>(),
      decoration: d,
      suggestions: const [],
      favorites: const [],
      itemSorter: (a, b) => a.compareTo(b),
      itemFilter: (_, _) => true,
      itemSubmitted: (_) {},
      itemAddedToFavorites: (_) {},
      itemRemovedFromFavorites: (_) {},
    ),
  ),
  _Component('SBBDecorated', .decorated, (d) => SBBDecorated(decoration: d, child: const Text('Value'))),
  _Component('SBBDecoratedText', .decoratedText, (d) => SBBDecoratedText(value: 'Value', decoration: d)),
  _Component(
    'SBBDropdown',
    .dropdown,
    (d) => SBBDropdown<int>(
      triggerDecoration: d,
      selectedItem: 1,
      items: const [SBBDropdownItem(value: 1, label: 'One')],
      onChanged: (_) {},
    ),
  ),
  _Component(
    'SBBMultiDropdown',
    .dropdown,
    (d) => SBBMultiDropdown<int>(
      triggerDecoration: d,
      selectedItems: const [1],
      items: const [SBBDropdownItem(value: 1, label: 'One')],
      onChanged: (_) {},
    ),
  ),
  _Component('SBBDateInput', .picker, (d) => SBBDateInput(value: _date, triggerDecoration: d, onDateChanged: (_) {})),
  _Component(
    'SBBTimeInput',
    .picker,
    (d) => SBBTimeInput(value: TimeOfDay.fromDateTime(_date), triggerDecoration: d, onTimeChanged: (_) {}),
  ),
  _Component(
    'SBBDateTimeInput',
    .picker,
    (d) => SBBDateTimeInput(value: _date, triggerDecoration: d, onDateTimeChanged: (_) {}),
  ),
];
