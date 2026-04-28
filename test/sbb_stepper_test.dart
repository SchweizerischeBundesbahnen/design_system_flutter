import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(
    String name, {
    required List<SBBStepperItem> numberedSteps,
    required List<SBBStepperItem> textSteps,
    required List<SBBStepperItem> iconSteps,
    required List<SBBStepperItem> customSteps,
    bool isFilled = false,
  }) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = StepperTest(
        numberedSteps: numberedSteps,
        textSteps: textSteps,
        iconSteps: iconSteps,
        customSteps: customSteps,
        isFilled: isFilled,
      );

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        name,
        find.byType(StepperTest),
      );
    });
  }

  final numberedSteps = [
    const SBBStepperItem.numbered(labelText: 'Step 1'),
    const SBBStepperItem.numbered(labelText: 'Step 2'),
    const SBBStepperItem.numbered(labelText: 'Step 3'),
    const SBBStepperItem.numbered(labelText: 'Step 4'),
    const SBBStepperItem.numbered(labelText: 'Step 5'),
  ];
  final textSteps = [
    const SBBStepperItem.text(text: 'A'),
    const SBBStepperItem.text(text: 'BC'),
    const SBBStepperItem.text(text: 'DEF'),
    const SBBStepperItem.text(text: 'GHIJ'),
    const SBBStepperItem.text(text: 'KLMNO'),
  ];
  final iconSteps = [
    const SBBStepperItem.icon(labelText: 'Step 1', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 2', icon: SBBIcons.train_small),
    const SBBStepperItem.icon(labelText: 'Step 3', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 4', icon: SBBIcons.unicorn_small),
  ];
  final customSteps = [
    SBBStepperItem.icon(
      label: SBBChip(trailingText: '1', labelText: 'Label', onChanged: null),
      icon: SBBIcons.unicorn_small,
      badgeIcon: SBBIcons.cross_small,
      style: SBBStepperItemStyle(
        badgeIconColor: SBBColors.black,
        badgeBackgroundColor: SBBColors.warning,
      ),
    ),
    SBBStepperItem.text(
      label: SBBLoadingIndicator.tiny(),
      text: 'Opt.',
      showBadgeWhenPassed: false,
      style: SBBStepperItemStyle(
        backgroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: SBBColors.iron,
          WidgetState.any: SBBColors.cement,
        }),
        borderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.selected: null,
          WidgetState.any: SBBColors.anthracite,
        }),
      ),
    ),
    SBBStepperItem.numbered(label: SBBStatus.information(labelText: 'Custom')),
    SBBStepperItem.icon(
      label: Container(
        padding: .all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange),
        child: Text('Label'),
      ),
      icon: SBBIcons.train_small,
    ),
    SBBStepperItem.numbered(label: SBBStatus.success(labelText: 'Custom')),
  ];

  generateTest(
    'stepper',
    numberedSteps: numberedSteps,
    textSteps: textSteps,
    iconSteps: iconSteps,
    customSteps: customSteps,
  );

  generateTest(
    'stepper_filled',
    numberedSteps: numberedSteps,
    textSteps: textSteps,
    iconSteps: iconSteps,
    customSteps: customSteps,
    isFilled: true,
  );
}

class StepperTest extends StatelessWidget {
  const StepperTest({
    super.key,
    required this.numberedSteps,
    required this.textSteps,
    required this.iconSteps,
    required this.customSteps,
    this.isFilled = false,
  });

  final List<SBBStepperItem> numberedSteps;
  final List<SBBStepperItem> textSteps;
  final List<SBBStepperItem> iconSteps;
  final List<SBBStepperItem> customSteps;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isFilled ? SBBColors.red : null,
      child: Column(
        mainAxisSize: .min,
        children: [
          const SBBListHeader('Numbered'),
          _stepper(numberedSteps, 0),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Icon'),
          _stepper(textSteps, 1),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Text without label'),
          _stepper(iconSteps, 2),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Custom'),
          _stepper(
            customSteps,
            3,
            style: SBBStepperStyle(
              dividerColor: SBBColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  SBBStepper _stepper(List<SBBStepperItem> steps, int activeStep, {SBBStepperStyle? style}) {
    if (isFilled) {
      return SBBStepper.filled(
        steps: steps,
        activeStep: activeStep,
        onStepPressed: (_, _) {},
      );
    }
    return SBBStepper(
      steps: steps,
      activeStep: activeStep,
      onStepPressed: (_, _) {},
    );
  }
}
