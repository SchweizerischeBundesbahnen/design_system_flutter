import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

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
                onSelection:
                    (selected) => {
                      setState(() {
                        _selected1 = selected;
                      }),
                    },
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBChip(
                label: 'No badge label',
                selected: _selected2,
                onSelection:
                    (selected) => {
                      setState(() {
                        _selected2 = selected;
                      }),
                    },
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBChip(
                label: 'Selected',
                badgeLabel: 'Label',
                selected: _selected3,
                onSelection:
                    (selected) => {
                      setState(() {
                        _selected3 = selected;
                      }),
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
              const SizedBox(height: sbbDefaultSpacing),
              const SBBChip(
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
