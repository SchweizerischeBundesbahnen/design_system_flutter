import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('date_time_input', (WidgetTester tester) async {
    final widget = Column(
      mainAxisSize: .min,
      children: _dateTimeInputItems(borderType: .standalone),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'date_time_input',
      find.byType(Column).first,
    );
  });

  testWidgets('date_time_input_listed', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: _dateTimeInputItems(borderType: .boxedOrListed),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'date_time_input_listed',
      find.byType(Column).first,
    );
  });
}

List<Widget> _dateTimeInputItems({required SBBInputBorderType borderType}) {
  final initialDateTime = DateTime(2024, 07, 03, 12, 33);
  final minimumDateTime = DateTime(2024, 08, 01, 16, 12);
  final maximumDateTime = DateTime(2024, 07, 01, 08, 43);
  return [
    SBBDateTimeInput(
      onDateTimeChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      onDateTimeChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBDateTimeInput(
      triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only', borderType: borderType),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      triggerDecoration: SBBInputDecoration(
        labelText: 'Label and Hint',
        placeholderText: 'Label and Hint',
        borderType: borderType,
      ),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      triggerDecoration: SBBInputDecoration(labelText: 'Label and Value', borderType: borderType),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      triggerDecoration: SBBInputDecoration(labelText: 'Custom date format', borderType: borderType),
      dateFormat: DateFormat('dd.MM.yy, H:m'),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Error',
        errorText: 'Error',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Disabled',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateTimeChanged: null,
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Minute interval',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      minuteInterval: 15,
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      minimumDateTime: minimumDateTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date before minimum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateTimeChanged: (_) {},
    ),
    SBBDateTimeInput(
      value: initialDateTime,
      maximumDateTime: maximumDateTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date after maximum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onDateTimeChanged: (_) {},
    ),
  ];
}
