import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  SelectPageState createState() => SelectPageState();
}

class SelectPageState extends State<SelectPage> {
  int? _selectedValue1;
  int? _selectedValue2 = 1;
  int? _selectedValue3;
  int? _selectedValue4;
  int? _selectedValue5;
  final _items = [
    const SelectMenuItem(value: 1, label: 'Item 1'),
    const SelectMenuItem(value: 2, label: 'Item 2'),
    const SelectMenuItem(value: 3, label: 'Item 3'),
    const SelectMenuItem(value: 4, label: 'Item 4'),
    const SelectMenuItem(value: 5, label: 'Item 5'),
  ];

  List<int> _multiSelectValues1 = [];
  List<int> _multiSelectValues2 = [1];
  List<int> _multiSelectValues3 = [];
  List<int> _multiSelectValues4 = [];
  List<int> _multiSelectValues5 = [];
  final _multiSelectItems = [
    const SelectMenuItem(value: 1, label: 'Item 1'),
    const SelectMenuItem(value: 2, label: 'Item 2'),
    const SelectMenuItem(value: 3, label: 'Item 3'),
    const SelectMenuItem(value: 4, label: 'Item 4'),
    const SelectMenuItem(value: 5, label: 'Item 5'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Single value'),
        SBBContentBox(
          child: Column(
            children: <Widget>[
              SBBSelect<int>(
                label: 'Label',
                value: _selectedValue1,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue1 = value);
                },
              ),
              SBBSelect<int>(
                label: 'Default Value',
                value: _selectedValue2,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue2 = value);
                },
              ),
              SBBSelect<int>(
                label: 'Custom Menu Title',
                title: 'This is the custom menu title',
                value: _selectedValue3,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue3 = value);
                },
              ),
              SBBSelect<int>(
                label: 'Icon',
                icon: SBBIcons.route_circle_start_small,
                value: _selectedValue4,
                items: _items,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _selectedValue4 = value);
                },
              ),
              SBBSelect<int>(
                label: 'Disabled',
                icon: SBBIcons.route_circle_start_small,
                value: _selectedValue4,
                items: _items,
                onChanged: null,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBTertiaryButton(
                labelText: 'Call showMenu() without building Widget',
                onPressed: () {
                  SBBSelect.showMenu<int>(
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
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Multiple values'),
        SBBContentBox(
          child: Column(
            children: <Widget>[
              SBBMultiSelect<int>(
                label: 'Label',
                values: _multiSelectValues1,
                items: _multiSelectItems,
                onChanged: (value) {
                  debugPrint('Selected: $value');
                  setState(() => _multiSelectValues1 = value);
                },
              ),
              SBBMultiSelect<int>(
                label: 'Default Value',
                values: _multiSelectValues2,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues2 = value);
                },
              ),
              SBBMultiSelect<int>(
                label: 'Custom Menu Title',
                title: 'This is the custom menu title',
                values: _multiSelectValues3,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues3 = value);
                },
              ),
              SBBMultiSelect<int>(
                label: 'Icon',
                icon: SBBIcons.route_circle_start_small,
                values: _multiSelectValues4,
                items: _multiSelectItems,
                onChanged: (value) {
                  setState(() => _multiSelectValues4 = value);
                },
              ),
              SBBMultiSelect<int>(
                label: 'Disabled',
                icon: SBBIcons.route_circle_start_small,
                values: _multiSelectValues4,
                items: _multiSelectItems,
                onChanged: null,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBTertiaryButton(
                labelText: 'Call showMenu() without building Widget',
                onPressed: () {
                  SBBMultiSelect.showMenu<int>(
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
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
      ],
    );
  }
}
