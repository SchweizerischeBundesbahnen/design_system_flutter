import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SlideToTogglePage extends StatefulWidget {
  const SlideToTogglePage({super.key});

  @override
  State<SlideToTogglePage> createState() => _SlideToTogglePageState();
}

class _SlideToTogglePageState extends State<SlideToTogglePage> {
  bool isEnabled = true;
  bool useThresholdReachedMode = true;
  bool isStateOff = false;

  SBBSlideToToggleState defaultValue = .off;
  bool defaultIsLoading = false;

  SBBSlideToToggleState defaultIconValue = .off;
  bool defaultIconIsLoading = false;

  SBBSlideToToggleState smallTextValue = .off;
  bool smallTextIsLoading = false;

  SBBSlideToToggleState smallIconValue = .off;
  bool smallIconIsLoading = false;

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
                final SBBSlideToToggleState newState = isStateOff ? .on : .off;

                defaultValue = newState;
                defaultIconValue = newState;
                smallTextValue = newState;
                smallIconValue = newState;
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
                  value: defaultValue,
                  onChanged: isEnabled
                      ? (state) {
                          setState(() => defaultValue = state);
                          _simulateWorkWithLoadingChange(isLoadingUpdate: (value) => defaultIsLoading = value);
                        }
                      : null,
                  triggerMode: triggerMode,
                  isLoading: defaultIsLoading,
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
                  value: defaultIconValue,
                  onChanged: isEnabled
                      ? (state) {
                          setState(() => defaultIconValue = state);
                          _simulateWorkWithLoadingChange(isLoadingUpdate: (value) => defaultIconIsLoading = value);
                        }
                      : null,
                  triggerMode: triggerMode,
                  isLoading: defaultIconIsLoading,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleIconData: SBBIcons.arrow_left_small,
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
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
                  value: smallTextValue,
                  onChanged: isEnabled
                      ? (state) {
                          setState(() => smallTextValue = state);
                          _simulateWorkWithLoadingChange(isLoadingUpdate: (value) => smallTextIsLoading = value);
                        }
                      : null,
                  triggerMode: triggerMode,
                  isLoading: smallTextIsLoading,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabelText: 'Stop',
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
                    toggleLabelText: 'Start',
                    helpLabelText: 'Drag to the right to start',
                  ),
                ),
                SBBSlideToToggleSmall(
                  value: smallIconValue,
                  onChanged: isEnabled
                      ? (state) {
                          setState(() => smallIconValue = state);
                          _simulateWorkWithLoadingChange(isLoadingUpdate: (value) => smallIconIsLoading = value);
                        }
                      : null,
                  triggerMode: triggerMode,
                  isLoading: smallIconIsLoading,
                  onToggleDecoration: SBBSlideToggleDecoration(
                    toggleIconData: SBBIcons.arrow_left_small,
                    helpLabelText: 'Drag to the left to stop',
                  ),
                  offToggleDecoration: SBBSlideToggleDecoration(
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

  Future<void> _simulateWorkWithLoadingChange({required void Function(bool value) isLoadingUpdate}) async {
    setState(() => isLoadingUpdate.call(true));
    await _simulateWork();
    if (mounted) {
      setState(() => isLoadingUpdate.call(false));
    }
  }

  SBBSlideToToggleTriggerMode get triggerMode => useThresholdReachedMode ? .onThresholdReached : .onTapReleased;
}
