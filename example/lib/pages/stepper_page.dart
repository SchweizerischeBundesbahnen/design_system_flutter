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
    SBBStepperItem(label: 'Step 4', icon: SBBIcons.train_small),
    SBBStepperItem(label: 'Step 5', icon: SBBIcons.tick_small),
  ];
  var activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.all(24),
        child: SBBStepper(
          steps: steps,
          activeStep: activeStep,
          onStepPressed: _onStepPressed,
        ),
      ),
    );
  }

  void _onStepPressed(SBBStepperItem item, int index) {
    setState(() {
      activeStep = index;
    });
  }
}
