import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  bool _selected1 = false;
  bool _selected2 = true;
  bool _selected3 = false;

  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: SBBSegmentedButton(
          segments: [
            SBBButtonSegment(value: true, labelText: 'All enabled'),
            SBBButtonSegment(value: false, labelText: 'All Disabled'),
          ],
          selected: _isEnabled,
          onSelectionChanged: (update) => setState(() => _isEnabled = update),
        ),
      ),
      body: Column(
        children: [
          const SBBListHeader('Default'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Row(
              mainAxisAlignment: .center,
              spacing: SBBSpacing.medium,
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
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: SBBChip(
              labelText: 'L${"o" * 100}ng Text',
              trailingText: 99.toString(),
              selected: _selected3,
              onChanged: _isEnabled ? (selected) => setState(() => _selected3 = selected) : null,
            ),
          ),
        ],
      ),
    );
  }
}
