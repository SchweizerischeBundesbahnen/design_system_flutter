import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(
    String name,
    DateTime initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  ) {
    final widget = DatePickerTest(
      initialDate: initialDate,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    );
    testWidgets(name, (WidgetTester tester) async {
      await Specs.run(
        Specs.mobileSpecs,
        widget,
        tester,
        name,
        find.byType(DatePickerTest),
      );
    });
  }

  generateTest(
    'date_picker_test_1',
    DateTime(2024, 07, 02),
    null,
    null,
  );
  generateTest(
    'date_picker_test_2',
    DateTime(2024, 07, 02),
    DateTime(2024, 06, 30),
    DateTime(2024, 07, 04),
  );
  generateTest(
    'date_picker_test_3',
    DateTime(2024, 06, 30),
    DateTime(2024, 07, 02),
    DateTime(2024, 07, 04),
  );
  generateTest(
    'date_picker_test_4',
    DateTime(2024, 07, 06),
    DateTime(2024, 07, 02),
    DateTime(2024, 07, 04),
  );
}

class DatePickerTest extends StatelessWidget {
  const DatePickerTest({
    super.key,
    required this.initialDate,
    required this.minimumDate,
    required this.maximumDate,
  });

  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (_) {},
              initialDate: initialDate,
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          SBBGroup(
            child: SBBDatePicker(
              onDateChanged: (_) {},
              initialDate: initialDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          Row(
            children: [
              SizedBox(
                width: 225,
                child: SBBGroup(
                  child: SBBDatePicker(
                    onDateChanged: (_) {},
                    initialDate: initialDate,
                  ),
                ),
              ),
              const SizedBox(width: sbbDefaultSpacing),
              SizedBox(
                width: 180,
                child: SBBGroup(
                  child: SBBDatePicker(
                    onDateChanged: (_) {},
                    initialDate: initialDate,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
