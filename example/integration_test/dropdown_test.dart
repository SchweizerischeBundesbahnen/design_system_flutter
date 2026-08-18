import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dropdownItem_whenSearchedForByKeyAndTapped_isFoundAndSelectsTheItem', (tester) async {
    final items = [
      SBBDropdownItem<int>(value: 0, label: 'Item 0', key: const ValueKey(0)),
      SBBDropdownItem<int>(value: 1, label: 'Item 1', key: const ValueKey(1)),
      SBBDropdownItem<int>(value: 2, label: 'Item 2', key: const ValueKey(2)),
    ];

    int? selected;
    await tester.pumpWidget(
      TestApp(
        child: SBBDropdown<int>(
          selectedItem: null,
          items: items,
          onChanged: (value) => selected = value,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SBBDecoratedText));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(2)), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey(2)));
    await tester.pumpAndSettle();

    expect(selected, 2);
  });

  testWidgets('multiDropdownItem_whenSearchedForByKeyAndTapped_isFoundAndTogglesTheItem', (tester) async {
    final items = [
      SBBDropdownItem<int>(value: 0, label: 'Item 0', key: const ValueKey(0)),
      SBBDropdownItem<int>(value: 1, label: 'Item 1', key: const ValueKey(1)),
      SBBDropdownItem<int>(value: 2, label: 'Item 2', key: const ValueKey(2)),
    ];

    List<int>? selected;
    await tester.pumpWidget(
      TestApp(
        child: SBBMultiDropdown<int>(
          selectedItems: const [],
          items: items,
          onChanged: (value) => selected = value,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SBBDecoratedText));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(2)), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey(2)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SBBPrimaryButton));
    await tester.pumpAndSettle();

    expect(selected, [2]);
  });
}
