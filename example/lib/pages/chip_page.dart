import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  bool _selected1 = false;
  bool _selected2 = true;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: sbbDefaultSpacing,
            children: [
              SBBChip(
                labelText: 'Chip Label',
                trailingText: 99.toString(),
                selected: _selected1,
                onChanged: (selected) => setState(() => _selected1 = selected),
              ),
              SBBChip(
                labelText: 'Chip Label',
                trailingText: 99.toString(),
                selected: _selected2,
                onChanged: (selected) => setState(() => _selected2 = selected),
              ),
            ],
          ),
        ),
        const SBBListHeader('Disabled'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: sbbDefaultSpacing,
            children: [
              SBBChip(labelText: 'Chip Label', trailingText: 99.toString(), onChanged: null),
              const SBBChip(labelText: 'Chip Label', onChanged: null, selected: true),
            ],
          ),
        ),
        const SBBListHeader('Long Text'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBChip(labelText: 'L${"o" * 100}ng Text', trailingText: 99.toString(), onChanged: (_) {}),
        ),
      ],
    );
  }
}
