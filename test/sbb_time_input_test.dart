import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('time_input', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: _timeInputItems(borderType: .standalone),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'time_input',
      find.byType(Column).first,
    );
  });

  testWidgets('time_input_listed', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return SBBContentBox(
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: _timeInputItems(borderType: .boxedOrListed),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'time_input_listed',
      find.byType(Column).first,
    );
  });
}

List<Widget> _timeInputItems({required SBBInputBorderType borderType}) {
  const initialTime = TimeOfDay(hour: 12, minute: 33);
  const minimumTime = TimeOfDay(hour: 16, minute: 12);
  const maximumTime = TimeOfDay(hour: 08, minute: 43);
  return [
    SBBTimeInput(
      onTimeChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBTimeInput(
      value: initialTime,
      onTimeChanged: (_) {},
      triggerDecoration: SBBInputDecoration(borderType: borderType),
    ),
    SBBTimeInput(
      triggerDecoration: SBBInputDecoration(placeholderText: 'Hint only', borderType: borderType),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      triggerDecoration: SBBInputDecoration(
        labelText: 'Label and Hint',
        placeholderText: 'Label and Hint',
        borderType: borderType,
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBInputDecoration(labelText: 'Label and Value', borderType: borderType),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBInputDecoration(labelText: 'Custom date format', borderType: borderType),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Error',
        errorText: 'Error',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Disabled',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onTimeChanged: null,
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Minute interval',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      minuteInterval: 15,
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      minimumTime: minimumTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date before minimum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      maximumTime: maximumTime,
      triggerDecoration: SBBInputDecoration(
        labelText: 'Initial date after maximum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        borderType: borderType,
      ),
      onTimeChanged: (_) {},
    ),
  ];
}
