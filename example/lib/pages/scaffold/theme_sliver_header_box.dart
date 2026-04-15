import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/theme_context_dropdown.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/theme_mode_segmented_button.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ThemeSliverHeaderbox extends StatelessWidget {
  const ThemeSliverHeaderbox({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBSliverHeaderbox.custom(
      padding: .all(SBBSpacing.xSmall),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: ThemeContextDropdown(),
          ),
          Expanded(child: ThemeModeSegmentedButton()),
        ],
      ),
    );
  }
}
