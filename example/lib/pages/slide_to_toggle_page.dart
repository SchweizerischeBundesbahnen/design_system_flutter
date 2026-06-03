import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SlideToTogglePage extends StatefulWidget {
  const SlideToTogglePage({super.key});

  @override
  State<SlideToTogglePage> createState() => _SlideToTogglePageState();
}

class _SlideToTogglePageState extends State<SlideToTogglePage> {
  final defaultTextController = SBBSlideToToggleController();
  final defaultIconController = SBBSlideToToggleController();
  final smallTextController = SBBSlideToToggleController();
  final smallIconController = SBBSlideToToggleController();

  bool isEnabled = true;

  Future<void> _simulateWork() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: Column(
          mainAxisSize: .min,
          children: [
            SBBSegmentedButton(
              segments: [
                SBBButtonSegment(value: true, labelText: 'All enabled'),
                SBBButtonSegment(value: false, labelText: 'All Disabled'),
              ],
              selected: isEnabled,
              onSelectionChanged: (update) => setState(() => isEnabled = update),
            ),
            const SBBListHeader('Controller'),
            Row(
              spacing: SBBSpacing.xSmall,
              children: [
                SBBTertiaryButtonSmall(
                  labelText: 'Change to On',
                  onPressed: () {
                    defaultTextController.changeTo(state: .on);
                    defaultIconController.changeTo(state: .on);
                    smallTextController.changeTo(state: .on);
                    smallIconController.changeTo(state: .on);
                  },
                ),
                SBBTertiaryButtonSmall(
                  labelText: 'Change to Off',
                  onPressed: () {
                    defaultTextController.changeTo(state: .off);
                    defaultIconController.changeTo(state: .off);
                    smallTextController.changeTo(state: .off);
                    smallIconController.changeTo(state: .off);
                  },
                ),
              ],
            ),
          ],
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
                  enabled: isEnabled,
                  controller: defaultTextController,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleLabelText: 'Stop',
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleLabelText: 'Start',
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
                SBBSlideToToggle(
                  enabled: isEnabled,
                  controller: defaultIconController,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleIconData: SBBIcons.arrow_left_small,
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleIconData: SBBIcons.arrow_right_small,
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
              ],
            ),
          ),

          const SBBListHeader('Small'),
          Padding(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.small,
              children: [
                SBBSlideToToggleSmall(
                  enabled: isEnabled,
                  controller: smallTextController,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleLabelText: 'Stop',
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleLabelText: 'Start',
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
                SBBSlideToToggleSmall(
                  enabled: isEnabled,
                  controller: smallIconController,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleIconData: SBBIcons.arrow_left_small,
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    onToggle: _simulateWork,
                    toggleIconData: SBBIcons.arrow_right_small,
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
