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
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabelText: 'Stop',
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabelText: 'Start',
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
                SBBSlideToToggle(
                  enabled: _isEnabled,
                  onActivate: _simulateWork,
                  onDeactivate: _simulateWork,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleIconData: SBBIcons.arrow_left_small,
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    toggleIconData: SBBIcons.arrow_right_small,
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
                SBBSlideToToggle(
                  enabled: _isEnabled,
                  onActivate: _simulateWork,
                  onDeactivate: _simulateWork,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabel: Container(color: SBBColors.green, child: Text('Stop')),
                    helpLabel: Container(
                      color: SBBColors.green,
                      child: Text('Test'),
                    ),
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabel: Container(color: SBBColors.green, child: Text('Start')),
                    helpLabel: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(SBBIcons.unicorn_small),
                        Text('Check this out'),
                      ],
                    ),
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
