import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('time_input', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return Column(
          mainAxisSize: .min,
          children: _timeInputItems(borderType: .standalone),
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
            children: SBBDivider.divideItems(
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

List<Widget> _timeInputItems({required SBBDecorationBorderType borderType}) {
  const initialTime = TimeOfDay(hour: 12, minute: 33);
  const minimumTime = TimeOfDay(hour: 16, minute: 12);
  const maximumTime = TimeOfDay(hour: 08, minute: 43);
  return [
    SBBTimeInput(
      onTimeChanged: (_) {},
      triggerDecoration: SBBDecoration(style: SBBDecorationStyle(borderType: borderType)),
    ),
    SBBTimeInput(
      value: initialTime,
      onTimeChanged: (_) {},
      triggerDecoration: SBBDecoration(style: SBBDecorationStyle(borderType: borderType)),
    ),
    SBBTimeInput(
      triggerDecoration: SBBDecoration(
        placeholderText: 'Hint only',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      triggerDecoration: SBBDecoration(
        labelText: 'Label and Hint',
        placeholderText: 'Label and Hint',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Label and Value',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Custom date format',
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Error',
        errorText: 'Error',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Disabled',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: null,
    ),
    SBBTimeInput(
      value: initialTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Minute interval',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      minuteInterval: 15,
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      minimumTime: minimumTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Initial date before minimum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
    SBBTimeInput(
      value: initialTime,
      maximumTime: maximumTime,
      triggerDecoration: SBBDecoration(
        labelText: 'Initial date after maximum date',
        leadingIconData: SBBIcons.calendar_small,
        trailingIconData: SBBIcons.arrow_circle_reset_small,
        style: SBBDecorationStyle(borderType: borderType),
      ),
      onTimeChanged: (_) {},
    ),
  ];
}
