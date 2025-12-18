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
  bool _selected3 = false;
  int _enabledIndex = 0;

  bool get _isEnabled => _enabledIndex == 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            spacing: sbbDefaultSpacing,
            children: [
              const ThemeModeSegmentedButton(),
              SBBSegmentedButton(
                values: ['All Enabled', 'All Disabled'],
                selectedStateIndex: _enabledIndex,
                selectedIndexChanged: (i) => setState(() => _enabledIndex = i),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Default'),
              SBBGroup(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: sbbDefaultSpacing,
                  children: [
                    SBBChip(
                      labelText: 'Chip Label',
                      trailingText: 99.toString(),
                      selected: _selected1,
                      onChanged: _isEnabled ? (selected) => setState(() => _selected1 = selected) : null,
                    ),
                    SBBChip(
                      labelText: 'Chip Label',
                      trailingText: 99.toString(),
                      selected: _selected2,
                      onChanged: _isEnabled ? (selected) => setState(() => _selected2 = selected) : null,
                    ),
                  ],
                ),
              ),

              const SBBListHeader('Long Text'),
              SBBGroup(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: SBBChip(
                  labelText: 'L${"o" * 100}ng Text',
                  trailingText: 99.toString(),
                  selected: _selected3,
                  onChanged: _isEnabled ? (selected) => setState(() => _selected3 = selected) : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
