import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('date_input', (WidgetTester tester) async {
    final widget = Column(
      mainAxisSize: .min,
      children: _dateInputItems(borderType: .standalone),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'date_input',
      find.byType(Column).first,
    );
  });

  testWidgets('date_input_listed', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: _dateInputItems(borderType: .boxedOrListed),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'date_input_listed',
      find.byType(Column).first,
    );
  });
}

List<Widget> _dateInputItems({required SBBInputBorderType borderType}) {
  final initialDate = DateTime(2024, 07, 03);
  final minimumDate = DateTime(2024, 08, 01);
  final maximumDate = DateTime(2024, 07, 01);
  return [
    SBBDateInput(
      onDateChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBDateInput(
      value: initialDate,
      onDateChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBDateInput(
      triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only', borderType: borderType),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      triggerDecoration: SBBInputDecoration(
        labelText: 'Label and Hint',
        placeholderText: 'Label and Hint',
        borderType: borderType,
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBInputDecoration(labelText: 'Label and Value', borderType: borderType),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBInputDecoration(labelText: 'Custom date format', borderType: borderType),
      dateFormat: DateFormat('dd.MM.yy'),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Error',
        errorText: 'Error',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Disabled',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateChanged: null,
    ),
    SBBDateInput(
      value: initialDate,
      minimumDate: minimumDate,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date before minimum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      maximumDate: maximumDate,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date after maximum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateChanged: (_) {},
    ),
  ];
}
