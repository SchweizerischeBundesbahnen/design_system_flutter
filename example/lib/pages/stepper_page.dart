import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  final steps = [
    SBBStepperItem(label: 'Step 1'),
    SBBStepperItem(label: 'Step 2'),
    SBBStepperItem(label: 'Step 3'),
    SBBStepperItem(label: 'Step 4'),
    SBBStepperItem(label: 'Step 5', icon: SBBIcons.tick_small),
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
      padding: EdgeInsetsDirectional.all(24),
      color: red ? SBBColors.red : null,
      child: stepper,
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      child: Row(
        children: [
          Expanded(child: Text('RED')),
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
