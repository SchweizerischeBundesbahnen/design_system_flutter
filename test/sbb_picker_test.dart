import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, int initialItem, int? minItem, int? maxItem, int? visibleItemCount) {
    final widget = PickerTest(
      initialItem: initialItem,
      minItem: minItem,
      maxItem: maxItem,
      visibleItemCount: visibleItemCount,
    );
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(widget.runtimeType));
    });
  }

  generateTest('picker_test_1', 0, null, null, null);
  generateTest('picker_test_2', 8, null, null, 5);
  generateTest('picker_test_3', 3, 2, 4, null);
}

class PickerTest extends StatelessWidget {
  const PickerTest({
    super.key,
    required this.initialItem,
    required this.minItem,
    required this.maxItem,
    int? visibleItemCount,
  }) : _visibleItemCount = visibleItemCount ?? 7;

  static const List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Raspberry',
    'Kiwi',
    'Coconut',
    'Peach',
  ];

  final int initialItem;
  final int? minItem;
  final int? maxItem;
  final int _visibleItemCount;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    spacing: SBBSpacing.medium,
    children: [
      Row(
        spacing: SBBSpacing.medium,
        children: [
          Flexible(
            child: SBBContentBox(
              child: SBBPicker.list(
                onSelectedItemChanged: (_) {},
                looping: true,
                initialSelectedIndex: initialItem,
                items: _fruitNames,
                visibleItemCount: _visibleItemCount,
              ),
            ),
          ),
          Flexible(
            child: SBBContentBox(
              child: SBBPicker.list(
                onSelectedItemChanged: (_) {},
                looping: false,
                initialSelectedIndex: initialItem,
                items: _fruitNames,
                visibleItemCount: _visibleItemCount,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: SBBSpacing.medium,
        children: [
          Flexible(
            child: SBBContentBox(
              child: SBBPicker(
                onSelectedItemChanged: (_) {},
                looping: true,
                initialSelectedIndex: initialItem,
                visibleItemCount: _visibleItemCount,
                itemBuilder: (_, index) {
                  final isEnabled = (minItem == null || index >= minItem!) && (maxItem == null || index <= maxItem!);
                  final item = _fruitNames[index % _fruitNames.length];
                  return SBBPickerItem(item, isEnabled: isEnabled);
                },
              ),
            ),
          ),
          Flexible(
            child: SBBContentBox(
              child: SBBPicker(
                onSelectedItemChanged: (_) {},
                looping: false,
                initialSelectedIndex: initialItem,
                visibleItemCount: _visibleItemCount,
                itemBuilder: (_, index) {
                  final isInRange = (index >= 0) && (index < _fruitNames.length);
                  if (!isInRange) {
                    return null;
                  }
                  final isEnabled = (minItem == null || index >= minItem!) && (maxItem == null || index <= maxItem!);
                  final item = _fruitNames[index];
                  return SBBPickerItem(item, isEnabled: isEnabled);
                },
              ),
            ),
          ),
          Flexible(
            child: SBBContentBox(
              child: SBBPicker(
                onSelectedItemChanged: (_) {},
                looping: false,
                initialSelectedIndex: initialItem,
                visibleItemCount: _visibleItemCount,
                itemBuilder: (_, index) {
                  final isInRange = (minItem == null || index >= minItem!) && (maxItem == null || index <= maxItem!);
                  if (!isInRange) {
                    return null;
                  }
                  final item = _fruitNames[index % _fruitNames.length];
                  return SBBPickerItem(item);
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
