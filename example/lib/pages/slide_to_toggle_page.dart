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
  bool useThresholdReachedMode = true;
  bool isStateOff = false;

  Future<void> _simulateWork() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Column(
        mainAxisSize: MainAxisSize.min,
        children: SBBDivider.divideItems(
          context: context,
          items: [
            SBBSwitchListItem(
              value: isEnabled,
              titleText: 'Is enabled',
              onChanged: (value) => setState(() => isEnabled = value),
            ),
            SBBSwitchListItem(
              value: useThresholdReachedMode,
              titleText: 'Use thresholdReached trigger mode',
              onChanged: (value) => setState(() => useThresholdReachedMode = value),
            ),
            SBBSwitchListItem(
              value: isStateOff,
              titleText: 'Toggle state programmatically',
              onChanged: (value) {
                setState(() => isStateOff = value);
                final SBBSlideToToggleState state = isStateOff ? .on : .off;

                defaultTextController.changeTo(state: state);
                defaultIconController.changeTo(state: state);
                smallTextController.changeTo(state: state);
                smallIconController.changeTo(state: state);
              },
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
                  triggerMode: triggerMode,
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
                  triggerMode: triggerMode,
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
                  triggerMode: triggerMode,
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
                  triggerMode: triggerMode,
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

  SBBSlideToToggleTriggerMode get triggerMode => useThresholdReachedMode ? .onThresholdReached : .onTapReleased;
}
