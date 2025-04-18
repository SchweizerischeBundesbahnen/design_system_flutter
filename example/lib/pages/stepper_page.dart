import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  final steps = [
    const SBBStepperItem(label: 'Step 1'),
    const SBBStepperItem(label: 'Step 2'),
    const SBBStepperItem(label: 'Step 3'),
    const SBBStepperItem(label: 'Step 4'),
    const SBBStepperItem(label: 'Step 5', icon: SBBIcons.tick_small),
  ];
  var activeStep = 0;
  var red = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _stepper(context),
      bottomNavigationBar: _footer(context),
    );
  }

  Widget _stepper(BuildContext context) {
    late final Widget stepper;
    if (red) {
      stepper = SBBStepper.red(
        steps: steps,
        activeStep: activeStep,
        onStepPressed: _onStepPressed,
      );
    } else {
      stepper = SBBStepper(
        steps: steps,
        activeStep: activeStep,
        onStepPressed: _onStepPressed,
      );
    }
    return Container(
      padding: const EdgeInsetsDirectional.all(24),
      color: red ? SBBColors.red : null,
      child: stepper,
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      child: Row(
        children: [
          const Expanded(child: Text('RED')),
          SBBSwitch(
            value: red,
            onChanged: (value) => setState(() => red = value),
          ),
        ],
      ),
    );
  }

  void _onStepPressed(SBBStepperItem item, int index) {
    setState(() {
      activeStep = index;
    });
  }
}
