import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ChipPage extends StatefulWidget {
  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBChip(
                label: 'Default',
                badgeLabel: 9.toString(),
                selected: _selected1,
                onSelection: (selected) => {
                  setState(() {
                    _selected1 = selected;
                  })
                },
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBChip(
                label: 'No badge label',
                selected: _selected2,
                onSelection: (selected) => {
                  setState(() {
                    _selected2 = selected;
                  })
                },
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBChip(
                label: 'Selected',
                badgeLabel: 'Label',
                selected: _selected3,
                onSelection: (selected) => {
                  setState(() {
                    _selected3 = selected;
                  })
                },
              ),
            ],
          ),
        ),
        const SBBListHeader('Disabled'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBChip(
                label: 'Default',
                badgeLabel: 3.toString(),
                onSelection: null,
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBChip(
                label: 'Selected',
                onSelection: null,
                selected: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
