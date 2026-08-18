import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('stepperItem_whenSearchedForByKeyAndTapped_isFoundAndSelectsTheStep', (tester) async {
    await tester.pumpWidget(const TestApp(child: _DemoStepper()));
    await tester.pumpAndSettle();

    expect(find.text('Step 0'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('step-2')));
    await tester.pumpAndSettle();

    expect(find.text('Step 2'), findsOneWidget);
  });
}

class _DemoStepper extends StatefulWidget {
  const _DemoStepper();

  @override
  State<_DemoStepper> createState() => _DemoStepperState();
}

class _DemoStepperState extends State<_DemoStepper> {
  var _activeStep = 0;

  @override
  Widget build(BuildContext context) {
    final steps = [
      for (var i = 0; i < 4; i++) SBBStepperItem.numbered(key: ValueKey('step-$i')),
    ];

    return Column(
      children: [
        SBBStepper(
          steps: steps,
          activeStep: _activeStep,
          onStepPressed: (_, index) => setState(() => _activeStep = index),
        ),
        Text('Step $_activeStep'),
      ],
    );
  }
}
