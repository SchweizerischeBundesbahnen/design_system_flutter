import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SlideToTogglePage extends StatefulWidget {
  const SlideToTogglePage({super.key});

  @override
  State<SlideToTogglePage> createState() => _SlideToTogglePageState();
}

class _SlideToTogglePageState extends State<SlideToTogglePage> {
  bool _isEnabled = true;

  Future<void> _simulateWork() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: SBBSegmentedButton(
          segments: [
            SBBButtonSegment(value: true, labelText: 'All enabled'),
            SBBButtonSegment(value: false, labelText: 'All Disabled'),
          ],
          selected: _isEnabled,
          onSelectionChanged: (update) => setState(() => _isEnabled = update),
        ),
      ),
      body: Column(
        children: [
          const SBBListHeader('Default'),
          Padding(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.small,
              children: [
                SBBSlideToToggle(
                  enabled: _isEnabled,
                  onActivate: _simulateWork,
                  onDeactivate: _simulateWork,
                  toggleOnLabelText: 'Stop',
                  toggleOffLabelText: 'Start',
                  offHelpText: 'Drag to the right to start',
                  onHelpText: 'Drag to the left to stop',
                ),
                SBBSlideToToggle(
                  enabled: _isEnabled,
                  onActivate: _simulateWork,
                  onDeactivate: _simulateWork,
                  toggleOffIcon: SBBIcons.arrow_right_small,
                  toggleOnIcon: SBBIcons.arrow_left_small,
                  offHelpText: 'Drag to the right to start',
                  onHelpText: 'Drag to the left to stop',
                ),
                SBBSlideToToggle(
                  enabled: _isEnabled,
                  onActivate: _simulateWork,
                  onDeactivate: _simulateWork,
                  toggleOnContent: Container(color: SBBColors.cloud, child: Text('Stop')),
                  toggleOffContent: Container(color: SBBColors.cloud, child: Text('Start')),
                  offHelpWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(SBBIcons.unicorn_small),
                      Text('Check this out'),
                    ],
                  ),
                  onHelpWidget: Container(
                    color: SBBColors.green,
                    child: Text('Test'),
                  ),
                ),
              ],
            ),
          ),

          const SBBListHeader('Small'),
        ],
      ),
    );
  }
}
