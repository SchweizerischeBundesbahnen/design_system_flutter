import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  var activeNumericStep = 0;
  var activeNumericStepFilled = 0;

  var activeIconStep = 1;
  var activeIconStepFilled = 1;

  var activeTextStep = 2;
  var activeTextStepFilled = 2;

  var activeCustomStep = 3;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(SBBSpacing.medium),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Default'),
        _defaultSteppers(),
        const SBBListHeader('Filled'),
        _filledSteppers(context),
      ],
    );
  }

  Widget _filledSteppers(BuildContext context) {
    return SBBContentBox(
      color: SBBBaseStyle.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBStepper.filled(
            steps: _numberedSteps,
            activeStep: activeNumericStepFilled,
            onStepPressed: (_, i) {
              setState(() => activeNumericStepFilled = i);
            },
          ),
          SBBStepper.filled(
            steps: _iconSteps,
            activeStep: activeIconStepFilled,
            onStepPressed: (_, i) {
              setState(() => activeIconStepFilled = i);
            },
          ),
          SBBStepper.filled(
            steps: _textStepsWithoutLabel,
            activeStep: activeTextStepFilled,
            onStepPressed: (_, i) {
              setState(() => activeTextStepFilled = i);
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
            steps: _numberedSteps,
            activeStep: activeNumericStep,
            onStepPressed: (_, i) {
              setState(() => activeNumericStep = i);
            },
          ),
          SBBStepper(
            steps: _iconSteps,
            activeStep: activeIconStep,
            onStepPressed: (_, i) {
              setState(() => activeIconStep = i);
            },
          ),
          SBBStepper(
            steps: _textStepsWithoutLabel,
            activeStep: activeTextStep,
            onStepPressed: (_, i) {
              setState(() => activeTextStep = i);
            },
          ),
          SBBStepper(
            style: SBBStepperStyle(
              dividerColor: SBBColors.orange,
            ),
            steps: _customSteps,
            activeStep: activeCustomStep,
            onStepPressed: (_, i) {
              setState(() => activeCustomStep = i);
            },
          ),
        ],
      ),
    );
  }

  List<SBBStepperItem> get _textStepsWithoutLabel => [
    const SBBStepperItem.text(text: 'A'),
    const SBBStepperItem.text(text: 'BC'),
    const SBBStepperItem.text(text: 'DEF'),
    const SBBStepperItem.text(text: 'GHIJ'),
    const SBBStepperItem.text(text: 'KLMNO'),
  ];

  List<SBBStepperItem> get _customSteps => [
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

  List<SBBStepperItem> get _iconSteps => [
    const SBBStepperItem.icon(labelText: 'Step 1', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 2', icon: SBBIcons.train_small),
    const SBBStepperItem.icon(labelText: 'Step 3', icon: SBBIcons.unicorn_small),
    const SBBStepperItem.icon(labelText: 'Step 4', icon: SBBIcons.unicorn_small),
  ];

  List<SBBStepperItem> get _numberedSteps => [
    const SBBStepperItem.numbered(labelText: 'Step 1'),
    const SBBStepperItem.numbered(labelText: 'Step 2'),
    const SBBStepperItem.numbered(labelText: 'Step 3'),
    const SBBStepperItem.numbered(labelText: 'Step 4'),
    const SBBStepperItem.numbered(labelText: 'Step 5'),
  ];
}
