import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  final numericSteps = [
    const SBBStepperItem.numbered(labelText: 'StepItem 1'),
    const SBBStepperItem.numbered(labelText: 'StepItem 2'),
    const SBBStepperItem.numbered(labelText: 'StepItem 3'),
    const SBBStepperItem.numbered(labelText: 'StepItem 4'),
    const SBBStepperItem.numbered(labelText: 'StepItem 5'),
  ];
  var activeNumericStep = 0;
  var activeNumericStepColored = 0;

  final iconSteps = [
    const SBBStepperItem.icon(labelText: 'Step 1', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 2', icon: SBBIcons.train_small),
    const SBBStepperItem.icon(labelText: 'Step 3', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 4', icon: SBBIcons.unicorn_small),
  ];
  var activeIconStep = 1;
  var activeIconStepColored = 1;

  final withoutLabelSteps = [
    const SBBStepperItem.text(text: 'A'),
    const SBBStepperItem.text(text: 'BC'),
    const SBBStepperItem.text(text: 'DEF'),
    const SBBStepperItem.text(text: 'GHIJ'),
    const SBBStepperItem.text(text: 'KLMNO'),
  ];
  var withoutLabelStep = 2;
  var withoutLabelStepColored = 2;

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
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange),
        child: Text('Label'),
      ),
      icon: SBBIcons.train_small,
    ),
    SBBStepperItem.numbered(label: SBBStatus.success(labelText: 'Custom')),
  ];
  var customStep = 3;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(SBBSpacing.medium),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Default'),
        _defaultSteppers(),
        const SBBListHeader('Colored'),
        _coloredSteppers(context),
      ],
    );
  }

  Widget _coloredSteppers(BuildContext context) {
    return SBBContentBox(
      color: SBBBaseStyle.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBStepper.colored(
            steps: numericSteps,
            activeStep: activeNumericStepColored,
            onStepPressed: (_, i) {
              setState(() => activeNumericStepColored = i);
            },
          ),
          SBBStepper.colored(
            steps: iconSteps,
            activeStep: activeIconStepColored,
            onStepPressed: (_, i) {
              setState(() => activeIconStepColored = i);
            },
          ),
          SBBStepper.colored(
            steps: withoutLabelSteps,
            activeStep: withoutLabelStepColored,
            onStepPressed: (_, i) {
              setState(() => withoutLabelStepColored = i);
            },
          ),
        ],
      ),
    );
  }

  Widget _defaultSteppers() {
    return SBBContentBox(
      padding: const EdgeInsets.symmetric(vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBStepper(
            steps: numericSteps,
            activeStep: activeNumericStep,
            onStepPressed: (_, i) {
              setState(() => activeNumericStep = i);
            },
          ),
          SBBStepper(
            steps: iconSteps,
            activeStep: activeIconStep,
            onStepPressed: (_, i) {
              setState(() => activeIconStep = i);
            },
          ),
          SBBStepper(
            steps: withoutLabelSteps,
            activeStep: withoutLabelStep,
            onStepPressed: (_, i) {
              setState(() => withoutLabelStep = i);
            },
          ),
          SBBStepper(
            style: SBBStepperStyle(
              dividerColor: SBBColors.orange,
            ),
            steps: customSteps,
            activeStep: customStep,
            onStepPressed: (_, i) {
              setState(() => customStep = i);
            },
          ),
        ],
      ),
    );
  }
}
