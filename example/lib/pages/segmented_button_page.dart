import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class SegmentedButtonPage extends StatefulWidget {
  const SegmentedButtonPage({super.key});

  @override
  SegmentedButtonPageState createState() => SegmentedButtonPageState();
}

class SegmentedButtonPageState extends State<SegmentedButtonPage> {
  String _selectedOption1 = 'Option 1';
  IconData _selectedVehicle1 = SBBIcons.microscooter_profile_small;
  String _selectedOption2 = 'Option 1';
  IconData _selectedVehicle2 = SBBIcons.microscooter_profile_small;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(padding: EdgeInsets.all(SBBSpacing.medium), child: ThemeModeSegmentedButton()),
        const SBBListHeader('Default (colors based on theme)'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
          child: SBBSegmentedButton<String>(
            segments: [
              SBBButtonSegment(
                value: 'Option 1',
                label: Container(width: 500, height: 200, color: SBBColors.orange),
              ),
              SBBButtonSegment(value: 'Option 2', labelText: 'Option 2'),
              SBBButtonSegment(value: 'Option 3', labelText: 'Option 3'),
            ],
            selected: _selectedOption1,
            onSelectionChanged: (value) => setState(() => _selectedOption1 = value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(SBBSpacing.medium),
          child: SBBSegmentedButton<IconData>(
            segments: [
              SBBButtonSegment(
                value: SBBIcons.microscooter_profile_small,
                leadingIconData: SBBIcons.microscooter_profile_small,
              ),
              SBBButtonSegment(
                value: SBBIcons.bicycle_small,
                leadingIconData: SBBIcons.bicycle_small,
              ),
              SBBButtonSegment(
                value: SBBIcons.scooter_profile_small,
                leadingIconData: SBBIcons.scooter_profile_small,
              ),
            ],
            selected: _selectedVehicle1,
            onSelectionChanged: (value) => setState(() => _selectedVehicle1 = value),
          ),
        ),
        const SBBListHeader('Red'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
          child: SBBSegmentedButton<String>(
            segments: [
              SBBButtonSegment(value: 'Option 1', labelText: 'Option 1'),
              SBBButtonSegment(value: 'Option 2', labelText: 'Option 2'),
              SBBButtonSegment(value: 'Option 3', labelText: 'Option 3'),
            ],
            selected: _selectedOption2,
            onSelectionChanged: (value) => setState(() => _selectedOption2 = value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(SBBSpacing.medium),
          child: SBBSegmentedButton<IconData>(
            segments: [
              SBBButtonSegment(
                value: SBBIcons.microscooter_profile_small,
                leadingIconData: SBBIcons.microscooter_profile_small,
              ),
              SBBButtonSegment(
                value: SBBIcons.bicycle_small,
                leadingIconData: SBBIcons.bicycle_small,
              ),
              SBBButtonSegment(
                value: SBBIcons.scooter_profile_small,
                leadingIconData: SBBIcons.scooter_profile_small,
              ),
            ],
            selected: _selectedVehicle2,
            onSelectionChanged: (value) => setState(() => _selectedVehicle2 = value),
          ),
        ),
      ],
    );
  }
}
