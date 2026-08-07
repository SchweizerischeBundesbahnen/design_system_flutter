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
  SBBPopoverNotch _notch = const SBBPopoverNotch.single();
  bool _alignNotchWithTarget = true;
  String _popoverContentText = 'This is a transient popover view.';

  List<SBBDropdownItem<SBBPopoverDirection>> get _directionItems => SBBPopoverDirection.values.map((dir) {
    final label = dir.name.substring(0, 1).toUpperCase() + dir.name.substring(1);
    return SBBDropdownItem(value: dir, label: label);
  }).toList();

  List<SBBDropdownItem<SBBPopoverNotch>> get _notchItems => const [
    SBBDropdownItem(value: SBBPopoverNotch.single(), label: 'Single'),
    SBBDropdownItem(value: SBBPopoverNotch.none(), label: 'None'),
    SBBDropdownItem(value: SBBPopoverNotch.both(), label: 'Both'),
  ];

  // alignWithTarget only applies to SBBPopoverNotch.single; the dropdown
  // above only ever selects between the three bare (default-aligned)
  // variants, so the toggle's value is layered in here.
  SBBPopoverNotch get _effectiveNotch {
    final notch = _notch;
    if (notch is! SBBPopoverNotchSingle) return notch;
    return SBBPopoverNotch.single(alignWithTarget: _alignNotchWithTarget);
  }

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
          SBBDropdown<SBBPopoverNotch>(
            triggerDecoration: const SBBInputDecoration(labelText: 'Notch'),
            selectedItem: _notch,
            items: _notchItems,
            onChanged: (value) {
              if (value != null) {
                setState(() => _notch = value);
              }
            },
          ),
          SBBSwitchListItem(
            titleText: 'Align Notch With Target',
            value: _alignNotchWithTarget,
            onChanged: _notch is SBBPopoverNotchSingle
                ? (value) => setState(() => _alignNotchWithTarget = value)
                : null,
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
            notch: _effectiveNotch,
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
              notch: _effectiveNotch,
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
              notch: _effectiveNotch,
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
