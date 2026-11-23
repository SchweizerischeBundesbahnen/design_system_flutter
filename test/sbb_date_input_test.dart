import 'package:material_ui/material_ui.dart';
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
            children: SBBDivider.divideItems(
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

List<Widget> _dateInputItems({required SBBDecorationBorderType borderType}) {
  final initialDate = DateTime(2024, 07, 03);
  final minimumDate = DateTime(2024, 08, 01);
  final maximumDate = DateTime(2024, 07, 01);
  return [
    SBBDateInput(
      onDateChanged: (_) {},
      triggerDecoration: SBBDecoration(style: SBBDecorationStyle(borderType: borderType)),
    ),
    SBBDateInput(
      value: initialDate,
      onDateChanged: (_) {},
      triggerDecoration: SBBDecoration(style: SBBDecorationStyle(borderType: borderType)),
    ),
    SBBDateInput(
      triggerDecoration: SBBDecoration(
        placeholderText: 'Hint only',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      triggerDecoration: SBBDecoration(
        labelText: 'Label and Hint',
        placeholderText: 'Label and Hint',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Label and Value',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Custom date format',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      dateFormat: DateFormat('dd.MM.yy'),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Error',
        errorText: 'Error',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Disabled',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: null,
    ),
    SBBDateInput(
      value: initialDate,
      minimumDate: minimumDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Initial date before minimum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
    SBBDateInput(
      value: initialDate,
      maximumDate: maximumDate,
      triggerDecoration: SBBDecoration(
        labelText: 'Initial date after maximum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onDateChanged: (_) {},
    ),
  ];
}
