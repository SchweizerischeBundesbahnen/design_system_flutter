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
    const SBBStepperItem(label: 'Step 1'),
    const SBBStepperItem(label: 'Step 2'),
    const SBBStepperItem(label: 'Step 3'),
    const SBBStepperItem(label: 'Step 4'),
    const SBBStepperItem(label: 'Step 5'),
  ];
  var activeNumericStep = 0;
  var activeNumericStepRed = 0;

  // TODO: Padding does not look good with other icons
  final iconSteps = [
    const SBBStepperItem(label: 'Step 1', icon: SBBIcons.unicorn_small),
    const SBBStepperItem(label: 'Step 2', icon: SBBIcons.unicorn_small),
    const SBBStepperItem(label: 'Step 3', icon: SBBIcons.unicorn_small),
    const SBBStepperItem(label: 'Step 4', icon: SBBIcons.unicorn_small),
    const SBBStepperItem(label: 'Step 5', icon: SBBIcons.unicorn_small),
  ];
  var activeIconStep = 0;
  var activeIconStepRed = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            spacing: sbbDefaultSpacing,
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
            ],
          ),
        ),
        const SBBListHeader('Colored'),
        SBBGroup(
          color: SBBBaseStyle.of(context).primaryColor,
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            spacing: sbbDefaultSpacing,
            children: [
              SBBStepper.colored(
                steps: numericSteps,
                activeStep: activeNumericStepRed,
                onStepPressed: (_, i) {
                  setState(() => activeNumericStepRed = i);
                },
              ),
              SBBStepper.colored(
                steps: iconSteps,
                activeStep: activeIconStepRed,
                onStepPressed: (_, i) {
                  setState(() => activeIconStepRed = i);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
