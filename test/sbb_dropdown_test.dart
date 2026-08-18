import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('dropdown', (WidgetTester tester) async {
    final items = [
      SBBDropdownItem<int>(value: 0, label: 'Item 0'),
      SBBDropdownItem<int>(value: 1, label: 'Item 1'),
      SBBDropdownItem<int>(value: 2, label: 'Item 2'),
      SBBDropdownItem<int>(value: 3, label: 'Item 3'),
      SBBDropdownItem<int>(value: 4, label: 'Item 4'),
    ];

    final widget = Builder(
      builder: (context) {
        return Column(
          children: [
            SBBListHeader('Standalone'),
            SBBDropdown<int>(
              selectedItem: null,
              items: items,
              onChanged: (_) {},
              triggerDecoration: SBBInputDecoration(borderType: .standalone),
            ),
            SBBDropdown<int>(
              selectedItem: 1,
              items: items,
              onChanged: (_) {},
              triggerDecoration: SBBInputDecoration(
                labelText: 'Default Value',
                leadingIconData: SBBIcons.dog_small,
                borderType: .standalone,
              ),
            ),
            SBBDropdown<int>(
              selectedItem: 1,
              items: items,
              onChanged: null,
              triggerDecoration: SBBInputDecoration(labelText: 'Disabled', borderType: .standalone),
            ),
            SBBListHeader('Listed'),
            SBBContentBox(
              margin: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall).copyWith(top: SBBSpacing.xSmall),
              child: Column(
                mainAxisSize: .min,
                children: SBBDivider.divideItems(
                  context: context,
                  items: [
                    SBBDropdown<int>(selectedItem: null, items: items, onChanged: (_) {}),
                    SBBDropdown<int>(
                      selectedItem: 1,
                      items: items,
                      onChanged: (_) {},
                      triggerDecoration: SBBInputDecoration(
                        labelText: 'Default Value',
                        leadingIconData: SBBIcons.dog_small,
                      ),
                    ),
                    SBBDropdown<int>(
                      selectedItem: 1,
                      items: items,
                      onChanged: null,
                      triggerDecoration: SBBInputDecoration(labelText: 'Disabled'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'dropdown',
      find.byType(Scaffold).first,
    );
  });

  testWidgets('items are selectable via their consumer-supplied key', (WidgetTester tester) async {
    final items = [
      SBBDropdownItem<int>(value: 0, label: 'Item 0', key: const ValueKey(0)),
      SBBDropdownItem<int>(value: 1, label: 'Item 1', key: const ValueKey(1)),
      SBBDropdownItem<int>(value: 2, label: 'Item 2', key: const ValueKey(2)),
    ];

    int? changed;
    await tester.pumpWidget(
      MaterialApp(
        theme: SBBTheme.light(),
        home: Scaffold(
          body: SBBDropdown<int>(
            selectedItem: null,
            items: items,
            onChanged: (value) => changed = value,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SBBDecoratedText));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(2)), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey(2)));
    await tester.pumpAndSettle();

    expect(changed, 2);
  });
}
