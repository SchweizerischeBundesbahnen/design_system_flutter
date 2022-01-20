import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('multiline checkbox', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
      ..addScenario(
        'checkbox tests',
        MultilineCheckboxText(),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'multiline_checkbox_checked', devices: TestApp.devices);

    await tester.tap(find.byKey(Key('checkbox')));
    await multiScreenGolden(tester, 'multiline_checkbox_null', devices: TestApp.devices);

    await tester.tap(find.byKey(Key('checkbox')));
    await multiScreenGolden(tester, 'multiline_checkbox_unchecked', devices: TestApp.devices);
  });
}

class MultilineCheckboxText extends StatefulWidget {
  @override
  _MultilineCheckboxTextState createState() => _MultilineCheckboxTextState();
}

class _MultilineCheckboxTextState extends State<MultilineCheckboxText> {
  bool? _listItemValue = true;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SBBGroup(
        child: SBBCheckboxListItem(
          key: Key('checkbox'),
          value: _listItemValue,
          label: 'Multiline Label with\nSecondary Label',
          allowMultilineLabel: true,
          secondaryLabel: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
          isLastElement: true,
          tristate: true,
          onChanged: (value) => setState(() => _listItemValue = value),
        ),
      ),
    ],
  );
}
