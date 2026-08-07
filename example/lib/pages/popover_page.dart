import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class PopoverPage extends StatefulWidget {
  const PopoverPage({super.key});

  @override
  State<PopoverPage> createState() => _PopoverPageState();
}

class _PopoverPageState extends State<PopoverPage> {
  // The center popover is driven through a controller, the edge popovers
  // through the showPopover / hidePopover builder callbacks — demonstrating
  // both ways of controlling an SBBPopover.
  final SBBPopoverController _centerPopoverController = SBBPopoverController();

  SBBPopoverDirection _preferredDirection = SBBPopoverDirection.bottom;
  bool _notch = true;
  bool _alignNotchToTarget = true;
  String _popoverContentText = 'This is a transient popover view.';

  List<SBBDropdownItem<SBBPopoverDirection>> get _directionItems => SBBPopoverDirection.values.map((dir) {
    final label = dir.name.substring(0, 1).toUpperCase() + dir.name.substring(1);
    return SBBDropdownItem(value: dir, label: label);
  }).toList();

  @override
  void dispose() {
    _centerPopoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: _componentConfig(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SBBListHeader('Standard Placement'),
          _standardPlacement(context),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Edge Collision (Shift)'),
          _edgePlacement(context),
        ],
      ),
    );
  }

  Widget _componentConfig(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: SBBDivider.divideItems(
        context: context,
        items: [
          SBBDropdown<SBBPopoverDirection>(
            triggerDecoration: const SBBInputDecoration(labelText: 'Preferred Direction'),
            selectedItem: _preferredDirection,
            items: _directionItems,
            onChanged: (value) {
              if (value != null) {
                setState(() => _preferredDirection = value);
              }
            },
          ),
          SBBSwitchListItem(
            titleText: 'Notch',
            value: _notch,
            onChanged: (value) => setState(() => _notch = value),
          ),
          SBBSwitchListItem(
            titleText: 'Align Notch To Target',
            value: _alignNotchToTarget,
            onChanged: _notch ? (value) => setState(() => _alignNotchToTarget = value) : null,
          ),
          SBBTextInput(
            decoration: const SBBInputDecoration(
              labelText: 'Popover Content',
            ),
            autofocus: false,
            controller: TextEditingController.fromValue(TextEditingValue(text: _popoverContentText)),
            onChanged: (value) => setState(() => _popoverContentText = value),
          ),
        ],
      ),
    );
  }

  Widget _standardPlacement(BuildContext context) {
    return SBBContentBox(
      child: Padding(
        padding: const EdgeInsets.all(SBBSpacing.medium),
        child: Center(
          child: SBBPopover(
            controller: _centerPopoverController,
            preferredDirection: _preferredDirection,
            showNotch: _notch,
            alignNotchToTarget: _alignNotchToTarget,
            offset: Offset(0, 8),
            targetBuilder: (context, showPopover) => SBBSecondaryButton(
              labelText: 'Open Center Popover',
              onPressed: _centerPopoverController.show,
            ),
            builder: (context, hidePopover) => Padding(
              padding: const EdgeInsets.all(SBBSpacing.medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_popoverContentText, style: SBBTextStyles.mediumLight),
                  const SizedBox(height: SBBSpacing.small),
                  SBBTertiaryButtonSmall(
                    iconData: SBBIcons.cross_small,
                    onPressed: _centerPopoverController.hide,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _edgePlacement(BuildContext context) {
    return SBBContentBox(
      child: Padding(
        padding: const EdgeInsets.all(SBBSpacing.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SBBPopover(
              preferredDirection: _preferredDirection,
              showNotch: _notch,
              alignNotchToTarget: _alignNotchToTarget,
              targetBuilder: (context, showPopover) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_left_small,
                onPressed: showPopover,
              ),
              builder: (context, _) => Padding(
                padding: const EdgeInsets.all(SBBSpacing.medium),
                child: Text(
                  'Left edge layout shift',
                  style: SBBTextStyles.mediumLight,
                ),
              ),
            ),
            SBBPopover(
              preferredDirection: _preferredDirection,
              showNotch: _notch,
              alignNotchToTarget: _alignNotchToTarget,
              targetBuilder: (context, showPopover) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_right_small,
                onPressed: showPopover,
              ),
              builder: (context, _) => Padding(
                padding: const EdgeInsets.all(SBBSpacing.medium),
                child: Text(
                  'Right edge layout shift',
                  style: SBBTextStyles.mediumLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
