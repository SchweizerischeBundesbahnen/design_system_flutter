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
  String _selectedOption2 = 'Option 1';
  IconData _selectedVehicle1 = SBBIcons.bicycle_small;
  IconData _selectedVehicle2 = SBBIcons.scooter_profile_small;
  IconData _selectedVehicle3 = SBBIcons.bicycle_small;
  IconData _selectedVehicle4 = SBBIcons.scooter_profile_small;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Default'),
              Column(
                spacing: SBBSpacing.small,
                children: [
                  SBBSegmentedButton<String>(
                    segments: [
                      SBBButtonSegment(value: 'Option 1', labelText: 'Option 1'),
                      SBBButtonSegment(value: 'Option 2', labelText: 'Option 2'),
                      SBBButtonSegment(value: 'Option 3', labelText: 'Option 3'),
                    ],
                    selected: _selectedOption1,
                    onSelectionChanged: (value) => setState(() => _selectedOption1 = value),
                  ),
                  SBBSegmentedButton<IconData>(
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
                  SBBSegmentedButton<IconData>(
                    segments: [
                      SBBButtonSegment(
                        value: SBBIcons.microscooter_profile_small,
                        leadingIconData: SBBIcons.microscooter_profile_small,
                        labelText: 'Micro',
                      ),
                      SBBButtonSegment(
                        value: SBBIcons.bicycle_small,
                        leadingIconData: SBBIcons.bicycle_small,
                        labelText: 'Bicycle',
                      ),
                      SBBButtonSegment(
                        value: SBBIcons.scooter_profile_small,
                        leadingIconData: SBBIcons.scooter_profile_small,
                        labelText: 'Scooter',
                      ),
                    ],
                    selected: _selectedVehicle2,
                    onSelectionChanged: (value) => setState(() => _selectedVehicle2 = value),
                  ),
                ],
              ),
              SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Filled'),

              Column(
                spacing: SBBSpacing.small,
                children: [
                  SBBSegmentedButtonFilled<String>(
                    segments: [
                      SBBButtonSegment(value: 'Option 1', labelText: 'Option 1'),
                      SBBButtonSegment(value: 'Option 2', labelText: 'Option 2'),
                      SBBButtonSegment(value: 'Option 3', labelText: 'Option 3'),
                    ],
                    selected: _selectedOption2,
                    onSelectionChanged: (value) => setState(() => _selectedOption2 = value),
                  ),
                  SBBSegmentedButtonFilled<IconData>(
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
                    selected: _selectedVehicle3,
                    onSelectionChanged: (value) => setState(() => _selectedVehicle3 = value),
                  ),
                  SBBSegmentedButtonFilled<IconData>(
                    segments: [
                      SBBButtonSegment(
                        value: SBBIcons.microscooter_profile_small,
                        leadingIconData: SBBIcons.microscooter_profile_small,
                        labelText: 'Micro',
                      ),
                      SBBButtonSegment(
                        value: SBBIcons.bicycle_small,
                        leadingIconData: SBBIcons.bicycle_small,
                        labelText: 'Bicycle',
                      ),
                      SBBButtonSegment(
                        value: SBBIcons.scooter_profile_small,
                        leadingIconData: SBBIcons.scooter_profile_small,
                        labelText: 'Scooter',
                      ),
                    ],
                    selected: _selectedVehicle4,
                    onSelectionChanged: (value) => setState(() => _selectedVehicle4 = value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
