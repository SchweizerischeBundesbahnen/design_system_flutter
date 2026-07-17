import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class PopoverPage extends StatefulWidget {
  const PopoverPage({super.key});

  @override
  State<PopoverPage> createState() => _PopoverPageState();
}

class _PopoverPageState extends State<PopoverPage> {
  SBBPopoverDirection _preferredDirection = SBBPopoverDirection.bottom;
  SBBPopoverNotch _notch = const SBBPopoverNotch.single();
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
          const SBBListHeader('Edge Collision (Smart Layout)'),
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
            preferredDirection: _preferredDirection,
            notch: _notch,
            targetBuilder: (context, showOverlay) => SBBSecondaryButton(
              labelText: 'Open Center Popover',
              onPressed: showOverlay,
            ),
            builder: (context, hideOverlay) => Padding(
              padding: const EdgeInsets.all(SBBSpacing.medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _popoverContentText,
                    style: SBBTextStyles.mediumLight,
                  ),
                  const SizedBox(height: SBBSpacing.small),
                  SBBTertiaryButtonSmall(
                    iconData: SBBIcons.cross_small,
                    onPressed: hideOverlay,
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
              notch: _notch,
              targetBuilder: (context, showOverlay) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_left_small,
                onPressed: showOverlay,
              ),
              builder: (context, hideOverlay) => Padding(
                padding: const EdgeInsets.all(SBBSpacing.medium),
                child: Text(
                  'Left edge layout shift',
                  style: SBBTextStyles.mediumLight,
                ),
              ),
            ),
            SBBPopover(
              preferredDirection: _preferredDirection,
              notch: _notch,
              targetBuilder: (context, showOverlay) => SBBTertiaryButtonSmall(
                iconData: SBBIcons.arrow_right_small,
                onPressed: showOverlay,
              ),
              builder: (context, hideOverlay) => Padding(
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
