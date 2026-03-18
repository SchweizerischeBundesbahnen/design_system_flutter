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

  int _itemCount = 5;

  List<SBBDropdownItem<int>> get _items =>
      List.generate(_itemCount, (idx) => SBBDropdownItem(value: idx, label: 'Item ${idx + 1}'));

  List<int> _multiSelectValues1 = [];
  List<int> _multiSelectValues2 = [1];
  List<int> _multiSelectValues3 = [];
  final _multiSelectItems = [
    const SBBDropdownItem(value: 1, label: 'Item 1'),
    const SBBDropdownItem(value: 2, label: 'Item 2'),
    const SBBDropdownItem(value: 3, label: 'Item 3'),
    const SBBDropdownItem(value: 4, label: 'Item 4'),
    const SBBDropdownItem(value: 5, label: 'Item 5'),
  ];

  String _sheetTitle = 'Default Title';
  bool _showLeadingIcon = false;
  bool _showCloseButton = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            mainAxisSize: .min,
            children: SBBListItem.divideListItems(
              context: context,
              items: [
                const ThemeModeSegmentedButton(),
                SizedBox(height: SBBSpacing.small),
                Padding(
                  padding: const EdgeInsets.only(left: SBBSpacing.medium),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    spacing: SBBSpacing.xxSmall,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              alignment: .center,
                              constraints: BoxConstraints(minWidth: 64.0),
                              padding: .symmetric(horizontal: SBBSpacing.medium),
                              child: Text('$_itemCount', style: SBBTextStyles.mediumBold),
                            ),
                            Expanded(
                              child: SBBSlider(
                                value: _itemCount.toDouble(),
                                min: 1,
                                max: 100,
                                divisions: 99,
                                onChanged: (value) {
                                  setState(() {
                                    _itemCount = value.round();
                                    // Reset selections that are out of range
                                    if (_selectedValue1 != null && _selectedValue1! >= _itemCount)
                                      _selectedValue1 = null;
                                    if (_selectedValue2 != null && _selectedValue2! >= _itemCount)
                                      _selectedValue2 = null;
                                    if (_selectedValue3 != null && _selectedValue3! >= _itemCount)
                                      _selectedValue3 = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Number of Items',
                        style: sbbTextStyle.xSmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: SBBSpacing.medium),
                  child: SBBTextInput(
                    decoration: SBBInputDecoration(
                      labelText: 'Bottom Sheet Title',
                    ),
                    autofocus: false,
                    controller: TextEditingController.fromValue(TextEditingValue(text: _sheetTitle)),
                    onChanged: (value) => setState(() => _sheetTitle = value),
                  ),
                ),
                Material(
                  child: SBBSwitchListItem(
                    titleText: 'Show Leading Icon',
                    value: _showLeadingIcon,
                    onChanged: (value) => setState(() => _showLeadingIcon = value),
                  ),
                ),
                SBBSwitchListItem(
                  titleText: 'Show Close Button',
                  value: _showCloseButton,
                  onChanged: (value) => setState(() => _showCloseButton = value),
                ),
              ],
            ).toList(growable: false),
          ),
        ),
        SliverPadding(
          padding: .symmetric(horizontal: SBBSpacing.xSmall),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Single Choice'),
              SBBContentBox(
                child: Column(
                  children: [
                    SBBDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(labelText: 'Label'),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItem: _selectedValue1,
                      items: _items,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                        setState(() => _selectedValue1 = value);
                      },
                    ),
                    SBBDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(labelText: 'Default Value'),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItem: _selectedValue2,
                      items: _items,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                        setState(() => _selectedValue2 = value);
                      },
                    ),
                    SBBDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(leadingIconData: SBBIcons.route_circle_start_small),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItem: _selectedValue3,
                      items: _items,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                        setState(() => _selectedValue3 = value);
                      },
                    ),
                    SBBDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(
                        labelText: 'Disabled',
                        leadingIconData: SBBIcons.route_circle_start_small,
                      ),
                      selectedItem: _selectedValue3,
                      items: _items,
                      onChanged: null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Multiple choice'),
              SBBContentBox(
                child: Column(
                  children: [
                    SBBMultiDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(labelText: 'Label'),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItems: _multiSelectValues1,
                      items: _multiSelectItems,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                        setState(() => _multiSelectValues1 = value);
                      },
                    ),
                    SBBMultiDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(labelText: 'Default Value'),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItems: _multiSelectValues2,
                      items: _multiSelectItems,
                      onChanged: (value) {
                        setState(() => _multiSelectValues2 = value);
                      },
                    ),
                    SBBMultiDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(leadingIconData: SBBIcons.route_circle_start_small),
                      sheetTitleText: _sheetTitle,
                      sheetLeadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                      sheetShowCloseButton: _showCloseButton,
                      selectedItems: _multiSelectValues3,
                      items: _multiSelectItems,
                      onChanged: (value) {
                        setState(() => _multiSelectValues3 = value);
                      },
                    ),
                    SBBMultiDropdown<int>(
                      triggerDecoration: const SBBInputDecoration(
                        labelText: 'Disabled',
                        leadingIconData: SBBIcons.route_circle_start_small,
                      ),
                      selectedItems: _multiSelectValues3,
                      items: _multiSelectItems,
                      onChanged: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
