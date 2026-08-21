import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';
import 'widget_tester_extensions.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'setSBBSliderValue_whenDivisionsSet_thenOnChangedAndOnChangeEndReportExactTarget',
    (tester) async {
      await tester.pumpWidget(
        const TestApp(
          child: _DemoSlider(initialValue: 20, min: 0, max: 100, divisions: 10),
        ),
      );
      await tester.pumpAndSettle();

      await tester.setSBBSliderValue(find.byType(SBBSlider), 70);

      expect(find.text('value: 70.00'), findsOneWidget);
      expect(find.text('changeEnd: 70.00'), findsOneWidget);
    },
  );

  testWidgets(
    'setSBBSliderValue_whenContinuousAndTargetBelowValue_thenValueEndsOnStepClosestToTarget',
    (tester) async {
      await tester.pumpWidget(const TestApp(child: _DemoSlider(initialValue: 0.8)));
      await tester.pumpAndSettle();

      await tester.setSBBSliderValue(find.byType(SBBSlider), 0.3);

      // 0.3 lies on the semantic step grid from 0.8 for both the 10% (iOS)
      // and 5% (Android) continuous step sizes.
      expect(find.text('value: 0.30'), findsOneWidget);
      expect(find.text('changeEnd: 0.30'), findsOneWidget);
    },
  );

  testWidgets(
    'setSBBSliderValue_whenTargetAboveMax_thenValueIsClampedToMax',
    (tester) async {
      await tester.pumpWidget(const TestApp(child: _DemoSlider(initialValue: 0.5)));
      await tester.pumpAndSettle();

      await tester.setSBBSliderValue(find.byType(SBBSlider), 2.0);

      expect(find.text('value: 1.00'), findsOneWidget);
      expect(find.text('changeEnd: 1.00'), findsOneWidget);
    },
  );

  testWidgets(
    'setSBBSliderValue_whenMultipleConcurrentInstances_thenOnlyTargetedInstanceChanges',
    (tester) async {
      await tester.pumpWidget(
        const TestApp(
          child: Column(
            children: [
              _DemoSlider(sliderKey: ValueKey('first'), initialValue: 20, min: 0, max: 100, divisions: 10),
              _DemoSlider(sliderKey: ValueKey('second'), initialValue: 20, min: 0, max: 100, divisions: 10),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.setSBBSliderValue(find.byKey(const ValueKey('second')), 90);

      expect(find.text('value: 20.00'), findsOneWidget);
      expect(find.text('value: 90.00'), findsOneWidget);
    },
  );
}

class _DemoSlider extends StatefulWidget {
  const _DemoSlider({this.sliderKey, required this.initialValue, this.min = 0.0, this.max = 1.0, this.divisions});

  final Key? sliderKey;
  final double initialValue;
  final double min;
  final double max;
  final int? divisions;

  @override
  State<_DemoSlider> createState() => _DemoSliderState();
}

class _DemoSliderState extends State<_DemoSlider> {
  late double _value = widget.initialValue;
  double? _changeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SBBSlider(
          key: widget.sliderKey,
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          onChanged: (value) => setState(() => _value = value),
          onChangeEnd: (value) => setState(() => _changeEnd = value),
        ),
        Text('value: ${_value.toStringAsFixed(2)}'),
        Text('changeEnd: ${_changeEnd == null ? 'none' : _changeEnd!.toStringAsFixed(2)}'),
      ],
    );
  }
}
