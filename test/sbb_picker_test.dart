import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(
    String name,
    int initialItem,
    int? minItem,
    int? maxItem,
  ) {
    final widget = PickerTest(
      initialItem: initialItem,
      minItem: minItem,
      maxItem: maxItem,
    );
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(widget.runtimeType),
      );
    });
  }

  generateTest('picker_test_1', 0, null, null);
  generateTest('picker_test_2', 5, null, null);
  generateTest('picker_test_3', 3, 2, 4);
}

class PickerTest extends StatelessWidget {
  const PickerTest({
    super.key,
    required this.initialItem,
    required this.minItem,
    required this.maxItem,
  });

  static const List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];

  final int initialItem;
  final int? minItem;
  final int? maxItem;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBPicker.list(
                    onSelectedItemChanged: (_) {},
                    looping: true,
                    initialSelectedIndex: initialItem,
                    items: _fruitNames,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker.list(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    items: _fruitNames,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              Expanded(
                child: SBBGroup(
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: true,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isEnabled =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
                      final item = _fruitNames[index % _fruitNames.length];
                      return SBBPickerItem(item, isEnabled: isEnabled);
                    },
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isInRange =
                          (index >= 0) && (index < _fruitNames.length);
                      if (!isInRange) {
                        return null;
                      }
                      final isEnabled =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
                      final item = _fruitNames[index];
                      return SBBPickerItem(item, isEnabled: isEnabled);
                    },
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              Expanded(
                child: SBBGroup(
                  child: SBBPicker(
                    onSelectedItemChanged: (_) {},
                    looping: false,
                    initialSelectedIndex: initialItem,
                    itemBuilder: (BuildContext context, int index) {
                      final isInRange =
                          (minItem == null || index >= minItem!) &&
                              (maxItem == null || index <= maxItem!);
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
