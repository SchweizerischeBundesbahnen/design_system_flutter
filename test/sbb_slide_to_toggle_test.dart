import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, Widget widget) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(SlideToToggleTest),
      );
    });
  }

  generateTest(
    'slide_to_toggle_off',
    const SlideToToggleTest(initialState: .off),
  );

  generateTest(
    'slide_to_toggle_on',
    const SlideToToggleTest(initialState: .on),
  );

  generateTest(
    'slide_to_toggle_small_off',
    const SlideToToggleTest(initialState: .off, isSmall: true),
  );

  generateTest(
    'slide_to_toggle_small_on',
    const SlideToToggleTest(initialState: .on, isSmall: true),
  );
}

class SlideToToggleTest extends StatelessWidget {
  const SlideToToggleTest({
    super.key,
    required this.initialState,
    this.isSmall = false,
  });

  final SBBSlideToToggleState initialState;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final listHeaderTitle = isSmall ? 'SBBSlideToToggleSmall' : 'SBBSlideToToggle';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _slideToToggleVariants(title: listHeaderTitle, enabled: true),
        _slideToToggleVariants(title: '$listHeaderTitle Disabled', enabled: false),
      ],
    );
  }

  Column _slideToToggleVariants({required String title, required bool enabled}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: SBBSpacing.xSmall,
      children: [
        SBBListHeader(title),
        // Slide-To-Toggle with toggle icon
        _slideToToggle(
          enabled: enabled,
          onDecoration: SBBSlideToggleDecoration(
            toggleIconData: SBBIcons.arrow_right_small,
            helpLabelText: 'Drag to the left to start',
          ),
          offDecoration: SBBSlideToggleDecoration(
            toggleIconData: SBBIcons.arrow_left_small,
            helpLabelText: 'Drag to the right to stop',
          ),
        ),
        // Slide-To-Toggle with toggle text
        _slideToToggle(
          enabled: enabled,
          onDecoration: SBBSlideToggleDecoration(
            toggleLabelText: 'Start',
            helpLabelText: 'Drag to the left to start. This is also a very l${"o" * 300}ng text.',
          ),
          offDecoration: SBBSlideToggleDecoration(
            toggleLabelText: 'Stop',
            helpLabelText: 'Drag to the right to stop',
          ),
        ),
        // Slide-To-Toggle with custom widgets
        _slideToToggle(
          enabled: enabled,
          onDecoration: SBBSlideToggleDecoration(
            toggleLabel: Container(
              color: SBBColors.turquoise,
              child: Icon(SBBIcons.unicorn_small),
            ),
            helpLabel: Row(
              mainAxisSize: .min,
              children: [Icon(SBBIcons.unicorn_small), Text('This is a custom help text for starting.')],
            ),
          ),
          offDecoration: SBBSlideToggleDecoration(
            toggleLabel: Container(
              color: SBBColors.turquoise,
              child: Icon(SBBIcons.unicorn_small),
            ),
            helpLabel: Row(
              mainAxisSize: .min,
              children: [Icon(SBBIcons.unicorn_small), Text('This is a custom help text for stopping.')],
            ),
          ),
        ),
      ],
    );
  }

  Widget _slideToToggle({
    required bool enabled,
    required SBBSlideToggleDecoration onDecoration,
    required SBBSlideToggleDecoration offDecoration,
  }) {
    return isSmall
        ? SBBSlideToToggleSmall(
            value: initialState,
            onChanged: enabled ? (_) {} : null,
            onToggleDecoration: onDecoration,
            offToggleDecoration: offDecoration,
          )
        : SBBSlideToToggle(
            value: initialState,
            onChanged: enabled ? (_) {} : null,
            onToggleDecoration: onDecoration,
            offToggleDecoration: offDecoration,
          );
  }
}
