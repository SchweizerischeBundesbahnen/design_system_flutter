import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/widgets.dart';

import '../native_app.dart';

class SegmentedButtonPage extends StatefulWidget {
  const SegmentedButtonPage({super.key});

  @override
  SegmentedButtonPageState createState() => SegmentedButtonPageState();
}

class SegmentedButtonPageState extends State<SegmentedButtonPage> {
  int _selectedStateIndex1 = 0;
  int _selectedStateIndex2 = 0;
  int _selectedStateIndex3 = 0;
  int _selectedStateIndex4 = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        const SBBListHeader('Default (colors based on theme)'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: SBBSegmentedButton(
            values: ['Option 1', 'Option 2', 'Option 3'],
            selectedIndexChanged: (value) => setState(() => _selectedStateIndex1 = value),
            selectedStateIndex: _selectedStateIndex1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSegmentedButton.icon(
            icons: {
              SBBIcons.microscooter_profile_small: 'Microscooter',
              SBBIcons.bicycle_small: 'Bicycle',
              SBBIcons.scooter_profile_small: 'Scooter',
            },
            selectedIndexChanged: (value) => setState(() => _selectedStateIndex2 = value),
            selectedStateIndex: _selectedStateIndex2,
          ),
        ),
        const SBBListHeader('Red'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: SBBSegmentedButton.redText(
            values: ['Option 1', 'Option 2', 'Option 3'],
            selectedIndexChanged: (value) => setState(() => _selectedStateIndex3 = value),
            selectedStateIndex: _selectedStateIndex3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSegmentedButton.redIcon(
            icons: {
              SBBIcons.microscooter_profile_small: 'Microscooter',
              SBBIcons.bicycle_small: 'Bicycle',
              SBBIcons.scooter_profile_small: 'Scooter',
            },
            selectedIndexChanged: (value) => setState(() => _selectedStateIndex4 = value),
            selectedStateIndex: _selectedStateIndex4,
          ),
        ),
      ],
    );
  }
}
