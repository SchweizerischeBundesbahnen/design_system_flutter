import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/native_app.dart';
import 'package:provider/provider.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ThemeModeSegmentedButton extends StatelessWidget {
  const ThemeModeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBSegmentedButton<bool>(
      segments: [
        SBBButtonSegment(value: false, leadingIconData: SBBIcons.sunshine_small),
        SBBButtonSegment(value: true, leadingIconData: SBBIcons.moon_small),
      ],
      onSelectionChanged: (value) {
        Provider.of<AppState>(context, listen: false).updateTheme(value);
      },
      selected: Provider.of<AppState>(context).isDarkModeOn,
    );
  }
}
