import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/native_app.dart';
import 'package:provider/provider.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ThemeContextDropdown extends StatelessWidget {
  const ThemeContextDropdown({super.key});

  List<SBBDropdownItem<SBBThemeContext>> get _themeContexts => [
    SBBDropdownItem(value: .sbb, label: 'SBB'),
    SBBDropdownItem(value: .offBrand, label: 'Off-Brand'),
    SBBDropdownItem(value: .safety, label: 'Safety'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return SBBDropdown<SBBThemeContext>(
          sheetTitleText: "Choose the theme's context",
          triggerDecoration: const SBBInputDecoration(labelText: 'Context'),
          selectedItem: appState.themeContext,
          items: _themeContexts,
          onChanged: (value) => Provider.of<AppState>(context, listen: false).updateThemeContext(value!),
        );
      },
    );
  }
}
