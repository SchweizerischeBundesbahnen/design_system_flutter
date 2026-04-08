import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('multidropdown', (WidgetTester tester) async {
    final items = [
      SBBDropdownItem<int>(value: 0, label: 'Item 0'),
      SBBDropdownItem<int>(value: 1, label: 'Item 1'),
      SBBDropdownItem<int>(value: 2, label: 'Item 2'),
      SBBDropdownItem<int>(value: 3, label: 'Item 3'),
      SBBDropdownItem<int>(value: 4, label: 'Item 4'),
    ];

    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          margin: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall).copyWith(top: SBBSpacing.xSmall),
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: [
                SBBMultiDropdown<int>(selectedItems: [], items: items, onChanged: (_) {}),
                SBBMultiDropdown<int>(
                  selectedItems: [1, 2],
                  items: items,
                  onChanged: (_) {},
                  triggerDecoration: SBBInputDecoration(
                    labelText: 'Default Value',
                    leadingIconData: SBBIcons.dog_small,
                  ),
                ),
                SBBMultiDropdown<int>(
                  selectedItems: [1],
                  items: items,
                  onChanged: null,
                  triggerDecoration: SBBInputDecoration(labelText: 'Disabled'),
                ),
              ],
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'multidropdown',
      find.byType(Scaffold).first,
    );
  });
}
