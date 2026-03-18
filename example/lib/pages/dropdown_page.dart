import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  int? _selectedValue1;
  int? _selectedValue2 = 1;
  int? _selectedValue3;
  int? _selectedValue4;
  int? _selectedValue5;
  final _items = [
    const SBBDropdownItem(value: 1, label: 'Item 1'),
    const SBBDropdownItem(value: 2, label: 'Item 2'),
    const SBBDropdownItem(value: 3, label: 'Item 3'),
    const SBBDropdownItem(value: 4, label: 'Item 4'),
    const SBBDropdownItem(value: 5, label: 'Item 5'),
  ];

  List<int> _multiSelectValues1 = [];
  List<int> _multiSelectValues2 = [1];
  List<int> _multiSelectValues3 = [];
  List<int> _multiSelectValues4 = [];
  List<int> _multiSelectValues5 = [];
  final _multiSelectItems = [
    const SBBDropdownItem(value: 1, label: 'Item 1'),
    const SBBDropdownItem(value: 2, label: 'Item 2'),
    const SBBDropdownItem(value: 3, label: 'Item 3'),
    const SBBDropdownItem(value: 4, label: 'Item 4'),
    const SBBDropdownItem(value: 5, label: 'Item 5'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(SBBSpacing.medium),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Single value'),
        SBBContentBox(
          child: Column(
            children: [
              SBBDropdown<int>(
                inputDecoration: SBBInputDecoration(labelText: 'Label'),
                value: _selectedValue1,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue1 = value);
                },
              ),
              SBBDropdown<int>(
                inputDecoration: SBBInputDecoration(labelText: 'Default Value'),
                value: _selectedValue2,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue2 = value);
                },
              ),
              SBBDropdown<int>(
                inputDecoration: SBBInputDecoration(labelText: 'Default Value'),
                // label: 'Custom Menu Title',
                // title: 'This is the custom menu title',
                value: _selectedValue3,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue3 = value);
                },
              ),
              SBBDropdown<int>(
                inputDecoration: SBBInputDecoration(leadingIconData: SBBIcons.route_circle_start_small),
                value: _selectedValue4,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue4 = value);
                },
              ),
              SBBDropdown<int>(
                inputDecoration: SBBInputDecoration(
                  labelText: 'Disabled',
                  leadingIconData: SBBIcons.route_circle_start_small,
                ),
                value: _selectedValue4,
                items: _items,
                onChanged: null,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBTertiaryButton(
                labelText: 'Call showMenu() without building Widget',
                onPressed: () {
                  SBBDropdown.showMenu<int>(
                    context: context,
                    title: 'Title',
                    value: _selectedValue5,
                    items: _items,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue5 = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: SBBSpacing.medium),
            ],
          ),
        ),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Multiple values'),
        SBBContentBox(
          child: Column(
            children: [
              SBBMultiDropdown<int>(
                label: 'Label',
                values: _multiSelectValues1,
                items: _multiSelectItems,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _multiSelectValues1 = value);
                },
              ),
              SBBMultiDropdown<int>(
                label: 'Default Value',
                values: _multiSelectValues2,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues2 = value);
                },
              ),
              SBBMultiDropdown<int>(
                label: 'Custom Menu Title',
                title: 'This is the custom menu title',
                values: _multiSelectValues3,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues3 = value);
                },
              ),
              SBBMultiDropdown<int>(
                label: 'Icon',
                icon: SBBIcons.route_circle_start_small,
                values: _multiSelectValues4,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues4 = value);
                },
              ),
              SBBMultiDropdown<int>(
                label: 'Disabled',
                icon: SBBIcons.route_circle_start_small,
                values: _multiSelectValues4,
                items: _multiSelectItems,
                onChanged: null,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBTertiaryButton(
                labelText: 'Call showMenu() without building Widget',
                onPressed: () {
                  SBBMultiDropdown.showMenu<int>(
                    context: context,
                    title: 'Title',
                    values: _multiSelectValues5,
                    items: _multiSelectItems,
                    onChanged: (value) {
                      setState(() {
                        setState(() => _multiSelectValues5 = value);
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: SBBSpacing.medium),
            ],
          ),
        ),
      ],
    );
  }
}
