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

  SBBPopoverPlacement _placement = SBBPopoverPlacement.bottom;
  bool _notch = true;
  bool _alignNotchToTarget = true;
  bool _showCloseButton = true;
  String _popoverContentText = 'This is a transient popover view.';

  static const Map<String, SBBPopoverPlacement> _placements = {
    'Top': SBBPopoverPlacement.top,
    'Top Start': SBBPopoverPlacement.topStart,
    'Top End': SBBPopoverPlacement.topEnd,
    'Bottom': SBBPopoverPlacement.bottom,
    'Bottom Start': SBBPopoverPlacement.bottomStart,
    'Bottom End': SBBPopoverPlacement.bottomEnd,
    'Left': SBBPopoverPlacement.left,
    'Left Start': SBBPopoverPlacement.leftStart,
    'Left End': SBBPopoverPlacement.leftEnd,
    'Right': SBBPopoverPlacement.right,
    'Right Start': SBBPopoverPlacement.rightStart,
    'Right End': SBBPopoverPlacement.rightEnd,
  };

  List<SBBDropdownItem<SBBPopoverPlacement>> get _placementItems =>
      _placements.entries.map((entry) => SBBDropdownItem(value: entry.value, label: entry.key)).toList();

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
          SBBDropdown<SBBPopoverPlacement>(
            triggerDecoration: const SBBInputDecoration(labelText: 'Preferred Placement'),
            selectedItem: _placement,
            items: _placementItems,
            onChanged: (value) {
              if (value != null) {
                setState(() => _placement = value);
              }
            },
          ),
          SBBSwitchListItem(
            titleText: 'Show Notch',
            value: _notch,
            onChanged: (value) => setState(() => _notch = value),
          ),
          SBBSwitchListItem(
            titleText: 'Align Notch To Target',
            value: _alignNotchToTarget,
            onChanged: _notch ? (value) => setState(() => _alignNotchToTarget = value) : null,
          ),
          SBBSwitchListItem(
            titleText: 'Show Close Button',
            value: _showCloseButton,
            onChanged: (value) => setState(() => _showCloseButton = value),
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
            placement: _placement,
            showNotch: _notch,
            alignNotchToTarget: _alignNotchToTarget,
            showCloseButton: _showCloseButton,
            titleText: 'Popover Title',
            leadingIconData: SBBIcons.circle_information_small,
            offset: const Offset(0, 8),
            targetBuilder: (context, showPopover) => SBBSecondaryButton(
              labelText: 'Open Center Popover',
              onPressed: _centerPopoverController.show,
            ),
            builder: (context, hidePopover) => SBBTextInput(),
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
              placement: _placement,
              showNotch: _notch,
              alignNotchToTarget: _alignNotchToTarget,
              showCloseButton: _showCloseButton,
              targetBuilder: (context, showPopover) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_left_small,
                onPressed: showPopover,
              ),
              builder: (context, _) => Text(
                'Left edge layout shift',
                style: SBBTextStyles.mediumLight,
              ),
            ),
            SBBPopover(
              placement: _placement,
              showNotch: _notch,
              alignNotchToTarget: _alignNotchToTarget,
              showCloseButton: _showCloseButton,
              targetBuilder: (context, showPopover) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_right_small,
                onPressed: showPopover,
              ),
              builder: (context, _) => Text(
                'Right edge layout shift',
                style: SBBTextStyles.mediumLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
